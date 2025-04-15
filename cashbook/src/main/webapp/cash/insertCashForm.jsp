<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%
	// dateList.jsp(특정 날짜의 수입/지출 리스트 출력) -> 수입/지출 입력(String cashDate) ->
	String cashDate = request.getParameter("cashDate");
	cashDate = "2025-04-11"; // 수정 요망
	
	// insertCashForm.jsp -> kind 선택(String kind)
	String kind = request.getParameter("kind");
	
	ArrayList<Category> list = null;
	if(kind != null) { // insertCashForm.jsp에서 kind 선택 후 재요청
		// DB : 선택된 kind의 title 목록
		CategoryDao categoryDao = new CategoryDao();
		list = categoryDao.selectCategoryListByKind(kind);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertCashForm</title>
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
	
	<h1>수입/지출 선택</h1>
	<form method="post" action="/cashbook/cash/insertCashForm.jsp">
		<input type="hidden" name="cashDate" value="<%=cashDate%>">
		분류
		<select name="kind">
			<option value="">- 선택 -</option>
			<option value="수입">수입</option>
			<option value="지출">지출</option>
		</select>
		<button class="btn btn-outline-primary" type="submit">선택</button>
	</form>
	<hr>
	<h1>수입/지출 이력 추가</h1>
	<form method="post" action="/cashbook/cash/insertCashAction.jsp">
		cashDate : <input type="date" name="cashDate" value="<%=cashDate%>"><br>
		항목 :
		<select name="categoryNo">
			<%
				if(list != null) {
				for(Category c : list) {
			%>
				<option value="<%=c.getCategoryNo()%>"><%=c.getTitle()%></option>
			<%
					}
				}
			%>
		</select>
		<div>금액 : <input type="number" name="amount"></div>
		<div>메모 : <input type="text" name="memo"></div>
		<div>색상 : <input type="color" name="color"></div>
		<button class="btn btn-outline-primary" type="submit">등록</button>
	</form>
</body>
</html>