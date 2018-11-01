package com.ambow.booksmanager.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ambow.booksmanager.domain.Book;
import com.ambow.booksmanager.domain.Borrow;
import com.ambow.booksmanager.domain.BorrowDto;
import com.ambow.booksmanager.service.BookService;
import com.ambow.booksmanager.service.BorrowService;
import com.ambow.booksmanager.service.ReaderService;

@Controller
@RequestMapping("/borrow")
public class BorrowController {
	
	private List<BorrowDto> borrowList=null;
	
	@Resource(name="bookService")
	private BookService bookService;
	@Resource(name="borrowService")
	private BorrowService borrowService;
	@Resource(name="readerService")
	private ReaderService readerService;
	
	@RequestMapping("/queryBorrowList")
	@ResponseBody
	public Map<String,Object> queryReaderList(
			@RequestParam(value="page", required=false, defaultValue="1") Integer page,
			@RequestParam(value="rows", required=false, defaultValue="10") Integer rows,
			@RequestParam(value="key", required=true, defaultValue="")String key) {
		Map<String,Object> map=new HashMap<String,Object>();
		
		if(null==key) {
			key="";
		}
		key="%"+key+"%";
		borrowList=borrowService.queryBorrowList(key);
		
		List<BorrowDto> list=null;
		if((page*rows)<borrowList.size())
			list=borrowList.subList((page-1)*rows, page*rows);
		else 
			list=borrowList.subList((page-1)*rows, borrowList.size());
		
		map.put("total", borrowList.size());
		map.put("rows", list);
		return map;
	}
	
	
	@RequestMapping("/insertBorrow")
	@ResponseBody
	public Map<String,Object> insertBorrow(@RequestBody Borrow borrow){
		Map<String,Object> map=new HashMap<String,Object>();
		//读者是否注册
		int isReaderExist=readerService.queryReaderById(borrow.getReaderId());
		if(isReaderExist==0) {
			map.put("flag", -2);//读者没注册
			return map;
		}
		//是否存在未还借阅
		int isBorrow=borrowService.queryCount(borrow.getReaderId());
		if(isBorrow>0) {
			map.put("flag", -1);//读者存在未归还借阅
			return map;
		}
		//当前图书可借阅天数
		int borrowDays=borrowService.queryBorrowDays(borrow.getBookId());
		borrow.setBorrowDay(borrowDays);
		//不存在未归还图书
		int flag=borrowService.insertBorrow(borrow);
		if(flag>0) {//是否借阅成功
			//更新归还时间
			int i=bookService.updateTime(borrow.getBookId());
			if(i>0) {
				map.put("flag", 1);
				return map;
			}
		}
		map.put("flag", "error");
		return map;
	}
	
	@RequestMapping("/deleteBorrowList")
	@ResponseBody
	public Map<String,Object> deleteBorrowList(int[] ids) {
		Map<String,Object> map=new HashMap<String,Object>();
		
		int flag=borrowService.deleteBorrow(ids);
		
		if(flag>0) {
			map.put("flag", flag);
		}else {
			map.put("flag", 0);
		}
		
		return map;
	}
	
