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
		/*
			1. 값 : 숫자, 문자, 문자열, 논리
			2. 식 : 연산, 변수, 메서드 호출 -> 값으로 치환(void 포함)
			3. 문 : 제어문(조건문 if/switch, 반복문 while/for/foreach) - {}
		*/
		int score = 100;
		if(score == 100) {
			System.out.println("점수는 100점입니다."); // void 값으로 치환 / 대입 연산자 X
		}
		
		int score2 = 90;
		if(score2 == 100) { // false
			System.out.println("score2 점수는 100점입니다.");
		} else {
			System.out.println("score2 점수는 100점이 아닙니다.");
		}
		
		int score3 = 90;
		if(score3 == 100) {
			System.out.println("score3 점수는 100점입니다.");
		} else if(score3 == 90) {
			System.out.println("score3 점수는 90점입니다.");
		}
		
		int age = 19;
		if(age % 2 == 1) {
			System.out.println("나이는 홀수입니다.");
		} else {
			System.out.println("나이는 짝수입니다.");
		}
		
		int age2 = 19;
		if(age2 % 2 == 1) {
			System.out.println("나이는 홀수입니다.");
		} else if(age2 % 2 == 0) {
			System.out.println("나이는 짝수입니다.");
		}
		
	%>
</body>
</html>