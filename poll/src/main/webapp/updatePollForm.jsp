<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="dto.*"%>
<%@page import="model.*"%>
<%@page import="java.util.*"%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	// 전달된 num 값 확인
	System.out.println("updatePollForm.jsp num: " + num);
	
	// 모델(Dao) 객체 생성
	QuestionDao questionDao = new QuestionDao();
	ItemDao itemDao = new ItemDao();
	
	// 해당 num 값을 가지는 데이터 행 조회
	Question q = questionDao.selectQuestion(num);
	ArrayList<Item> itemList = itemDao.selectItemList(num);
	
	// 기존 항목 데이터 출력을 위한 설정
	int contentSize = 8;
	String[] content = new String[contentSize]; 
	for(int i = 0; i < contentSize; i++) {
		if(i < itemList.size() && itemList.get(i).getContent() != null) {
			content[i] = itemList.get(i).getContent();
		} else {
			content[i] = "";
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>UpdatePollForm</title>
</head>
<body>
	<h1>투표 프로그램</h1>
	<hr>
	<h2>설문 수정</h2>
	<form method="post" action="/poll/updatePollAction.jsp">
		<input type="hidden" name="num" value="<%=q.getNum()%>">
		<table border="1">
			<tr>
				<td>질문</td>
				<td colspan="2">
					<input type="text" name="title" value="<%=q.getTitle()%>">
				</td>
			</tr>
			<tr>
				<td rowspan="8">항목</td>
				<td>1) <input type="text" name="content" value="<%=content[0]%>"></td>
				<td>2) <input type="text" name="content" value="<%=content[1]%>"></td>
			</tr>
			<tr>
				<td>3) <input type="text" name="content" value="<%=content[2]%>"></td>
				<td>4) <input type="text" name="content" value="<%=content[3]%>"></td>
			</tr>
			<tr>
				<td>5) <input type="text" name="content" value="<%=content[4]%>"></td>
				<td>6) <input type="text" name="content" value="<%=content[5]%>"></td>
			</tr>
			<tr>
				<td>7) <input type="text" name="content" value="<%=content[6]%>"></td>
				<td>8) <input type="text" name="content" value="<%=content[7]%>"></td>
			</tr>
			<tr>
				<td>시작일</td>
				<td><input type="date" name="startdate" value="<%=q.getStartdate()%>" readonly></td>
			</tr>
			<tr>
				<td>종료일</td>
				<td><input type="date" name="enddate" value="<%=q.getEnddate()%>" readonly></td>
			</tr>
			<tr>
				<td>복수 투표</td>
				<td>
				<%
					if(q.getType() == 1) {
				%>
						<input type="radio" name="type" value="1" checked>yes
				<%
					} else {
				%>
						<input type="radio" name="type" value="1">yes
				<%
					}
				%>
				
				<%
					if(q.getType() == 0) {
				%>
						<input type="radio" name="type" value="0" checked>no
				<%
					} else {
				%>
						<input type="radio" name="type" value="0">no
				<%
					}
				%>
				</td>
			</tr>
		</table>
		<button type="submit">수정하기</button>
	
	</form>
</body>
</html>