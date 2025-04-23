<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 
	가로모드 구구단
	1) 2*1=2 2*2=4 ...
	
	세로모드 구구단
	2) 2*1=2 3*1=3 ...
 -->
 <h1>가로모드 구구단</h1>
<%
	// 열보다 행을 먼저 만들고 다음 열을 만든다.
	// 1) 가로모드 : 2단을 먼저
	// 2*1=2 : 단은 고정되어 있고 인덱스가 1 ~ 9까지 증가
	for(int dan = 2; dan <= 9; dan++) { // x 8
		// 하나의 단을 출력
		for(int i = 1; i <= 9; i++) {
			// 콘솔에 출력
			// System.out.print(2 + "*" + i + "=" + (2*i));
			// System.out.print(" ");
			// 페이지에 출력
%>
			<%=dan%>*<%=i%>=<%=2*i%>&nbsp;
<%
		}
%>
		<br>
<%	
	}
%>

<h1>세로모드 구구단</h1>
<%
	// 열보다 행을 먼저 만들고 다음 열을 만든다.
	// 인덱스가 고정되어 있고 단이 2 ~ 9까지 증가
	for(int i = 1; i <= 9; i++) {
		
		for(int dan = 2; dan <= 9; dan++) {
%>
			<%=dan%>*<%=i%>=<%=dan*i%>&nbsp;
<%
		}
%>
		<br>
<%
	}
%>
</body>
</html>