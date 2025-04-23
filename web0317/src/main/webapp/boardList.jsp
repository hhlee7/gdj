<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	Connection conn = null;
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	String sql1 = "select count(*) cnt from board";
	
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "select board_no boardNo, board_title boardTitle from board order by board_no desc limit ?, ?";
	
	Class.forName("com.mysql.cj.jdbc.Driver");
	// 드라이버 로딩 확인
	System.out.println("드라이버 로딩 성공");
	
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0317", "root", "java1234");
	// connection 확인
	System.out.println(conn);
	
	stmt1 = conn.prepareStatement(sql1);
	// stmt1 / 쿼리 완성됨을 확인
	System.out.println("stmt1: " + stmt1);
	
	// rs1 / 쿼리 실행 후 결과 확인
	rs1 = stmt1.executeQuery();
	System.out.println("rs1: " + rs1);
	
	// 전체 행의 수
	int totalCnt = 0;
	if(rs1.next()) {
		totalCnt = rs1.getInt("cnt");
	}
	// totalCnt 값 확인
	System.out.println("totalCnt: " + rs1.getInt("cnt"));
		
	int rowPerPage = 10; // 페이지 당 행의 수
	
	// 첫 번재 행
	int startRow = (currentPage - 1) * rowPerPage;
	
	int lastPage = totalCnt / rowPerPage;
	if(totalCnt % rowPerPage != 0) {
		lastPage += 1;
	}
	
	stmt2 = conn.prepareStatement(sql2);	
	stmt2.setInt(1, startRow);
	stmt2.setInt(2, rowPerPage);
	// stmt2 / 쿼리 완성됨을 확인
	System.out.println(stmt2);
	
	// rs2 / 쿼리 실행 후 결과 확인
	rs2 = stmt2.executeQuery();
	System.out.println("rs2: " + rs2);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>Board List</h1>
	<div>
		<a href="/web0317/insertBoardForm.jsp">입력</a>
	</div>
	<table border="1">
		<tr>
			<th>boardNo</th>
			<th>boardTitle</th>
		</tr>
		<%
			while(rs2.next()) {
		%>
				<tr>
					<td><%=rs2.getInt("boardNo")%></td>
					<td><a href="/web0317/boardOne.jsp?boardNo=<%=rs2.getInt("boardNo")%>">
						<%=rs2.getString("boardTitle")%>
						</a>
					</td>
				</tr>
		<%
			}
		%>
	</table>
	<%
		if(currentPage > 1) {
	%>
			<a href="/web0317/boardList.jsp?currentPage=<%=currentPage - 1%>">[이전]</a>
	<%
		}
	%>
	
	<%
		if(currentPage < lastPage) {
	%>
			<a href="/web0317/boardList.jsp?currentPage=<%=currentPage + 1%>">[다음]</a>			
	<%
		}
	%>
</body>
</html>