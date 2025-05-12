<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardOne</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card shadow">
					<div class="card-body">
						<h1 class="card-title text-center mb-4">게시글 상세</h1>
						<table class="table table-hover">
							<tr>
								<th class="table-secondary" style="width: 20%;">번호</th>
								<td>${board.boardNo}</td>
							</tr>
							<tr>
								<th class="table-secondary">제목</th>
								<td>${board.boardTitle}</td>
							</tr>
							<tr>
								<th class="table-secondary">첨부파일</th>
								<td>
									<c:forEach var="f" items="${fileList}">
										<c:choose>
											<c:when test="${f.filetype.startsWith('image/')}">
												<div class="mb-2">
													<a href="/upload/${f.filename}" download class="d-block mb-1">${f.filename}</a>
													<img src="/upload/${f.filename}" class="img-fluid rounded" style="max-width: 100%; max-height: 400px;">
												</div>
											</c:when>
											<c:otherwise>
												<a href="/upload/${f.filename}" download class="d-block mb-2">${f.filename}</a>
											</c:otherwise>
										</c:choose>
									</c:forEach>
								</td>
							</tr>
						</table>
						<div class="d-flex justify-content-between">
							<div class="d-flex gap-2">
								<a href="/modifyBoard?boardNo=${board.boardNo}" class="btn btn-warning">수정</a>
								<a href="/removeBoard?boardNo=${board.boardNo}" onclick="return confirm('정말 삭제하시겠습니까?');" class="btn btn-danger">삭제</a>
							</div>
							<a href="/boardList" class="btn btn-secondary">목록</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>