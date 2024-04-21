package com.example.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.example.demo.dto.PostsDto.PostsDetail;
import com.example.demo.entity.News;
import com.example.demo.entity.NewsResponse;
import com.example.demo.entity.PagingInfo;
import com.example.demo.entity.Posts;
import com.example.demo.service.PaginationService;
import com.example.demo.service.PostsService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class NewsController {
	
	@Autowired
	private PostsService postsService;
	
	@Autowired
	private PaginationService paginationService;
	
	
		@GetMapping("/")
		public String homeAndNews(@RequestParam(name = "page", defaultValue = "1") int page, Model model,Long categoryId) {
			// 뉴스 데이터를 가져오는 코드
	    final String url = "https://openapi.naver.com/v1/search/news.json?query=%EC%A3%BC%EC%8B%9D&display=10&start=1&sort=sim";

	    HttpHeaders headers = new HttpHeaders();
	    headers.set("X-Naver-Client-Id", "WAeE5GRg__9xflIfBSQ5");
	    headers.set("X-Naver-Client-Secret", "2YF69gonop");

	    HttpEntity<String> entity = new HttpEntity<>(headers);
	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);
	    String newsData = response.getBody();
	    ObjectMapper mapper = new ObjectMapper();
	    mapper.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false); 

	    
	    // 페이징 정보 계산 및 모델에 추가
	    PagingInfo pagingInfo = paginationService.getPagingInfo(page, 10, categoryId);
	    model.addAttribute("pagingInfo", pagingInfo);
	    
	    // 페이징 처리된 게시글 목록 조회 및 모델에 추가
	    System.out.println("Controller: 페이지 번호 = " + page);
	    List<PostsDetail> pagedPostsList = paginationService.getPostsByPage(page, 10);
	    System.out.println("Controller: 조회된 게시글 수 = " + pagedPostsList.size());
	 // 모델에 게시글 목록 추가
	    model.addAttribute("pagedPostsList", pagedPostsList);
	    

	    try {
	        NewsResponse newsResponse = mapper.readValue(newsData, NewsResponse.class);
	        List<News> newsList = newsResponse.getItems();
	        model.addAttribute("newsData", newsList);
	        
	    } catch (JsonProcessingException e) {
	        e.printStackTrace();
	    }


	    return "index";
	}
	
	



}
