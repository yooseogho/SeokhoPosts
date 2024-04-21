package com.example.demo.dto;


import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import com.example.demo.entity.PagingInfo;

import java.util.List; // 이 부분을 수정하세요.
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class PostsDto {
	
	
	// 루트페이지 게시글 확인
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class PostsDetail {
	    private Long pno; // 게시글 번호
	    private String title; // 제목
	    private String nickname; // 작성자 닉네임
	    private LocalDate postsCreatedate; // 작성일자
	    private Long views; // 조회수
	    private Long likeCount; // 추천수
	    private Long cano; // 카테고리 번호

	    public String getPostsCreatedate() {
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	        return sdf.format(Date.from(postsCreatedate.atStartOfDay(ZoneId.systemDefault()).toInstant()));
	    }

	    public Long getLikeCount() {
	        return likeCount;
	    }
	}
	
	
	
	// read_page 게시글 읽기
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class read {
	    private Long pno; // 게시글 번호
	    private String title; // 제목
	    private String nickname; // 작성자 이름
	    private Long likeCount; // 추천수
	    private Long views; // 조회수
	    private LocalDate postsCreatedate; // 작성일자
	    private Long commentsCount; // 댓글수
	    private String postsContent; // 글 본문
	}
	
	
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class FilteredPostsResponse {
	    private List<PostsDetail> posts; // 게시글 목록
	    private PagingInfo pagingInfo; // 페이지네이션 정보
	}

	
	
	
}
