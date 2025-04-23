<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>homeworkForm</title>
</head>
<body>
	<h1>나이 검색</h1>
	<form action="/web0310/homeworkAction.jsp">
		<div>
			성별 :
			<input type="radio" value="M" name="gender">남
			<input type="radio" value="F" name="gender">여
		</div>
		<div>
			나이 :
			<input type="number" min="0" max="100" name="age">
		</div>
		<button type="submit">검색</button>
	</form>
</body>
</html>