package com.example.demo.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.demo.entity.Likes;
import com.example.demo.entity.Member;
import com.example.demo.service.LikesService;
import com.example.demo.service.MemberService;
import com.example.demo.service.PostsService;

@Controller
public class LikesController {

	@Autowired
	private LikesService likesService;
	@Autowired
	private PostsService postsService;
	@Autowired
	private MemberService memberService;

	@PostMapping("/likes")
	@ResponseBody
	public ResponseEntity<?> updateLike(@RequestBody Map<String, Object> payload, HttpSession session) {
	    // 세션에서 로그인한 사용자의 ID 가져오기, 키를 "loginUser"로 변경
	    String memberId = (String) session.getAttribute("loginUser");

	    // 로그인하지 않은 경우 에러 처리
	    if (memberId == null) {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of(
	                "status", "error",
	                "message", "로그인이 필요합니다."
	        ));
	    }

	    Long pno = Long.valueOf(payload.get("pno").toString());

	    // 이미 추천했는지 확인
	    int count = likesService.findByMemberId(memberId, pno);
	    if (count > 0) {
	        // 이미 추천한 경우
	        return ResponseEntity.ok(Map.of(
	                "status", "error",
	                "message", "이미 추천하셨습니다."
	        ));
	    }

	    // 추천 처리
	    Likes likes = new Likes();
	    // likes 객체에 필요한 정보 설정 (예: memberId, pno)
	    likes.setMemberId(memberId);
	    likes.setPno(pno);
	    likesService.save(likes); // 좋아요 데이터 삽입
	    likesService.increaseLikeCount(pno); // 특정 게시글의 좋아요 증가

	    // 성공 응답 반환
	    return ResponseEntity.ok(Map.of(
	            "status", "success",
	            "message", "추천되었습니다."
	    ));
	}




}