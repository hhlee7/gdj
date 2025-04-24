<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int deptno = Integer.parseInt(request.getParameter("deptno"));
	String dname = request.getParameter("dname");
	String loc = request.getParameter("loc");
	// 값 넘어오는지 디버깅
	System.out.println("insertDeptAction.jsp deptno: " + deptno);
	System.out.println("insertDeptAction.jsp dname: " + dname);
	System.out.println("insertDeptAction.jsp loc: " + loc);
	
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "insert into dept(deptno, dname, loc) values(?, ?, ?)";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe", "goodee", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, deptno);
	stmt.setString(2, dname);
	stmt.setString(3, loc);
	System.out.println("insertDeptAction.jsp stmt: " + stmt);
	
	int row = 0;
	row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("정상 입력");
	} else {
		System.out.println("입력 이상");
	}
	response.sendRedirect("/web0319/deptList.jsp");
%>