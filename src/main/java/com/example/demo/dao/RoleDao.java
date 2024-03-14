package com.example.demo.dao;

import com.example.demo.entity.Role;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface RoleDao {
    @Select("SELECT * FROM role WHERE rno = #{rno}")
    List<Role> getRolesByRno(Long rno);
}