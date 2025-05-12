<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>modifyBoard</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card shadow">
					<div class="card-body">
						<h1 class="card-title text-center mb-4">게시글 수정</h1>
						<form id="modifyForm" action="${pageContext.request.contextPath}/modifyBoard" method="post">
							<input type="hidden" name="boardNo" value="${board.boardNo}">
							<div class="mb-3">
								<label for="boardTitle" class="form-label">제목</label>
								<input type="text" class="form-control" name="boardTitle" id="boardTitle" value="${board.boardTitle}">
							</div>
							<div class="d-flex justify-content-between">
								<button id="modifyBtn" type="button" class="btn btn-primary">수정</button>
								<a href="/boardList" class="btn btn-secondary">목록</a>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		document.querySelector('#modifyBtn').addEventListener('click', () => {
			if(document.querySelector('#boardTitle').value == '') {
				alert('제목을 입력하세요.');
				return;
			}
			document.querySelector('#modifyForm').submit();
		})
	</script>
</body>
</html>