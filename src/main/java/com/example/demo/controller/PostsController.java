package com.example.demo.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.annotation.Secured;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.dto.CommentsDto;
import com.example.demo.dto.PostsDto;
import com.example.demo.dto.PostsDto.PostsDetail;
import com.example.demo.entity.Member;
import com.example.demo.entity.Posts;
import com.example.demo.service.CommentsService;
import com.example.demo.service.PostsService;

@Controller
public class PostsController {

	@Autowired
	private PostsService postsService;
	
    @Autowired
    private FileManageController fileManageController;
    
    @Autowired
    private CommentsService commentsService;
	
	



    
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
	public ModelAndView read_page(@RequestParam("pno") Long pno, ModelAndView mav) {
	    PostsDto.read postDetail = postsService.getPostDetail(pno);
	    String postsContent = postsService.ContentRead(pno);
	    postDetail.setPostsContent(postsContent);
	    List<CommentsDto.CommentsRead> comments = commentsService.readCommentsByPostId(pno);
	    postsService.UpViews(pno);
	    
	    mav.addObject("post", postDetail);
	    mav.addObject("comments", comments);
	    mav.setViewName("read_page");
	    return mav;
	}



	
	// 글쓰기
	@PostMapping("/writePost")
	public String writePost(Posts posts, @RequestParam("file") MultipartFile file, HttpSession session) {
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



	            Long savedPostId = postsService.savePost(posts);
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

	
	

	
	
	


	
	
	
}
