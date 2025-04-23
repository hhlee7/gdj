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
	String sn1 = request.getParameter("sn1");
	String sn2 = request.getParameter("sn2");
	
	String gender = "남자";
	int genderNum = Integer.parseInt(sn2.substring(0, 1)); 
	if(genderNum % 2 == 0) { // sn2의 첫번째 숫자는 짝수
		gender = "여자";
	}
	
	String strBirthYear = sn1.substring(0, 2); // 4자리 중 뒤 2자리
	// 앞에 19 or 20
	if(genderNum == 1 || genderNum == 2 || genderNum == 5 || genderNum == 6) {
		strBirthYear = "19" + strBirthYear;
	} else if(genderNum == 3 || genderNum == 4 || genderNum == 7 || genderNum == 8) {
		strBirthYear = "20" + strBirthYear;
	} else {
		System.out.println("잘못된 주민번호입니다.");
	}
	
	// 생일
	int birthYear = Integer.parseInt(strBirthYear);
	int birthMonth = Integer.parseInt(sn1.substring(2, 4));
	int birthDate = Integer.parseInt(sn1.substring(4));
	
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
	
%>
	<div>성별 : <%=gender%></div>
	<div>나이 : <%=age%></div>
</body>
</html>