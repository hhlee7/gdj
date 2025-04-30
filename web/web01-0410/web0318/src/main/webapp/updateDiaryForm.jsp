<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	int y = Integer.parseInt(request.getParameter("y"));
	int m = Integer.parseInt(request.getParameter("m"));
	int d = Integer.parseInt(request.getParameter("d"));
	// y, m, d 값 넘어오는지 확인
	System.out.println("updateDiaryForm.jsp y: " + y);
	System.out.println("updateDiaryForm.jsp m: " + m);
	System.out.println("updateDiaryForm.jsp d: " + d);
	
	int diaryNo = Integer.parseInt(request.getParameter("diaryNo"));
	System.out.println("updateDiaryForm.jsp diaryNo:" + diaryNo);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select diary_no diaryNo, diary_title diaryTitle, diary_color diaryColor, diary_memo diaryMemo from diary where diary_no = ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0318", "root", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, diaryNo);
	// stmt 확인
	System.out.println("updateDiaryForm.jsp stmt:" + stmt);
	rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>updateDiaryForm</h1>
		<%
			if(rs.next()) {
		%>
			<form action="/web0318/updateDiaryAction.jsp">
				<input type="hidden" name="y" value="<%=y%>">
				<input type="hidden" name="m" value="<%=m%>">
				<input type="hidden" name="d" value="<%=d%>">
				<table border="1">
					<tr>
						<th>diaryNo</th>
						<td><input type="number" name="diaryNo" value='<%=rs.getInt("diaryNo")%>' readonly></td>
					</tr>
					<tr>
						<th>diaryTitle</th>
						<td><input type="text" name="diaryTitle" value='<%=rs.getString("diaryTitle")%>'></td>
					</tr>
					<tr>
						<th>diaryColor</th>
						<td><input type="color" name="diaryColor" value="<%=rs.getString("diaryColor")%>"></td>
					</tr>
					<tr>
						<th>diaryMemo</th>
						<td><textarea rows="5" cols="50" name="diaryMemo"><%=rs.getString("diaryMemo")%></textarea></td>
					</tr>
					</table>
					<button type="submit">일정 수정</button>
			</form>
		<%
			}
		%>
</body>
</html>