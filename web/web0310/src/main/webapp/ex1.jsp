<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>중복(중첩, 이중, 다중, ...) for문</h1>
	<h2> 결과 : 012012012 출력 </h2>
	<%
		// 1)
		System.out.println("012012012"); // x 1
	
		// 2)
		// for
		for(int i = 0; i < 3; i++) {
			System.out.print("012"); // x 3
		}
		System.out.println();
		
		// 3)
		// 이중 for
		for(int i = 0; i < 3; i++) {
			for(int n = 0; n < 3; n++) {
				System.out.print(n); // i:0 -> n:0, i:0 -> n:1, i:0 -> n:2, i:1 -> n:0, ... / x 9
			}			
		}
		System.out.println();
		
		// 4)
		// 이중 for문을 단일 for문으로 튜닝(리팩토리)
		for(int i = 0; i < 9; i++) {
			System.out.print(i % 3); // 012345678
		}
	%>
</body>
</html>