<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>signLevel3</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/signature_pad@4.1.7/dist/signature_pad.umd.min.js"></script>
<script>
	$(document).ready(function() {
		// 캔버스에 사인 후 객체로 받는 SignaturePad 생성자
		// SignaturePad API 실행은 https://github.com/szimek/signature_pad 페이지 readMe파일 API 부분 참고
		const signaturePad = new SignaturePad($('canvas')[0], {
			minWidth: 1,
			maxWidth: 1,
			penColor: '#000000'
		});
		
		// 캔버스 내용을 초기화하는 SignaturePad API clear() 메서드
		$('#btnClear').click(function() {
			signaturePad.clear();
		});
		
		// Ajax로 SignaturePad 객체 안 사인 이미지를 서버로 전송
		$('#btnSign').click(function() {
			if(signaturePad.isEmpty()) {
				alert('사인을 작성해주세요.');
			} else {
				// $.ajax({}).done().fail();
				
				$.ajax({
					asyn : true, // true면 비동기(백그라운드로 실행)
					url : '/addSign',
					type : 'post',
					data : {
						id: $('#id').text(),
						signImg: signaturePad.toDataURL(), // signaturePad.toDataURL("image/jpeg"); 인수 생략 시 기본값은 png 이미지
					} // 로그인 사용자 id와 SignaturePad 객체안의 사인 이미지
				}).done(function(data) {
					alert(data); // data = '결제 완료'
					// 사인을 초기화 signaturePad.clear();
					
					// js로 페이지 이동 location.href='이동할 페이지'
				}).fail(function() {
					alert('결제 실패');
				});
			}
		});
	});
</script>
</head>
<body>
	<!-- id : 사인 레벨이 되는 로그인 사용자 id -->
	<div id="id">manager</div> <!-- <input id="id" type="text" value="manager"> -->
	<canvas style="border: 1px solid #FF0000"></canvas>
	<br>
	<button type="button" id="btnClear">지우기</button>
	<button type="button" id="btnSign">결제하기</button>
</body>
</html>