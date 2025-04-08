<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dto.*"%>
<%@ page import="model.*"%>
<%@ page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%
	// question 테이블 리스트 -> 페이징 -> title 링크(stardate <= 오늘 날짜 <= enddate) -> 투표 프로그램
	
	// 현재 페이지 설정
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	// 페이징 정보 설정
	int rowPerPage = 5; // 한 페이지 당 보여줄 행 개수
	Paging paging = new Paging();
	paging.setCurrentPage(currentPage);
	paging.setRowPerPage(rowPerPage);
	
	// Dao 객체 생성
	QuestionDao questionDao = new QuestionDao();
	ItemDao itemDao = new ItemDao();
	
	// 마지막 페이지 설정
	int lastPage = paging.getLastPage((questionDao.getTotalQuestion()));
	
	// 오늘 날짜 가져오기
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	String todayStr = sdf.format(date);
	Date today = sdf.parse(todayStr);
	
	// 해당 페이지에 속한 리스트 조회
	ArrayList<Question> list = questionDao.selectQuestionList(paging);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>설문 리스트</title>
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
	
	<h1>설문 리스트</h1>
	<table class="table table-hover">
		<tr>
			<th>번호</th>
			<th>제목</th>
			<th>투표 기간</th>
			<th>현재 투표 현황</th>
			<th>투표</th>
			<th>삭제</th>
			<th>수정</th>
			<th>종료 일자 수정</th>
			<th>결과</th>
		</tr>
		<%
			for(Question q : list) {
		%>
				<tr>
					<td><%=q.getNum()%></td>
					<td><%=q.getTitle()%></td>
					<td><%=q.getStartdate()%> ~ <%=q.getEnddate()%></td>
					<td><%=q.getSumCnt()%></td>
					<td>
					<%
						Date startDate = sdf.parse(q.getStartdate());
						Date endDate = sdf.parse(q.getEnddate());
						if(today.before(startDate)) {
					%>
							투표 시작 전
					<%
						} else if(today.after(endDate)) {
					%>
							투표 종료
					<%
						} else {
					%>
							<a class="btn btn-outline-primary" href="/poll/updateItemForm.jsp?num=<%=q.getNum()%>">투표하기</a>
					<%
						}
					%>
					</td>
					<td>
					<%
						if(today.after(endDate) || q.getSumCnt() >= 1) {
					%>
							불가
					<%
						} else {
					%>
							<a class="btn btn-outline-primary" href="/poll/deletePollAction.jsp?num=<%=q.getNum()%>">삭제</a>
					<%
							}
					
					%>
					</td>
					<td>
						<a class="btn btn-outline-primary" href="/poll/updatePollForm.jsp?num=<%=q.getNum()%>">수정</a>
					</td>
					<td>
					<%
						if(today.before(endDate) || today.equals(endDate)) {
					%>
							<a class="btn btn-outline-primary" href="/poll/updateQuestionEnddateForm.jsp?num=<%=q.getNum()%>">종료 일자 수정</a>
					<%
						} else {
					%>
							불가
					<%
						}
					%>
					</td>
					<td>
					<%
						if(today.after(endDate)) {
					%>
							<a class="btn btn-outline-primary" href="/poll/questionOneResult.jsp?num=<%=q.getNum()%>">결과보기</a>
					<%
						} else {
					%>
							투표 진행 중
					<%
						}
					%>
					</td>
				</tr>
		<%
			}
		%>
	</table>
	
	<!-- 페이징 -->
	<ul class="pagination">
	<%
		if(currentPage > 1) {
	%>
			<li class="page-item"><a class="page-link" href="/poll/pollList.jsp?currentPage=<%=currentPage - 1%>">이전</a></li>
	<%
		}
	%>
			<li class="page-item"><a class="page-link" href="/poll/pollList.jsp?currentPage=<%=currentPage%>"><%=currentPage%></a></li>
			
	<%
		if(currentPage < lastPage) {
	%>
			<li class="page-item"><a class="page-link" href="/poll/pollList.jsp?currentPage=<%=currentPage + 1%>">다음</a></li>
	<%
		}
	%>
	</ul>
</body>
</html>