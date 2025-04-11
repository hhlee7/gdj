<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 현재 로그인 상태 확인
	String AdminId = (String)(session.getAttribute("loginAdmin"));
			
	if(AdminId != null) { // 로그인 상태라면 index 페이지로 이동
		response.sendRedirect("/cashbook/index.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<h1>Login</h1>
	<form action="/cashbook/loginAction.jsp">
		<table class="table table-hover">
			<tr>
				<th>ID</th>
				<td><input type="text" name="adminId"></td>
			</tr>
			<tr>
				<th>PW</th>
				<td><input type="password" name="adminPw"></td>
			</tr>
		</table>
		<%
			if(request.getParameter("msg") != null) {
		%>
				<div><%=request.getParameter("msg")%></div>
		<%
			}
		%>
		<button type="submit" class="btn btn-outline-primary">로그인</button>
	</form>
</body>
</html>