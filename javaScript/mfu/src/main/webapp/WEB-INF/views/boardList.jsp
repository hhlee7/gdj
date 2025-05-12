<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>boardList</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
	<div class="container mt-5">
		<div class="row justify-content-center">
			<div class="col-md-8">
				<div class="card shadow">
					<div class="card-body">
						<h1 class="card-title text-center mb-4">게시판 목록</h1>
						<table class="table table-hover">
							<thead class="table-secondary">
								<tr>
									<th scope="col">번호</th>
									<th scope="col">제목</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="b" items="${list}">
									<tr>
										<td>${b.boardNo}</td>
										<td>
											<a href="/boardOne?boardNo=${b.boardNo}">${b.boardTitle}</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="text-start">
							<a href="/addBoard" class="btn btn-primary">글쓰기</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>