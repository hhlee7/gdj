<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.*" %>
<%@ page import="dto.Board" %>
<!-- controller -->
<%
	String key = request.getParameter("key");
	String searchWord = request.getParameter("searchWord");
	// 검색 시 넘어오는 key & searchWord 값 확인
	System.out.println("key: " + key);
	System.out.println("searchWord: " + searchWord);
	
	if(searchWord == null) {
		searchWord = "";
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
	String sql = "select board_no boardNo, board_title boardTitle, board_content boardContent from board order by board_no offset ? rows fetch next ? rows only";
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "select count(*) cnt from board";
	
	Class.forName("oracle.jdbc.driver.OracleDriver");
	conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521/xe", "goodee", "java1234");
	
	// 검색어가 공백일 때
	if(searchWord == "") {
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(2, rowPerPage);
		stmt2 = conn.prepareStatement(sql2);
	} else {
		// 제목 검색 시
		if(key.equals("title")) {
			sql = "select board_no boardNo, board_title boardTitle, board_content boardContent from board where board_title like ? order by board_no offset ? rows fetch next ? rows only";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchWord + "%");
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
			sql2 = "select count(*) cnt from board where board_title like ?";
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, "%" + searchWord + "%");
		// 내용 검색 시
		} else if(key.equals("content")) {
			sql = "select board_no boardNo, board_title boardTitle, board_content boardContent from board where board_content like ? order by board_no offset ? rows fetch next ? rows only";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchWord + "%");
			stmt.setInt(2, startRow);
			stmt.setInt(3, rowPerPage);
			sql2 = "select count(*) cnt from board where board_content like ?";
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, "%" + searchWord + "%");
		// 제목 or 내용 검색 시
		} else {
			sql = "select board_no boardNo, board_title boardTitle, board_content boardContent from board where board_title like ? or board_content like ? order by board_no offset ? rows fetch next ? rows only";
			stmt = conn.prepareStatement(sql);
			stmt.setString(1, "%" + searchWord + "%");
			stmt.setString(2, "%" + searchWord + "%");
			stmt.setInt(3, startRow);
			stmt.setInt(4, rowPerPage);
			sql2 = "select count(*) cnt from board where board_title like ? or board_content like ?";
			stmt2 = conn.prepareStatement(sql2);
			stmt2.setString(1, "%" + searchWord + "%");
			stmt2.setString(2, "%" + searchWord + "%");
		}
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
	
	ArrayList<Board> list = new ArrayList<>();
	while(rs.next()) {
		Board b = new Board();
		b.boardNo = rs.getInt("boardNo");
		b.boardTitle = rs.getString("boardTitle");
		b.boardContent = rs.getString("boardContent");
		list.add(b);
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
	<h1>Board List</h1>
	<table border="1">
		<tr>
			<th>boardNo</th>
			<th>boardTitle</th>
			<th>boardContent</th>
		</tr>
		<%
			for(Board b : list) {
		%>
				<tr>
					<td><%=b.boardNo%></td>
					<td><%=b.boardTitle%></td>
					<td><%=b.boardContent%></td>
				</tr>
		<%
			}
		%>
	</table>
	<%
		if(currentPage > 1) {
	%>
			<a href="/web0320/boardList.jsp?key=<%=key%>&searchWord=<%=searchWord%>&currentPage=<%=currentPage - 1%>">[이전]</a>
	<%
		}
	%>
	
	<%=currentPage%>
	
	<%
		if(currentPage < lastPage) {
	%>
			<a href="/web0320/boardList.jsp?key=<%=key%>&searchWord=<%=searchWord%>&currentPage=<%=currentPage + 1%>">[다음]</a>			
	<%
		}
	
	
	%>
	<form action="/web0320/boardList.jsp">
		<select name="key">
			<%
				if(key == null) {
			%>
					<option value="title">제목</option>
					<option value="content">내용</option>	
					<option value="all">제목 or 내용</option>
			<%		
				} else {
					if(key.equals("title")) {
			%>
					<option value="title" selected>제목</option>
			<%
				} else {
			%>
					<option value="title">제목</option>			
			<%
				}
			%>
			<%
				if(key.equals("content")) {
			%>
					<option value="content" selected>내용</option>
			<%
				} else {
			%>
					<option value="content">내용</option>			
			<%
				}
			%>
			<%
				if(key.equals("all")) {
			%>
					<option value="all" selected>제목 or 내용</option>
			<%
				} else {
			%>
					<option value="all">제목 or 내용</option>			
			<%
					}
				} 
			%>
		</select>
		<input type="text" name="searchWord" value="<%=searchWord%>">
		<button type="submit">검색</button>
	</form>
</body>
</html>