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
	String sql = "SELECT film_id filmId, title, description FROM film_text"
				+ " order by filmId"
				+ " limit ?, ?";
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "SELECT count(*) cnt from film_text";
	
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
		map.put("filmId", rs.getInt("filmId"));
		map.put("title", rs.getString("title"));
		map.put("description", rs.getString("description"));
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
	<h1>Film List</h1>
	<table border="1">
		<tr>
			<th>filmId</th>
			<th>title</th>
			<th>description</th>
		</tr>
		<%
			for(HashMap<String, Object> map : list) {
		%>
				<tr>
					<td><%=map.get("filmId")%></td>
					<td><a href="/sakila/d0326/filmOne.jsp?filmId=<%=map.get("filmId")%>"><%=map.get("title")%></a></td>
					<td><%=map.get("description")%></td>
				</tr>
		<%
			}
		%>
	</table>
	
	<!-- 페이징 -->
	<a href="/sakila/d0326/filmList.jsp?currentPage=1">[처음]</a>
	<%
		if(startPage > 1) {
	%>
		<a href="/sakila/d0326/filmList.jsp?currentPage=<%=startPage - 10%>">[이전 10페이지]</a>
	<%
		}
	%>
	
	<%
		if(currentPage > 1) {
	%>
		<a href="/sakila/d0326/filmList.jsp?currentPage=<%=currentPage - 1%>">[이전]</a>
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
				<a href="/sakila/d0326/filmList.jsp?currentPage=<%=i%>">[<%=i%>]</a>
	<%
			}
		}
	%>
	
	<%
		if(currentPage < lastPage) {
	%>
		<a href="/sakila/d0326/filmList.jsp?currentPage=<%=currentPage + 1%>">[다음]</a>
	<%
		}
	%>
	
	<%
		if(endPage < lastPage) {
	%>
		<a href="/sakila/d0326/filmList.jsp?currentPage=<%=startPage + 10%>">[다음 10페이지]</a>
	<%
		}
	%>
	<a href="/sakila/d0326/filmList.jsp?currentPage=<%=lastPage%>">[끝으로]</a>
</body>
</html>