<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));	
	}
	int rowPerPage = 10; // 페이지 당 보여줄 행의 수
	
	// 보여줄 데이터의 첫 번째 행	
	int startRow = (currentPage - 1) * rowPerPage;
	
	Connection conn = null;
	// 전체 행의 개수
	PreparedStatement stmt1 = null;
	ResultSet rs1 = null;
	String sql1 = "select count(*) from qna";
	
	// 리스트에 필요한 데이터(행들)
	PreparedStatement stmt2 = null;
	ResultSet rs2 = null;
	String sql2 = "select num, category, title from qna order by num desc limit ?, ?";
	
	// 1) mysql 드라이버를 메모리에 로딩
	Class.forName("com.mysql.cj.jdbc.Driver");
	System.out.println("드라이버 로딩 성공!");
	
	// 2) Connection(접속)하기
	conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/db0313", "root", "java1234");
	System.out.println(conn);
	
	// 3) 쿼리 생성 후 완성(? 값이 있다면)
	stmt1 = conn.prepareStatement(sql1); // select count(*) from qna
	
	// 4) 쿼리 실행 후 결과 값
	rs1 = stmt1.executeQuery();
	rs1.next();
	System.out.println("전체 행의 수: " + rs1.getInt("count(*)")); // 300 : 전체 행의 수
	
	// 전체 행의 수
	int totalCnt = rs1.getInt("count(*)");
	
	// 마지막 페이지
	int lastPage = totalCnt / rowPerPage;
	if(totalCnt % rowPerPage != 0) {
		lastPage += 1; // 전체 개수가 100개다 -> 100/10 마지막 페이지 10, 전체 102/10 -> 10이지만 마지막 페이지 11이어야 모두 출력 가능
	}
	
	// 리스트 데이터 관련
	// 3) 쿼리 생성 후 완성(? 값이 있다면)
	stmt2 = conn.prepareStatement(sql2);
	
	// 쿼리 완성(? 값 설정)
	stmt2.setInt(1, startRow);
	stmt2.setInt(2, rowPerPage);
	System.out.println(stmt2); // 쿼리가 완성되었는지 확인 디버깅
	
	// 4) 쿼리 실행 후 결과 값
	rs2 = stmt2.executeQuery(); // 대부분 10행짜리, 마지막 페이지의 경우 10행보다 작을 수 있다.
	System.out.println("rs2: " + rs2);
%>

	<h1>QnA 목록</h1>
	
	<div>
		<a href="/web0313/insertQnaForm.jsp">글입력</a>
	</div>
	
	<table border="1">
		<tr>
			<th>NUM</th>
			<th>CATEGORY</th>
			<th>TITLE</th>
		</tr>
		<!-- rs2의 길이 만큼 반복 : API로 제공되는 "이터레이터 패턴" 사용 -->
		<%
			while(rs2.next()) { // 커스를 한 행씩 이동하면서 이동한 행에 데이터가 없으면 false
		%>
				<tr>
					<td><%=rs2.getInt("num")%></td>
					<td><%=rs2.getString("category")%></td>
					<td>
						<a href="/web0313/qnaOne.jsp?num=<%=rs2.getInt("num")%>"><%=rs2.getString("title")%></a>
					</td>
				</tr>
				
				
		<%
			}
		%>
	</table>
	
	<!-- 페이징 -->
	<a href="/web0313/qnaList.jsp?currentPage=1">[처음]</a>
	
	<% // 이전
	 	if(currentPage > 1) {
	%>
			<a href="/web0313/qnaList.jsp?currentPage=<%=currentPage - 1%>">[이전]</a>
	<%
	 	}
	%>
	<!-- 현재 페이지 -->
	<%=currentPage%>
	
	<% // 다음
		if(currentPage < lastPage) {
	%>
			<a href="/web0313/qnaList.jsp?currentPage=<%=currentPage + 1%>">[다음]</a>
	<%
		}
	%>
		
	<a href="/web0313/qnaList.jsp?currentPage=<%=lastPage%>">[마지막]</a>
</body>
</html>