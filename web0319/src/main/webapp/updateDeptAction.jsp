<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int deptno = Integer.parseInt(request.getParameter("deptno"));
	String dname = request.getParameter("dname");
	String loc = request.getParameter("loc");
	
	System.out.println("updateDeptAction.jsp deptno: " + deptno);
	System.out.println("updateDeptAction.jsp dname: " + dname);
	System.out.println("updateDeptAction.jsp loc: " + loc);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "update board set deptno = ?, dname = ?, loc = ? where deptno = ?";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe", "goodee", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, deptno);
	stmt.setString(2, dname);
	stmt.setString(3, loc);
	System.out.println("updateDeptAction.jsp stmt: " + stmt);
	
	int row = stmt.executeUpdate();
	
	if(row == 1) {
		response.sendRedirect("/web0319/deptList.jsp");
	} else {
		System.out.println("update 오류");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>

</body>
</html>