<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>j04.jsp</title>
</head>
<body>
	<h1>연산자</h1>
	<%
		int a = 5;
		int b = 3;
		int c1, c2, c3, c4, c5;
		
		c1 = a + b;
		/*
			c1 = 5 + b;
			c1 = 5 + 3;
			c1 = 8;
		*/
		c2 = a - b;
		c3 = a * b;
		c4 = a / b;
		c5 = a % b;
		
		double d = (double)a / (double)b; // d = 5.0 / 3.0
		// double d2 = (double)a / b;
		System.out.println(c1);
		System.out.println(c2);
		System.out.println(c3);
		System.out.println(c4);
		System.out.println(c5);
		System.out.println(d);
		
		int x = 10;
		x = ++x; // x = x + 1; // 11
		x = x++; // x = x + 1; // 12
	%>
</body>
</html>