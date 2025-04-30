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

	String targetYear = request.getParameter("targetYear");
	// 전달된 파라미터 값 확인용 출력
	System.out.println("stats.jsp targetYear: " + targetYear);
	
	if (targetYear == null) {
		Calendar cal = Calendar.getInstance();
		targetYear = String.valueOf(cal.get(Calendar.YEAR));
	}
	
	// Stats 모델 호출
	StatsDao statsDao = new StatsDao();

	// 전체 통계 데이터를 조회하여 list에 저장
	ArrayList<Stats> list = statsDao.selectStatsByTotal();
	
	// 연도별 수입 및 지출 통계 데이터를 조회하여 list에 저장
	ArrayList<Stats> incomeList = statsDao.selectStatsByYearAndKind("수입");
	ArrayList<Stats> expenseList = statsDao.selectStatsByYearAndKind("지출");
	
	// 해당 연도의 월별 수입 및 지출 통계 데이터를 조회하여 list에 저장
	ArrayList<Stats> incomeList2 = statsDao.selectStatsByMonthAndYearAndKind(targetYear, "수입");
	ArrayList<Stats> expenseList2 = statsDao.selectStatsByMonthAndYearAndKind(targetYear, "지출");	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>statistics</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<!-- nav.jsp include -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1>전체 통계</h1>
	<table class="table table-hover">
		<tr>
			<th>분류</th>
			<th>건수</th>
			<th>합계</th>
		</tr>
		<%
			for(Stats s : list) {
		%>
				<tr>
					<td><%=s.getKind()%></td>
					<td><%=s.getCount()%></td>
					<td><%=String.format("%,d" ,s.getAmount())%></td>
				</tr>
		<%
			}
		%>
	</table>

	<h1>연도별 통계</h1>	
	<div class="row">
	<div class="col-6">
	<table class="table table-hover">
		<tr>
			<th>연도</th>
			<th>분류</th>
			<th>건수</th>
			<th>합계</th>
		</tr>
		<%
			for(Stats s : incomeList) {
		%>
				<tr>
					<td><%=s.getCashDate()%></td>
					<td><%=s.getKind()%></td>
					<td><%=s.getCount()%></td>
					<td><%=String.format("%,d" ,s.getAmount())%></td>
				</tr>
		<%
			}
		%>
	</table>
	</div>
	
	<div class="col-6">
	<table class="table table-hover">
		<tr>
			<th>연도</th>
			<th>분류</th>
			<th>건수</th>
			<th>합계</th>
		</tr>
		<%
			for(Stats s : expenseList) {
		%>
				<tr>
					<td><%=s.getCashDate()%></td>
					<td><%=s.getKind()%></td>
					<td><%=s.getCount()%></td>
					<td><%=String.format("%,d" ,s.getAmount())%></td>
				</tr>
		<%
			}
		%>
	</table>
	</div>
	</div>
	
	<form action="/cashbook/stats.jsp">
	<label for="targetYear">연도</label>
	<select name="targetYear" id="targetYear">
    	<option value="2025">2025</option>
    	<option value="2024">2024</option>
    	<option value="2023">2023</option>
    </select>
    <button type="submit" class="btn btn-outline-primary">조회</button>
    </form>
	
	<h1><%=targetYear%>년 월별 통계</h1>
	<div class="row">
	<div class="col-6">
	<table class="table table-hover">
		<tr>
			<th>월</th>
			<th>분류</th>
			<th>건수</th>
			<th>합계</th>
		</tr>
		<%
			for(Stats s : incomeList2) {
		%>
				<tr>
					<td><%=s.getCashDate()%></td>
					<td><%=s.getKind()%></td>
					<td><%=s.getCount()%></td>
					<td><%=String.format("%,d" ,s.getAmount())%></td>
				</tr>
		<%
			}
		%>
	</table>
	</div>
	<div class="col-6">
	<table class="table table-hover">
		<tr>
			<th>월</th>
			<th>분류</th>
			<th>건수</th>
			<th>합계</th>
		</tr>
		<%
			for(Stats s : expenseList2) {
		%>
				<tr>
					<td><%=s.getCashDate()%></td>
					<td><%=s.getKind()%></td>
					<td><%=s.getCount()%></td>
					<td><%=String.format("%,d" ,s.getAmount())%></td>
				</tr>
		<%
			}
		%>
	</table>
	</div>
	</div>
</body>
</html>