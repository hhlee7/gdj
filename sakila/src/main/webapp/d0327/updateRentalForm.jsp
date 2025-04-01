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
%>

<!-- Model -->
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select i.inventory_id inventoryId, i.film_id filmId, i.store_id storeId, f.title title, r.customer_id customerId"
				+ " from inventory i inner join film f on i.film_id = f.film_id"
				+ " INNER JOIN rental r ON i.inventory_id = r.inventory_id"
				+ " WHERE i.inventory_id = ? and r.return_date is null";
	Class.forName("com.mysql.cj.jdbc.Driver");
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, inventoryId);
	// 완성된 쿼리 확인용 출력
	System.out.println("updateRentalForm.jsp stmt: " + stmt);
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
	<h1>Update Rental Inventory</h1>
	<%
		if(rs.next()) {
	%>
		<form action="/sakila/d0327/updateRentalAction.jsp" method="post">
			<table border="1">
				<tr>
					<th>customerId</th>
					<td>
						<input type="text" name="customerId" value='<%=rs.getInt("customerId")%>' readonly>
					</td>
				</tr>
				<tr>
					<th>inventoryId</th>
					<td><input type="text" name="inventoryId" value='<%=rs.getInt("inventoryId")%>' readonly></td>
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
			<button type="submit">반납하기</button>
		</form>
	<%
		}
	%>
</body>
</html>