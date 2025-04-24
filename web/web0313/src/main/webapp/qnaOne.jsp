<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	System.out.println("num: " + num);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select num, category, title, content, writer, age, qnadate from qna where num = ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0313", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, num);
	System.out.println(stmt);
	rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>QnA 상세</h1>
	<%
		if(rs.next()) { // rs안에 1행의 데이터가 있다면 출력
	%>
			<table border="1">
				<tr>
					<td>NUM</td>
					<td><%=rs.getInt("num")%></td><!-- num -->
				</tr>
				<tr>
					<td>CATEGORY</td>
					<td><%=rs.getString("category")%></td>
				</tr>
				<tr>
					<td>TITLE</td>
					<td><%=rs.getString("title")%></td>
				</tr>
				<tr>
					<td>CONTENT</td>
					<td><%=rs.getString("content")%></td>
				</tr>
				<tr>
					<td>WRITER</td>
					<td><%=rs.getString("writer")%></td>
				</tr>
				<tr>
					<td>AGE</td>
					<td><%=rs.getInt("age")%></td>
				</tr>
				<tr>
					<td>QNADATE</td>
					<td><%=rs.getString("qnadate")%></td>
				</tr>
			</table>
			<div>
				<a href="/web0313/deleteQnaForm.jsp?num=<%=num%>">[삭제]</a>
				<a href="/web0313/updateQnaForm.jsp?num=<%=num%>">[수정]</a>
			</div>
	<%
		}
	%>
</body>
</html>