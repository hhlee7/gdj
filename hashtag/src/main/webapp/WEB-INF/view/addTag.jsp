<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>addTag</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>
	<h1>${boardNo}번 게시글 / 해시태그 입력</h1>
	<form action="/addTagAction" id="tagForm" method="post">
		<input type="hidden" name="boardNo" value="${boardNo}">
		해시태그 :
		<textarea rows="2" cols="80" id="tags" name="tags">${tags}</textarea>
		<br>
		<button type="button" id="btn">태그 추가</button>
	</form>
	
	<script type="text/javascript">
		$('#btn').click(() => {
			let tags = $('#tags').val();
			
			// 정규 표현식
			tags = tags.replace(/[^가-힣a-zA-Z0-9,]/g, '');
			// alert(tags);
			
			$('#tags').val(tags);
			
			$('#tagForm').submit();
		});
	</script>
</body>
</html>