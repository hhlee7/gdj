<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * rowPerPage;

	// 1) 드라이버 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	// 2) 접속(mysql 주소, mysql 계정, mysql 암호)
	Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0312", "root", "java1234");
	System.out.println(conn);
	
	// 3-1) 접속한 DB에 전달할 SQL 쿼리 준비 -> PreparedStatement 데이터 타입 저장
	PreparedStatement stmt = conn.prepareStatement("select num, title from board order by num desc limit ?, ?");
	
	// 3-2) 쿼리 완성
	stmt.setInt(1, startRow);	
	stmt.setInt(2, rowPerPage);

	// 4) PreparedStatement 데이터 타입 저장된 SQL쿼리 실행 명령 후 쿼리 결과 값 반환 받음
	ResultSet rs = stmt.executeQuery();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<table border="1">
		<tr>
			<th>NUM</th>
			<th>TITLE</th>
		</tr>
	<%
		while(rs.next()) { // 전체 10행이기에 10번 반복
	%>
			<tr>
				<td><%=rs.getInt("num")%></td>
				<td><%=rs.getString("title")%></td>
			</tr>
	<%
		}
	%>
	</table>
	<a href="/web0312db/boardList.jsp?currentPage=<%=currentPage - 1%>">[이전]</a>
	<a href="/web0312db/boardList.jsp?currentPage=<%=currentPage + 1%>">[다음]</a>
</body>
</html>