<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자메인</title>
<!-- 본문 css -->
<link rel="stylesheet" href="${path}/resources/css/style.css">
<!-- 헤더,푸터 css -->
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<!-- jquery 연결 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- Slick 불러오기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<!-- Slick 직접 연결 -->
<link rel="stylesheet" href="${path}/resources/slick/slick-theme.css">
<link rel="stylesheet" href="${path}/resources/slick/slick.css">
<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/sellerMain.css" />
<script src="${path}/resources/slick/slick.min.js"></script>

</head>
<body>
	<script>
	$(function(){
		$("#toStatics").on("click",toStatics);//통계 대쉬보드
		$("#toPrdList").on("click",toPrdList);//판매/대여 상품목록
		$("#toDelivery").on("click",toDelivery);// 판매자 판매/배송 목록
		$("#toQ&AList").on("click",toQAList);// 판매자 문의목록	
	});
	
	function toStatics(){
		$.ajax({
			type:"get",
			url:"seller/Statics.do",
			success:function(responseData) {
				alert("toStatics");
				$("#section").html(responseData);
			},
			error : function(xhrmstatus, error) {
				alert(error);
			}
		});		
	}
	function toPrdList(){
		$.ajax({
			type:"post",
			url:"PrdList.do",
			success:function(responseData) {
				$("#section").html(responseData);
			},
			error : function(xhrmstatus, error) {
				alert(error);
			}
		});		
	}
	function toDelivery(){
		$.ajax({
			type:,
			url:,
			success:function(responseData) {
				$("#section").html(responseData);
			},
			error : function(xhrmstatus, error) {
				alert(error);
			}
		});		
	}
	function toQAList(){
		$.ajax({
			type:,
			url:,
			success:function(responseData) {
				$("#section").html(responseData);
			},
			error : function(xhrmstatus, error) {
				alert(error);
			}
		});		
	}
	</script>

	<%@ include file="../../common/header.jsp"%>
	<main>
		<aside>
			<ul>
				<li><a onclick="location.href='${path}/seller/MainPage.do'">통계</a></li>
				<li><a onclick="location.href='${path}/seller/PrdList.do'">판매/대여 상품 목록</a></li>
				<li><a onclick="location.href='${path}/seller/DeliveryList.do'">주문/배송</a></li>
				<li><a onclick="location.href='${path}/seller/Q&AList.do'">문의 목록</a></li>
			</ul>
		</aside>

		<section id="section">
			${path}
			<h2>마이페이지</h2>
			<hr />
			<div class="user-info">
				<p>김철수</p>
				<p>573-50-00882</p>
			</div>

			<div class="stats">
				<h3>통계</h3>
				<div id="chart_div"></div>
				<script type="text/javascript"
					src="https://www.gstatic.com/charts/loader.js"></script>
				<script type="text/javascript">
					google.charts.load("current", {
						packages : [ "corechart" ]
					});
					google.charts.setOnLoadCallback(drawChart);
					function drawChart() {
						var data = google.visualization.arrayToDataTable([
								[ "날짜", "결제건수" ], [ "2024-05-01", 1 ],
								[ "2024-05-02", 2 ], [ "2024-05-03", 1 ],
								[ "2024-05-04", 3 ], [ "2024-05-05", 1 ],
								[ "2024-05-06", 4 ], [ "2024-05-07", 2 ], ]);

						var options = {
							title : "결제건수",
							curveType : "function",
							legend : {
								position : "bottom"
							},
						};

						var chart = new google.visualization.LineChart(document
								.getElementById("chart_div"));

						chart.draw(data, options);
					}
				</script>
			</div>
		</section>
		<aside class="notifications">
			<div class="notify_icon">
				<img src="${path}/resources/images/bell.png" alt="알림"
					class="bell_icon" />
				<div class="icon">
					<span>15</span>
				</div>
				<div class="popup">
					<p>결제 완료 주문 : 5건</p>
					<p>결제 대기 주문 : 23건</p>
				</div>
			</div>
		</aside>
	</main>
	<script>
      document
        .querySelector(".notifications .bell_icon")
        .addEventListener("click", function () {
          document
            .querySelector(".notifications .popup")
            .classList.toggle("show");
        });
    </script>
	<style>
.notifications .popup.show {
	display: block;
}
</style>
</body>
</html>