package com.ambow.booksmanager.domain;

import java.math.BigDecimal;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Borrow {
    private Integer borrowId;

    private Integer booktypeId;

    private Integer bookId;

    private Integer readerId;

    private Integer empId;

    private Integer borrowIsback;

    private Date borrowDate;

    private Date backDate;

    private Integer borrowIsdamaged;

    private Integer borrowDay;

    private Integer borrowExceedDay;

    private BigDecimal borrowPrice;

    private Integer borrowState;
    
    

	public Integer getBorrowId() {
        return borrowId;
    }

    public void setBorrowId(Integer borrowId) {
        this.borrowId = borrowId;
    }

    public Integer getBooktypeId() {
        return booktypeId;
    }

    public void setBooktypeId(Integer booktypeId) {
        this.booktypeId = booktypeId;
    }

    public Integer getBookId() {
        return bookId;
    }

    public void setBookId(Integer bookId) {
        this.bookId = bookId;
    }

    public Integer getReaderId() {
        return readerId;
    }

    public void setReaderId(Integer readerId) {
        this.readerId = readerId;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public Integer getBorrowIsback() {
        return borrowIsback;
    }

    public void setBorrowIsback(Integer borrowIsback) {
        this.borrowIsback = borrowIsback;
    }
    
    public Date getBorrowDate() {
        return borrowDate;
    }
    
    public void setBorrowDate(Date borrowDate) {
        this.borrowDate = borrowDate;
    }
    
    public Date getBackDate() {
        return backDate;
    }
    public void setBackDate(Date backDate) {
        this.backDate = backDate;
    }

    public Integer getBorrowIsdamaged() {
        return borrowIsdamaged;
    }

    public void setBorrowIsdamaged(Integer borrowIsdamaged) {
        this.borrowIsdamaged = borrowIsdamaged;
    }

    public Integer getBorrowDay() {
        return borrowDay;
    }

    public void setBorrowDay(Integer borrowDay) {
        this.borrowDay = borrowDay;
    }

    public Integer getBorrowExceedDay() {
        return borrowExceedDay;
    }

    public void setBorrowExceedDay(Integer borrowExceedDay) {
        this.borrowExceedDay = borrowExceedDay;
    }

    public BigDecimal getBorrowPrice() {
        return borrowPrice;
    }

    public void setBorrowPrice(BigDecimal borrowPrice) {
        this.borrowPrice = borrowPrice;
    }

    public Integer getBorrowState() {
        return borrowState;
    }

    public void setBorrowState(Integer borrowState) {
        this.borrowState = borrowState;
    }
}