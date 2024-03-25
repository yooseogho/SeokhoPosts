package com.example.demo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.demo.service.MemberService;

@RestController
public class MemberRestContoell {
	
	@Autowired
    private MemberService memberService;


    


	@GetMapping("/check-id")
	public ResponseEntity<?> checkDuplicateId(@RequestParam String memberId) {
	    // 아이디 중복 검사
	    boolean isDuplicated = memberService.isDuplicatedId(memberId);
	    // 중복된 아이디가 없다면 200 OK 응답을,
	    // 중복된 아이디가 있다면 409 Conflict 응답을 반환합니다.
	    return isDuplicated ? ResponseEntity.status(HttpStatus.CONFLICT).build() 
	                        : ResponseEntity.ok().build();
	}





	
}
