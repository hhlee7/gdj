<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	int y = Integer.parseInt(request.getParameter("y"));
	int m = Integer.parseInt(request.getParameter("m"));
	int d = Integer.parseInt(request.getParameter("d"));
	// y, m, d 값 넘어오는지 확인
	System.out.println("dateList.jsp y: " + y);
	System.out.println("dateList.jsp m: " + m);
	System.out.println("dateList.jsp d: " + d);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	String sql = "select diary_no diaryNo, diary_date diaryDate, diary_title diaryTitle, diary_color diaryColor, diary_memo diaryMemo, updatedate, createdate from diary where year(diary_date) = ? and month(diary_date) = ? and day(diary_date) = ?";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0318", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, y);
	stmt.setInt(2, m);
	stmt.setInt(3, d);
	// stmt 확인
	System.out.println("dateList.jsp stmt: " + stmt);
	rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1><%=y%>년 <%=m%>월 <%=d%>일 다이어리 목록</h1>
	<div>		
		<a href="/web0318/diary.jsp">달력 돌아가기</a>
	</div>
	<table border="1">
		<tr>
			<th>diaryNo</th>
			<th>diaryDate</th>
			<th>diaryTitle</th>
			<th>diaryColor</th>
			<th>diaryMemo</th>
			<th>updatedate</th>
			<th>createdate</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
		<%
			while(rs.next()) {
		%>
				<tr>
					<td><%=rs.getInt("diaryNo")%></td>
					<td><%=rs.getString("diaryDate")%></td>
					<td><%=rs.getString("diaryTitle")%></td>
					<td><%=rs.getString("diaryColor")%></td>
					<td><%=rs.getString("diaryMemo")%></td>
					<td><%=rs.getString("updatedate")%></td>
					<td><%=rs.getString("createdate")%></td>
					<td><a href='/web0318/updateDiaryForm.jsp?diaryNo=<%=rs.getInt("diaryNo")%>&y=<%=y%>&m=<%=m%>&d=<%=d%>'>수정</a></td>
					<td><a href='/web0318/deleteDiaryAction.jsp?diaryNo=<%=rs.getInt("diaryNo")%>&y=<%=y%>&m=<%=m%>&d=<%=d%>'>삭제</a></td>
				</tr>
		<%		
			}
		%>
	</table>
	<div>
		<a href="/web0318/insertDiaryForm.jsp?y=<%=y%>&m=<%=m%>&d=<%=d%>">일정 추가</a>
	</div>
</body>
</html>