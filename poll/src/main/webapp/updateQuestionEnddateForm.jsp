<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	// 전달된 num 값 확인
	System.out.println("updateQuestionEnddateForm.jsp num: " + num);
	
	// 모델(Dao) 객체 생성
	QuestionDao questionDao = new QuestionDao();
	
	// 해당 num 값을 가지는 데이터 행 조회
	Question q = questionDao.selectQuestion(num);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>종료 일자 수정</title>
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
	
	<h1>종료 일자 수정</h1>
		<form method="post" action="/poll/updateQuestionEnddateAction.jsp">
		<input type="hidden" name="num" value="<%=q.getNum()%>">
			<table class="table table-hover">
				<tr>
					<th>종료 일자</th>
					<td>
						<input type="date" name="enddate" value="<%=q.getEnddate()%>">
					</td>
				</tr>
			</table>
		<button class="btn btn-outline-primary" type="submit">수정하기</button>
		</form>
</body>
</html>