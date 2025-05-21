<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>changePw</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		$('#changeBtn').click(function() {
			const nowPw = $('#nowPw').val();
			const pw1 = $('#pw1').val();
			const pw2 = $('#pw2').val();
			
			if(pw1 != pw2) {
				alert("변경할 비밀번호가 일치하지 않습니다.");
				return;
			}
			
			$.ajax({
				url: '/changePw',
				type: 'post',
				data: {
					nowPw: nowPw,
					pw1: pw1
				},
				success: function(data) {
					if(data == 'success') {
						window.location.href = '/login';
					} else {
						alert('비밀번호가 일치하지 않습니다.');
					}
				}
			})
		});
	});
</script>
</head>
<body>
	<h1>비밀번호 변경</h1>
	<form id="changeForm" method="post" action="/changePw">
		<div>
			현재 비밀번호 : <input type="password" id="nowPw" name="nowPw">
		</div>
		<div>
			변경 비밀번호 : <input type="password" id="pw1" name="pw1">
		</div>
		<div>
			비밀번호 확인 : <input type="password" id="pw2" name="pw2">
		</div>
		<button type="button" id="changeBtn">변경</button>
	</form>
</body>
</html>