	/*
	 * 	1、插入归还时间，是否损坏
		2、返回这条记录，即一个borrow对象
		3、根据归还时间和借阅时间计算借阅天数，与规定天数对比
			超出天数
				根据记录的bookid查询每天借阅费用，计算节约费用
			未超出天数
				继续
		4、update isback，exceed_day,price,state
	 */
	@RequestMapping("/insertReturn")
	@ResponseBody
	public Map<String,Object> insertReturn(
			@RequestBody Borrow borrow){
		Map<String,Object> map=new HashMap<String,Object>();
		Map<String,Object> dataMap=new HashMap<String,Object>();
		
		Borrow addBorrow=new Borrow();
		//插入归还时间、是否损坏
		int flag=borrowService.insertReturn(borrow);
		if(flag>0) {
			//得到借阅记录信息
			Borrow borrow2=borrowService.queryById(borrow.getBorrowId());
			bookService.updateTime(borrow.getBookId());
			//计算实际借阅天数
			long startTime=borrow2.getBorrowDate().getTime();
			long endTime=borrow2.getBackDate().getTime();
			int actualDay=new Long((startTime-endTime)/1000/60/60/24).intValue();
			int exceedDay=(actualDay-borrow2.getBorrowDay())>0?(actualDay-borrow2.getBorrowDay()):0;
			addBorrow.setBorrowExceedDay(exceedDay);
			//根据bookid得到记录
			Book book=bookService.findBookById(borrow.getBookId());
			if(exceedDay>0) {//超期
				//计算借阅费用
				//计算超期的收费和损坏费用，即罚款
				BigDecimal exDay=new BigDecimal(exceedDay);
				BigDecimal price=exDay.multiply(book.getBookBorrowPrice());
				if(borrow.getBorrowIsdamaged()==1) {
					BigDecimal unitPrice=new BigDecimal(book.getBookPrice());
					price=price.add(unitPrice);
				}
				addBorrow.setBorrowPrice(price);
			}else {//没有超期
				if(borrow.getBorrowIsdamaged()==1) {
					BigDecimal unitPrice=new BigDecimal(book.getBookPrice());
					addBorrow.setBorrowPrice(unitPrice);
				}else {//没有损坏
					addBorrow.setBorrowPrice(new BigDecimal(0));
				}
				addBorrow.setBorrowId(borrow.getBorrowId());
				addBorrow.setBorrowIsback(1);
				//这里先不能改，因为会导致后面查询不到这条记录
				//addBorrow.setBorrowState(0);
			}
			int i=borrowService.insertReturn(addBorrow);
			if(i>0) {
				map.put("flag", "success");
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				Borrow borrow3=borrowService.queryById(borrow.getBorrowId());
				String date1=sdf.format(borrow3.getBorrowDate());
				String date2=sdf.format(borrow3.getBackDate());
				dataMap.put("r_borrowDate", date1);
				dataMap.put("r_returnDate", date2);
				dataMap.put("r_allowDays", borrow3.getBorrowDay());
				dataMap.put("r_exceedDays", borrow3.getBorrowExceedDay());
				dataMap.put("r_damagedBook", borrow3.getBorrowIsdamaged());
				dataMap.put("r_punishMoney", borrow3.getBorrowPrice());
				//状态值为0
				Borrow delBorrow=new Borrow();
				delBorrow.setBorrowId(borrow.getBorrowId());
				delBorrow.setBorrowState(0);
				borrowService.insertReturn(delBorrow);
				map.put("dataMap", dataMap);
			}else {
				map.put("flag", "fail");
			}
		}else {
			map.put("flag", "error");
		}
		
		
		return map;
	}
	
	@RequestMapping("/queryHistoricalBorrow")
	@ResponseBody
	public Map<String,Object> queryHistoricalBorrow(
			@RequestParam(value="readerId", required=false, defaultValue="0")int readerId) {
		Map<String,Object> map=new HashMap<String,Object>();
		//结果集
		List<Map<String,Object>> list=
				borrowService.queryHistoricalBorrow(readerId);
		//返回集
		List<Map<String,Object>> result=null;
		//遍历结果集，如果归还时间为null，即map中没有归还时间，就加上
		Iterator it=list.iterator();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		while(it.hasNext()) {
			Map<String,Object> midMap=(Map<String, Object>) it.next();
			//如果还没有归还
			if(midMap.get("returnTime")==null) {
				midMap.put("returnTime", "未归还");
				midMap.put("borrowPrice", "0");
			}
			//格式化时间
			midMap.put("borrowTime", sdf.format((Date)midMap.get("borrowTime")));
			midMap.put("returnTime", sdf.format((Date)midMap.get("returnTime")));
			
			if(result==null) {
				result=new ArrayList<Map<String,Object>>();
			}
			result.add(midMap);
		}
		
		//没有数据
		if(result==null) {
			map.put("flag", "NoData");
			return map;
		}
		
		map.put("total", result.size());
		map.put("rows", result);
		return map;
	}
}
