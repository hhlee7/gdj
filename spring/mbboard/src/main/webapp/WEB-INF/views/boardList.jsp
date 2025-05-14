<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>boardList</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

<div class="container mt-5">

	<h1 class="mb-4">📋 게시판 목록</h1>

	<!-- 검색 -->
	<form id="searchForm" method="get" action="boardList" class="row g-3 mb-4">
		<div class="col-auto">
			<input type="text" name="searchWord" id="searchWord" class="form-control" value="${param.searchWord}" placeholder="제목 검색">
		</div>
		<div class="col-auto">
			<button type="submit" class="btn btn-primary">검색</button>
		</div>
	</form>

	<table class="table table-hover table-bordered text-center align-middle">
		<thead class="table-light">
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="b" items="${boardList}">
				<tr>
					<td>${b.boardNo}</td>
					<td><a href="boardOne?boardNo=${b.boardNo}">${b.boardTitle}</a></td>
					<td>${b.boardUser}</td>
					<td>${b.createdate}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>

	<div class="d-flex justify-content-between align-items-center mt-4">
		<!-- 글쓰기 -->
		<div>
			<a href="insertBoard" class="btn btn-success">글쓰기</a>
		</div>
		
		<!-- 페이징 -->
		<div class="flex-grow-1 d-flex justify-content-center align-items-center gap-3">
			<c:if test="${page.currentPage > 1}">
				<a href="?currentPage=${page.currentPage - 1}&searchWord=${param.searchWord}" class="btn btn-outline-secondary btn-sm">이전</a>
			</c:if>
	
			<span>${page.currentPage} / ${page.lastPage}</span>
	
			<c:if test="${page.currentPage < page.lastPage}">
				<a href="?currentPage=${page.currentPage + 1}&searchWord=${param.searchWord}" class="btn btn-outline-secondary btn-sm">다음</a>
			</c:if>
		</div>
	
	</div>
</div>
	
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