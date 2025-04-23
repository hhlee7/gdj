<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>난수 생성 연습</h1>
	<%
		double num = Math.random(); // 0.00... ~ 0.99...
		System.out.println(num);
		// 요구사항 : 0 ~ 9
		int num2 = (int)(num * 10); // 0.00... ~ 9.99...
		System.out.println(num2);
		// 요구사항 : 1 ~ 6
		int diceNum = (int)((num * 5) + 1);
		System.out.println(diceNum);
	%>
</body>
</html>