package com.ambow.booksmanager.domain;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Book {
	private int bookId;
	private int	bookTypeId;
	private String bookName;
	private String bookWriter;
	private String bookTranslator;
	private Date bookPublicDate;
	private String bookPublicHouse;
	private int bookNum;
	private double bookPrice;
	private int bookState;
	private int bookIsborrow;
	private int bookBorrowDays;
	private BigDecimal bookBorrowPrice;
	private BookType bookType;
	private Date bookReturnTime;
	
	public BookType getBookType() {
		return bookType;
	}

	public Date getBookReturnTime() {
		return bookReturnTime;
	}

	public void setBookReturnTime(Date bookReturnTime) {
		this.bookReturnTime = bookReturnTime;
	}

	public void setBookType(BookType bookType) {
		this.bookType = bookType;
	}

	public Book() {
		super();
	}
	
	public Book(int bookId, int bookTypeId, String bookName, String bookWriter, String bookTranslator,
			Date bookPublicDate, String bookPublicHouse, int bookNum, double bookPrice, int bookState, int bookIsborrow,
			int bookBorrowDays, BigDecimal bookBorrowPrice) {
		super();
		this.bookId = bookId;
		this.bookTypeId = bookTypeId;
		this.bookName = bookName;
		this.bookWriter = bookWriter;
		this.bookTranslator = bookTranslator;
		this.bookPublicDate = bookPublicDate;
		this.bookPublicHouse = bookPublicHouse;
		this.bookNum = bookNum;
		this.bookPrice = bookPrice;
		this.bookState = bookState;
		this.bookIsborrow = bookIsborrow;
		this.bookBorrowDays = bookBorrowDays;
		this.bookBorrowPrice = bookBorrowPrice;
	}

	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public int getBookTypeId() {
		return bookTypeId;
	}
	public void setBookTypeId(int bookTypeId) {
		this.bookTypeId = bookTypeId;
	}
	public String getBookName() {
		return bookName;
	}
	public void setBookName(String bookName) {
		this.bookName = bookName;
	}
	public String getBookWriter() {
		return bookWriter;
	}
	public void setBookWriter(String bookWriter) {
		this.bookWriter = bookWriter;
	}
	public String getBookTranslator() {
		return bookTranslator;
	}
	public void setBookTranslator(String bookTranslator) {
		this.bookTranslator = bookTranslator;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8") 
	public Date getBookPublicDate() {
		return bookPublicDate;
	}
	@JsonFormat(pattern="yyyy-MM-dd",timezone = "GMT+8") 
	public void setBookPublicDate(Date bookPublicDate) {
		this.bookPublicDate = bookPublicDate;
	}
	public String getBookPublicHouse() {
		return bookPublicHouse;
	}
	public void setBookPublicHouse(String bookPublicHouse) {
		this.bookPublicHouse = bookPublicHouse;
	}
	public int getBookNum() {
		return bookNum;
	}
	public void setBookNum(int bookNum) {
		this.bookNum = bookNum;
	}
	public double getBookPrice() {
		return bookPrice;
	}
	public void setBookPrice(double bookPrice) {
		this.bookPrice = bookPrice;
	}
	public int getBookState() {
		return bookState;
	}
	public void setBookState(int bookState) {
		this.bookState = bookState;
	}
	public int getBookIsborrow() {
		return bookIsborrow;
	}
	public void setBookIsborrow(int bookIsborrow) {
		this.bookIsborrow = bookIsborrow;
	}
	public int getBookBorrowDays() {
		return bookBorrowDays;
	}
	public void setBookBorrowDays(int bookBorrowDays) {
		this.bookBorrowDays = bookBorrowDays;
	}
	public BigDecimal getBookBorrowPrice() {
		return bookBorrowPrice;
	}
	public void setBookBorrowPrice(BigDecimal bookBorrowPrice) {
		this.bookBorrowPrice = bookBorrowPrice;
	}
	@Override
	public String toString() {
		return "Book [bookId=" + bookId + ", bookTypeId=" + bookTypeId + ", bookName=" + bookName + ", bookWriter="
				+ bookWriter + ", bookTranslator=" + bookTranslator + ", bookPublicDate=" + bookPublicDate
				+ ", bookPublicHouse=" + bookPublicHouse + ", bookNum=" + bookNum + ", bookPrice=" + bookPrice
				+ ", bookState=" + bookState + ", bookIsborrow=" + bookIsborrow + ", bookBorrowDays=" + bookBorrowDays
				+ ", bookBorrowPrice=" + bookBorrowPrice + "]";
	}
	
}
