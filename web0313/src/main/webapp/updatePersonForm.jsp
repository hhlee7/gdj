<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	// num 값 넘어오는지 디버깅
	System.out.println("num: " + num);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select num, name, birth, memo from person where num = ?";
	
	// 1) mysql api 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	
	// 2) db 연결
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0313", "root", "java1234");
	
	// 3) 쿼리 생성 or 추가 완성
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, num);
	// stmt 디버깅
	System.out.println(stmt);

	// 4) 쿼리 실행
	rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>명함 수정</h1>
	<%
		if(rs.next()) {
	%>
	<form action="/web0313/updatePersonAction.jsp">
		<table border="1">
			<tr>
				<th>NUM</th>
				<td><input type="text" name="num" value='<%=rs.getInt("num")%>' readonly></td>
			</tr>
			<tr>
				<th>NAME</th>
				<td><input type="text" name="name" value='<%=rs.getString("name")%>'></td>
			</tr>
			<tr>
				<th>BIRTH</th>
				<td><input type="text" name="birth" value='<%=rs.getInt("birth")%>'></td>
			</tr>
			<tr>
				<th>MEMO</th>
				<td><textarea rows="5" cols="50" name="memo"><%=rs.getString("memo")%></textarea></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
	<%
		}
	%>
</body>
</html>