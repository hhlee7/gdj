<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container py-5">

<div class="mb-4">
	<a href="/login" class="btn btn-primary">로그인</a>
</div>

<div class="row g-4">
	<!-- 전체 방문자 수 카드 -->
	<div class="col-md-6">
		<div class="card h-100">
			<div class="card-header bg-primary text-white">전체 방문자 수</div>
			<div class="card-body">
				<ul class="list-group list-group-flush">
					<li class="list-group-item d-flex justify-content-between">
						<span>비회원 (전체)</span>
						<span>${connectCountMapAll.ANONYMOUS}</span>
					</li>
					<li class="list-group-item d-flex justify-content-between">
						<span>회원</span>
						<span>${connectCountMapAll.MEMBER}</span>
					</li>
					<li class="list-group-item d-flex justify-content-between">
						<span>관리자</span>
						<span>${connectCountMapAll.ADMIN}</span>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<!-- 오늘 방문자 수 카드 -->
	<div class="col-md-6">
		<div class="card h-100">
			<div class="card-header bg-success text-white">오늘 방문자 수</div>
			<div class="card-body">
				<ul class="list-group list-group-flush">
					<li class="list-group-item d-flex justify-content-between">
						<span>비회원 (오늘)</span>
						<span>${connectCountMapToday.ANONYMOUS}</span>
					</li>
					<li class="list-group-item d-flex justify-content-between">
						<span>회원</span>
						<span>${connectCountMapToday.MEMBER}</span>
					</li>
					<li class="list-group-item d-flex justify-content-between">
						<span>관리자</span>
						<span>${connectCountMapToday.ADMIN}</span>
					</li>
				</ul>
			</div>
		</div>
	</div>

	<!-- 현재 접속자 수 카드 -->
	<div class="col-md-6">
		<div class="card h-100">
			<div class="card-header bg-warning">현재 접속자 수</div>
			<div class="card-body text-center">
				<h1 class="display-5">${currentConnectCount}</h1>
				<p class="text-muted">※ 현재 서버에 접속 중인 사용자 수</p>
			</div>
		</div>
	</div>
</div>

</body>
</html>