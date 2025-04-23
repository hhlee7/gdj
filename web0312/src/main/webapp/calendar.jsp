<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar" %>
<%
	// targetMonth 기본값은 오늘을 기준으로 월 달력 출력
	Calendar firstDate = Calendar.getInstance();
	firstDate.set(Calendar.DATE, 1); // 오늘 날짜 정보에서 date만 1일로 변경
	
	// 매개값이 년도 있다면
	// String targetYear = request.getParameter("targetYear");
	// 매개값이 월만 있다면
	String targetMonth = request.getParameter("targetMonth");
	if(targetMonth != null) {
		// firstDate.set(Calendar.YEAR, Integer.parseInt(targetYear));
		// targetMonth <- 0 ~ 11
		// 12 입력되면 0 이 되고, Calendar.YEAR 값이 + 1
		// -1 입력되면 12가 되고, Calendar.YEAR 값이 - 1
		firstDate.set(Calendar.MONTH, Integer.parseInt(targetMonth));
	}
	
	// 마지막 날짜
	int lastDate = firstDate.getActualMaximum(Calendar.DATE);
	System.out.println("lastDate: " + lastDate);
	
	// 요일 : 1일의 요일을 안다면 모두 알 수 있다. 일(1) ~ 토(7)
	int dayOfWeek = firstDate.get(Calendar.DAY_OF_WEEK);
	
	// 출력에 필요한 데이터
	int startBlank = dayOfWeek - 1;
	int endBlank = 0;
	int totalCell = startBlank + lastDate + endBlank;
	// totalCell 가 7로 나누어 떨어지지 않는다면, endBlank 가 더 필요하다.
	if(totalCell % 7 != 0) {
		endBlank = 7 - (totalCell % 7);
		// 변경된 endBlank로 다시 totalCell을 계산
		totalCell = startBlank + lastDate + endBlank;
	}
	System.out.println("startBlank: " + startBlank);
	System.out.println("endBlank: " + endBlank);
	System.out.println("totalCell: " + totalCell);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1><%=firstDate.get(Calendar.YEAR)%>년 <%=firstDate.get(Calendar.MONTH) + 1%>월</h1>
	<div>
		<!-- 월별 페이징 네비게이션 -->
		<!-- ex) 출력된 게 1월이라면, 시스템 값은 0 이고 이전 달 : -1, 다음 달: 1 -->
		<!-- ex) 출력된 게 12월이라면, 시스템 값은 11 이고 이전 달 : 10, 다음 달: 12 -->
		<a href="/web0312/calendar.jsp?targetMonth=<%=firstDate.get(Calendar.MONTH) - 1%>">[이전달]</a>
		<a href="/web0312/calendar.jsp?targetMonth=<%=firstDate.get(Calendar.MONTH) + 1%>">[다음달]</a>
	</div>
	
	<table border="1">
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
					
						<%
							if(i - startBlank < 1 || i - startBlank > lastDate) {
						%>
									<td>&nbsp;</td>
						<%
							} else {
								if(i % 7 == 0) {
						%>
									<td style="color: blue"><%=i - startBlank%></td>
						<%
								} else if(i % 7 == 1) {
						%>
									<td style="color: red"><%=i - startBlank%></td>
						<%									
								} else {
						%>
									<td><%=i - startBlank%></td>
						<%
								}
							}
						%>
					
			<%
					if(i % 7 == 0) {
			%>
						</tr><tr><!-- 한 행이 7열이 되도록 -->
			<%
					}
				}
			%>
		</tr>
	</table>
</body>
</html>