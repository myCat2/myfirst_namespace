package com.ambow.booksmanager.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ambow.booksmanager.domain.Emp;
import com.ambow.booksmanager.service.EmpService;

@Controller
@RequestMapping("/emp")
public class EmpController {
	@Autowired
	EmpService empService;

	/**
	 * 员工列表
	 */
	@ResponseBody
	@RequestMapping("/list.do")
	public List<Emp> list() {

		return this.empService.findEmpRole();
	}

	/**
	  * 根据用户Id查询详情
	 */
	@RequestMapping("/update1.do")
	@ResponseBody
	public void findEmpById(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String EmpId = request.getParameter("EmpId");
		System.out.println(EmpId);
		Emp Emp = empService.findEmpById(EmpId);
			request.getSession().setAttribute("emp", Emp);
	}
	/**
	 * 保存用户信息
	 */
	@RequestMapping("/save.do")
	@ResponseBody
	public Map<String, String> save(@RequestBody Emp emp) {

		Map<String, String> map = new HashMap<>();
		if (empService.saveEmp(emp) > 0) {
			map.put("msg", "success");
			return map;
		} else {
			map.put("msg", "fail");
			return map;
		}

	}

	/**
	 * 修改员工
	 */
	@RequestMapping("/update.do")
	@ResponseBody
	public Map<String, String> modify(Emp emp) {

		Map<String, String> map = new HashMap<>();
		if (empService.modifyEmp(emp) > 0) {
			map.put("msg", "success");
			return map;
		} else {
			map.put("msg", "fail");
			return map;
		}

	}

	/**
	 * 多选删除
	 */
	@RequestMapping("/deleteByIds.do")
	@ResponseBody
	public Map<String, String> deleteByIds(String ids) {
		Map<String, String> map = new HashMap<>();
		if (empService.removeEmpByIds(ids) > 0) {
			map.put("msg", "success");
			return map;// 框架中不加项目名称
		} else {
			map.put("msg", "fail");
			return map;
		}
	}

	/**
	 * 登录
	 */
	@RequestMapping("/login.do")
	@ResponseBody
	public Map<String, String> login(HttpServletRequest request, HttpServletResponse response) throws IOException {
		// 获取用户输入的账户
		String EmpLoginName = request.getParameter("EmpLoginName");
		// 获取用户输入的密码
		String EmpLoginPwd = request.getParameter("EmpLoginPwd");

		// 获取登录类型
		int type = Integer.parseInt(request.getParameter("type"));
		// 返回信息
		Map<String, String> map = new HashMap<>();

		// 判断用户名和密码是否正确

		// 查询用户是否存在
		Emp loginUser = empService.login(EmpLoginName, EmpLoginPwd, type);
		if (loginUser == null) {// 如果用户名或密码错误
			map.put("msg", "loginError");
		} else { // 正确
			if (type == 1) {
				map.put("msg", "admin");
			} else if (type == 2) {
				map.put("msg", "Sadmin");
			} else if (type == 3) {
				map.put("msg", "manager");
			} else if (type == 4) {
				map.put("msg", "boss");
			}
			// 将该用户名保存到session中
			request.getSession().setAttribute("user", loginUser);
		}
		// 返回登录信息
		return map;
	}
	/**
	 * 根据登录者身份转到普通管理员界面
	 */
	@RequestMapping("/admin.do")
	public void Admin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/view/admin/AdminMain.jsp").forward(request, response);
	}
	/**
	 * 根据登录者身份转到高级管理员界面
	 */
	@RequestMapping("/Sadmin.do")
	public void Sadmin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/view/admin/SAdmin.jsp").forward(request, response);
	}
	/**
	 * 根据登录者身份转到采购经理界面
	 */
	@RequestMapping("/manager.do")
	public void Manager(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/view/admin/Manager.jsp").forward(request, response);
	}
	/**
	 * 根据登录者身份转到馆长界面
	 */
	@RequestMapping("/boss.do")
	public void Boos(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/view/admin/Boss.jsp").forward(request, response);
	}
	/**
	 * 退出登录
	 */
	@RequestMapping("/loginOut.do")
	private void loginOut(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 退出系统时清除系统登录的用户
		request.getSession().removeAttribute("user");
		String contextPath = request.getContextPath();
		// 转发到登录界面
		response.sendRedirect(contextPath + "/index.jsp");
	}
	/**
	 * 修改当前登录密码
	 */
	@RequestMapping("/newPwd.do")
	@ResponseBody
	public Map<String, String> editPassword(HttpServletRequest request, HttpServletResponse response)
			throws IOException {

		int id = Integer.parseInt((request.getParameter("id")));
		String password = request.getParameter("password");
		Map<String, String> map = new HashMap<>();
		if (empService.modifyPassWord(password, id) > 0) {
			map.put("msg", "success");
			return map;
		} else {
			map.put("msg", "fail");
			return map;
		}
	}
	/**
     * 获取饼状图数据
     * @return
     */
    @RequestMapping("/echartsData.do")
    @ResponseBody
    public List<Map<String, Object>> echartsData(){
        return empService.pieData();
    }
    @RequestMapping("/EntryDate.do")
    @ResponseBody
    public List<Map<String, Object>> EntryDate(){
        return empService.barData();
    }
}
