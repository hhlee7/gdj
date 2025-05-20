<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>loginPage</title>
</head>
<body>
	<h1>loginPage</h1>
	
	<h3>loginList</h3>
	<table border="1">
		<tr>
			<th>no</th>
			<th>id</th>
			<th>logindate</th>
		</tr>
		<c:forEach var="h" items="${historyList}">
		<tr>
			<td>${h.no}</td>
			<td>${h.id}</td>
			<td>${h.logindate}</td>
		</tr>
		</c:forEach>
	</table>
</body>
</html>