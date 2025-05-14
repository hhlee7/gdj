<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateBoard</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>updateBoard</h1>
	<form id="updateForm" action="${pageContext.request.contextPath}/updateBoard" method="post">
		<input type="hidden" name="boardNo" value="${board.boardNo}">
		<table border="1">
			<tr>
				<th>제목</th>
				<td><input type="text" name="boardTitle" id="boardTitle" value="${board.boardTitle}"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea rows="3" cols="50" name="boardContent" id="boardContent">${board.boardContent}</textarea></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><input type="text" name="boardUser" id="boardUser" value="${board.boardUser}"></td>
			</tr>
		</table>
		<button type="submit">수정</button>
	</form>
	<a href="boardList">목록</a>
	
	<script>
		// 입력값 유효성 검사
		$('#updateForm').on('submit', function(e) {
			if($('#boardTitle').val() == '') {
				alert('제목을 입력하세요.');
				e.preventDefault();
				return;
			}
			if($('#boardContent').val() == '') {
				alert('내용을 입력하세요.');
				e.preventDefault();
				return;
			}
			if($('#boardUser').val() == '') {
				alert('작성자를 입력하세요.');
				e.preventDefault();
				return;
			}
		});
	</script>
	
</body>
</html>