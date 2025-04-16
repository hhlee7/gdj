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

	// 캘린더 객체 생성 및 해당 월의 1일로 날짜 설정
	Calendar firstDate = Calendar.getInstance();
	firstDate.set(Calendar.DATE, 1);
	// test
	// 파라미터로 전달된 targetYear, targetMonth가 있다면 해당 연월로 설정
	System.out.println("monthList.jsp targetMonth: " + request.getParameter("targetMonth"));
	if(request.getParameter("targetYear") != null && request.getParameter("targetMonth") != null) {
		firstDate.set(Calendar.YEAR, Integer.parseInt(request.getParameter("targetYear")));
		firstDate.set(Calendar.MONTH, Integer.parseInt(request.getParameter("targetMonth")));
	}
	
	// 해당 월의 마지막 날짜 계산
	int lastDate = firstDate.getActualMaximum(Calendar.DATE);
	
	// 1일의 요일 구함
	int dayOfWeek = firstDate.get(Calendar.DAY_OF_WEEK);
	
	// 1일 앞에 필요한 공백 셀 수 계산
	int startBlank = dayOfWeek - 1;
	
	// 달력 전체 셀 수를 7의 배수로 맞추기 위한 끝 공백 계산
	int endBlank = 0;
	int totalCell = startBlank + lastDate + endBlank;
	if(totalCell % 7 != 0) {
		endBlank = 7 - (totalCell % 7);
		totalCell += endBlank;
	}
	
	// Cash 모델 호출
	CashDao cashDao = new CashDao();
	
	// 해당 연도와 월의 가계부 목록을 조회하여 list에 저장
	ArrayList<Cash> list = cashDao.selectMonthList(firstDate.get(Calendar.YEAR), firstDate.get(Calendar.MONTH) + 1);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>monthList</title>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
	<style>
		td:hover {
			background-color: #f5f5f5; /* hover 시 배경색 */
		}
	
		th {
			background-color: #f8f9fa; /* 상단 요일 행 색상 */
			font-weight: bold;
		}
	</style>
</head>
<body class="container">
	<!-- nav.jsp include -->
	<jsp:include page="/inc/nav.jsp"></jsp:include>
	
	<h1>가계부 달력</h1>
	<div class="my-4 mx-auto">
	<div class="text-center">
	<div>
		<h1><%=firstDate.get(Calendar.YEAR)%>년 <%=firstDate.get(Calendar.MONTH) + 1%>월</h1>
	</div>
	<table class="table table-bordered">
		<tr>
			<th>일</th>
			<th>월</th>
			<th>화</th>
			<th>수</th>
			<th>목</th>
			<th>금</th>
			<th>토</th>
		</tr>
		<tr>
			<%
				for(int i = 1; i <= totalCell; i++) {
			%>
					<td>
						<%
							int d = i - startBlank;
							if(d > 0 && d <= lastDate) {
						%>
								<div>
									<a href="/cashbook/dateList.jsp?y=<%=firstDate.get(Calendar.YEAR)%>&m=<%=firstDate.get(Calendar.MONTH) + 1%>&d=<%=d%>">
										<%=d%>
									</a>
								</div>
						<%
									for(Cash c : list) {
										String cashDate = c.getCashDate();
										if(Integer.parseInt(cashDate.substring(8)) == d) {
						%>
											<div style='color:<%=c.getColor()%>'>
												[<%=c.getKind()%>] <%=c.getTitle()%>
											</div>
						<%				
										}
									}
							} else {
						%>
								&nbsp;
						<%
							}
						%>
					</td>
			<%		
					if(i % 7 == 0) {
			%>
						</tr><tr>
			<%			
					}
				}
			%>
		</tr>
	</table>
	<div>
		<a class="btn btn-outline-primary" href="/cashbook/monthList.jsp?targetYear=<%=firstDate.get(Calendar.YEAR)%>&targetMonth=<%=firstDate.get(Calendar.MONTH) - 1%>">이전달</a>
		<a class="btn btn-outline-primary" href="/cashbook/monthList.jsp?targetYear=<%=firstDate.get(Calendar.YEAR)%>&targetMonth=<%=firstDate.get(Calendar.MONTH) + 1%>">다음달</a>
	</div>
	</div>
	</div>
</body>
</html>