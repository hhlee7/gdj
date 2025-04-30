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

	int cashNo = Integer.parseInt(request.getParameter("cashNo"));
	// 전달된 파라미터 값 확인용 출력
	System.out.println("updateCashForm.jsp cashDate: " + cashNo);
	
	// Cash 모델 호출
	CashDao cashDao = new CashDao();
	
	// 해당 cashNo 값을 가지는 데이터를 조회하여 list에 저장
	Cash c = cashDao.selectCashOne(cashNo);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateCashForm</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container">
	<h1>내역 수정</h1>
	<form method="post" action="/cashbook/cash/updateCashAction.jsp">
		<input type="hidden" name="cashNo" value=<%=cashNo%>>
		<div>일자 : <input type="date" name="cashDate" value="<%=c.getCashDate()%>"></div>
		<div>금액 : <input type="number" name="amount" value="<%=c.getAmount()%>"></div>
		<div>메모 : <input type="text" name="memo" value="<%=c.getMemo()%>"></div>
		<div>색상 : <input type="color" name="color" value="<%=c.getColor()%>"></div>
		<button type="submit">수정</button>
	</form>
</body>
</html>