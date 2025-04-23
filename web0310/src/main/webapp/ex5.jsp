<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bo.Box"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		int z = Box.add(3, 5); // static
		
		Box b = new Box();
		int k = b.mul(2, 2); // not static
		
		double a = Math.random(); // static
		
		// HttpRequest request;
		String s = request.getParameter("id"); // not static
	%>
</body>
</html>