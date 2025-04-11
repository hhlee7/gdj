<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%
	Calendar firstDate = Calendar.getInstance();
	firstDate.set(Calendar.DATE, 1);
	
	System.out.println("monthList.jsp targetMonth: " + request.getParameter("targetMonth"));
	if(request.getParameter("targetMonth") != null) {
		firstDate.set(Calendar.MONTH, Integer.parseInt(request.getParameter("targetMonth")));
	}
	
	int lastDate = firstDate.getActualMaximum(Calendar.DATE);
	
	int dayOfWeek = firstDate.get(Calendar.DAY_OF_WEEK);
	
	int startBlank = dayOfWeek - 1;
	int endBlank = 0;
	
	int totalCell = startBlank + lastDate + endBlank;
	if(totalCell % 7 != 0) {
		endBlank = 7 - (totalCell % 7);
		totalCell += endBlank;
	}
	
	CashDao cashDao = new CashDao();
	ArrayList<Cash> list = cashDao.selectMonthList(firstDate.get(Calendar.YEAR), firstDate.get(Calendar.MONTH) + 1);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>monthList</title>
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
	
	<h1>가계부 달력</h1>
	<div>
		<%=firstDate.get(Calendar.YEAR)%>년 <%=firstDate.get(Calendar.MONTH) + 1%>월
	</div>
	<table class="table table-hover">
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
												[<%=c.getKind()%>]
												<%=c.getTitle()%>
												<%=c.getMemo()%>
												<%=c.getAmount()%>
											</div>
						<%				
										}
									}
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
		<a href="/cashbook/monthList.jsp?targetMonth=<%=firstDate.get(Calendar.MONTH) - 1%>">이전달</a>
		<a href="/cashbook/monthList.jsp?targetMonth=<%=firstDate.get(Calendar.MONTH) + 1%>">다음달</a>
	</div>
</body>
</html>