package com.ambow.booksmanager.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import javax.annotation.Resource;


import org.apache.log4j.Logger;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ambow.booksmanager.domain.Book;
import com.ambow.booksmanager.domain.BookType;
import com.ambow.booksmanager.service.BookService;

@Controller
@RequestMapping("/book")
public class BookController {
	
		@Resource(name="bookService")
		private BookService bookService;
		private static Logger logger = Logger.getLogger(BookController.class);
		/**
		  * 根据用户Id查询用户详情
		 */
		@RequestMapping("/detail")
		public String detail(int bookId ,Model model){
			Book book = bookService.findBookById(bookId);
			model.addAttribute("book",book);
			System.out.println("执行了");
			return "book/detail";
		}
		/**
		 * 修改用户信息
		 */
		@RequestMapping("/update")
		@ResponseBody
		public Map<String, String> update( Book book){
			//System.out.println(bookName+"---------------");	
			System.out.println(book.toString());
			Map<String, String> map = new HashMap<>();
			bookService.modifyBook(book);
			map.put("msg", "success");
			return map;//框架中不加项目名称
		}	
		/**
		  * 保存用户信息
		 */
		@RequestMapping("/save")
		@ResponseBody
		public Map<String, String> save( Book book){
			
			Map<String, String> map = new HashMap<>();
			System.out.println(book.toString());
			if(bookService.addBook(book)>0) {
				map.put("msg", "success");
				return map;//框架中不加项目名称
			}else {
				map.put("msg", "fail");
				return map;
			}
			
		}
		/**
		 * 图书种类下拉框
		 */
		@RequestMapping("/booktypelist")
		@ResponseBody
		public List<BookType> bookTypelist(){
			
			List<BookType> list = bookService.findAllType();
			BookType bookType = new BookType();
			bookType.setBookTypeId(0);
			bookType.setBookTypeName("请选择");
			list.add(bookType);
			return list;
		}
		/**
		 * 用户列表展示
		 */
		@RequestMapping("/booklist")
		@ResponseBody
		public Map<String,Object> list(
				@RequestParam(value="page",required=false,defaultValue="1")String page ,
				@RequestParam(value="rows",required=false,defaultValue="10")String rows,
				@RequestParam(value="bookTypeId",required=false,defaultValue="")String bookTypeId,
				@RequestParam(value="str",required=false,defaultValue="")String str){
			System.out.println(page +"-----"+rows+"  =====" + bookTypeId+"  +++"+str);
			logger.info("调用了bookService的list方法。");
			List<Book> bookList = bookService.findAllBookType(bookTypeId,"%"+str+"%",Integer.parseInt(page),Integer.parseInt(rows));
			List<Book> countList = bookService.findAll();
		
//			List<User> userList = userService.findAllUserRoles();
			long count = countList.size();
			Map<String, Object> map = new HashMap<String, Object>();
			System.out.println("Controller执行了"+bookList.size()+"11");
			map.put("total", count);
			map.put("rows", bookList);
			return map;
		}
		/**
		 * 删除
		 */
		@RequestMapping("/delete")
		@ResponseBody
		public Map<String, Object> delete(@RequestParam(value="ids") String ids) {
			Map<String, Object> map = new HashMap<String, Object>();
			
			int result = bookService.removeUserByIds(ids);
			if(result>0) {
				map.put("msg", "success");
				return map;
			}
			map.put("msg", "fail");
			return map;
		}
}
