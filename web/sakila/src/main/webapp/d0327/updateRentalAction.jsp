<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!-- Controller -->
<%
	Integer inventoryId = Integer.parseInt(request.getParameter("inventoryId"));
	Integer customerId = Integer.parseInt(request.getParameter("customerId"));
	Integer staffId = (Integer)session.getAttribute("loginStaff");
	// 전달된 inventoryId, customerId, staffId 값 확인
	System.out.println("updateRentalAction.jsp inventoryId:" + inventoryId);
	System.out.println("updateRentalAction.jsp customerId:" + customerId);
	System.out.println("updateRentalAction.jsp staffId:" + staffId);
	
%>

<!-- Model -->
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	String sql = "update rental set return_date = now() where inventory_id = ? and customer_id = ? and staff_id = ?";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, inventoryId);
	stmt.setInt(2, customerId);
	stmt.setInt(3, staffId);
	// 완성된 쿼리 디버깅
	System.out.println("updateRentalAction.jsp stmt: " + stmt);
	
	int row = stmt.executeUpdate();
	if(row == 0) {
		System.out.println("updateRentalAction.jsp : update 실패");
		response.sendRedirect("/sakila/d0327/updateRentalForm.jsp");
	} else if(row == 1) {
		System.out.println("updateRentalAction.jsp : update 성공");
		response.sendRedirect("/sakila/d0325/rentalList.jsp");
	} else {
		System.out.println("update error");
	}
%>