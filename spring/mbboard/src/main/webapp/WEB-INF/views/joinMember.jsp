<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinMember</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(function() {
		$('#idckBtn').click(function() {
			// ID 공백 체크
			if($('#idck').val() == '') {
				alert('아이디를 입력하세요.');
				return;
			}
			
			// ID 유무 확인
			$.ajax({
				url:'/isId/' + $('#idck').val()
				, type:'get'
				, success: function(data) {
					if(data == true) {
						alert('이미 사용중인 아이디입니다.');
					} else {
						alert('사용 가능한 아이디입니다.');
						$('#id').val($('#idck').val());
					}
				} 
			});
		});
	
		$('#btn').click(function() {
			let pw = $('#pw').val();
			let pw2 = $('#pw2').val();
			
			// 비밀번호 공백 체크
			if(pw == '' || pw2 == "") {
				alert('비밀번호를 입력하세요.');
				return;
			}
			
			// 비밀번호 일치 여부 확인
			if(pw != pw2) {
				alert('비밀번호가 일치하지 않습니다.');
				return;
			}
			
			// 모든 조건 만족 시, submit
			$('#joinForm').submit();
		});
	});
</script>
</head>
<body>
	<h1>회원가입</h1>
	<h2>ID 검색</h2>
	<table border="1">
		<tr>
			<th>ID 검색</th>
			<td>
				<input type="text" id="idck">
				<button type="button" id="idckBtn">ID 검색</button>
			</td>
		</tr>
	</table>
	
	<br>
		
	<form id="joinForm" action="/joinMember" method="post">
		<table border="1">
			<tr>
				<th>아이디</th>
				<td><input type="text" id="id" name="memberId" readonly></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" id="pw" name="memberPw">
					확인 - <input type="password" id="pw2" name="pw2">	
				</td>
			</tr>
		</table>
		<button type="button" id="btn">회원가입</button>
	</form>
</body>
</html>