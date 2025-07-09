<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>회원 수정</h1>
	<hr>
	<form action="/user/editUserAction" method="post">
    	current password: <input type="password" name="currentPassword">
    	<br>
    	new password: <input type="password" name="newPassword">
		<br>
		<button>수정</button>
	</form>
</body>
</html>