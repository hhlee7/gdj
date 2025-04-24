<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<form action="/web0313/deleteQnaAction.jsp">
		<input type="hidden" name="num" value="<%=num%>">
		<div>
			PW : <input type="password" name="pw">
		</div>
		<button type="submit">삭제</button>
	</form>
</body>
</html>