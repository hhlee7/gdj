<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>insertBoardForm</h1>
	<form action="/web0317/insertBoardAction.jsp">
		<table border="1">
			<tr>
				<th>boardTitle</th>
				<td><input type="text" name="boardTitle"></td>
			</tr>		
			<tr>
				<th>boardContent</th>
				<td><textarea rows="5" cols="50" name="boardContent"></textarea></td>
			</tr>		
			<tr>
				<th>boardWriter</th>
				<td><input type="text" name="boardWriter"></td>
			</tr>
			<tr>
				<th>boardPw</th>
				<td><input type="password" name="boardPw"></td>
			</tr>
		</table>
		<button type="submit">입력</button>
	</form>
</body>
</html>