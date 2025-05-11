<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modifyBoard</title>
</head>
<body>
	<h1>modifyBoard</h1>
	<form id="modifyForm" action="${pageContext.request.contextPath}/modifyBoard" method="post">
		<input type="hidden" name="boardNo" value="${board.boardNo}">
		<table border="1">
			<tr>
				<td>boardTitle</td>
				<td>
					<input type="text" name="boardTitle" id="boardTitle" value="${board.boardTitle}">
				</td>
			</tr>
		</table>
		<button id="modifyBtn" type="button">수정</button>
	</form>
	<a href="/boardList">목록으로</a>
	<script>
		document.querySelector('#modifyBtn').addEventListener('click', () => {
			if(document.querySelector('#boardTitle').value == '') {
				alert('title을 입력하세요.');
				return;
			}
			document.querySelector('#modifyForm').submit();
		})
	</script>
</body>
</html>