<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>rechangeMemberPw</title>
</head>
<body>
	<h1>rechangeMemberPw</h1>
	<form method="post" action="/rechangeMemberPw">
		<div>
			memberId : <input type="text" name="memberId">
		</div>
		<div>
			메일로 받은 PW : <input type="password" name="MemberPw">
		</div>
		<div>
			변경할 PW : <input type="password" name="reMemberPw">
		</div>
		<button type="submit">패스워드 변경</button>
	</form>
</body>
</html>