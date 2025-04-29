<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="mvcboard.dto.*"%>
<%@page import="java.util.*"%>
<%
	Board board = (Board)request.getAttribute("board");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>addBoard</h1>
	<form method="post" action="<%=request.getContextPath()%>/modifyBoard">
		<table border="1">
			<!-- PK값은 readonly -->
			<tr>
				<th>boardNo</th>
				<td><input type="text" name="boardNo" value="<%=board.getBoardNo()%>" readonly></td>
			</tr>
			<tr>
				<th>title</th>
				<td><input type="text" name="boardTitle" value="<%=board.getBoardTitle()%>"></td>
			</tr>
			<tr>
				<th>content</th>
				<td><textarea rows="5" cols="50" name="boardContent"><%=board.getBoardContent()%></textarea></td>
			</tr>
			
			<!-- 확인용으로 입력값 받음 -->
			<tr>
				<th>pw</th>
				<td><input type="password" name="boardPw"></td>
		</table>
		<button type="submit">등록</button>
	</form>
</body>
</html>