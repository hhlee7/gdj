<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	// 로그인 상태 확인
	Integer staffId = (Integer)(session.getAttribute("loginStaff"));
			
	if(staffId == null) { // 로그아웃 상태라면 로그인 페이지로 이동
		response.sendRedirect("/sakila/d0328/loginForm.jsp");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<div>
		<%=staffId%>님, 반갑습니다.
		<a href="/sakila/d0328/logout.jsp">[로그아웃]</a>
		<a href="/sakila/d0328/updatePasswordForm.jsp">[비밀번호 수정]</a>
	</div>
	<hr>
	<h1>Index</h1>
	<ol>
		<li><a href="/sakila/d0325/rentalList.jsp">대여 목록</a></li>
		<li><a href="/sakila/d0326/filmList.jsp">필름 목록</a></li>
		<li><a href="/sakila/d0326/actorList.jsp">액터 목록</a></li>
		<li><a href="/sakila/d0327/inventoryList.jsp">인벤토리 목록</a></li>
		<li><a href="/sakila/d0401/actorInfoList.jsp">배우 목록</a></li>
		<li><a href="/sakila/d0401/customerList.jsp">고객 목록</a></li>
	</ol>
</body>
</html>