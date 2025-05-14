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
				<th>주소</th>
				<td>
					<input type="text" name="postcode" id="postcode" placeholder="우편번호">
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" name="roadAddress" id="roadAddress" placeholder="도로명주소">
					<input type="text" name="jibunAddress" id="jibunAddress" placeholder="지번주소">
					<span id="guide" style="color:#999;display:none"></span>
					<input type="text" name="detailAddress" id="detailAddress" placeholder="상세주소">
					<input type="text" name="extraAddress" id="extraAddress" placeholder="참고항목">
				</td>
			</tr>
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
	
	<!-- 카카오 주소 API 호출을 위한 CDN 주소 -->
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	    function execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("roadAddress").value = roadAddr;
	                document.getElementById("jibunAddress").value = data.jibunAddress;
	                
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                if(roadAddr !== ''){
	                    document.getElementById("extraAddress").value = extraRoadAddr;
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }
	
	                var guideTextBox = document.getElementById("guide");
	                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	                if(data.autoRoadAddress) {
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                    guideTextBox.style.display = 'block';
	
	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                    guideTextBox.style.display = 'block';
	                } else {
	                    guideTextBox.innerHTML = '';
	                    guideTextBox.style.display = 'none';
	                }
	            }
	        }).open();
	    }
	</script>
</body>
</html>