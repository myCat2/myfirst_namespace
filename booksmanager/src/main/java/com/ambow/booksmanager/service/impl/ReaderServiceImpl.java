package com.ambow.booksmanager.service.impl;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ambow.booksmanager.dao.ReaderMapper;
import com.ambow.booksmanager.domain.Reader;
import com.ambow.booksmanager.service.ReaderService;

@Service(value="readerService")
public class ReaderServiceImpl implements ReaderService{
	
	@Autowired
	private ReaderMapper readerMapper;
	
	/*@Override
	public Reader queryReaderById(int id) {
		return readerMapper.queryReaderById(id);
	}*/

	@Override
	public List<Reader> queryReaderList(String key) {
		return readerMapper.queryReaderList(key);
	}

	@Override
	public int insertReader(Reader reader) {
		return readerMapper.insertReader(reader);
	}

	@Override
	public int deleteReaderList(int[] ids) {
		return readerMapper.deleteReaderList(ids);
	}

	@Override
	public int updateReader(Reader reader) {
		return readerMapper.updateReader(reader);
	}

	@Override
	public int queryReaderById(int readerId) {
		return readerMapper.queryReaderById(readerId);
	}

	
	
}
