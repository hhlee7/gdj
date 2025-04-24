<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>ex12</h1>
	<%
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		// System.out.println(id);
		// System.out.println(pw);
	%>
	<div>
		ID : <%=id%>
		<br>
		PW : <%=pw%>
	</div>
</body>
</html>