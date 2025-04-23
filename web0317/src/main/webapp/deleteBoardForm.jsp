<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<form action="/web0317/deleteBoardAction.jsp">
		<input type="hidden" name="boardNo" value="<%=boardNo%>">
		<div>
			boardPw : 
			<input type="password" name="boardPw">
			<button type="submit">삭제</button>
		</div>
	</form>
</body>
</html>