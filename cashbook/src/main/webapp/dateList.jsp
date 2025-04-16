<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
	// 현재 로그인 상태 확인
	String AdminId = (String)(session.getAttribute("loginAdmin"));
			
	if(AdminId == null) { // 로그아웃 상태라면 로그인 페이지로 이동
		response.sendRedirect("/cashbook/loginForm.jsp");
		return;
	}
	
	int y = Integer.parseInt(request.getParameter("y"));
	int m = Integer.parseInt(request.getParameter("m"));
	int d = Integer.parseInt(request.getParameter("d"));
	// 전달된 파라미터 값 확인용 출력
	System.out.println("dateList.jsp y: " + y);
	System.out.println("dateList.jsp m: " + m);
	System.out.println("dateList.jsp d: " + d);

	// Cash 모델 호출
	CashDao cashDao = new CashDao();
	
	// 해당 연도와 월의 가계부 목록을 조회하여 list에 저장
	ArrayList<Cash> list = cashDao.selectDateList(y, m, d);
	
	// 해당 일자(연.월.일 일치)의 수입/지출 별 금액 합계를 조회하여 list2에 저장
	ArrayList<HashMap<String, Object>> list2 = cashDao.selectDailyAmountByKind(y, m, d);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dateList</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<!-- nav.jsp include -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1><%=y%>년 <%=m%>월 <%=d%>일 내역</h1>
	<table class="table table-hover">
		<tr>
			<th>분류</th>
			<th>항목</th>
			<th>금액</th>
			<th>메모</th>
		</tr>
		<%
			for(Cash c : list) {
		%>
				<tr onclick="location.href='/cashbook/cash/cashOne.jsp?cashNo=<%=c.getCashNo()%>'" style="cursor:pointer;">
					<td><%=c.getKind()%></td>
					<td><%=c.getTitle()%></td>
					<td><%=String.format("%,d",c.getAmount())%></td>
					<td><%=c.getMemo()%></td>
				</tr>
		<%
			}
		%>
	</table>
	
	<h1>합계</h1>
	<table class="table table-hover">
		<tr>
			<th>분류</th>
			<th>총합</th>
		</tr>
		<%
			for(HashMap<String, Object> map : list2) {
		%>
				<tr>
					<td><%=map.get("kind")%></td>
					<td><%=String.format("%,d", map.get("sumAmount"))%></td>
				</tr>
		<%
			}
		%>
	</table>
	<div>
		<a class="btn btn-outline-primary" href="/cashbook/monthList.jsp?targetYear=<%=y%>&targetMonth=<%=m - 1%>">달력</a>
		<a class="btn btn-outline-primary" href="/cashbook/cash/insertCashForm.jsp">새 내역 등록</a>
	</div>
</body>
</html>