<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 현재 로그인 상태 확인
	String AdminId = (String)(session.getAttribute("loginAdmin"));
			
	if(AdminId == null) { // 로그아웃 상태라면 로그인 페이지로 이동
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}

	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	// 전달된 파라미터 값 확인용 출력
	System.out.println("insertReceiptForm.jsp cashNo: " + cashNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertReceiptForm</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<!-- nav.jsp include -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1>영수증 첨부</h1>
	<form action="/cashbook/receipt/insertReceiptAction.jsp" method="post" enctype="multipart/form-data">
		<input type="hidden" name="cashNo" value="<%=cashNo%>">
		<div>이미지 : <input type="file" name="imageFile"></div>
		<%
			if(request.getParameter("msg") != null) {
		%>
				<div><%=request.getParameter("msg")%></div>
		<%
			}
		%>
		<button class="btn btn-outline-primary" type="submit">등록</button>
    </form>
</body>
</html>