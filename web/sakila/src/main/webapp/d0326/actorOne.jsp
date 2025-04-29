<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!-- Controller -->
<%
	//로그인 상태 확인
	Integer staffId = (Integer)(session.getAttribute("loginStaff"));
			
	if(staffId == null) { // 로그아웃 상태라면 로그인 페이지로 이동
		response.sendRedirect("/sakila/loginForm.jsp");
		return;
	}

	int actorId = Integer.parseInt(request.getParameter("actorId"));
	// 전달된 actorId 값 확인
	System.out.println("actorOne.jsp actorId: " + actorId);
%>

<!-- Model -->
<%
	// mysql 드라이버 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	System.out.println("actorOne.jsp: 드라이버 로딩 성공");

	// 특정 배우의 상세 정보를 조회하는 쿼리 실행
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "SELECT actor_id actorId"
				+ ", CONCAT(first_name, ' ', last_name) name"
				+ ", last_update lastUpdate"
				+ " FROM actor"
				+ " where actor_id = ?";
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, actorId);
	rs = stmt.executeQuery();
	
	// 조회된 배우 정보를 HashMap에 담고, ArrayList에 저장
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("actorId", rs.getInt("actorId"));
		map.put("name", rs.getString("name"));
		map.put("lastUpdate", rs.getString("lastUpdate"));
		list.add(map);
	}
	
	// 배우의 출연작 정보를 조회하는 쿼리 실행
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "SELECT ft.film_id filmId, ft.title title, fa.actor_id actorId"
				+ " FROM film_text ft INNER JOIN film_actor fa ON ft.film_id = fa.film_id"
				+ " WHERE actor_id = ?";
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, actorId);
	rs2 = stmt2.executeQuery();
	
	// 조회된 출연작 정보를 HashMap에 담고, ArrayList에 저장
	ArrayList<HashMap<String, Object>> list2 = new ArrayList<HashMap<String, Object>>();
	while(rs2.next()) {
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		map2.put("filmId", rs2.getInt("filmId"));
		map2.put("title", rs2.getString("title"));
		list2.add(map2);
	}
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<div>
		<%=staffId%>님, 반갑습니다.
		<a href="/sakila/index.jsp">[대시보드로 이동]</a>
	</div>
	<hr>
	<!-- 배우 상세 정보 출력 -->
	<h1>Actor One</h1>
	<table border="1">
		<%
			for(HashMap<String, Object> map : list) {
		%>
				<tr>
					<th>actorId</th>
					<td><%=map.get("actorId")%></td>
				</tr>
				<tr>
					<th>name</th>
					<td><%=map.get("name")%></td>
				</tr>
				<tr>
					<th>lastUpdate</th>
					<td><%=map.get("lastUpdate")%></td>
				</tr>
		<%
			}
		%>
	</table>
	
	<!-- 배우 출연작 리스트 출력 -->
	<h1>Filmography</h1>
	<table border="1">
				<tr>
					<th>no</th>
					<th>title</th>
				</tr>
				<tr>
		<%
			int i = 1;
			for(HashMap<String, Object> map2 : list2) {
		%>
					<td><%=i++%></td>
					<td><a href="/sakila/d0326/filmOne.jsp?filmId=<%=map2.get("filmId")%>"><%=map2.get("title")%></a></td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>