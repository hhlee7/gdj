<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	// 전달된 num 값 확인
	System.out.println("deleteBoardForm.jsp num: " + num);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>deleteBoardForm</title>
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
	
	<h1>글삭제</h1>
	<form method="post" action="/poll/board/deleteBoardAction.jsp">
		<input type="hidden" name="num" value="<%=num%>">
		<table class="table table-hover">
			<tr>
				<td>pass</td>
				<td><input type="password" name="pass"></td>
			</tr>
		</table>
		<button class="btn btn-outline-primary" type="submit">삭제하기</button>
	</form>
</body>
</html>