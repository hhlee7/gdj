<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>MyPage</h1>
	<hr>
	${loginUsername}님, 반갑습니다.<br>
	ROLE : ${loginRole}<br>
	<a href="/logout">로그아웃</a>
</body>
</html>