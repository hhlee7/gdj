<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%!
	// 태어난 해를 입력하면 나이를 반환하는 메서드
	public int getAge(int year) {
		int age = 0;
		Calendar today = Calendar.getInstance();
		int todayYear = today.get(Calendar.YEAR);
		age = todayYear - year;
		return age;
	}

	public int getAgeKo(int year, int month, int date) {
		int age = 0;
		Calendar today = Calendar.getInstance();
		int todayYear = today.get(Calendar.YEAR);
		int todayMonth = today.get(Calendar.MONTH) + 1;
		int todayDate = today.get(Calendar.DATE);
		
		age = todayYear - year;
		if(month > todayMonth) {
			age--; // age = age - 1;
		} else if(month == todayMonth && date > todayDate) {
			age--;			
		}		
		return age;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	나이 : <%=getAge(1994)%>
	나이 : <%=getAgeKo(1994, 5, 5)%>
</body>
</html>