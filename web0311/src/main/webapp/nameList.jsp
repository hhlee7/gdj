<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	System.out.println("currentPage: " + currentPage);

	String[] db = null;
	db = new String[105]; // index : 0 ~ 104
	
	for(int i = 0; i < db.length; i++) {
		// 3개의 랜덤 char 문자를 생성
		int temp = (int)(Math.random() * 26) + 97; // 97 ~ 122
		char c1 = (char)temp;
		temp = (int)(Math.random() * 26) + 97; // 97 ~ 122
		char c2 = (char)temp;
		temp = (int)(Math.random() * 26) + 97; // 97 ~ 122
		char c3 = (char)temp;
		
		db[i] = "" + c1 + c2 + c3;
	}
	
	// 페이징 관련 로직
	// 한 페이지에 출력할 이름의 개수
	int idxPerPage = 5;
	// 마지막 페이지 : 전체 개수(db.length) / idxPerPage -> 나누어 떨이지지 않으면 올림(or + 1)
	int lastPage = db.length / idxPerPage;
	if(db.length % idxPerPage != 0) { // 결과가 나누어 떨이지지 않으면
		lastPage += 1; // 105 / 10 --> 10, 105 % / 10 --> 5, lastPage --> 10 + 1
	}
	
	int startIdx = (currentPage - 1) * idxPerPage;
	/*
	첫 번째 인덱스는 현재 페이지(currentPage)와 페이지 당 보여줄 개수(idxPerPage)에 따라 일정한 패턴을 가짐
	currentPage 1	2	3	4	5
	
					이전 페이지 x 10(idxPerPage)
	
	startIdx	0	10	20	30	40
	*/
	
	// 출력할 페이지의 마지막 인덱스는 마지막 페이지의 경우 변경 필요
	int endIdx = startIdx + (idxPerPage - 1);
	if(endIdx > db.length - 1) { // ex) 마지막 페이지 100 ~ 104 출력 되어야 하는데 endIdx : 109 -> 104 변경
		endIdx = db.length - 1; // endIdx를 전체 배열의 마지막 idx로 변경
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>nameList</title>
</head>
<body>
	<table border="1">
		<tr>
			<td>INDEX</td>
			<td>NAME</td>
		</tr>
		<%
			// i(인덱스)값도 출력하기 위해서 foreach 문 대신 for 문을 선택
			for(int i = startIdx; i <= endIdx; i++) {
		%>
				<tr>
					<td><%=i%></td>
					<td><%=db[i]%></td>
				</tr>				
		<%
			}
		%>
	</table>
	<div>
		<!-- 페이징 로직 -->
		<a href="/web0311/nameList.jsp?currentPage=1">[처음으로]</a>
		<!-- 현재 페이지가 1 이 아닐 때 출력 : 현재 페이지가 1 보다 클 때 -->
		<%
			if(currentPage > 1) { // currentPage != 1
		%>
				<a href="/web0311/nameList.jsp?currentPage=<%=currentPage - 1%>">[이전]</a>
		<%
			}
		%>
		
		<%=currentPage%>
		
		<!-- 현재 페이지가 마지막 페이지가 아닐 때 출력 : 현재 페이지가 마지막 페이지보다 작을 때 -->
		<%
			if(currentPage < lastPage) {
		%>
				<a href="/web0311/nameList.jsp?currentPage=<%=currentPage + 1%>">[다음]</a>
		<%
			}
		%>
		<a href="/web0311/nameList.jsp?currentPage=<%=lastPage%>">[마지막으로]</a>
	</div>
</body>
</html>