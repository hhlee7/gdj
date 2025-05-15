<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>adminHome</title>
</head>
<body>
	<h1>${loginMember.memberId}관리자</h1>
	<div><a href="/logout">로그아웃</a></div>
	<h2><a href="admin/memberList">멤버 리스트</a></h2>
	<!--
		회원가입 = Ajax API 아이디 중복검사 후
		memberRole 수정
	 -->
</body>
</html>