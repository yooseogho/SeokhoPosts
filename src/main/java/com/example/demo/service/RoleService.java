package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.dao.RoleDao;
import com.example.demo.entity.Role;

@Service
public class RoleService {
    @Autowired
    private RoleDao roleDao;
    
    public List<Role> getRolesByRno(Long rno) {
        return roleDao.getRolesByRno(rno);
    }

}
