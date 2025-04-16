<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 현재 로그인 상태 확인
	String AdminId = (String)(session.getAttribute("loginAdmin"));
			
	if(AdminId == null) { // 로그아웃 상태라면 로그인 페이지로 이동
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<!-- nav.jsp include -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1 class="fw-bold fs-2">목차</h1>
	<ul class="list-group list-group-numbered">
		<li class="list-group-item">
			<a href="/cashbook/category/categoryList.jsp">카테고리 목록</a>
		</li>
		<li class="list-group-item">
			<a href="/cashbook/monthList.jsp">가계부 달력</a>
		</li>
		<li class="list-group-item">
			<a href="/cashbook/stats.jsp">수입 / 지출 통계</a>
		</li>
	</ul>
</body>
</html>