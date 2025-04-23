<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
	Class.forName("com.mysql.cj.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "SELECT case when LENGTH < 60 then '~ 1시간'"
				+ " when LENGTH < 120 then '~ 2시간'"
				+ " ELSE '2시간 ~' END runningTime"
				+ " , COUNT(*) cnt"
				+ " FROM film"
				+ " GROUP BY case when LENGTH < 60 then '~ 1시간'"
				+ " when LENGTH < 120 then '~ 2시간'"
				+ " ELSE '2시간 ~' END";
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	System.out.println(conn);
	
	stmt = conn.prepareStatement(sql);
	rs = stmt.executeQuery();
	
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("runningTime", rs.getString("runningTime"));
		map.put("cnt", rs.getInt("cnt"));
		list.add(map);
	}
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
			<th>runningTime</th>
			<th>cnt</th>
		</tr>
		<%
			for(HashMap<String, Object> map : list) {
		%>
		<tr>
			<td><%=map.get("runningTime")%></td>
			<td><%=map.get("cnt")%></td>
		</tr>
		<%
			}
		%>
	</table>
</body>
</html>