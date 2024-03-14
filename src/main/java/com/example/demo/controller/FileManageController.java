package com.example.demo.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.example.demo.servide.PostsService;


@Controller
public class FileManageController {
	@Autowired
	private PostsService postsService;


    
	@PostMapping("/uploadSummernoteImageFile")
	@ResponseBody
	public ResponseEntity<?> handleFileUpload(@RequestParam("file") MultipartFile file) {
	    // 이미지 파일을 저장하고, 저장된 이미지의 URL을 가져옵니다.
	    String fileUrl = postsService.storeFile(file);
	    return new ResponseEntity<>(fileUrl, HttpStatus.OK);
	}


}