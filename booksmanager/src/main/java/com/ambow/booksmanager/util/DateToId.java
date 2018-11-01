package com.ambow.booksmanager.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Locale;

public  class DateToId {
	public  static String  getStringDateId() {
		SimpleDateFormat df1 = new SimpleDateFormat("yyyyMMddHHmmss",Locale.US);
		return df1.format(new Date());
	}
}
