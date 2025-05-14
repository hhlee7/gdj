<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne</title>
</head>
<body>
	<h1>boardOne</h1>
	<table border="1">
		<tr>
			<th>번호</th>
			<td>${board.boardNo}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td>${board.boardTitle}</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>${board.boardContent}</td>
		</tr>
		<tr>
			<th>작성자</th>
			<td>${board.boardUser}</td>
		</tr>
		<tr>
			<th>수정일</th>
			<td>${board.updatedate}</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td>${board.createdate}</td>
		</tr>
	</table>
	<a href="boardList">목록</a>
	<a href="updateBoard?boardNo=${board.boardNo}">수정</a>
	<a href="deleteBoard?boardNo=${board.boardNo}" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
</body>
</html>