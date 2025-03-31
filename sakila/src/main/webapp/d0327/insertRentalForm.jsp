<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!-- Controller -->
<%
	// staff 로그인 상태 확인
	Integer staffId = (Integer)(session.getAttribute("loginStaff"));
	// 로그아웃 상태라면 로그인 페이지로 이동
	if(staffId == null) {
		response.sendRedirect("/sakila/d0328/loginForm.jsp");
		return;
	}
	
	Integer inventoryId = Integer.parseInt(request.getParameter("inventoryId"));
	Integer customerId = null;
	if(request.getParameter("customerId") != null) {
		// 대여 실행할 고객 선택 후 이 페이지가 다시 요청되면 customerId 값을 받아옴
		customerId = Integer.parseInt(request.getParameter("customerId"));
	}
%>

<!-- Model -->
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select i.inventory_id inventoryId, i.film_id filmId, i.store_id storeId, f.title title from inventory i inner join film f on i.film_id = f.film_id where inventory_id = ?";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, inventoryId);
	// 완성된 쿼리 디버깅
	System.out.println(stmt);
	rs = stmt.executeQuery();
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>Insert Rental Inventory</h1>
	<%
		if(rs.next()) {
	%>
		<form action="/sakila/d0327/searchCustomerIdList.jsp" method="post">
			<input type="hidden" name="inventoryId" value="<%=inventoryId%>">
			<input type="text" name="searchName">
			<button type="submit">이름으로 customerId 검색</button>
		</form>
		
		<form action="/sakila/d0327/insertRentalAction.jsp" method="post">
			<table border="1">
				<tr>
					<th>customerId</th>
					<td>
						<input type="text" name="customerId" value="<%=customerId%>" readonly>
					</td>
				</tr>
				<tr>
					<th>inventoryId</th>
					<td><input type="text" name="inventoryId" value="<%=inventoryId%>" readonly></td>
				</tr>
				<tr>
					<th>filmId</th>
					<td>
					<input type="text" name="filmId" value="<%=rs.getInt("filmId")%>" readonly> /
					<%=rs.getString("title")%>
					</td>
				</tr>
				<tr>
					<th>storeId</th>
					<td><input type="text" name="storeId" value="<%=rs.getInt("storeId")%>" readonly></td>
				</tr>
				<tr>
					<th>staffId</th>
					<td><input type="text" name="staffId" value="<%=staffId%>" readonly></td>
				</tr>
			</table>
			<button type="submit">대여하기</button>
		</form>
	<%
		}
	%>
</body>
</html>