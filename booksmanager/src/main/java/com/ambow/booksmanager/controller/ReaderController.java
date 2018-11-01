package com.ambow.booksmanager.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.support.HttpRequestHandlerServlet;

import com.ambow.booksmanager.domain.Reader;
import com.ambow.booksmanager.service.ReaderService;

@Controller
@RequestMapping("/reader")
public class ReaderController {
	//缓存所有reader的变量
	List<Reader> readerList=null;
	
	@Resource(name="readerService")
	private ReaderService readerService;
	
	/*@RequestMapping("/queryReaderById")
	@ResponseBody
	public Reader queryReaderById(@Param("id") int id) {
		Reader reader=readerService.queryReaderById(id);
		return reader;
	}*/
	
	@RequestMapping("/queryReaderList")
	@ResponseBody
	public Map<String,Object> queryReaderList(
			@RequestParam(value="page", required=false, defaultValue="1") Integer page,
			@RequestParam(value="rows", required=false, defaultValue="10") Integer rows,
			@RequestParam(value="key", required=true, defaultValue="") String key) {
		Map<String,Object> map=new HashMap<String,Object>();
		
		if(null==key) {
			key="";
		}
		key="%"+key+"%";
		readerList=readerService.queryReaderList(key);
		
		List<Reader> list=null;
		if((page*rows)<readerList.size())
			list=readerList.subList((page-1)*rows, page*rows);
		else 
			list=readerList.subList((page-1)*rows, readerList.size());
		
		map.put("total", readerList.size());
		map.put("rows", list);
		return map;
	}
	
	@RequestMapping("/insertReader")
	@ResponseBody
	public Map<String,Object> insertReader(@RequestBody Reader reader) {
		Map<String,Object> map=new HashMap<String,Object>();
		
		int flag=readerService.insertReader(reader);
		
		if(flag>0) {
			map.put("flag", flag);
		}else {
			map.put("flag", 0);
		}
		
		return map;
	}
	
	@RequestMapping("/updateReader")
	@ResponseBody
	public Map<String,Object> updateReader(@RequestBody Reader reader) {
		Map<String,Object> map=new HashMap<String,Object>();
		
		int flag=readerService.updateReader(reader);
		
		if(flag>0) {
			map.put("flag", flag);
		}else {
			map.put("flag", 0);
		}
		
		return map;
	}
	
	@RequestMapping("/deleteReaderList")
	@ResponseBody
	public Map<String,Object> deleteReaderList(int[] ids) {
		Map<String,Object> map=new HashMap<String,Object>();
		
		int flag=readerService.deleteReaderList(ids);
		
		if(flag>0) {
			map.put("flag", flag);
		}else {
			map.put("flag", 0);
		}
		
		return map;
	}
	
	
}
