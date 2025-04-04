<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="model.*"%>
<%@page import="dto.*"%>
<%@page import="java.util.*"%>

<%
	// Controller : request 분석 + model 호출
	int num = Integer.parseInt(request.getParameter("num"));

	// 문제 출력
	// item 출력
	
	// 1) questionOne
	QuestionDao questionDao = new QuestionDao();
	Question question = questionDao.selectQuestion(num);

	// 2) 1)의 itemList
	ItemDao itemDao = new ItemDao();
	ArrayList<Item> itemList = itemDao.selectItemListByNum(num);
	
	// 3) 총 투표 수
	int totalCount = itemDao.selectItemCountByNum(num);
%>

<!-- View -->
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>투표결과</title>
	<!-- Latest compiled and minified CSS -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
	
	<!-- Latest compiled JavaScript -->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- nav.jsp include -->
	<div>
		<jsp:include page="/inc/nav.jsp"></jsp:include>
	</div>
	
	<h1><%=num%>. 투표결과</h1>
	<table class="table table-hover">
		<tr>
			<td colspan="4">
				Q : <%=question.getTitle()%>
			</td>
		</tr>
		<tr>
			<td colspan="4">
				총 투표 수 : <%=totalCount%>
			</td>
		</tr>
		<tr>
			<td>번호</td>
			<td>내용</td>
			<td>카운트(차트)</td>
			<td>카운트</td>
		</tr>
		<%
			for(Item i : itemList) {
		%>
				<tr>
					<td><%=i.getInum()%></td>
					<td><%=i.getContent()%></td>
					<td>
					<!-- 각 count값에 대한 백분율 값 -->
						<%
							int percentage = (int)(Math.round((double)i.getCount() / (double)totalCount * 100));
						%>
						<div class="progress">
						  <div class="progress-bar" style="width:<%=percentage%>%"><%=percentage%>%</div>
						</div>
					</td>
					<td><%=i.getCount()%></td>
				</tr>
		<%	
			}
		%>
	</table>
</body>
</html>