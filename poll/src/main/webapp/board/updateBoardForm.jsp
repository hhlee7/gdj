<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	// 전달된 num 값 확인
	System.out.println("updateBoardForm.jsp num: " + num);
	
	BoardDao boardDao = new BoardDao();
	Board b = boardDao.selectBoardOne(num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateBoardForm</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<!-- nav.jsp include -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1>글수정</h1>
	<form method="post" action="/poll/board/updateBoardAction.jsp">
		<input type="hidden" name="num" value="<%=num%>">
		<table class="table table-hover">
			<tr>
				<td>name</td>
				<td><input type="text" name="name" value="<%=b.getName()%>"></td>
			</tr>
			<tr>
				<td>subject</td>
				<td><input type="text" name="subject" value="<%=b.getSubject()%>"></td>
			</tr>
			<tr>
				<td>content</td>
				<td><textarea name="content" rows="5" cols="50"><%=b.getContent()%></textarea></td>
			</tr>
			<tr>
				<td>pass</td>
				<td><input type="password" name="pass"></td>
			</tr>
		</table>
		<button class="btn btn-outline-primary" type="submit">수정하기</button>
	</form>
</body>
</html>