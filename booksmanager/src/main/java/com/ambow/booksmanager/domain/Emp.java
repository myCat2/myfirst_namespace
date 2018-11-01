package com.ambow.booksmanager.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Emp {
	private int empId;
	private String empLoginName;
	private String empLoginPwd;
	private String empName;
	private String empSex;
	private Date empEntryDate;
	private String empTel;
	private String empAddress;
	private String empRemark;
	private int empState;
	private Role role;
	private int roleId;

	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public String getEmpLoginName() {
		return empLoginName;
	}

	public void setEmpLoginName(String empLoginName) {
		this.empLoginName = empLoginName;
	}

	public String getEmpLoginPwd() {
		return empLoginPwd;
	}

	public void setEmpLoginPwd(String empLoginPwd) {
		this.empLoginPwd = empLoginPwd;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getEmpSex() {
		return empSex;
	}

	public void setEmpSex(String empSex) {
		this.empSex = empSex;
	}
	 @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8") 
	public Date getEmpEntryDate() {
		return empEntryDate;
	}
	 @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8") 
	public void setEmpEntryDate(Date empEntryDate) {
		this.empEntryDate = empEntryDate;
	}

	public String getEmpTel() {
		return empTel;
	}

	public void setEmpTel(String empTel) {
		this.empTel = empTel;
	}

	public String getEmpAddress() {
		return empAddress;
	}

	public void setEmpAddress(String empAddress) {
		this.empAddress = empAddress;
	}

	public String getEmpRemark() {
		return empRemark;
	}

	public void setEmpRemark(String empRemark) {
		this.empRemark = empRemark;
	}

	public int getEmpState() {
		return empState;
	}

	public void setEmpState(int empState) {
		this.empState = empState;
	}

	

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}

	
	public int getRoleId() {
		return roleId;
	}

	public void setRoleId(int roleId) {
		this.roleId = roleId;
	}

	

	@Override
	public String toString() {
		return "Emp [empId=" + empId + ", empLoginName=" + empLoginName + ", empLoginPwd=" + empLoginPwd + ", empName="
				+ empName + ", empSex=" + empSex + ", empEntryDate=" + empEntryDate + ", empTel=" + empTel
				+ ", empAddress=" + empAddress + ", empRemark=" + empRemark + ", empState=" + empState + ", role="
				+ role + ", roleId=" + roleId + "]";
	}

	public Emp(int empId, String empLoginName, String empLoginPwd, String empName, String empSex, Date empEntryDate,
			String empTel, String empAddress, String empRemark, int empState, Role role, int roleId) {
		super();
		this.empId = empId;
		this.empLoginName = empLoginName;
		this.empLoginPwd = empLoginPwd;
		this.empName = empName;
		this.empSex = empSex;
		this.empEntryDate = empEntryDate;
		this.empTel = empTel;
		this.empAddress = empAddress;
		this.empRemark = empRemark;
		this.empState = empState;
		this.role = role;
		this.roleId = roleId;
	}

	public Emp() {
		super();
	}

}
