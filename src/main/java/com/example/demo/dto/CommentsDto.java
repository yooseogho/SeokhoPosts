package com.example.demo.dto;



import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor(access = AccessLevel.PRIVATE)
public class CommentsDto {
	
	
	
	
	@Data
	@AllArgsConstructor
	@NoArgsConstructor
	public static class CommentsRead {
	    private Long cono;
	    private String commentsContent;
	    private String commentsCreatedate;
	    private String nickname;
	    private Long pno;
	}


}

