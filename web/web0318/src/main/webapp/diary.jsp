<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.sql.*"%>

<%
	// 현재 월의 기본값은 오늘의 월(1일)
	Calendar firstDate = Calendar.getInstance();
	firstDate.set(Calendar.DATE, 1);
	
	System.out.println("diary.jsp targetMonth: " + request.getParameter("targetMonth"));
	if(request.getParameter("targetMonth") != null) {
		firstDate.set(Calendar.MONTH, Integer.parseInt(request.getParameter("targetMonth")));
	}
	
	// 시작 날짜 1일
	// 마지막 날짜
	int lastDate = firstDate.getActualMaximum(Calendar.DATE);
	
	
	// 1일의 요일 -> 시작 공백
	int dayOfWeek = firstDate.get(Calendar.DAY_OF_WEEK);
	int startBlank = dayOfWeek - 1;
	// 마지막 공백
	int endBlank = 0;
	// totalCell은 7의 배수
	int totalCell = startBlank + lastDate + endBlank;
	if(totalCell % 7 != 0) {
		endBlank = 7 - (totalCell % 7);
		totalCell += endBlank;
	}
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String sql = "select diary_no diaryNo, diary_date diaryDate, diary_title diaryTitle, diary_color diaryColor from diary where YEAR(diary_date) = ? and MONTH(diary_date) = ? order by diary_date";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0318", "root", "java1234");
	stmt = conn.prepareStatement(sql, ResultSet.TYPE_SCROLL_SENSITIVE, ResultSet.CONCUR_UPDATABLE);
	stmt.setInt(1, firstDate.get(Calendar.YEAR));
	stmt.setInt(2, firstDate.get(Calendar.MONTH) + 1);
	rs = stmt.executeQuery();
	/* 디버깅
	while(rs.next()) {
		System.out.println(rs.getString("diaryDate") + ":" + rs.getString("diaryTitle"));
	}
	// 커서를 다시 처음으로 이동 
	rs.beforeFirst();
	*/
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>
	<div>
		<a href="/web0318/diary.jsp?targetMonth=<%=firstDate.get(Calendar.MONTH) - 1%>">이전달</a>
		<%=firstDate.get(Calendar.YEAR)%>년 <%=firstDate.get(Calendar.MONTH) + 1%>월
		<a href="/web0318/diary.jsp?targetMonth=<%=firstDate.get(Calendar.MONTH) + 1%>">다음달</a>
		<!-- issue : 1월 이전이면 -1, 12월 다음이면 12 -> Calendar API안에서 자동으로 계산됨 -->
	</div></h1>
	<table border="1" width="80%">
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
						<!--
						i:<%-- =i --%>
						<br>
						 -->
						<%
							int d = i - startBlank;
							if(d > 0 && d <= lastDate) {
						%>
								<div>
									<a href="/web0318/dateList.jsp?y=<%=firstDate.get(Calendar.YEAR)%>&m=<%=firstDate.get(Calendar.MONTH) + 1%>&d=<%=d%>">
										<%=d%>
									</a>
								</div>
						<%
								while(rs.next()) {
									String diaryDate = rs.getString("diaryDate");
									if(Integer.parseInt(diaryDate.substring(8)) == d) {
						%>
										<div style='color:<%=rs.getString("diaryColor")%>'>
											<%=rs.getString("diaryTitle")%>
										</div>
						<%				
									}
								}
								// 커서를 처음 위치로
								rs.beforeFirst();
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
</body>
</html>