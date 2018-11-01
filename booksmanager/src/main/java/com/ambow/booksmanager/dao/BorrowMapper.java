package com.ambow.booksmanager.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.ambow.booksmanager.domain.Borrow;
import com.ambow.booksmanager.domain.BorrowDto;

public interface BorrowMapper {
	List<BorrowDto> queryBorrowList(String key);
	Borrow queryById(int borrowId);
	//插入借阅的相关数据
	int insertBorrow(Borrow borrow);
	//插入归还的相关数据
	int insertReturn(Borrow borrow);
	int deleteBorrow(@Param(value="ids") int[] ids);
	
	//查询读者是否存在未还记录
	int queryCount(int readerId);
	//查询某本书的可借天数
	int queryBorrowDays(int bookId);
	//查询读者历史借阅
	List<Map<String,Object>> queryHistoricalBorrow(int readerId);
	
}	
