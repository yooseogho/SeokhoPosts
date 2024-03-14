package com.example.demo.entity;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {
	
	private String memberId; 			// 회원아이디
	private String password; 			// 비밀번호
	private String email;				// 이메일
	private String name;				// 이름
	private String nickname;			// 별명
	private LocalDate lastlogin;		// 마지막로그인 시간
	private LocalDate memberCreatedate; // 생성일자
	private LocalDate modified;			// 수정일자
	private LocalDate birthday;			// 생년월일
	private Long rno;					// 권한번호
	



@Override
public String toString() {
    return "Member {\n" +
           "  memberId: " + memberId + ",\n" +	
           "  password: " + password + ",\n" +
           "  email: " + email + ",\n" +
           "  name: " + name + ",\n" +
           "  nickname: " + nickname + ",\n" +
           "  lastlogin: " + lastlogin + ",\n" +
           "  memberCreatedate: " + memberCreatedate + ",\n" +
           "  modified: " + modified + ",\n" +
           "  birthday: " + birthday + ",\n" +
           "  rno: " + rno + "\n" +
           "}";
}

}
