<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<!-- Controller -->
<%
	//페이징 설정
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10; // 페이지 당 보여줄 행 개수
	int startRow = (currentPage - 1) * rowPerPage;
	
	int pageBlock = 10; // 페이지 번호 10개씩 표시
	int startPage = ((currentPage - 1) / pageBlock) * pageBlock + 1;
	int endPage = startPage + pageBlock - 1;
%>

<!-- Model -->
<%
	//mysql 드라이버 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	System.out.println("드라이버 로딩 성공");
	
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "SELECT actor_id actorId"
				+ ", CONCAT(first_name, ' ', last_name) NAME"
				+ ", last_update lastUpdate"
				+ " FROM actor"
				+ " order by actorId"
				+ " limit ?, ?";
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "SELECT count(*) cnt from actor";
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sakila", "root", "java1234");	
	stmt = conn.prepareStatement(sql);
	stmt.setInt(1, startRow);
	stmt.setInt(2, rowPerPage);
	stmt2 = conn.prepareStatement(sql2);
	rs = stmt.executeQuery();
	rs2 = stmt2.executeQuery();
	rs2.next();
	// 조회된 전체 행 수 출력 확인
	System.out.println("전체 행의 수: " + rs2.getInt("cnt"));
	
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	while(rs.next()) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("actorId", rs.getInt("actorId"));
		map.put("name", rs.getString("name"));
		map.put("lastUpdate", rs.getString("lastUpdate"));
		list.add(map);
	}
	
	// 페이징 - 마지막 페이지 설정
	int totalCnt = rs2.getInt("cnt");
	int lastPage = totalCnt / rowPerPage;
	if(totalCnt % rowPerPage != 0) {
		lastPage += 1;
	}
	if(endPage > lastPage) {
		endPage = lastPage;
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
	<h1>Actor List</h1>
	<table border="1">
		<tr>
			<th>actorId</th>
			<th>name</th>
			<th>lastUpdate</th>
		</tr>
		<%
			for(HashMap<String, Object> map : list) {
		%>
				<tr>
					<td><%=map.get("actorId")%></td>
					<td><%=map.get("name")%></td>
					<td><%=map.get("lastUpdate")%></td>
				</tr>
		<%
			}
		%>
		</table>
		<!-- 페이징 -->
		<a href="/sakila/d0326/actorList.jsp?currentPage=1">[처음]</a>
		<%
			if(startPage > 1) {
		%>
			<a href="/sakila/d0326/actorList.jsp?currentPage=<%=startPage - 10%>">[이전 10페이지]</a>
		<%
			}
		%>
		
		<%
			if(currentPage > 1) {
		%>
			<a href="/sakila/d0326/actorList.jsp?currentPage=<%=currentPage - 1%>">[이전]</a>
		<%
			}
		%>
		<!-- 페이지 번호 리스트 -->
		<%
			for(int i = startPage; i <= endPage; i++) {
				if(i == currentPage) {
		%>
					[<%=i%>]
		<%
				} else {
		%>
					<a href="/sakila/d0326/actorList.jsp?currentPage=<%=i%>">[<%=i%>]</a>
		<%
				}
			}
		%>
		
		<%
			if(currentPage < lastPage) {
		%>
			<a href="/sakila/d0326/actorList.jsp?currentPage=<%=currentPage + 1%>">[다음]</a>
		<%
			}
		%>
		
		<%
			if(endPage < lastPage) {
		%>
			<a href="/sakila/d0326/actorList.jsp?currentPage=<%=startPage + 10%>">[다음 10페이지]</a>
		<%
			}
		%>
		<a href="/sakila/d0326/actorList.jsp?currentPage=<%=lastPage%>">[끝으로]</a>
</body>
</html>