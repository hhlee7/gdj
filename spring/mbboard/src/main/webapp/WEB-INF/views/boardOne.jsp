<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardOne</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

<div class="container mt-5">

	<h1 class="mb-4">📄 게시글 상세보기</h1>

	<c:choose>
		<c:when test="${board != null}">
			<table class="table table-hover table-bordered">
				<tr>
					<th class="table-light" style="width: 20%;">번호</th>
					<td>${board.boardNo}</td>
				</tr>
				<tr>
					<th class="table-light">제목</th>
					<td>${board.boardTitle}</td>
				</tr>
				<tr>
					<th class="table-light">내용</th>
					<td>${board.boardContent}</td>
				</tr>
				<tr>
					<th class="table-light">작성자</th>
					<td>${board.boardUser}</td>
				</tr>
				<tr>
					<th class="table-light">수정일</th>
					<td>${board.updatedate}</td>
				</tr>
				<tr>
					<th class="table-light">작성일</th>
					<td>${board.createdate}</td>
				</tr>
			</table>

			<div class="d-flex justify-content-start gap-2 mt-3">
				<a href="boardList" class="btn btn-secondary">목록</a>
				<a href="updateBoard?boardNo=${board.boardNo}" class="btn btn-warning">수정</a>
				<a href="deleteBoard?boardNo=${board.boardNo}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
			</div>

		</c:when>

		<c:otherwise>
			<script>
				alert('잘못된 접근입니다.');
				location.href = 'boardList';
			</script>
		</c:otherwise>
	</c:choose>
</div>

</body>
</html>