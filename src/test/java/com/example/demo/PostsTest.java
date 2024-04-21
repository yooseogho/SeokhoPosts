package com.example.demo;

import static org.assertj.core.api.Assertions.assertThat;

import javax.persistence.PersistenceContext;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.orm.jpa.TestEntityManager;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.demo.entity.Likes;
import com.example.demo.entity.Posts;
import com.example.demo.service.LikesService;
import com.example.demo.service.PostsService;




@SpringBootTest
public class PostsTest {
	
	   @PersistenceContext
	    private TestEntityManager entityManager;

	@Autowired
	private PostsService postsService;
	
	@Autowired
	private LikesService likesService ;

	


    
//    @Test
    public void saveLikesTest() {
        // given
        Likes likes = new Likes();
        likes.setMemberId("yoosuckho8"); // 테스트용 memberId 설정
        likes.setPno(274L); // 테스트용 pno 설정

        // when
        Long ino = likesService.save(likes);

        // then
        assertThat(ino).isNotNull(); // ino가 정상적으로 생성되었는지 확인
    }
    
    
    
    
//    @Test
//    public void increaseLikeCountTest() {
//        // given
//        Long pno = 274L;
//        when(likesDao.updateLikeCountByPno(pno)).thenReturn(1);
//
//        // when
//        int updatedRows = likesService.increaseLikeCount(pno);
//
//        // then
//        assertThat(updatedRows).isEqualTo(1); // 가정: 좋아요 수가 정확히 1만큼 증가했는지 확인
//
//        // Verify that the method was called with the correct parameter
//        verify(likesDao).updateLikeCountByPno(pno);
//    }
    
    
    
    
}
