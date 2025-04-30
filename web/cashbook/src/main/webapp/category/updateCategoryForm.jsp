<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%
	// 현재 로그인 상태 확인
	String AdminId = (String)(session.getAttribute("loginAdmin"));
			
	if(AdminId == null) { // 로그아웃 상태라면 로그인 페이지로 이동
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}

	int categoryNo = Integer.parseInt(request.getParameter("categoryNo"));
	// 전달된 파라미터 값 확인용 출력
	System.out.println("updateCategoryForm.jsp categoryNo: " + categoryNo);
	
	// Category 모델 호출
	CategoryDao categoryDao = new CategoryDao();
	
	// 해당 categoryNo값을 가지는 데이터 행 조회
	Category c = categoryDao.selectCategory(categoryNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCategoryForm</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<!-- nav.jsp include -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1>카테고리 수정</h1>
	<form action="/cashbook/category/updateCategoryAction.jsp">
	<input type="hidden" name="categoryNo" value="<%=c.getCategoryNo()%>">
		<table class="table table-hover">
			<tr>
				<th>분류</th>
				<td>
					<select class="form-select" name="kind">
						<option value="수입" <%=c.getKind().equals("수입") ? "selected" : ""%>>수입</option>
						<option value="지출" <%=c.getKind().equals("지출") ? "selected" : ""%>>지출</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" value="<%=c.getTitle()%>"></td>
			</tr>
		</table>
		<%
			if(request.getParameter("msg") != null) {
		%>
				<div><%=request.getParameter("msg")%></div>
		<%
			}
		%>
		<button class="btn btn-outline-primary" type="submit">수정</button>
	</form>
</body>
</html>