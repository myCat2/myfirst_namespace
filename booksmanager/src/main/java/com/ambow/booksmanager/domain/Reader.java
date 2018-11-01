package com.ambow.booksmanager.domain;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

public class Reader {
    private Integer readerId;

    private String readerName;

    private String readerSex;
    
    
    private Date readerDate;

    private String readerIdentity;

    private String readerTel;

    private String readerAddress;
    
    private String readerState; 

    public String getReaderState() {
		return readerState;
	}

	public void setReaderState(String readerState) {
		this.readerState = readerState;
	}

	public Integer getReaderId() {
        return readerId;
    }

    public void setReaderId(Integer readerId) {
        this.readerId = readerId;
    }

    public String getReaderName() {
        return readerName;
    }

    public void setReaderName(String readerName) {
        this.readerName = readerName == null ? null : readerName.trim();
    }

    public String getReaderSex() {
        return readerSex;
    }
    public void setReaderSex(String readerSex) {
        this.readerSex = readerSex == null ? null : readerSex.trim();
    }
    
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8") 
    public Date getReaderDate() {
        return readerDate;
    }
    @JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone = "GMT+8") 
    public void setReaderDate(Date readerDate) {
        this.readerDate = readerDate;
    }

    public String getReaderIdentity() {
        return readerIdentity;
    }

    public void setReaderIdentity(String readerIdentity) {
        this.readerIdentity = readerIdentity == null ? null : readerIdentity.trim();
    }

    public String getReaderTel() {
        return readerTel;
    }

    public void setReaderTel(String readerTel) {
        this.readerTel = readerTel == null ? null : readerTel.trim();
    }

    public String getReaderAddress() {
        return readerAddress;
    }

    public void setReaderAddress(String readerAddress) {
        this.readerAddress = readerAddress == null ? null : readerAddress.trim();
    }

  
}