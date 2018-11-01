package com.ambow.booksmanager.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ambow.booksmanager.domain.Book;
import com.ambow.booksmanager.domain.BookType;
import com.ambow.booksmanager.domain.Purchase;
import com.ambow.booksmanager.service.BookService;
import com.ambow.booksmanager.service.BookTypeService;
import com.ambow.booksmanager.util.DateToId;

@Controller
@RequestMapping("/bookType")	
public class BookTypeController {
	
	@Resource(name="bookTypeService")
	private BookTypeService bookTypeService;
	
	
	/**
	 * 保存或者添加
	 */
	@RequestMapping("/save")
	@ResponseBody
	public Map<String, String> save(BookType bookType){
		
		System.out.println(bookType.toString());
		Map<String, String> map = new HashMap<>();
		if(bookTypeService.save(bookType)>0) {
			map.put("msg", "success");
			return map;//����в�����Ŀ����
		}
		map.put("msg", "fail");
		return map;
	}	
	
	/**
	 * 查询所有
	 */
	@RequestMapping("/booktypelist")
	@ResponseBody
	public Map<String,Object> booktypelist(String page ,String rows, @RequestParam(value="str",required=false,defaultValue="")String str){
		System.out.println("=====" + " ******------+++"+str);
		
		List<BookType> bookTypeList = bookTypeService.list("%"+str+"%",Integer.parseInt(page),Integer.parseInt(rows));
		Long count = bookTypeService.count();
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("total", count);
		map.put("rows", bookTypeList);
		return map;
	}
	/**
	 * 批量删除
	 */
	@RequestMapping("/delete")
	@ResponseBody
	public Map<String, Object> delete(@RequestParam(value="ids") String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result = bookTypeService.delete(ids);
		if(result>0) {
			map.put("msg", "success");
			return map;
		}
		map.put("msg", "fail");
		return map;
	}
	/**
	 * 查询图书编号和图书名称下拉框
	 */
	@RequestMapping("/bookIdandName")
	@ResponseBody
	public List<Book> selectBookIdandName() {
		
		List<Book> list = bookTypeService.selectBookIdandName();
		return list;
	}
	/**
	 * 提交申请,并下架
	 */
	@RequestMapping("/addapplacation")
	@ResponseBody
	public Map<String, String> addapplacation(Purchase purchase){
		//purchase.set();
	try {
		purchase.setPurchaseNo(DateToId.getStringDateId());
		System.out.println(purchase.toString()+" -----------"+purchase.getPurchaseDate());
		//格式化输出时间
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		java.util.Date time=null;
		time= sdf.parse(sdf.format(new Date()));
		purchase.setPurchaseDate(time); 
		
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Map<String, String> map = new HashMap<>();
		int result1 = bookTypeService.addapplacation(purchase);
		int result2 = bookTypeService.deleteBookById(purchase.getBookId());
		if(result1>0&&result2>0) {
			map.put("msg", "success");
			return map;
		}
		map.put("msg", "fail");
		return map;
	}
	
	
	

	/**
	 * 查询所有申请记录
	 */
	@RequestMapping("/Purchaselist")
	@ResponseBody
	public Map<String,Object> Purchaselist(String page ,String rows){
		System.out.println("=====" + " ******------+++");
		
		List<Purchase> purchaseList = bookTypeService.selectAllPurchase(Integer.parseInt(page),Integer.parseInt(rows));
		Long count = bookTypeService.Purchasecount();
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("total", count);
		map.put("rows", purchaseList);
		return map;
	}
	/**
	 * 批量修改审批类型,并上架
	 */
	@RequestMapping("/update")
	@ResponseBody
	public Map<String, Object> update(@RequestParam(value="ids") String ids,@RequestParam(value="bookids") String bookids) {
		Map<String, Object> map = new HashMap<String, Object>();
		int result1 = bookTypeService.update(ids);
		int result2 = bookTypeService.updateUpBook(bookids);
		if(result1>0&&result2>0) {
			map.put("msg", "success");
			return map;
		}
		map.put("msg", "fail");
		return map;
	}
	
}
