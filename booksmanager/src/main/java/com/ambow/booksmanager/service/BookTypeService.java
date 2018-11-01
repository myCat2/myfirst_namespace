package com.ambow.booksmanager.service;

import java.util.List;

import com.ambow.booksmanager.domain.Book;
import com.ambow.booksmanager.domain.BookType;
import com.ambow.booksmanager.domain.Purchase;

public interface BookTypeService {
	
	
	public int save(BookType bookType);
	
	public int delete(String ids);
	
	public List<BookType> list(String str,int page ,int rows);
	
	public Long count();

	public List<Book> selectBookIdandName();
	
	public int addapplacation(Purchase purchase); 
	
	public List<Purchase> selectAllPurchase(int page ,int rows);
	
	public Long Purchasecount();
	
	public int update(String ids);
	
	public int deleteBookById(int bookId);
	
	public int updateUpBook(String bookids);
}
