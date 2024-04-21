package com.example.demo.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.LikesDao;
import com.example.demo.entity.Likes;


@Service
public class LikesService {
	
	@Autowired
	private LikesDao likesDao;
	
	
	
	/** 좋아요 데이터 삽입 */ 
	public Long save(Likes likes) {
	    Long ino = likesDao.save(likes);
	    // 반환된 기본키(ino) 리턴
	    return ino;
	}
	
	
	/** 좋아요 수 증가 */
	public int increaseLikeCount(Long pno) {
	    return likesDao.updateLikeCountByPno(pno);

	}
	
	
	/** 전달받은 사용자 ID와 게시글 번호를 기준으로 해당 사용자의 게시글 좋아요 수를 조회 */
	public int findByMemberId(String memberId, Long pno) {
		return likesDao.countByMemberId(memberId, pno);
	}

	
	
	
	
}
