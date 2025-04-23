<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	String saveID = "admin";
	String savePW = "1234";
	
	if(id.equals(saveID) && pw.equals(savePW)) {
%>
		<%=id%>님 반갑습니다.
<%
	} else {
%>
		잘못 입력하셨습니다.
<%
	}
%>
</body>
</html>