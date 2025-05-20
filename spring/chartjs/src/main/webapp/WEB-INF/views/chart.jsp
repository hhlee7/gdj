<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chart</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>
</head>
<body>
	<h1>Chart.js 라이브러리 실습</h1>
	
	<div>
		<h1>1) 나라별 평균 나이</h1>
		<canvas id="chart1" style="width:100%;max-width:600px"></canvas>
	</div>
	
	<div>
		<h1>2) 성별 가입자 수</h1>
		<canvas id="chart2" style="width:100%;max-width:600px"></canvas>
	</div>
	
	<div>
		<h1>3) 년도별 나라별 가입자 수</h1>
		<canvas id="chart3" style="width:100%;max-width:600px"></canvas>
	</div>
	
	<div>
		<h1>4) 년도별 누적 가입자 수</h1>
		<canvas id="chart4" style="width:100%;max-width:600px"></canvas>
	</div>
	
	<script>
		// chart1
		$.ajax({
			url : '/rest/avgAgeByCountry',
			type : 'post',
			success : function(data) {
				// console.log(data);
				// chart1에 bar chart를 출력 start
				// chart.js가 bar chart에 요구하는 모델
				const xValues = []; // 나라
				const yValues = []; // 평균 나이
				const barColors = [ "green", "blue", "orange", "brown" ];

				$(data).each(function(i, e) {
					xValues.push(e.country);
					yValues.push(e.age);
				});

				/*
				 $(data).each(function(i, e) {
				    console.log(e);
				    xValues[i] = e.country;
				    yValues[i] = e.age;
				 });
				 */
				// console.log(xValues);
				// console.log(yValues);
				new Chart("chart1", {
					type : "bar",
					data : {
						labels : xValues,
						datasets : [ {
							backgroundColor : barColors,
							data : yValues
						} ]
					},
					options : {
						legend : {
							display : false
						},
						scales : {
							yAxes : [ {
								ticks : {
									beginAtZero : true
								}
							} ]
						},

						title : {
							display : true,
							text : "나라별 평균 나이"
						}
					}
				});
				// chart1에 bar chart를 출력 end
			}
		});

		// chart2
		$.ajax({
			url : '/rest/countByGender',
			type : 'post',
			success : function(data) {
				// console.log(data);
				// start chart2
				const xValues = [];
				const yValues = [];
				const barColors = ["#b91d47", "#00aba9"];

				$(data).each(function(i, e) {
					xValues.push(e.gender);
					yValues.push(e.count);
				});
				// console.log(xValues);
				// console.log(yValues);

				new Chart("chart2", {
					type : "pie",
					data : {
						labels : xValues,
						datasets : [ {
							backgroundColor : barColors,
							data : yValues
						} ]
					},
					options : {
						title : {
							display : true,
							text : "성별 가입자 수"
						}
					}
				});
				// end chart2
			}
		});

		// chart3
		$.ajax({
			url : '/rest/countByYearAndCountry',
			type : 'post',
			success : function(data) {
				// console.log(data);

				// start chart3
				const xValues = []; // 년도
				const d0 = []; // 독일
				const d1 = []; // 미국
				const d2 = []; // 한국
				const d3 = []; // 호주

				$(data).each(function(i, e) {
					if (i % 4 == 0) {
						xValues.push(e.year);
						d0.push(e.count);
					} else if (i % 4 == 1) {
						d1.push(e.count);
					} else if (i % 4 == 2) {
						d2.push(e.count);
					} else if (i % 4 == 3) {
						d3.push(e.count);
					}
				});

				/*
				console.log(xValues);
				console.log(d0);
				console.log(d1);
				console.log(d2);
				console.log(d3);
				 */

				new Chart("chart3", {
					type : "line",
					data : {
						labels : xValues,
						datasets : [ {
							label : '독일',
							data : d0,
							borderColor : "red",
							fill : false
						}, {
							label : '미국',
							data : d1,
							borderColor : "green",
							fill : false
						}, {
							label : '한국',
							data : d2,
							borderColor : "blue",
							fill : false
						}, {
							label : '호주',
							data : d3,
							borderColor : "yellow",
							fill : false
						} ]
					},
					options : {
						legend : {
							display : true
						}
					}
				});
				// end chart3
			}
		});
		
		// chart4
		$.ajax({
			url : '/rest/totalCountByYear',
			type : 'post',
			success : function(data) {
				// console.log(data);
				// start chart4
				const xValues = [];
				const yValues = [];

				$(data).each(function(i, e) {
					xValues.push(e.year);
					yValues.push(e.sumCount);
				});

				// console.log(xValues);
				// console.log(yValues);

				new Chart("chart4", {
					type : "line",
					data : {
						labels : xValues,
						datasets : [ {
							label : '누적 가입자 수',
							fill : false,
							pointRadius : 1,
							borderColor : "rgba(255,0,0,0.5)",
							data : yValues
						} ]
					},
					options : {
						legend : {
							display : true
						},
						title : {
							display : false,
							text : "년도별 누적 가입자 수",
							fontSize : 16
						}
					}
				});
				// end chart4
			}
		});
	</script>
</body>
</html>