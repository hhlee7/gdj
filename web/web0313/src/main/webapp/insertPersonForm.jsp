<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>명함 입력</h1>
	<form action="/web0313/insertPersonAction.jsp">
		<table border="1">
			<tr>
				<th>NAME</th>
				<td>
					<input type="text" name="name">
				</td>
			</tr>
			<tr>
				<th>BIRTH</th>
				<td>
					<input type="number" name="birth" min="1900" max="2025">
				</td>
			</tr>
			<tr>
				<th>MEMO</th>
				<td>
					<textarea rows="5" cols="80" name="memo"></textarea>
				</td>
			</tr>
		</table>
		<button type="submit">입력</button>
	</form>
</body>
</html>