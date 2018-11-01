package com.ambow.booksmanager.service;

import java.util.List;
import java.util.Map;


import com.ambow.booksmanager.domain.Reader;

public interface ReaderService {
	/*Reader queryReaderById(int id);*/
	List<Reader> queryReaderList(String key);
	int queryReaderById(int readerId);
	int insertReader(Reader reader);
	/*int deleteReader(int id);*/
	int deleteReaderList(int[] ids);
	int updateReader(Reader reader);
}
