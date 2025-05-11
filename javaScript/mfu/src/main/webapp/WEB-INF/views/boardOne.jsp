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
			<th>첨부파일</th>
			<td>
				<c:forEach var="f" items="${fileList}">
					<c:choose>
						<c:when test="${f.filetype.startsWith('image/')}">
							<div>
								<a href="/upload/${f.filename}" download="${f.filename}">
									${f.filename}
								</a>
							</div>
							<img src="/upload/${f.filename}" width="500">
						</c:when>
						<c:otherwise>
							<a href="/upload/${f.filename}" download="${f.filename}">
								${f.filename}
							</a>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</td>
		</tr>
	</table>
	<a href="/modifyBoard?boardNo=${board.boardNo}">수정</a>
	<a href="/removeBoard?boardNo=${board.boardNo}" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
	<a href="/boardList">목록으로</a>
</body>
</html>