<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertBoard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body class="bg-light">

<div class="container mt-5" style="max-width: 700px;">
	<h1 class="mb-4 text-center">📝 게시글 작성</h1>

	<div class="card">
		<div class="card-body">
			<form id="insertForm" action="${pageContext.request.contextPath}/insertBoard" method="post">
				<div class="mb-3">
					<label for="boardTitle" class="form-label">제목</label>
					<input type="text" class="form-control" name="boardTitle" id="boardTitle">
				</div>
				<div class="mb-3">
					<label for="boardContent" class="form-label">내용</label>
					<textarea class="form-control" name="boardContent" id="boardContent" rows="4"></textarea>
				</div>
				<div class="mb-3">
					<label for="boardUser" class="form-label">작성자</label>
					<input type="text" class="form-control" name="boardUser" id="boardUser">
				</div>
				<div class="d-flex justify-content-between">
					<a href="boardList" class="btn btn-secondary">목록</a>
					<button type="submit" class="btn btn-primary">등록</button>
				</div>
			</form>
		</div>
	</div>
</div>

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