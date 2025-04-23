<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>addBoard</h1>
	<form method="post" action="<%=request.getContextPath()%>/addBoard">
		<table border="1">
			<tr>
				<th>title</th>
				<td><input type="text" name="boardTitle"></td>
			</tr>
			<tr>
				<th>content</th>
				<td><textarea rows="5" cols="50" name="boardContent"></textarea></td>
			</tr>
			<tr>
				<th>user</th>
				<td><input type="text" name="boardUser"></td>
			</tr>
			<tr>
				<th>pw</th>
				<td><input type="password" name="boardPw"></td>
		</table>
		<button type="submit">등록</button>
	</form>
</body>
</html>