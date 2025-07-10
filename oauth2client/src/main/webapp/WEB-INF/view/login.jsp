<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SNS Login</title>

<!-- Font Awesome 아이콘 사용 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
body {
	font-family: Arial, sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
	background-color: #f4f4f4;
}

.sns-login {
	display: flex;
	flex-direction: column;
	gap: 12px;
	width: 220px;
}

.sns-login a {
	display: flex;
	align-items: center;
	justify-content: center;
	text-decoration: none;
	padding: 12px 20px;
	font-size: 16px;
	font-weight: bold;
	border-radius: 5px;
	transition: background-color 0.3s ease;
}

.google {
	background-color: #dd4b39;
	color: white;
}

.google:hover {
	background-color: #c23321;
}

.naver {
	background-color: #03c75a;
	color: white;
}

.naver:hover {
	background-color: #02b14a;
}

.kakao {
	background-color: #ffe812;
	color: #3c1e1e;
}

.kakao:hover {
	background-color: #ffdf00;
}

.sns-login i {
	margin-right: 8px;
}
</style>
</head>
<body>
	<div class="sns-login">
		<a href="/oauth2/authorization/naver" class="naver">
			<i class="fas fa-leaf"></i>Naver Login
		</a>
		<a href="/oauth2/authorization/google" class="google">
			<i class="fab fa-google"></i>Google Login
		</a>
		<a href="" class="kakao">
			<i class="fas fa-comment"></i>Kakao Login
		</a>
	</div>
</body>
</html>
