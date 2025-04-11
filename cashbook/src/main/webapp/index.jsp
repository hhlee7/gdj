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
</head>
<body class="container">
	<!-- nav.jsp include -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1>Index</h1>
	<ul>
		<li>
			<a href="/cashbook/category/categoryList.jsp">카테고리 목록</a>
		</li>
	</ul>
</body>
</html>