<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int boardNo = Integer.parseInt(request.getParameter("boardNo"));
	int commentNo = Integer.parseInt(request.getParameter("commentNo"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<form action="/web0317/deleteCommentAction.jsp">
		<input type="hidden" name="boardNo" value="<%=boardNo%>">
		<input type="hidden" name="commentNo" value="<%=commentNo%>">
		<div>
			commentPw : 
			<input type="password" name="commentPw">
			<button type="submit">삭제</button>
		</div>
	</form>
</body>
</html>