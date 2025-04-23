<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	table, td {border: 1px solid red;}
</style>
</head>
<body>
	<h1>입력폼 연습</h1>
	<form action="/web0306/ex22.jsp">
		<table>
			<tr>
				<td>이름</td>
				<td><input name="name" type="text"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input name="pw" type="password"></td>
			</tr>
			<tr>
				<td>나이</td>
				<td><input name="age" type="number" min="0" max="200" step="1"></td>
			</tr>
			<tr>
				<td>생일</td>
				<td><input name="birth" type="date"></td>
			</tr>
			<tr>
				<td>좋아하는 색상</td>
				<td><input name="favoriteColor" type="color"></td>
			</tr>
			<tr>
				<td>별점</td>
				<td><input name="starPoint" type="range" min="0" max="100" step="10"></td>
			</tr>
			<tr>
				<td>성별</td>
				<td>
					<input name="gender" type="radio" value="남">남
					<input name="gender" type="radio" value="여">여
				</td>
			</tr>
			<tr>
				<td>취미</td>
				<td>
					<input type="checkbox" value="야구" name="hobby">야구
					<input type="checkbox" value="축구" name="hobby">축구
					<input type="checkbox" value="게임" name="hobby">게임
				</td>
			</tr>
			<tr>
				<td>소속</td>
				<td>
					<select name="classroom">
						<option value="1">1강의실</option>
						<option value="2">2강의실</option>
						<option value="3">3강의실</option>
						<option value="4">4강의실</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>메모</td>
				<td><textarea name="memo" rows="3" cols="30"></textarea></td>
			</tr>
		</table>
		<button type="submit">회원가입</button>
	</form>
</body>
</html>