<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>로또 번호 생성기</h1>
	<%
		// 1) 1 ~ 45 까지 생성
		int[] ball = new int[45]; // index 0 ~ 44
		for(int i = 0; i < ball.length; i++) {
			// 번호는 1부터 45까지 하나의 ball에 각각 맵핑
			ball[i] = i + 1;
		}
		
		for(int i = 0; i < 1000000; i++) { // 섞기를 1000000번 반복
			// 섞기
			int num = (int)(Math.random() * 45); // 0 ~ 44 임의의 수 -> 인덱스 이름에 사용
			// shuffle 알고리즘
			int temp = ball[0]; // 0번째 값을 복사
			ball[0] = ball[num];
			ball[num] = temp;
		}
		
	%>
		<div>
			<%
				for(int i = 0; i < 6; i++) {
			%>
					<%=ball[i]%>, 
			<%
				}
			%>
		</div>
</body>
</html>