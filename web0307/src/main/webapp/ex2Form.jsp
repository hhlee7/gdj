<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>ex2From : 생일(name=birth), 성별(name=gender), 좋아하는 색깔(name=myColor)</h1>
	<form action="/web0307/ex2Action.jsp">
		<table border="1">
			<tr>
				<td>생일</td><!-- 출력 : 나이 -->
				<td><input type="date" name="birth"></td>
			</tr>
			<tr>
				<td>성별</td><!-- 출력 : 이모지 -->
				<td>
					<input type="radio" name="gender" value="M">남
					<input type="radio" name="gender" value="F">여
				</td>
			</tr>
			<tr>
				<td>좋아하는 색깔</td><!-- 출력 : 16진수 출력 + 글자색 변경하여 출력 -->
				<td><input type="color" name="myColor"></td>
			</tr>
		</table>
		<button type="submit">입력</button>
	</form>
</body>
</html>