<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!-- Controller -->
<%

%>

<!-- Model -->
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select actor_id actorId, first_name firstName, last_name lastName from actor";
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	System.out.println(conn);
	
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("actorId", rs.getInt("actorId"));
		map.put("firstName", rs.getString("firstName"));
		map.put("lastName", rs.getString("lastName"));
		list.add(map);
	}
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>actorList</title>
</head>
<body>
	<h1>actorList</h1>
	<table border="1">
		<tr>
			<th>actorId</th>
			<th>firstName</th>
			<th>lastName</th>
		</tr>
		<%
			for(HashMap<String, Object> map : list) {
		%>
				<tr>
					<td><%=map.get("actorId")%></td>
					<td><%=map.get("firstName")%></td>
					<td><%=map.get("lastName")%></td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>