<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%
	// 현재 로그인 상태 확인
	String AdminId = (String)(session.getAttribute("loginAdmin"));
			
	if(AdminId == null) { // 로그아웃 상태라면 로그인 페이지로 이동
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}
	
	// 현재 페이지 설정
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 페이징 정보 설정
	int rowPerPage = 10; // 한 페이지 당 보여줄 행 개수
	Paging p = new Paging();
	p.setCurrentPage(currentPage);
	p.setRowPerPage(rowPerPage);
	
	// Category 모델 호출
	CategoryDao categoryDao = new CategoryDao();
	
	// 마지막 페이지 설정
	int lastPage = p.getLastPage((categoryDao.getTotalCategory()));
	
	// 해당 페이지에 속한 리스트 조회
	ArrayList<Category> list = categoryDao.selectCategoryList(p);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>categoryList</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<!-- nav.jsp include -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1>카테고리 목록</h1>
	<table class="table table-hover">
		<tr>
			<th>번호</th>
			<th>분류</th>
			<th>항목</th>
			<th>등록일</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%
			for(Category c : list) {
		%>
				<tr>
					<td><%=c.getCategoryNo()%></td>
					<td><%=c.getKind()%></td>
					<td><%=c.getTitle()%></td>
					<td><%=c.getCreatedate()%></td>
					<td><a class="btn btn-outline-primary" href="/cashbook/category/updateCategoryForm.jsp?categoryNo=<%=c.getCategoryNo()%>">수정</a></td>
					<td><a class="btn btn-outline-primary" href="/cashbook/category/deleteCategoryAction.jsp?categoryNo=<%=c.getCategoryNo()%>">삭제</a></td>
				</tr>
		<%
			}
		%>
	</table>
	
	<!-- 페이징 -->
	<div class="d-flex justify-content-between align-items-center my-3">
	<ul class="pagination">
	<%
		if(currentPage > 1) {
	%>
			<li class="page-item"><a class="page-link" href="/cashbook/category/categoryList.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
	<%
		}
	%>
			<li class="page-item"><a class="page-link" href="/cashbook/category/categoryList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
			
	<%
		if(currentPage < lastPage) {
	%>
			<li class="page-item"><a class="page-link" href="/cashbook/category/categoryList.jsp?currentPage=<%=currentPage + 1%>">다음</a></li>
	<%
		}
	%>
	</ul>
	<a class="btn btn-outline-primary" href="/cashbook/category/insertCategoryForm.jsp">카테고리 추가</a>
	</div>
</body>
</html>