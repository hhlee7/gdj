<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginForm</title>
</head>
<body>
	<h1>로그인 폼</h1>
	<form action="/web0310/loginAction2.jsp">
		<table border="1">
			<tr>
				<td>ID</td>
				<td><input type="text" name="id"></td>
			</tr>
			<tr>
				<td>PW</td>
				<td><input type="password" name="pw"></td>
			</tr>
			<tr>
				<td colspan="2"><button type="submit">로그인</button></td>
			</tr>
		</table>
	</form>
</body>
</html>