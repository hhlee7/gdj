<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
</head>
<body>
	<h1>Board List</h1>
	<table border="1">
		<tr>
			<th>boardNo</th>
			<th>title</th>
			<th>tags</th>
			<th>add tag</th>
		</tr>
		<c:forEach var="b" items="${boardList}">
			<tr>
				<td>${b.boardNo}</td>
				<td>${b.title}</td>
				<td>${b.tags}</td>
				<td><a href="/addTag?boardNo=${b.boardNo}">add tag</a></td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>