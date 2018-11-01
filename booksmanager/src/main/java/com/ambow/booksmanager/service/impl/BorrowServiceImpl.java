package com.ambow.booksmanager.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ambow.booksmanager.dao.BorrowMapper;
import com.ambow.booksmanager.domain.Borrow;
import com.ambow.booksmanager.domain.BorrowDto;
import com.ambow.booksmanager.service.BorrowService;

@Service(value="borrowService")
public class BorrowServiceImpl implements BorrowService{
	
	@Autowired
	private BorrowMapper borrowMapper;

	@Override
	public List<BorrowDto> queryBorrowList(String key) {
		return borrowMapper.queryBorrowList(key);
	}

	@Override
	public int insertBorrow(Borrow borrow) {
		int flag=borrowMapper.insertBorrow(borrow);
		return flag;
	}

	@Override
	public int insertReturn(Borrow borrow) {
		return borrowMapper.insertReturn(borrow);
	}

	@Override
	public int deleteBorrow(int[] ids) {
		return borrowMapper.deleteBorrow(ids);
	}

	@Override
	public int updateBorrow(Borrow borrow) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int queryCount(int readerId) {
		return borrowMapper.queryCount(readerId);
	}

	@Override
	public int queryBorrowDays(int bookId) {
		return borrowMapper.queryBorrowDays(bookId);
	}

	@Override
	public Borrow queryById(int borrowId) {
		return borrowMapper.queryById(borrowId);
	}

	@Override
	public List<Map<String, Object>> queryHistoricalBorrow(int readerId) {
		return borrowMapper.queryHistoricalBorrow(readerId);
	}

}
