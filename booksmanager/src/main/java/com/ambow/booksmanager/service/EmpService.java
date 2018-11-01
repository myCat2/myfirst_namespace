package com.ambow.booksmanager.service;

import java.util.List;
import java.util.Map;

import com.ambow.booksmanager.domain.Emp;

public interface EmpService {
	public Emp login(String EmpLoginName, String EmpLoginPwd, int type);

	public List<Emp> findAllEmp();
	public List<Emp> findEmpRole();

	public Emp findEmpByName(String name);

	public int saveEmp(Emp emp);

	public int modifyEmp(Emp emp);

	public void removeEmp(int empId);
	
	public int removeEmpByIds(String ids);
	
	public int modifyPassWord(String password,int id);

	public List<Map<String, Object>> pieData();

	public List<Map<String, Object>> barData();

	public Emp findEmpById(String empId);

}
