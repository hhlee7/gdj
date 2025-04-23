<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.util.Calendar" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	System.out.println("num: " + num);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select num, name, birth, memo, createdate from person where num = ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0313", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, num);
	System.out.println(stmt);
	rs = stmt.executeQuery();
	
	Calendar today = Calendar.getInstance();
	int todayYear = today.get(Calendar.YEAR);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>명함 상세</h1>
	<%
		if(rs.next()) {
	%>
			<table border="1">
				<tr>
					<td>NUM</td>
					<td><%=rs.getInt("num")%></td>
				</tr>
				<tr>
					<td>NAME</td>
					<td><%=rs.getString("name")%></td>
				</tr>
				<tr>
					<td>BIRTH</td>
					<td><%=rs.getInt("birth")%>(<%=todayYear - rs.getInt("birth")%>)</td>
				</tr>
				<tr>
					<td>MEMO</td>
					<td><%=rs.getString("memo")%></td>
				</tr>
				<tr>
					<td>CREATEDATE</td>
					<td><%=rs.getString("createdate")%></td>
				</tr>				
			</table>
			<div>
				<a href="/web0313/deletePerson.jsp?num=<%=num%>">[삭제]</a>
				<a href="/web0313/updatePersonForm.jsp?num=<%=num%>">[수정]</a>
			</div>
	<%
		}
	%>

</body>
</html>