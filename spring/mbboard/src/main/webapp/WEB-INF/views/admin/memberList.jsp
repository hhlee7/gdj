<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberList</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head>
<body>
	<h1>memberList</h1>
	<table border="1">
		<tr>
			<th>아이디</th>
			<th>권한</th>
			<th>권한 변경</th>
		</tr>
		<c:forEach var="m" items="${memberList}">
			<tr>
				<td>${m.memberId}</td>
				<td>${m.memberRole}</td>
				<td>
					<c:if test="${m.memberId != loginMember.memberId}">
						<select class="changeRole" data-member-id="${m.memberId}">
							<option value="MEMBER" ${m.memberRole == 'MEMBER' ? 'selected' : ''}>MEMBER</option>
							<option value="ADMIN" ${m.memberRole == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
						</select>
						<button type="button" class="changeBtn" data-member-id="${m.memberId}">변경</button>
					</c:if>
					<c:if test="${m.memberId == loginMember.memberId}">
						<span style="color: gray;">본인 계정</span>
					</c:if>
				</td>
			</tr>
		</c:forEach>
	</table>
	
	<a href="/admin/adminHome">홈으로</a>

	<script>
	$(function() {
		$('.changeBtn').click(function() {
			const memberId = $(this).data('member-id');
			const newRole = $('.changeRole[data-member-id="' + memberId + '"]').val();

			$.ajax({
				url: '/admin/changeRole',
				type: 'post',
				data: { memberId, newRole },
				success: function(response) {
					if (response === 'success') {
						location.reload();
					} else {
						alert('권한 변경 실패');
					}
				}
			});
		});
	});
	</script>
</body>
</html>