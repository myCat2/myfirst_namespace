package com.ambow.booksmanager.dao;

import java.util.List;

import com.ambow.booksmanager.domain.Menu;
import com.ambow.booksmanager.domain.RoleMenuMiddle;

public interface MenuMapper {

	public List<Menu> findAllMenu();

	public Menu findMenuById(Menu menu);

	public void findMenuByName(Menu menu);

	public void addMenu(Menu menu);

	public void delRoleMenu(RoleMenuMiddle roleMenuMiddle);

	public void delMenu(Menu menu);

	public void updateMenu(Menu menu);

	public List<RoleMenuMiddle> findRoleByMenuId(Menu menu);
}
