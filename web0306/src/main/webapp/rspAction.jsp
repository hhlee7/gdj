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
	String userRsp = request.getParameter("userRsp");
	// 디버깅
	System.out.println("userRsp: " + userRsp); // 문자열 연산자 + 
	
	// 시스템의 가위, 바위, 보를 결정 -> 랜덤(난수를 이용)
	int num = (int)(Math.random() * 3); // 0, 1, 2
	String[] arr = {"가위", "바위", "보"};
	/*
		arr[0] --> 가위, arr[1] --> 바위, arr[2] --> 보
	*/
	
	String comRsp = arr[num];
	System.out.println("comRsp: " + comRsp);
	
	String result = "";	
	// userRsp vs comRsp : == 사용할 수 없다.
	
	/*
	if(userRsp.equals(comRsp)) {
		result = "비겼다";
	} else if(userRsp.equals("가위")&&comRsp.equals("보")) { // user 승리
		result = "user 이겼다";
	} else if(userRsp.equals("바위")&&comRsp.equals("가위")) { // user 승리
		result = "user 이겼다";
	} else if(userRsp.equals("보")&&comRsp.equals("바위")) { // user 승리
		result = "user 이겼다";
	} else {
		result = "com 이겼다";		
	}
	*/
	
	if(userRsp.equals(comRsp)) {
		result = "비겼다";
	} else if(
			(userRsp.equals("가위")&&comRsp.equals("보"))
			|| (userRsp.equals("바위")&&comRsp.equals("가위"))
			|| (userRsp.equals("보")&&comRsp.equals("바위"))
			) { // user 승리
		result = "user 이겼다";
	} else {
		result = "com 이겼다";		
	}
	
%>

	userRsp: <%=userRsp%>
	<br>
	comRsp: <%=comRsp%>
	<br>
	<%=result%>
</body>
</html>