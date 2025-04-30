<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int deptno = Integer.parseInt(request.getParameter("deptno"));
	System.out.println("deleteDeptAction.jsp deptno: " + deptno);	

	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "delete from dept where deptno = ?";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe", "goodee", "java1234");
	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, deptno);
	System.out.println("deleteDeptAction.jsp stmt: " + stmt);
	
	int row = 0;
	row = stmt.executeUpdate();
	if(row == 1) {
		System.out.println("삭제 완료");
	} else {
		System.out.println("delete error");
	}
	response.sendRedirect("/web0319/deptList.jsp");
%>