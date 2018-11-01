package com.ambow.booksmanager.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Service;


import com.ambow.booksmanager.dao.BookTypeMapper;
import com.ambow.booksmanager.domain.Book;
import com.ambow.booksmanager.domain.BookType;
import com.ambow.booksmanager.domain.Purchase;
import com.ambow.booksmanager.service.BookTypeService;

@Service(value="bookTypeService")
public class BookTypeServiceImpl implements BookTypeService{

	@Autowired
	private BookTypeMapper bookTypeMapper;
	
	public int save(BookType bookType) {
		if(bookType.getBookTypeId()!=0) {
			return bookTypeMapper.update(bookType);
		}else {
			return bookTypeMapper.insert(bookType);
		}
	
	}

	public int delete(String ids) {
		return bookTypeMapper.delete(ids);
	}

	
	public List<BookType> list(String str, int page, int rows) {
		return bookTypeMapper.selectAllList(str,(page-1)*rows , rows);
	}

	@Override
	public Long count() {
		return bookTypeMapper.getCount();
	}

	
	public List<Book> selectBookIdandName() {
		return bookTypeMapper.selectAllBookIdandName();
		
	}

	
	public int addapplacation(Purchase purchase) {
		return bookTypeMapper.addapplacation(purchase);
	}

	
	public List<Purchase> selectAllPurchase(int page, int rows) {
		return bookTypeMapper.selectAllPurchase((page-1)*page, rows);
	}

	@Override
	public Long Purchasecount() {
		return bookTypeMapper.getPurchaseCount();
	}

	@Override
	public int update(String ids) {
		return bookTypeMapper.updateType(ids);
	}

	@Override
	public int deleteBookById(int bookId) {
		return bookTypeMapper.deleteBookById(bookId);

	}

	@Override
	public int updateUpBook(String bookids) {
		return bookTypeMapper.updateUpBook(bookids);
	}

}
