<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertBoard</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>insertBoard</h1>
	<form id="insertForm" action="${pageContext.request.contextPath}/insertBoard" method="post">
		<table border="1">
			<tr>
				<th>제목</th>
				<td><input type="text" name="boardTitle" id="boardTitle"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="3" cols="50" name="boardContent" id="boardContent"></textarea></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="boardUser" id="boardUser"></td>
			</tr>
		</table>
		<button type="submit">등록</button>
	</form>
	<a href="boardList">목록</a>
	
	<script>
		// 입력값 유효성 검사
		$('#insertForm').on('submit', function() {
			if($('#boardTitle').val() == '') {
				alert('제목을 입력하세요.');
				return false;
			}
			if($('#boardContent').val() == '') {
				alert('내용을 입력하세요.');
				return false;
			}
			if($('#boardUser').val() == '') {
				alert('작성자를 입력하세요.');
				return false;
			}
		});
	</script>
	
</body>
</html>