package com.ambow.booksmanager.service;

import java.util.List;

import com.ambow.booksmanager.domain.Book;
import com.ambow.booksmanager.domain.BookType;



public interface BookService {
	//添加方法
	public int addBook(Book book);
	//删除方法
	public int removeUserByIds(String ids);
	//修改方法
	public int modifyBook(Book book);
	//保存图书
	public int saveBook(Book book);
	//通过ID查询图书
	public Book findBookById(int bookid);
	//通过作者或者书名
	public List<Book> findBooksByStr(String str);
	//查询所有
	public List<Book> findAll();
	//查询图书类型下拉框
	public List<BookType> findAllType();
	
	//借阅后更新图书状态
	int updateState(int bookId);
	//还书后更新图书归还时间
	int updateTime(int bookId);

	
	public List<Book> findAllBookType(String bookTypeId ,String str,int page ,int rows);
}
