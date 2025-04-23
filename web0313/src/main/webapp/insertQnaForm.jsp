<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<h1>QnA 입력</h1>
	<form action="/web0313/insertQnaAction.jsp">
		<table border="1">
			<tr>
				<th>CATEGORY</th>
				<td>
					<select name="category">
						<option value="상품">상품</option>
						<option value="주문">주문</option>
						<option value="배달">배달</option>
						<option value="기타">기타</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>TITLE</th>
				<td>
					<input type="text" name="title">
				</td>
			</tr>
			<tr>
				<th>CONTENT</th>
				<td>
					<textarea rows="5" cols="80" name="content"></textarea>
				</td>
			</tr>
			<tr>
				<th>WRITER</th>
				<td>
					<input type="text" name="writer">					
				</td>
			</tr>
			<tr>
				<th>AGE(10대, 20대, ...)</th>
				<td>
					<input type="number" name="age" min="0" step="10">
				</td>				
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" name="pw">
				</td>
			</tr>
		</table>
		<button type="submit">입력</button>
	</form>
</body>
</html>