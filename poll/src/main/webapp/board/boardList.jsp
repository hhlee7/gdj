<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*" %>
<%@ page import="model.*" %>
<%@ page import="java.util.*" %>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	BoardDao boardDao = new BoardDao();
	Paging p = new Paging();
	
	// 페이징 정보 설정
	int rowPerPage = 15; // 한 페이지 당 보여줄 행 개수
	p.setCurrentPage(currentPage);
	p.setRowPerPage(rowPerPage);
	
	// 마지막 페이지 설정
	int lastPage = p.getLastPage((boardDao.getTotalBoard()));
	
	ArrayList<Board> list = boardDao.selectBoardList(p);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardList</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container">
	<!-- nav.jsp include -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1>BoardList</h1>
	
	<!-- boardlist table -->
	<table class="table table-hover">
		<thead>
			<tr>
				<td>번호</td>
				<td>제목</td>
			</tr>
		</thead>
		<tbody>
			<%
				for(Board b : list) {
			%>
				<tr>
					<td><%=b.getNum()%></td>
					<td>
						<%
							for(int i = 0; i <= b.getDepth(); i++) {
						%>
								&nbsp;&nbsp;
						<%
							}
						%>
						<%
							if(b.getDepth() >= 1) {
						%>
								↪
						<%
							}
						%>
						<a href="/poll/board/boardOne.jsp?num=<%=b.getNum()%>">
							<%=b.getSubject()%>
						</a>
					</td>
				</tr>
			<%
				}
			%>
		</tbody>
	</table>
	
	<!-- 페이징 -->
	<ul class="pagination">
	<%
		if(currentPage > 1) {
	%>
			<li class="page-item"><a class="page-link" href="/poll/board/boardList.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
	<%
		}
	%>
			<li class="page-item"><a class="page-link" href="/poll/board/boardList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
			
	<%
		if(currentPage < lastPage) {
	%>
			<li class="page-item"><a class="page-link" href="/poll/board/boardList.jsp?currentPage=<%=currentPage + 1%>">다음</a></li>
	<%
		}
	%>
	</ul>
</body>
</html>