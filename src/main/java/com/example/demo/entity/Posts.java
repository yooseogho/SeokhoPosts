package com.example.demo.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.CreationTimestamp;

@Data
@AllArgsConstructor
@NoArgsConstructor					// 게시글
public class Posts {
	private Long pno;					// 게시글 번호
	private String title;				// 게시글 제목
	private String postsContent;		// 게시글 내용
	@CreationTimestamp
	private LocalDate postsCreatedate;	// 게시글 작성일자
	private LocalDate postsModified;	// 게시글 수정일자
	private String memberId;  // MEMBER_ID2에 해당하는 필드
	private Long views; // 조회수
	private Long likeCount; // 좋아요 수
	private Long cano; // 케테고리 번호
	


}
