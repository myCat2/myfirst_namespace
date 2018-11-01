package com.ambow.booksmanager.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.web.bind.annotation.RequestParam;

import com.ambow.booksmanager.domain.Emp;

public interface EmpMapper {
	public Emp login(@Param("EmpLoginName")String EmpLoginName, @Param("EmpLoginPwd")String EmpLoginPwd,@Param("type")int type);

	public List<Emp> findAllEmp();
	
	public List<Emp> findEmpRole();

	public Emp findEmpByName(String name);

	public int saveEmp(Emp emp);

	public int modifyEmp(Emp emp);

	public void removeEmp(int empId);
	
	public int removeEmpByIds(@Param("ids")String ids);
	
	public int modifyPassWord(@Param("password")String password,@Param("id")int id);
	
	public Emp findEmpById(@Param("empId")String empId);

	//统计男女用户人数
    @Select("select case when emp_sex='女' then '女' when emp_sex='男' then '男' end as SEX,count(emp_sex) as SEXCOUNT from empinfo group by emp_sex")
    List<Map<String,Object>> count();
    
    @Select("select MONTHNAME(emp_entry_date) as MONTHNAME,count(emp_id) as EMPCOUNT from empinfo group by MONTHNAME(emp_entry_date)")
    List<Map<String,Object>> count1();

}
