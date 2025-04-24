<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>j01.jsp</title>
</head>
<body>
	<%
		// 출력하는 방법(값을 출력)
		// 자바언어에서 값 : 숫자(실수, 정수), 문자(문자한자, 문자열), 논리
		// 콘솔에 출력
		// 값 출력
		System.out.println(3.14);
		System.out.println(5);
		System.out.println('가');
		System.out.println("abc");
		System.out.println(true);
		System.out.println(false);
		System.out.println("1");
		System.out.println("true");
		// 계산식(표현식) --> 연산 후 값으로 변경 --> 결과값을 출력
		System.out.println(1+3); // 4
		System.out.println(10<7); // false
		System.out.println("구디"+"아카데미"); // 구디아카데미
		int name = 7;
		System.out.println(name);
		
		out.print(name);
	%>
</body>
</html>