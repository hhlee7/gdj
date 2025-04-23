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
	// 배열 사용
	// int[] answer = {4,2,3,1,1,2,1,2,4,2};

	int answer1 = 4;
	int answer2 = 2;
	int answer3 = 3;
	int answer4 = 1;
	int answer5 = 1;
	int answer6 = 2;
	int answer7 = 1;
	int answer8 = 2;
	int answer9 = 4;
	int answer10 = 2;
	
	int total = 100; // 총점
	int questionCount = 10; // 문제 수
	int scorePerOne = total / questionCount; // 한 문제당 점수
	int myScore = 0;
	
	String q1 = request.getParameter("q1");
	int numQ1 = Integer.parseInt(q1); // api 설명 : 입력된 문자값을 숫자로 변경하는 api
	String q2 = request.getParameter("q2");
	int numQ2 = Integer.parseInt(q2);
	String q3 = request.getParameter("q3");
	int numQ3 = Integer.parseInt(q3);
	String q4 = request.getParameter("q4");
	int numQ4 = Integer.parseInt(q4);
	String q5 = request.getParameter("q5");
	int numQ5 = Integer.parseInt(q5);
	String q6 = request.getParameter("q6");
	int numQ6 = Integer.parseInt(q6);
	String q7 = request.getParameter("q7");
	int numQ7 = Integer.parseInt(q7);
	String q8 = request.getParameter("q8");
	int numQ8 = Integer.parseInt(q8);
	String q9 = request.getParameter("q9");
	int numQ9 = Integer.parseInt(q9);
	String q10 = request.getParameter("q10");
	int numQ10 = Integer.parseInt(q10);
	
	String name = request.getParameter("name");
	
	String grade1 = "";
	String grade2 = "";
	String grade3 = "";
	String grade4 = "";
	String grade5 = "";
	String grade6 = "";
	String grade7 = "";
	String grade8 = "";
	String grade9 = "";
	String grade10 = "";
	
	if(answer1 == numQ1) {
		myScore = myScore + scorePerOne; // myScore += scorePerOne;
		grade1 = "O";
	} else {
		grade1 = "X";
	}
	if(answer2 == numQ2) {
		myScore = myScore + scorePerOne;
		grade2 = "O";
	} else {
		grade2 = "X";
	}
	if(answer3 == numQ3) {
		myScore = myScore + scorePerOne;
		grade3 = "O";
	} else {
		grade3 = "X";
	}
	if(answer4 == numQ4) {
		myScore = myScore + scorePerOne;
		grade4 = "O";
	} else {
		grade4 = "X";
	}
	if(answer5 == numQ5) {
		myScore = myScore + scorePerOne;
		grade5 = "O";
	} else {
		grade5 = "X";
	}
	if(answer6 == numQ6) {
		myScore = myScore + scorePerOne;
		grade6 = "O";
	} else {
		grade6 = "X";
	}
	if(answer7 == numQ7) {
		myScore = myScore + scorePerOne;
		grade7 = "O";
	} else {
		grade7 = "X";
	}
	if(answer8 == numQ8) {
		myScore = myScore + scorePerOne;
		grade8 = "O";
	} else {
		grade8 = "X";
	}
	if(answer9 == numQ9) {
		myScore = myScore + scorePerOne;
		grade9 = "O";
	} else {
		grade9 = "X";
	}
	if(answer10 == numQ10) {
		myScore = myScore + scorePerOne;
		grade10 = "O";
	} else {
		grade10 = "X";
	}
%>
	<div>
		<%=name%>
	</div>
	
	<div>
		<table border="1">
			<tr><!-- title -->
				<td>번호</td>
				<td>정답</td>
				<td>제출</td>
				<td>비교</td>
			</tr>
			
			<tr><!-- 1 -->
				<td>1</td>
				<td><%=answer1%></td>
				<td><%=numQ1%></td>
				<td><%=grade1%></td>
			</tr>
			
			<tr><!-- 2 -->
				<td>2</td>
				<td><%=answer2%></td>
				<td><%=numQ2%></td>
				<td><%=grade2%></td>
			</tr>
			
			<tr><!-- 3 -->
				<td>3</td>
				<td><%=answer3%></td>
				<td><%=numQ3%></td>
				<td><%=grade3%></td>
			</tr>
			
			<tr><!-- 4 -->
				<td>4</td>
				<td><%=answer4%></td>
				<td><%=numQ4%></td>
				<td><%=grade4%></td>
			</tr>
			
			<tr><!-- 5 -->
				<td>5</td>
				<td><%=answer5%></td>
				<td><%=numQ5%></td>
				<td><%=grade5%></td>
			</tr>
			
			<tr><!-- 6 -->
				<td>6</td>
				<td><%=answer6%></td>
				<td><%=numQ6%></td>
				<td><%=grade6%></td>
			</tr>
			
			<tr><!-- 7 -->
				<td>7</td>
				<td><%=answer7%></td>
				<td><%=numQ7%></td>
				<td><%=grade7%></td>
			</tr>
			
			<tr><!-- 8 -->
				<td>8</td>
				<td><%=answer8%></td>
				<td><%=numQ8%></td>
				<td><%=grade8%></td>
			</tr>
			
			<tr><!-- 9 -->
				<td>9</td>
				<td><%=answer9%></td>
				<td><%=numQ9%></td>
				<td><%=grade9%></td>
			</tr>
			
			<tr><!-- 10 -->
				<td>10</td>
				<td><%=answer10%></td>
				<td><%=numQ10%></td>
				<td><%=grade10%></td>
			</tr>			
		</table>
	</div>
	
	<div>		
		총점 : <%=myScore%>점
	</div>
</body>
</html>