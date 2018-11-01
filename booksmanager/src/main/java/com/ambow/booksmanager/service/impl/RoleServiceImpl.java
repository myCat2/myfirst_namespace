package com.ambow.booksmanager.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ambow.booksmanager.dao.RoleMapper;
import com.ambow.booksmanager.domain.Emp;
import com.ambow.booksmanager.domain.Role;
import com.ambow.booksmanager.domain.RoleEmpMiddle;
import com.ambow.booksmanager.domain.RoleMenuMiddle;
import com.ambow.booksmanager.service.RoleService;
@Service(value="roleService")
public class RoleServiceImpl implements RoleService {
	@Resource(name="roleMapper")
	private RoleMapper roleMapper;

	@Override
	public int modify(Emp emp) {
		// TODO Auto-generated method stub
		return roleMapper.modify(emp);
	}

	
}
