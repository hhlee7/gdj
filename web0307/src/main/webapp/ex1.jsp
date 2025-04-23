<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>title</title>
</head>
<body>
<%
	Calendar c = null;
	c = Calendar.getInstance(); // c는 오늘 날짜 정보를 참조한다.
	int year = c.get(Calendar.YEAR);
	int month = c.get(Calendar.MONTH);
	int date = c.get(Calendar.DATE);
	int dayOfWeek = c.get(Calendar.DAY_OF_WEEK); // 데이터 1 ~ 7 -> 정보 일 ~ 토
	String yo = "";
	if(dayOfWeek == 1) {
		yo = "일";
	} else if(dayOfWeek == 2) {
		yo = "월";
	} else if(dayOfWeek == 3) {
		yo = "화";
	} else if(dayOfWeek == 4) {
		yo = "수";
	} else if(dayOfWeek == 5) {
		yo = "목";
	} else if(dayOfWeek == 6) {
		yo = "금";
	} else if(dayOfWeek == 7) {
		yo = "토";
	}
%>
	<div>오늘 날짜 정보 : <%=c%></div>
	<div><%=year%>년 <%=month+1%>월 <%=date%>일 <%=yo%>요일</div>
</body>
</html>