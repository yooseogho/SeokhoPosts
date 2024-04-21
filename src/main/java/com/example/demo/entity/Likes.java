package com.example.demo.entity;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
@Data
public class Likes {
	private Long lno;				// 좋아요 번호
	private LocalDate likeDate;		// 공감버튼 누른시간
	private String memberId;  // 회원 ID
	private Long pno;  // 게시글 번호
}
