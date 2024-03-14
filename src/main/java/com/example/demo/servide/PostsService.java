package com.example.demo.servide;

import java.io.File;
import java.time.LocalDate;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.NoSuchElementException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.example.demo.dao.MemberDao;
import com.example.demo.dao.PostsDao;
import com.example.demo.dto.PostsDto.PostsDetail;
import com.example.demo.dto.PostsDto.read;
import com.example.demo.entity.Member;
import com.example.demo.entity.Posts;

@Service
public class PostsService {
	


	private static final Long Long = null;

	@Autowired
	private PostsDao postsDao;
	
	@Autowired
	private MemberDao memberDao;
	


	
// 디렉토리에 사진저장하는 로직
	public String storeFile(MultipartFile file) {
	    // 파일의 원래 이름을 가져옵니다.
	    String fileName = file.getOriginalFilename();

	    // 파일 이름에서 특수 문자를 제거합니다.
	    fileName = fileName.replaceAll("[^a-zA-Z0-9.-]", "_");

	    // 파일 이름이 너무 길면 줄입니다.
	    if (fileName.length() > 200) {
	        fileName = fileName.substring(0, 200);
	    }

	    try {
	        // 파일 저장 경로를 설정합니다.
	        String savePath = "C:/upload/";

	        // 파일을 저장할 디렉토리가 존재하는지 확인하고, 없으면 생성합니다.
	        File dir = new File(savePath);
	        if (!dir.exists()) {
	            dir.mkdirs();
	        }

	        // 파일을 저장할 경로와 파일 이름을 합쳐서 전체 경로를 만듭니다.
	        String filePath = savePath + fileName;
	        file.transferTo(new File(filePath));
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    // 저장된 파일의 URL을 반환합니다.
	    String fileUri = "http://localhost:8081/upload/" + fileName;

	    return fileUri;
	}
	
	
	
	public List<PostsDetail> getAllPostsDetail() {
	    List<PostsDetail> postsDetailList = postsDao.findAllPostsDetail();
	    System.out.println("리스트 내용: " + postsDetailList);
	    return postsDetailList;
	}

	
	public Member getLoggedInMember(HttpSession session) {
	    String memberId = (String) session.getAttribute("loginUser");
	    if (memberId != null) {
	        return memberDao.getmember(memberId);
	    } else {
	        return null;
	    }
	}
	
	
	// 글쓰기
	public Long savePost(Posts posts) {
	    if(posts == null) {
	        throw new IllegalArgumentException("Posts object is null");
	    }
	    posts.setLikeCount(0L); // 좋아요 수를 0으로 초기화
	    LocalDate now = LocalDate.now();  // 현재 날짜를 가져옵니다.
	    posts.setPostsCreatedate(now); // 현재 날짜 설정
	    return  (long) postsDao.save(posts);
	}

	
	
	
	// 글 읽기
	public read getPostDetail (Long pno) {
	    read postDetail = postsDao.findAllRead().stream()
	        .filter(post -> post.getPno().equals(pno))
	        .findFirst()
	        .orElseThrow(() -> new NoSuchElementException("Post not found with id : " + pno));
	    return postDetail;
	}
	
	
	// 본문 내용 읽기
	public String ContentRead(Long pno) {
		return postsDao.FindByContent(pno);
	}
	
	
	//조회수 증가
	public Long UpViews(Long pno) {
		return postsDao.increaseViews(pno);
		
	}
	
	// 최신글 정보 가져오기
    public List<Posts> getLatestPosts() {
        return postsDao.findTop5ByOrderByCreatedDateDesc();
    }



}
