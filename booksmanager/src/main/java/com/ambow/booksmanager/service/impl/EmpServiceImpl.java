package com.ambow.booksmanager.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;

import com.ambow.booksmanager.dao.EmpMapper;
import com.ambow.booksmanager.domain.Emp;
import com.ambow.booksmanager.service.EmpService;
@Service(value="empService")
public class EmpServiceImpl implements EmpService {

	@Resource(name="empMapper")
	private EmpMapper empMapper;
	@Override
	public Emp login(String EmpLoginName, String EmpLoginPwd, int type) {
		// TODO Auto-generated method stub
		return empMapper.login(EmpLoginName, EmpLoginPwd, type);
	}

	@Override
	public List<Emp> findAllEmp() {
		// TODO Auto-generated method stub
		return empMapper.findAllEmp();
	}

	@Override
	public Emp findEmpByName(String name) {
		// TODO Auto-generated method stub
		return empMapper.findEmpByName(name);
	}

	@Override
	public int saveEmp(Emp emp) {
		// TODO Auto-generated method stub
		
		return empMapper.saveEmp(emp);

	}

	@Override
	public int modifyEmp(Emp emp) {
		// TODO Auto-generated method stub
		
		return empMapper.modifyEmp(emp);

	}

	@Override
	public void removeEmp(int empId) {
		// TODO Auto-generated method stub
		empMapper.removeEmp(empId);

	}

	@Override
	public int removeEmpByIds(String ids) {
		// TODO Auto-generated method stub
		return empMapper.removeEmpByIds(ids);
	}

	@Override
	public List<Emp> findEmpRole() {
		// TODO Auto-generated method stub
		return empMapper.findEmpRole();
	}

	@Override
	public int modifyPassWord(String password, int id) {
		// TODO Auto-generated method stub
		return empMapper.modifyPassWord(password, id);
	}
	/**
     * 饼状图数据
     * @return
     */
    public List<Map<String,Object>> pieData(){
        List<Map<String,Object>> data =new ArrayList<>();
        List<Map<String, Object>> listdata=empMapper.count();
        if(listdata.size()>0){
            for(int i=0;i<listdata.size();i++){
                Map<String,Object> map=new HashMap<>();
                map.put("name", listdata.get(i).get("SEX"));
                map.put("value", listdata.get(i).get("SEXCOUNT"));
                data.add(map);
            }
        }
        return data;
    }

	@Override
	public List<Map<String, Object>> barData() {
		
		List<Map<String,Object>> data =new ArrayList<>();
        List<Map<String, Object>> listdata=empMapper.count1();
        if(listdata.size()>0){
            for(int i=0;i<listdata.size();i++){
            	Map<String,Object> map=new HashMap<>();
                map.put("name", listdata.get(i).get("MONTHNAME"));
                map.put("value", listdata.get(i).get("EMPCOUNT"));
                data.add(map);
                //map.get("MONTHNAME");
                System.out.println(map);
            }
        }
        System.out.println(data);
        return data;
	}

	@Override
	public Emp findEmpById(String empId) {
		// TODO Auto-generated method stub
		return empMapper.findEmpById(empId);
	}

}
