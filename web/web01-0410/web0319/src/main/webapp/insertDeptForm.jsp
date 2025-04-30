<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>insertDeptForm</h1>
	<form action="insertDeptAction.jsp">
		<table border="1">
			<tr>
				<th>deptno</th>
				<td><input type="number" name="deptno"></td>
			</tr>
			<tr>
				<th>dname</th>
				<td><input type="text" name="dname"></td>
			</tr>
			<tr>
				<th>loc</th>
				<td><input type="text" name="loc"></td>
			</tr>
		</table>
		<button type="submit">부서 추가</button>
	</form>
</body>
</html>