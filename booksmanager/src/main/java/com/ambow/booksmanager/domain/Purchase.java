package com.ambow.booksmanager.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Purchase {
	private int purchaseId;
	private String purchaseNo;
	private int bookId;
	private String purchaseReason;
	private Date purchaseDate;
	private int purchaseState;
	private int empId;
	private String purchaseRemark;
	
	private Emp emp;
	public Emp getEmp() {
		return emp;
	}
	public void setEmp(Emp emp) {
		this.emp = emp;
	}
	
	private Book book;
	public Book getBook() {
		return book;
	}
	public void setBook(Book book) {
		this.book = book;
	}
	public int getPurchaseId() {
		return purchaseId;
	}
	public void setPurchaseId(int purchaseId) {
		this.purchaseId = purchaseId;
	}
	public String getPurchaseNo() {
		return purchaseNo;
	}
	public void setPurchaseNo(String purchaseNo) {
		this.purchaseNo = purchaseNo;
	}
	public int getBookId() {
		return bookId;
	}
	public void setBookId(int bookId) {
		this.bookId = bookId;
	}
	public String getPurchaseReason() {
		return purchaseReason;
	}
	public void setPurchaseReason(String purchaseReason) {
		this.purchaseReason = purchaseReason;
	}
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8") 
	public Date getPurchaseDate() {
		return purchaseDate;
	}
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8") 
	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}
	public int getPurchaseState() {
		return purchaseState;
	}
	public void setPurchaseState(int purchaseState) {
		this.purchaseState = purchaseState;
	}
	public int getEmpId() {
		return empId;
	}
	public void setEmpId(int empId) {
		this.empId = empId;
	}
	public String getPurchaseRemark() {
		return purchaseRemark;
	}
	public void setPurchaseRemark(String purchaseRemark) {
		this.purchaseRemark = purchaseRemark;
	}
	@Override
	public String toString() {
		return "Purchase [purchaseId=" + purchaseId + ", purchaseNo=" + purchaseNo + ", bookId=" + bookId
				+ ", purchaseReason=" + purchaseReason + ", purchaseDate=" + purchaseDate + ", purchaseState="
				+ purchaseState + ", empId=" + empId + ", purchaseRemark=" + purchaseRemark + "]";
	}
	
	
}
