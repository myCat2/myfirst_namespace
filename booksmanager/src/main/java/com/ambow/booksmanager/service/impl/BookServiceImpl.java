package com.ambow.booksmanager.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ambow.booksmanager.dao.BookMapper;
import com.ambow.booksmanager.domain.Book;
import com.ambow.booksmanager.domain.BookType;
import com.ambow.booksmanager.service.BookService;


@Service(value="bookService")
public class BookServiceImpl implements BookService {

	@Autowired
	private BookMapper bookMapper;

	public int addBook(Book book) {
		return bookMapper.insert(book);
	}

	public int removeUserByIds(String ids) {
		return bookMapper.deleteByIds(ids);
	}

	
	public int modifyBook(Book book) {
		return bookMapper.update(book);
	}

	public Book findBookById(int id) {
		return bookMapper.selectById(id);
	}

	public List<Book> findBooksByStr(String str) {
		return bookMapper.selectBooksByStr(str);
	}

	public List<Book> findAll() {
		return bookMapper.selectAll();
	}


	@Override
	public int saveBook(Book book) {
		if(book.getBookId() == 0) {
			return bookMapper.insert(book);
		}else {
			return bookMapper.update(book);
		}
	}

	//带类型的查询所有
	public List<Book> findAllBookType(String bookTypeId, String str,int page ,int rows) {
		return bookMapper.selectAllBookType(bookTypeId , str , (page-1)*rows , rows);
	}

	@Override
	public List<BookType> findAllType() {

		return bookMapper.selectAllType();
	}

	@Override
	public int updateState(int bookId) {
		return bookMapper.updateState(bookId);
	}

	@Override
	public int updateTime(int bookId) {
		return bookMapper.updateTime(bookId);
	}

	

}
