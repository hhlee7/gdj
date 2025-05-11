<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
</head>
<body>
	<h1>boardList</h1>
	<table border="1">
		<tr>
			<th>번호</th>
			<th>제목</th>
		</tr>
		<c:forEach var="b" items="${list}">
			<tr>
				<td>${b.boardNo}</td>
				<td>
					<a href="/boardOne?boardNo=${b.boardNo}">
						${b.boardTitle}
					</a>
				</td>
			</tr>
		</c:forEach>
	</table>
	
	<a href="/addBoard">글쓰기</a>
</body>
</html>