<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%
	// question 테이블 리스트 -> 페이징 -> title 링크(stardate <= 오늘 날짜 <= enddate) -> 투표 프로그램
	// QuestionDao.selectQuestionList(Paging)
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage = 10;
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	QuestionDao questionDao = new QuestionDao();
	ArrayList<Question> list = questionDao.selectQuestionList(paging);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>pollList</title>
</head>
<body>
	<h1>설문 리스트</h1>
	<!-- foreach문 ArrayList<Question> list 출력
	title 링크(stardate <= 오늘 날짜 <= enddate) 투표 시작 전, 투표 종료, 투표 하기 -->
	<table border="1">
		<tr>
			<th>num</th>
			<th>title</th>
			<th>startdate</th>
			<th>enddate</th>
			<th>createdate</th>
			<th>type</th>
		</tr>
		<%
			for(Question q : list) {
		%>
				<tr>
					<td><%=q.getNum()%></td>
					<td><%=q.getTitle()%></td>
					<td><%=q.getStartdate()%></td>
					<td><%=q.getEnddate()%></td>
					<td><%=q.getCreatedate()%></td>
					<td><%=q.getType()%></td>
				</tr>
		<%
			}
		%>
	</table>
	
</body>
</html>