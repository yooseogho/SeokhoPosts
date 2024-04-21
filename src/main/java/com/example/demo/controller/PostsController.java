package com.example.demo.controller;

import java.util.Collections;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.dao.PostsDao;
import com.example.demo.dto.CommentsDto;
import com.example.demo.dto.PostsDto;
import com.example.demo.dto.PostsDto.PostsDetail;
import com.example.demo.entity.Member;
import com.example.demo.entity.News;
import com.example.demo.entity.NewsResponse;
import com.example.demo.entity.PagingInfo;
import com.example.demo.entity.Posts;
import com.example.demo.service.CommentsService;
import com.example.demo.service.PaginationService;
import com.example.demo.service.PostsService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;


@Controller
public class PostsController {

	@Autowired
	private PostsService postsService;
    
    @Autowired
    private CommentsService commentsService;
	@Autowired
	private PaginationService paginationService;
	@Autowired
	private PostsDao postsDao;

    
	// 글쓰기 페이지
	@Secured("ROLE_USER")
	@GetMapping("/write_page")
	public ModelAndView write_page() {
		return new ModelAndView("write_page");
	}
	
	
	
	// 최신글 정보 가저요기(어사이드 목록용)
    @GetMapping("/api/latest-posts")
    public ResponseEntity<List<Posts>> getLatestPosts() {
        List<Posts> posts = postsService.getLatestPosts();  // 최신 게시글 정보를 가져오는 메서드
        return ResponseEntity.ok(posts);
    }

	
	
    @GetMapping("read_page")
    public ModelAndView read_page(@RequestParam("pno") Long pno, ModelAndView mav, @RequestParam(name = "page", defaultValue = "1") int page, Model model) {
        // 게시글 상세 정보 조회
        PostsDto.read postDetail = postsService.getPostDetail(pno);
        String postsContent = postsService.ContentRead(pno);
        postDetail.setPostsContent(postsContent);
        List<CommentsDto.CommentsRead> comments = commentsService.readCommentsByPostId(pno);
        postsService.UpViews(pno);

        // 뉴스 데이터를 가져오는 로직 추가
	    final String url = "https://openapi.naver.com/v1/search/news.json?query=%EC%A3%BC%EC%8B%9D&display=10&start=1&sort=sim";
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-Naver-Client-Id", "WAeE5GRg__9xflIfBSQ5");
        headers.set("X-Naver-Client-Secret", "2YF69gonop");

        HttpEntity<String> entity = new HttpEntity<>(headers);
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
        String newsData = response.getBody();
        ObjectMapper mapper = new ObjectMapper();
        mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);

        
	    // 페이징 정보 계산 및 모델에 추가
	    PagingInfo pagingInfo = paginationService.getPagingInfo(page, 10, pno);
	    model.addAttribute("pagingInfo", pagingInfo);
	    
	 // 페이징 처리된 게시글 목록 조회 및 모델에 추가
	    System.out.println("Controller: 페이지 번호 = " + page);
	    List<PostsDetail> pagedPostsList = paginationService.getPostsByPage(page, 10);
	    System.out.println("Controller: 조회된 게시글 수 = " + pagedPostsList.size());
	    // 모델에 게시글 목록 추가
	    model.addAttribute("pagedPostsList", pagedPostsList);
	    model.addAttribute("pno", pno); // 이 코드를 통해 pno 값을 뷰로 전달
        try {
            NewsResponse newsResponse = mapper.readValue(newsData, NewsResponse.class);
            List<News> newsList = newsResponse.getItems();
            mav.addObject("newsData", newsList);  // 뉴스 데이터 모델에 추가
        } catch (JsonProcessingException e) {
            e.printStackTrace();
        }
        

        // 기존에 있던 모델 추가 로직
        mav.addObject("post", postDetail);
        mav.addObject("comments", comments);
        mav.setViewName("read_page");

        return mav;
    }



	
	// 글쓰기
    @PostMapping("/writePost")
    public String writePost(Posts posts, @RequestParam("file") MultipartFile file, @RequestParam("category") Long category, HttpSession session) {
        try {
            Member member = postsService.getLoggedInMember(session);
            if (member != null) {
                String memberId = member.getMemberId(); 
                posts.setMemberId(memberId); // 로그인한 회원의 ID를 설정

                if (!file.isEmpty()) {
                    // 이미지 파일을 저장하고 URL을 가져옵니다.
                    String fileUrl = postsService.storeFile(file);

                    // 본문에 이미지 URL을 추가합니다.
                    String content = posts.getPostsContent();
                    content += "<img src=\"" + fileUrl + "\" />";
                    posts.setPostsContent(content);

                    // 로그에 본문 내용을 출력합니다.
                    System.out.println("Content after adding image: " + content);
                }

                // 카테고리 ID를 savePost 메소드에 전달합니다.
                Long savedPostId = postsService.savePost(posts, category);
                if (savedPostId == null) {
                    throw new Exception("Failed to save post");
                }

                return "redirect:/";
            } else {
                return "redirect:/write_page"; // 현재 페이지로 리다이렉트
            }
        } catch (Exception e) {
            // 예외가 발생한 경우 로그에 예외 메시지와 스택 트레이스를 남깁니다.
            System.err.println("An error occurred: " + e.getMessage());
            e.printStackTrace();
            return "error"; // 오류 페이지로 리다이렉트
        }
    }
    
    
    
    @GetMapping("/getFilteredPosts")
    public ResponseEntity<?> getFilteredPosts(
            @RequestParam(name = "category", defaultValue = "all") String categoryStr,
            @RequestParam(name = "page", defaultValue = "1") int page) {
        List<PostsDetail> pagedFilteredPostsList;
        PagingInfo pagingInfo;

        if ("all".equals(categoryStr)) {
            // 모든 카테고리의 게시글을 페이지네이션하여 조회
            pagedFilteredPostsList = paginationService.getPostsByPage(page, 10);
            pagingInfo = paginationService.getPagingInfoForAllPosts(page, 10); // 이 메서드는 가정으로 추가한 것입니다.
        } else {
            try {
                Long category = Long.parseLong(categoryStr);
                // 특정 카테고리의 게시글을 페이지네이션하여 조회
                pagingInfo = paginationService.getPagingInfoByCategory(category, page, 10);
                pagedFilteredPostsList = paginationService.getPostsByCategoryAndPage(category, page, 10);
            } catch (NumberFormatException e) {
                // 카테고리 번호가 유효하지 않을 경우 에러 메시지와 함께 응답
                return ResponseEntity.badRequest().body(Map.of("error", "Invalid category number"));
            }
        }

        return ResponseEntity.ok(Map.of("posts", pagedFilteredPostsList, "pagingInfo", pagingInfo));
    }

	



	
}
