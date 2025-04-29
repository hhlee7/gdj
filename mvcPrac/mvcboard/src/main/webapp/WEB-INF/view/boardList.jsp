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
	<h1>boardList</h1>
	<%
		// 원래는 instanceof 있어야 함
		ArrayList<Board> list = (ArrayList<Board>)request.getAttribute("list");
		int lastPage = (Integer)request.getAttribute("lastPage");
	%>
	<table border="1">
		<tr>
			<th>no</th>
			<th>title</th>
			<th>user</th>
			<th>date</th>
		</tr>
		<%
			for(Board b : list) {
		%>
		<tr>
			<td><%=b.getBoardNo()%></td>
			<td><a href="<%=request.getContextPath()%>/boardOne?boardNo=<%=b.getBoardNo()%>"><%=b.getBoardTitle()%></a></td>
			<td><%=b.getBoardUser()%></td>
			<td><%=b.getBoardDate()%></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>