<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	hello
	<br>
	<%
		for(int i = 1; i <= 10; i = i + 1) {
			out.print(i);
		}
	%>
</body>
</html>
