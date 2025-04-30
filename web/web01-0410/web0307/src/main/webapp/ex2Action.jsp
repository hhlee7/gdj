<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String birth = request.getParameter("birth");
	String gender = request.getParameter("gender");
	String myColor = request.getParameter("myColor");
	// request 매개값 디버깅
	System.out.println("ex2Action.jsp birth: " + birth);
	System.out.println("ex2Action.jsp gender: " + gender);
	System.out.println("ex2Action.jsp myColor: " + myColor);
	
	// m -> 이모지 boy &#128102;
	// g -> 이모지 girl &#128103;
	
	String strBirthYear = birth.substring(0, 4); // 0번째부터 4번째 앞까지 잘라서 반환
	int birthYear = Integer.parseInt(strBirthYear);
	int birthMonth = Integer.parseInt(birth.substring(5, 7));
	int birthDate = Integer.parseInt(birth.substring(8));
	// 오늘 날짜 년도에서 생일 년도를 빼기
	// 오늘 날짜
	Calendar today = Calendar.getInstance();
	int todayYear = today.get(Calendar.YEAR);
	int todayMonth = today.get(Calendar.MONTH) + 1;
	int todayDate = today.get(Calendar.DATE);
	
	int age = 0;
	age = todayYear - birthYear;
	// 만약 생일이 아직 지나지 않았다면 -1 : 1) 생일의 월이 오늘의 월보다 크다. 2) 생일의 월이 같고 일이 크다.
	if(birthMonth > todayMonth) { // 생일이 아직 지나지 않았다
		age = age - 1; // age -= 1; age--; --age;
	} else if(birthMonth == todayMonth && birthDate > todayDate) {
		age = age - 1;
	}
	
	String genderEmoji = "";
	if(gender.equals("M")) {
		genderEmoji = "&#128102";
	} else {
		genderEmoji = "&#128103";
		
	}
%>
	<table border="1">
		<tr>
			<td>나이</td>
			<td><%=age%></td>
		</tr>
		<tr>
			<td>성별</td>
			<td><%=genderEmoji%></td>
		</tr>
		<tr>
			<td>좋아하는 색깔</td>
			<td style="background-color:<%=myColor%>;"><%=myColor%></td>
		</tr>
	</table>
</body>
</html>