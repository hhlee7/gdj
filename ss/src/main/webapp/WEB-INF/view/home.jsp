<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>Home</h1>
	
	<hr>
	
	<!-- 로그인이 안 되어있다면 -->
	<c:if test="${loginUsername == 'anonymousUser'}">
		<a href="/addUser">회원가입</a>
		<a href="/login">로그인</a>
	</c:if>
	
	<!-- 로그인이 되어있다면 -->
	<c:if test="${loginUsername != 'anonymousUser'}">
		${loginUsername}님 반갑습니다.
		<a href="/logout">로그아웃</a> <!-- 로그아웃 설정은 SecurityConfig.class -->
		<a href="/user/editUser">회원수정</a>
		<form action="/user/delete" method="post" onsubmit="return confirm('정말 탈퇴하시겠습니까?')">
			<button>회원 탈퇴</button>
		</form>
	</c:if>
</body>
</html>