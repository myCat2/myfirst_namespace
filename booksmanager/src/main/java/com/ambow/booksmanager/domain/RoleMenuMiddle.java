package com.ambow.booksmanager.domain;

public class RoleMenuMiddle {

	private int roleMenuId;
	private Role role;
	private Menu menu;

	public int getRoleMenuId() {
		return roleMenuId;
	}

	public void setRoleMenuId(int roleMenuId) {
		this.roleMenuId = roleMenuId;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	@Override
	public String toString() {
		return "RoleMenuMiddle [roleMenuId=" + roleMenuId + ", role=" + role + ", menu=" + menu + "]";
	}

	public RoleMenuMiddle(int roleMenuId, Role role, Menu menu) {
		super();
		this.roleMenuId = roleMenuId;
		this.role = role;
		this.menu = menu;
	}

	public RoleMenuMiddle() {
		super();
	}

}
