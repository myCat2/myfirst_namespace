package com.ambow.booksmanager.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.ambow.booksmanager.domain.Book;
import com.ambow.booksmanager.domain.BookType;
import com.ambow.booksmanager.domain.Purchase;

public interface BookTypeMapper {
	
	int insert(BookType bookType);
	//字符串 必须使用 @Param(value="ids")
	int delete(@Param(value="ids") String ids);
	
	int update(BookType bookType);
	
	List<BookType> selectAllList(@Param(value="str") String str,@Param(value="page") int page ,@Param(value="rows") int rows);
	
	Long getCount();
	
	List<Book> selectAllBookIdandName();
	
	int addapplacation(Purchase purchase);
	/*查询所有申请表*/
	List<Purchase> selectAllPurchase(@Param(value="page") int page ,@Param(value="rows") int rows);
	
	Long getPurchaseCount();
	
	int updateType(@Param(value="ids") String ids);
	
	int deleteBookById(int bookId);
	
	int updateUpBook(@Param(value="bookids") String bookids);
}
