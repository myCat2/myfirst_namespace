package com.ambow.booksmanager.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.ambow.booksmanager.domain.Reader;

public interface ReaderMapper {
	/*Reader queryReaderById(int id);*/
	List<Reader> queryReaderList(String key);
	int queryReaderById(int readerId);
	int insertReader(Reader reader);
	/*	int deleteReader(int id);*/
	int deleteReaderList(@Param(value="ids") int[] ids);
	int updateReader(Reader reader);
}
