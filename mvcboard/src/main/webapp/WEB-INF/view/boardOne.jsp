<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="mvcboard.dto.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<%
		// Board board = (Board)request.getAttribute("board");
		// 실무에서 사용 X
		
		// FM
		Object obj = request.getAttribute("board");
		Board board = null; // 모델
		if(obj instanceof Board) {
			board = (Board)obj;
		}
		
		if(board != null) {
	%>
	<table border="1">
		<tr>
			<th>no</th>
			<td><%=board.getBoardNo()%></td>
		</tr>
		<tr>
			<th>title</th>
			<td><%=board.getBoardTitle()%></td>
		</tr>
		<tr>
			<th>content</th>
			<td><%=board.getBoardContent()%></td>
		</tr>
		<tr>
			<th>user</th>
			<td><%=board.getBoardUser()%></td>
		</tr>
		<tr>
			<th>date</th>
			<td><%=board.getBoardDate()%></td>
		</tr>
	</table>
	<%
		}
	%>
	<div>
		<a href="<%=request.getContextPath()%>/modifyBoard?boardNo=<%=board.getBoardNo()%>">수정</a>
		<a href="<%=request.getContextPath()%>">삭제</a>
	</div>
</body>
</html>