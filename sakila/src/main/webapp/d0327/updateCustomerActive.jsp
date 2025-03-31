<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!-- Controller -->
<%
	Integer customerId = Integer.parseInt(request.getParameter("customerId"));
	Integer active = Integer.parseInt(request.getParameter("active"));
	// 전달된 customerId, active 값 확인
	System.out.println("uadateCustomerActive.jsp customerId: " + customerId);
	System.out.println("uadateCustomerActive.jsp active: " + active);
%>

<!-- Model -->
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "update customer set active = ? where customer_id = ? and active = ?";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	if(active == 0) {
		stmt.setInt(1, 1);
	} else {
		return;
	}
	stmt.setInt(2, customerId);
	stmt.setInt(3, active);
	// 완성된 쿼리 디버깅
	System.out.println("uadateCustomerActive.jsp stmt: " + stmt);
	
	int row = stmt.executeUpdate();
	if(row == 0) {
		System.out.println("uadateCustomerActive.jsp : active update 실패");
	} else if(row == 1) {
		System.out.println("uadateCustomerActive.jsp : active update 성공");
	} else {
		System.out.println("update error");
	}
%>