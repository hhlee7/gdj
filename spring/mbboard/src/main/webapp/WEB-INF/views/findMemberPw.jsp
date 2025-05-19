<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>findMemberPw</title>
</head>
<body>
	<h1>비밀번호 찾기</h1>
	<form method="post" action="/findMemberPw">
		memberID : <input type="text" name="memberId">
		<br>
		email : <input type="text" name="email">
		<br>
		<button type="submit">비밀번호 찾기</button>
		* 10분안에 비밀번호 변경
	</form>
</body>
</html>