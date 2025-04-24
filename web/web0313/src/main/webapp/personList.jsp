<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	Connection conn = null;

	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	String sql1 = "select count(*) from person";
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "select num, name, birth, createdate from person order by createdate desc limit ?, ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0313", "root", "java1234");
	System.out.println(conn);
	
	stmt1 = conn.prepareStatement(sql1);
	
	rs1 = stmt1.executeQuery();
	rs1.next();
	System.out.println("전체 행의 수: " + rs1.getInt("count(*)"));
	
	
	int currentPage = 1;	
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	
	int startRow = (currentPage - 1) * rowPerPage;
	
	int totalCnt = rs1.getInt("count(*)");
	
	int lastPage = totalCnt / rowPerPage;
	if(totalCnt % rowPerPage != 0) {
		lastPage += 1;
	}
	
	stmt2 = conn.prepareStatement(sql2);
	
	stmt2.setInt(1, startRow);
	stmt2.setInt(2, rowPerPage);
	System.out.println(stmt2);
	
	rs2 = stmt2.executeQuery();
	System.out.println("rs2: " + rs2);
%>

	<h1>명함 목록</h1>
	
	<div>
		<a href="/web0313/insertPersonForm.jsp">명함 입력</a>
	</div>
	
	<table border="1">
		<tr>
			<th>NUM</th>
			<th>NAME</th>
			<th>BIRTH</th>
			<th>CREATEDATE</th>
		</tr>
		
		<%
			while(rs2.next()) {
		%>
				<tr>
					<td><%=rs2.getInt("num")%></td>
					<td>
						<a href="/web0313/personOne.jsp?num=<%=rs2.getString("num")%>"><%=rs2.getString("name")%></a>
					</td>
					<td><%=rs2.getInt("birth")%></td>
					<td><%=rs2.getString("createdate")%></td>
				</tr>
		<%
			}
		%>
	</table>
	
	<a href="/web0313/personList.jsp?currentPage=1">[처음]</a>
	
	<%
		if(currentPage > 1) {
	%>
			<a href="/web0313/personList.jsp?currentPage=<%=currentPage - 1%>">[이전]</a>
	<%
		}
	%>
	
	<%=currentPage%>
	
	<%
		if(currentPage < lastPage) {
	%>
			<a href="/web0313/personList.jsp?currentPage=<%=currentPage + 1%>">[다음]</a>			
	<%
		}
	
	
	%>
	
	<a href="/web0313/personList.jsp?currentPage=<%=lastPage%>">[마지막]</a>
</body>
</html>