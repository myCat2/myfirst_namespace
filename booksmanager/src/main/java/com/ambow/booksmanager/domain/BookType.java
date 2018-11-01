package com.ambow.booksmanager.domain;

public class BookType {
	private int bookTypeId;
	private String bookTypeName;
	private int bookTypeState;
	
	public BookType() {
		super();
	}
	public BookType(int bookTypeId, String bookTypeName, int bookTypeState) {
		super();
		this.bookTypeId = bookTypeId;
		this.bookTypeName = bookTypeName;
		this.bookTypeState = bookTypeState;
	}
	@Override
	public String toString() {
		return "Booktype [bookTypeId=" + bookTypeId + ", bookTypeName=" + bookTypeName + ", bookTypeState="
				+ bookTypeState + "]";
	}
	public int getBookTypeId() {
		return bookTypeId;
	}
	public void setBookTypeId(int bookTypeId) {
		this.bookTypeId = bookTypeId;
	}
	public String getBookTypeName() {
		return bookTypeName;
	}
	public void setBookTypeName(String bookTypeName) {
		this.bookTypeName = bookTypeName;
	}
	public int getBookTypeState() {
		return bookTypeState;
	}
	public void setBookTypeState(int bookTypeState) {
		this.bookTypeState = bookTypeState;
	}
	
}
