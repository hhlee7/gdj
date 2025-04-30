<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="dto.Member" %>
<!-- controller -->
<%
	String gender = request.getParameter("gender");
	String searchWord = request.getParameter("searchWord");
	// 넘어오는 gender & searchWord 값 확인
	System.out.println("gender: " + gender);
	System.out.println("searchWord: " + searchWord);
	
	if(searchWord == null) {
		searchWord = "";
	}
	if(gender == null) {
		gender = "";
	}
	
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	int startRow = (currentPage - 1) * rowPerPage;
%>

<!-- model -->
<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	String sql = "select member_no memberNo, gender, name from member order by member_no offset ? rows fetch next ? rows only";
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "select count(*) cnt from member";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe", "goodee", "java1234");
	
	// 검색 필터 없을 시
	if(gender.equals("") && searchWord.equals("")) {
		sql = "select member_no memberNo, gender, name from member order by member_no offset ? rows fetch next ? rows only";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		stmt2 = conn.prepareStatement(sql2);
	// 성별만 검색 시
	} else if(!gender.equals("") && searchWord.equals("")) {
		sql = "select member_no memberNo, gender, name from member where gender = ? order by member_no offset ? rows fetch next ? rows only";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, gender);
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		sql2 = "select count(*) cnt from member where gender = ?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, gender);
	// 이름만 검색 시
	} else if(gender.equals("") && !searchWord.equals("")) {
		sql = "select member_no memberNo, gender, name from member where name like ? order by member_no offset ? rows fetch next ? rows only";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%" + searchWord + "%");
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		sql2 = "select count(*) cnt from member where name like ?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, "%" + searchWord + "%");
	// 성별과 이름 모두 검색 시
	} else {
		sql = "select member_no memberNo, gender, name from member where gender = ? and name like ? order by member_no offset ? rows fetch next ? rows only";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, gender);
		stmt.setString(2, "%" + searchWord + "%");
		stmt.setInt(3, startRow);
		stmt.setInt(4, rowPerPage);
		sql2 = "select count(*) cnt from member where gender = ? and name like ?";
		stmt2 = conn.prepareStatement(sql2);
		stmt2.setString(1, gender);
		stmt2.setString(2, "%" + searchWord + "%");
	}
		
	rs = stmt.executeQuery();
	rs2 = stmt2.executeQuery();
	rs2.next();
	// 전체 행 수 출력 확인
	System.out.println("전체 행의 수: " + rs2.getInt("cnt"));
	
	int totalCnt = rs2.getInt("cnt");
	
	int lastPage = totalCnt / rowPerPage;
	if(totalCnt % rowPerPage != 0) {
		lastPage += 1;
	}
	
	ArrayList<Member> list = new ArrayList<>();
	while(rs.next()) {
		Member m = new Member();
		m.memberNo = rs.getInt("memberNo");
		m.gender = rs.getString("gender");
		m.name = rs.getString("name");
		list.add(m);
	}
%>

<!-- view -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>Member List</h1>
	<!-- 리스트 출력 + 페이징 -->
	<table border="1">
		<tr>
			<th>memberNo</th>
			<th>gender</th>
			<th>name</th>
		</tr>
		<%
			for(Member m : list) {
		%>
				<tr>
					<td><%=m.memberNo%></td>
					<td><%=m.gender%></td>
					<td><%=m.name%></td>
				</tr>
		<%
			}
		%>
	</table>
	<a href="/web0320/memberList.jsp?gender=<%=gender%>&searchWord=<%=searchWord%>&currentPage=1">[처음]</a>	
	<%
		if(currentPage > 1) {
	%>
			<a href="/web0320/memberList.jsp?gender=<%=gender%>&searchWord=<%=searchWord%>&currentPage=<%=currentPage - 1%>">[이전]</a>
	<%
		}
	%>
	
	<%=currentPage%>
	
	<%
		if(currentPage < lastPage) {
	%>
			<a href="/web0320/memberList.jsp?gender=<%=gender%>&searchWord=<%=searchWord%>&currentPage=<%=currentPage + 1%>">[다음]</a>			
	<%
		}
	%>
	<a href="/web0320/memberList.jsp?gender=<%=gender%>&searchWord=<%=searchWord%>&currentPage=<%=lastPage%>">[마지막]</a>
	<form action="/web0320/memberList.jsp">
		<input type="radio" name="gender" value="M">남
		<input type="radio" name="gender" value="F">여
		<div>이름 검색
		<input type="text" name="searchWord">
		<button type="submit">검색</button>
		</div>
	</form>
</body>
</html>