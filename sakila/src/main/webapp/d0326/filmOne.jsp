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

	int filmId = Integer.parseInt(request.getParameter("filmId"));
	// 전달된 filmId 값 확인
	System.out.println("filmOne.jsp filmId: " + filmId);
%>

<!-- Model -->
<%
	// mysql 드라이버 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	System.out.println("filmOne.jsp: 드라이버 로딩 성공");
	
	// 특정 영화의 상세 정보를 조회하는 쿼리 실행
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "SELECT film_id filmId, title, description, release_year releaseYear"
				+ ", language_id languageId, original_language_id originalLanguageId"
				+ ", rental_duration rentalDuration, rental_rate rentalRate, length"
				+ ", replacement_cost replacementCost, rating"
				+ ", special_features specialFeatures, last_update lastUpdate"
				+ " FROM film"
				+ " WHERE film_id = ?";
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, filmId);
	rs = stmt.executeQuery();
	
	// 조회된 영화 정보를 HashMap에 담고, ArrayList에 저장
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("filmId", rs.getInt("filmId"));
		map.put("title", rs.getString("title"));
		map.put("description", rs.getString("description"));
		map.put("releaseYear", rs.getString("releaseYear"));
		map.put("languageId", rs.getInt("languageId"));
		map.put("originalLanguageId", rs.getInt("originalLanguageId"));
		map.put("rentalDuration", rs.getInt("rentalDuration"));
		map.put("rentalRate", rs.getInt("rentalRate"));
		map.put("length", rs.getInt("length"));
		map.put("replacementCost", rs.getInt("replacementCost"));
		map.put("rating", rs.getString("rating"));
		map.put("specialFeatures", rs.getString("specialFeatures"));
		map.put("lastUpdate", rs.getString("lastUpdate"));
		list.add(map);
	}
	
	// 영화의 출연자 정보를 조회하는 쿼리 실행
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "SELECT fa.film_id filmId, a.actor_id actorId"
				+ ", CONCAT(a.first_name, ' ', a.last_name) name"
				+ " FROM film_actor fa INNER JOIN actor a ON fa.actor_id = a.actor_id"
				+ " WHERE film_id = ?";
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setInt(1, filmId);
	rs2 = stmt2.executeQuery();
	
	// 조회된 출연자 정보를 HashMap에 담고, ArrayList에 저장
	ArrayList<HashMap<String, Object>> list2 = new ArrayList<HashMap<String, Object>>();
	while(rs2.next()) {
		HashMap<String, Object> map2 = new HashMap<String, Object>();
		map2.put("actorId", rs2.getInt("actorId"));
		map2.put("name", rs2.getString("name"));
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
	<!-- 영화 정보 출력 -->
	<h1>Film One</h1>
	<table border="1">
		<%
			for(HashMap<String, Object> map : list) {
		%>
				<tr>
					<th>filmId</th>
					<td><%=map.get("filmId")%></td>
				</tr>
				<tr>
					<th>title</th>
					<td><%=map.get("title")%></td>
				</tr>
				<tr>
					<th>description</th>
					<td><%=map.get("description")%></td>
				</tr>
				<tr>
					<th>releaseYear</th>
					<td><%=map.get("releaseYear")%></td>
				</tr>
				<tr>
					<th>languageId</th>
					<td><%=map.get("languageId")%></td>
				</tr>
				<tr>
					<th>originalLanguageId</th>
					<td><%=map.get("originalLanguageId")%></td>
				</tr>
				<tr>
					<th>rentalDuration</th>
					<td><%=map.get("rentalDuration")%></td>
				</tr>
				<tr>
					<th>rentalRate</th>
					<td><%=map.get("rentalRate")%></td>
				</tr>
				<tr>
					<th>length</th>
					<td><%=map.get("length")%></td>
				</tr>
				<tr>
					<th>replacementCost</th>
					<td><%=map.get("replacementCost")%></td>
				</tr>
				<tr>
					<th>rating</th>
					<td><%=map.get("rating")%></td>
				</tr>
				<tr>
					<th>specialFeatures</th>
					<td><%=map.get("specialFeatures")%></td>
				</tr>
				<tr>
					<th>lastUpdate</th>
					<td><%=map.get("lastUpdate")%></td>
				</tr>
		<%
			}
		%>
	</table>
	
	<!-- 출연자 목록 출력 -->
	<h1>Cast List</h1>
	<table border="1">
				<tr>
					<th>no</th>
					<th>name</th>
				</tr>
				<tr>
		<%
			int i = 1;
			for(HashMap<String, Object> map2 : list2) {
		%>
					<td><%=i++%></td>
					<td><a href="/sakila/d0326/actorOne.jsp?actorId=<%=map2.get("actorId")%>"><%=map2.get("name")%></a></td>
				</tr>
		<%
			}
		%>
	</table>
</body>
</html>