<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	int targetYear = Integer.parseInt(request.getParameter("targetYear"));
	int targetMonth = Integer.parseInt(request.getParameter("targetMonth"));
	System.out.println("targetYear: " + targetYear);
	System.out.println("targetMonth: " + targetMonth);
	
	Calendar firstDate = Calendar.getInstance(); // 오늘 날짜 정보 : 2025-03-11
	// target의 1일 날짜로 변경
	firstDate.set(Calendar.YEAR, targetYear);
	firstDate.set(Calendar.MONTH, targetMonth - 1);
	firstDate.set(Calendar.DATE, 1);
	int dayOfWeek = firstDate.get(Calendar.DAY_OF_WEEK); // 요일을 추정 가능한 숫자를 반환 / 일:1, 월:2, ... 토:7
	int lastDate = firstDate.getActualMaximum(Calendar.DAY_OF_MONTH); // firstDate의 월 날짜 중 제일 큰 숫자 -> 마지막 날짜
	int startBlank = dayOfWeek - 1; // 달력의 시작은 일요일부터 라고 할 때
	int endBlank = 0;
	
	int totalTd = startBlank + lastDate + endBlank;
	if(totalTd % 7 != 0) { // totalTd가 7로 나누어 나머지가 0이 되게 endBlank를 변경
		endBlank = 7 - (totalTd % 7);
		totalTd = startBlank + lastDate + endBlank; // 변경된 endBlank로 totalTD 다시 계산	
	}
%>

	<h1><%=targetYear%>년 <%=targetMonth%>월</h1>
	<table border="1">
		<tr>
			<%
				for(int i = 1; i <= totalTd; i++) {
			%>
					<td><%=i - startBlank%></td>
			<%
					if(i % 7 == 0) { // 행의 변경
			%>
						</tr><tr>
			<%
					}
				}
			%>
		</tr>
	</table>
</body>
</html>