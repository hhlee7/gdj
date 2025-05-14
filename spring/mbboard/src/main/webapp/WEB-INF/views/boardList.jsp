<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>boardList</h1>
	
	<!-- 검색 -->
	<form id="searchForm" method="get" action="boardList">
		<input type="text" name="searchWord" id="searchWord" value="${param.searchWord}" placeholder="제목 검색">
		<button type="submit">검색</button>
	</form>
	
	<table border="1">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일</th>
		</tr>
		<c:forEach var="b" items="${boardList}">
			<tr>
				<td>${b.boardNo}</td>
				<td><a href="boardOne?boardNo=${b.boardNo}">${b.boardTitle}</a></td>
				<td>${b.boardUser}</td>
				<td>${b.createdate}</td>
			</tr>
		</c:forEach>
	</table>
	
	<!-- 페이징 -->
	<c:if test="${page.currentPage > 1}">
		<a href="?currentPage=${page.currentPage - 1}&searchWord=${param.searchWord}">[이전]</a>
	</c:if>
	
	${page.currentPage}
	
	<c:if test="${page.currentPage < page.lastPage}">
		<a href="?currentPage=${page.currentPage + 1}&searchWord=${param.searchWord}">[다음]</a>
	</c:if>
	
	<br>
	
	<a href="insertBoard">글쓰기</a>
	
	<script>
		$('#searchForm').on('submit', function(e) {
			const keyWord = $('#searchWord').val();
			if(keyWord == '') {
				alert('검색어를 입력하세요.');
				e.preventDefault();
			}
		});
	</script>
</body>
</html>