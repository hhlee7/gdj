<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(function() {
		// sn1 입력 완료 시 sn2로 포커스 이동
		$('#sn1').keyup(function() {
			if($(this).val().length == 6) {
				$('#sn2').focus();
			}
		});
		
		$('#sn2').blur(function() {
			let sn1 = $('#sn1').val();
			let sn2 = $('#sn2').val();
			
		// 외부 API 서버를 호출 - 비동기 호출이 필수 O
			// 해당 조건일 경우에만 ajax 호출
			// sn1의 길이 6, sn2의 길이 7, 둘 다 숫자인 경우에만
			if(sn1.length == 6 && sn2.length == 7 && !isNaN(sn1) && !isNaN(sn2)) {
				$.ajax({
					url:'http://localhost:9999/isSn/' + sn1 + sn2
					, type:'get'
					, success: function(data) {
									if(data == true) {
										alert('주민번호 인증 성공');
										// 성별 확인
										if(Number(sn2.substr(0, 1)) % 2 == 0) {
											$('#gender').val('여');
										} else {
											$('#gender').val('남');
										}
										// 나이 계산
										let birthYearPrefix = '';
										let genderCode = sn2.substr(0, 1);
										
										if(genderCode == '1' || genderCode == '2') {
											birthYearPrefix = '19';
										} else if(genderCode == '3' || genderCode == '4') {
											birthYearPrefix = '20';
										} else {
											alert('알 수 없는 성별 코드입니다.');
											return;
										}
										
										let birthYear = parseInt(birthYearPrefix + sn1.substr(0, 2));
										let birthMonth = parseInt(sn1.substr(2, 2));
										let birthDate = parseInt(sn1.substr(4, 2));
										
										let today = new Date();
										let age = today.getFullYear() - birthYear;
										
										let birthDay = new Date(today.getFullYear(), birthMonth - 1, birthDate);
										if(today < birthDay) {
											age--;
										}
										
										$('#age').val(age);
										
									} else {
										alert('주민번호 인증 실패');
									}
								}
				});
			} else {
				alert('주민번호 형식이 올바르지 않습니다.');
			}
		});
		
		// 내부 API 서버를 호출 - 비동기 구현 필수 X -> 편의상 비동기로 구현
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
	<hr>
	<h2>주민번호 확인</h2>
	<table border="1">
		<tr>
			<th>주민번호</th>
			<td>
				<input type="text" id="sn1"> <!-- keyup, length6, focus sn2 -->
				- 
				<input type="text" id="sn2"> <!-- blur length == 7, snapi 호출, true gender + age, false alert 잘못된 주민번호 -->
			</td>
		</tr>
	</table>
	<hr>
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
				<th>성별</th>
				<td><input type="text" id="gender" name="gender" readonly></td>
			</tr>
			<tr>
				<th>나이</th>
				<td><input type="text" id="age" name="age" readonly></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><input type="text" id="id" name="id" readonly></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td>
					<input type="password" id="pw" name="pw">
					확인 - <input type="password" id="pw2" name="pw2">
				</td>
			</tr>
		</table>
		<button type="button" id="btn">회원가입</button>
	</form>
</body>
</html>