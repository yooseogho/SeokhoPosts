package com.example.demo;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.example.demo.entity.Posts;
import com.example.demo.service.PostsService;

@SpringBootTest
public class postsDaoTest {
	

	@Autowired
	private PostsService postsService;
	

	
	@Test
	public void savePostsTest() {
	    Long categoryId = 5L; // 가정: 카테고리 아이디가 1L이라고 합시다.
	    for(int i = 0; i < 30; i++) {
	        Posts post = new Posts();
	        post.setTitle(" 글 제목" + i);
	        post.setPostsContent("글 본문" + i);
	        post.setMemberId("yoosuckho50");
	        postsService.savePost(post, categoryId); // 카테고리 아이디를 전달
	    }
	}
    
    
    
}
