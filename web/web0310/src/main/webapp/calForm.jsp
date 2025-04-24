<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>calForm</title>
</head>
<body>
	<h1>계산기</h1>
	<form action="/web0310/calAction.jsp">
		<input type="number" name="num1">
		<select name="op">
			<option value="add">+</option>
			<option value="subtraction">-</option>
			<option value="multiplication">*</option>
			<option value="division">/</option>
		</select>
		<input type="number" name="num2">
		<button type="submit">계산</button>
	</form>
</body>
</html>