package com.example.demo.dto;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import com.example.demo.entity.Member;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class MemberDto {

	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class Join {
		private String memberId; // 회원아이디
		private String password; // 비밀번호
		private String email; // 이메일
		private String name; // 이름
		private String nickname; // 별명
		@DateTimeFormat(pattern = "yyyy-MM-dd")
		private LocalDate birthday; // 생년월일
		
		public Member toEntity() {
			return new Member(memberId, password, email, name, nickname, null, null, null, birthday, 1L);

		}
	}
	
	
}
