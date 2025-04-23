<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%!
	// 선언문(정의문)
	// ※ 실행문이 아니다.
	public void add21() { // 메서드 이름 : add21, 입력값은 없다, 반환값이 없다.
		int x = 2 + 1;	
	}

	public void printHello() { // 메서드 이름 : printHello, 입력값은 없다, 반환값이 없다.
		System.out.println("hello");
	}
	
	public String resultThanks() { // 메서드 이름 : resultThanks, 입력값은 없다, 반환값이 있다. -> 문자열
		return "감사합니다.";
	}
	
	public String resultHello() { // 메서드 이름 : resultHello, 입력값은 없다, 반환값이 있다. -> 문자열
		String str = "hello";
		return str;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		add21();
		printHello();
		var x = resultThanks(); // x : "감사합니다"
		String str = resultHello();
	%>
	<%=x%>
	<br>
	<%=str%>
</body>
</html>