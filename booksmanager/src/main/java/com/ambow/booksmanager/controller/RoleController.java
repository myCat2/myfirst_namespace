package com.ambow.booksmanager.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ambow.booksmanager.domain.Emp;
import com.ambow.booksmanager.service.RoleService;

@Controller
@RequestMapping("/role")
public class RoleController {
	@Autowired
	RoleService roleService;
	/**
	 * 修改员工
	 */
	@RequestMapping("/update.do")
	@ResponseBody
	public Map<String, String> modify(Emp emp) {

		Map<String, String> map = new HashMap<>();
		if (roleService.modify(emp) > 0) {
			map.put("msg", "success");
			return map;
		} else {
			map.put("msg", "fail");
			return map;
		}
	}
}
