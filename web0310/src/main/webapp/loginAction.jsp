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
	// 사용자가 입력한 ID/PW
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	// Database Server에서 가져온 사용자 ID/PW
	String saveID = "admin";
	String savePW = "1234";
	
	if(id.equals(saveID)) {
		// 중첩 if문
		if(pw.equals(savePW)) {
%>
			<%=id%>님 반갑습니다.
<%
		} else {
%>
			PW가 틀렸습니다.
<%			
		}
	} else {
%>
		ID가 틀렸습니다.
<%
	}
%>
</body>
</html>