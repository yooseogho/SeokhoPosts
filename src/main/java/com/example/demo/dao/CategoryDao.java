package com.example.demo.dao;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.entity.Category;

@Mapper
public interface CategoryDao {
	
	
	@Insert("insert into category values(#{cano},#{categoryName},#{pno})")
	public Category save();
	
	@Select("select * from category where cano =#{cano}")
	 public Long findByCano();

}
