<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	String AdminId = (String)(session.getAttribute("loginAdmin"));
%>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- 사용자 정보 -->
<nav class="navbar navbar-expand-sm bg-light navbar-light">
	<div class="btn-group btn-group-sm">
		<%=AdminId%>님, 반갑습니다.
		&nbsp;
		<a class="btn btn-outline-primary" href="/cashbook/logout.jsp">로그아웃</a>
		<a class="btn btn-outline-primary" href="/cashbook/updateAdminPwForm.jsp">비밀번호 수정</a>
	</div>
</nav>

<!-- 페이지 네비게이션 -->
<nav class="mb-3">
	<ul class="nav nav-pills">
		<li class="nav-item">
			<a class="nav-link" href="/cashbook/index.jsp">홈으로</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="/cashbook/category/categoryList.jsp">카테고리</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="/cashbook/monthList.jsp">가계부 달력</a>
		</li>
		<li class="nav-item">
			<a class="nav-link" href="/cashbook/stats.jsp">통계</a>
		</li>
	</ul>
</nav>