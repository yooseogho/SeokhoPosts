	package com.example.demo.entity;
	
	import java.util.List; // 이 부분을 수정
	import lombok.AllArgsConstructor;
	import lombok.Data;
	import lombok.NoArgsConstructor;
	
	@AllArgsConstructor
	@NoArgsConstructor
	@Data
	public class NewsResponse {
	    private String lastBuildDate;
	    private int total;
	    private int start;
	    private int display;
	    private List<News> items;
	}
