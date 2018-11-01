package com.ambow.booksmanager.domain;

public class RoleEmpMiddle {

	private int roleEmpId;
	private Role role;
	private Emp emp;

	public int getRoleEmpId() {
		return roleEmpId;
	}

	public void setRoleEmpId(int roleEmpId) {
		this.roleEmpId = roleEmpId;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	public Emp getEmp() {
		return emp;
	}

	public void setEmp(Emp emp) {
		this.emp = emp;
	}

	@Override
	public String toString() {
		return "RoleEmpMiddle [roleEmpId=" + roleEmpId + ", role=" + role + ", emp=" + emp + "]";
	}

	public RoleEmpMiddle(int roleEmpId, Role role, Emp emp) {
		super();
		this.roleEmpId = roleEmpId;
		this.role = role;
		this.emp = emp;
	}

	public RoleEmpMiddle() {
		super();
	}

}
