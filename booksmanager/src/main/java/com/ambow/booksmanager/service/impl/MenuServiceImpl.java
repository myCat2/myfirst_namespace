package com.ambow.booksmanager.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.ambow.booksmanager.dao.MenuMapper;
import com.ambow.booksmanager.domain.Menu;
import com.ambow.booksmanager.domain.RoleMenuMiddle;
import com.ambow.booksmanager.service.MenuService;

@Service(value = "menuService")
public class MenuServiceImpl implements MenuService {
	@Resource(name = "menuMapper")
	private MenuMapper menuMapper;

	@Override
	public List<Menu> findAllMenu() {
		// TODO Auto-generated method stub
		return menuMapper.findAllMenu();
	}

	@Override
	public Menu findMenuById(Menu menu) {
		// TODO Auto-generated method stub
		return menuMapper.findMenuById(menu);
	}

	@Override
	public void findMenuByName(Menu menu) {
		// TODO Auto-generated method stub
		menuMapper.findMenuByName(menu);

	}

	@Override
	public void addMenu(Menu menu) {
		// TODO Auto-generated method stub
		menuMapper.addMenu(menu);

	}

	@Override
	public void delRoleMenu(RoleMenuMiddle roleMenuMiddle) {
		// TODO Auto-generated method stub
		menuMapper.delRoleMenu(roleMenuMiddle);

	}

	@Override
	public void delMenu(Menu menu) {
		// TODO Auto-generated method stub
		menuMapper.delMenu(menu);

	}

	@Override
	public void updateMenu(Menu menu) {
		// TODO Auto-generated method stub
		menuMapper.updateMenu(menu);

	}

	@Override
	public List<RoleMenuMiddle> findRoleByMenuId(Menu menu) {
		// TODO Auto-generated method stub
		return menuMapper.findRoleByMenuId(menu);
	}

}
