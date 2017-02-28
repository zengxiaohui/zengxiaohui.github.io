生成时间戳：
	long currentTime=System.currentTimeMillis();

时间格式化：
	Date date=new Date();
	DateFormat format=new SimpleDateFormat("yyyy-MM-dd");
	String retime=format.format(date);

jsp：
	1.<fmt:formatDate value="${date}" type="both"/>  
	输出格式: 2010-5-31 23:59:59  
	2.<fmt:formatDate value="${date}" type="date"/>  
	输出格式: 2010-4-1  
	3.<fmt:formatDate value="${date}" type="time"/>  
	输出格式: 23:59:59  
	4.<fmt:formatDate value="${date}" type="date" dateStyle="default"/>  
	输出格式:2010-5-31  	  
	5.<fmt:formatDate value="${date}" type="date" dateStyle="short"/>  
	输出格式:04-5-31  	  
	6.<fmt:formatDate value="${date}" type="date" dateStyle="medium"/>  
	输出格式:2010-5-31  	  
	7.<fmt:formatDate value="${date}" type="date" dateStyle="long"/>  
	输出格式: 2010年5月31日  	  
	8.<fmt:formatDate value="${date}" type="date" dateStyle="full"/>  
	输出格式:2010年5月31日 星期一  	  
	9.<fmt:formatDate value="${date}" type="time" timeStyle="default"/>  
	输出格式: 23:59:59  	  
	10.<fmt:formatDate value="${date}" type="time" timeStyle="short"/>  
	输出格式:下午11:59  	  
	11.<fmt:formatDate value="${date}" type="time" timeStyle="medium"/>  
	输出格式: 23:59:59  	  
	12.<fmt:formatDate value="${date}" type="time" timeStyle="long"/>  
	输出格式: 下午11时59分59秒  	  
	13.<fmt:formatDate value="${date}" type="time" timeStyle="full"/>  
	输出格式: 下午11时59分59秒 CDT  	  
	14.<fmt:formatDate value="${date}" type="both" pattern="EEEE, MMMM d, yyyy 输出格式: HH:mm:ss Z"/>  
	星期四, 四月 1, 2010 13:30:00 -0600  	  
	15.<fmt:formatDate value="${date}" type="both" pattern="d MMM yy, h:m:s a zzzz/>  
	输出格式: 31 五月 04, 11:59:59 下午 中央夏令时 