package com.ambow.booksmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ambow.booksmanager.domain.Book;
import com.ambow.booksmanager.domain.BookType;


public interface BookMapper {
	
	    int insert(Book book);
	
	    Book selectById(int id);
	    //xml里面没写
	    int update(Book book);
	    
		List<Book> selectAll();
		
		List<Book> selectAllBookType(@Param(value="bookTypeId") String bookTypeId ,@Param(value="str") String str,@Param(value="page") int page,@Param(value="rows") int rows);
		
		List<Book> selectBooksByStr(String str);
		
		int deleteByIds(@Param(value="ids") String ids);
		
		List<BookType> selectAllType();
		
		int updateState(int bookId);
		
		int updateTime(int bookId);
}
