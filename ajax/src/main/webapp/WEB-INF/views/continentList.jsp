<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>continentList</title>
</head>
<body>
	<form id="form1" action="/continentList" method="get">
	
		<!--  대륙 선택 -->
		<select id="continent" name="continent">
			<option value="">:::대륙선택:::</option>
			<c:forEach var="continent" items="${continentList}">
				<c:choose>
					<c:when test="${continent.continentNo == param.continent}">
						<option value="${continent.continentNo}" selected>
							${continent.continentName}
						</option>
					</c:when>
					<c:otherwise>
						<option value="${continent.continentNo}">
							${continent.continentName}
						</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
		
		<!--  나라 선택 -->
		<select id="country" name="country">
			<option value="">:::나라선택:::</option>
			<c:forEach var="country" items="${countryList}">
				<c:choose>
					<c:when test="${country.countryNo == param.country}">
						<option value="${country.countryNo}" selected>
							${country.countryName}
						</option>
					</c:when>
					<c:otherwise>
						<option value="${country.countryNo}">
							${country.countryName}
						</option>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</select>
		
		<!--  도시 선택 -->
		<select id="city" name="city">
			<option value="">:::도시선택:::</option>
			<c:forEach var="city" items="${cityList}">
				<option value="${city.cityNo}">
					${city.cityName}
				</option>
			</c:forEach>
		</select>
	</form>
	
	<script>
		document.querySelector('#continent').addEventListener('change', function() {
			if(this.value == '') {
				alert('대륙을 선택하세요.');
				return;
			}
			
			document.querySelector('#form1').submit();
		});
		
		document.querySelector('#country').addEventListener('change', function() {
			if(this.value == '') {
				alert('나라를 선택하세요.');
				return;
			}
			
			document.querySelector('#form1').submit();
		});
	</script>
</body>
</html>