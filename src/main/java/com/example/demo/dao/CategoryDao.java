package com.example.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.entity.Category;

@Mapper
public interface CategoryDao {
	
	
	   // Category 엔티티를 저장하는 메서드, 매개변수 추가
    @Insert("insert into category(cano, categoryName) values(#{cano}, #{categoryName})")
    public int save(Category category); // 보통 저장 메서드는 저장된 엔티티의 ID나, 저장된 행의 수를 반환합니다.

    // 카테고리 번호에 해당하는 Category 엔티티를 찾는 메서드
    @Select("select * from category where cano = #{cano}")
    public Category findByCano(Long cano);

    // 카테고리 ID가 존재하는지 확인하는 메서드
    @Select("SELECT COUNT(cano) FROM category WHERE cano = #{cano}")
    public int countById(Long cano);
    
    // existsById 메소드를 사용하기 위한 기본적인 구현체를 제공
    default public boolean existsById(Long cano) {
        // countById 메소드를 호출하여 categoryId가 존재하는지 확인
        return countById(cano) > 0;
    }
	
	
}
