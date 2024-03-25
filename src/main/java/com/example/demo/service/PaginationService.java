package com.example.demo.service; 

import com.example.demo.dao.PostsDao;
import com.example.demo.dto.PostsDto.PostsDetail;
import com.example.demo.entity.PagingInfo;
import com.example.demo.entity.Posts;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PaginationService {

    @Autowired
    private PostsDao postsDao;

    public List<PostsDetail> getPostsByPage(int pageNum, int pageSize) {
        int start = (pageNum - 1) * pageSize + 1;
        int totalPosts = postsDao.countPosts(); // 전체 게시글 수를 구함
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
        int end = pageNum * pageSize;

        // 마지막 페이지에서 end 값이 전체 게시글 수를 초과하지 않도록 조정
        if (end > totalPosts) {
            end = totalPosts;
        }

        return postsDao.findPostsDetailByPage(start, end);
    }

    
    // 현재 페이지 번호를 기반으로 페이징 정보 계산
    public PagingInfo getPagingInfo(int pageNum, int pageSize) {
        int totalPosts = postsDao.countPosts();
        int totalPages = (int) Math.ceil((double) totalPosts / pageSize);
        int pageGroupSize = 5; // 한 번에 보여줄 페이지 번호 개수

        int currentPageGroup = (int) ((pageNum - 1) / pageGroupSize);
        int startPage = currentPageGroup * pageGroupSize + 1;
        int endPage = Math.min(startPage + pageGroupSize - 1, totalPages);

        boolean hasNextGroup = endPage < totalPages;
        boolean hasPreviousGroup = startPage > 1;

        return new PagingInfo(startPage, endPage, hasNextGroup, hasPreviousGroup, totalPages);
    }


}
