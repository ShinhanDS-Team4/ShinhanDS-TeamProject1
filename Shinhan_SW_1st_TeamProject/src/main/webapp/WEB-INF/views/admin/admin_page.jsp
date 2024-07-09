<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<title>관리자 페이지</title>

<script>
	document.addEventListener('DOMContentLoaded', function() {
	    var ctxVisitors = document.getElementById('visitorsChart').getContext('2d');
		 // 현재 연도와 월을 가져오기
	    var now = new Date();
	    var year = now.getFullYear();
	    var month = now.getMonth() + 1; // 월은 0부터 시작하므로 +1

	    // 마지막 날 구하기
	    var last_day = new Date(year, month, 0).getDate();
	    //var last_day = new Date(2024, 11, 0).getDate(); // 11월을 설정하면 12월의 마지막 날을 얻을 수 있습니다.
	    
	    var labels = [];
	    for (let i = 1; i <= last_day; i++) {
	        labels.push(i);
	    }
		
	    // 현재 날짜를 "YYYY-MM" 형식으로 가져오기
    	var currentDate = new Date().toISOString().slice(0, 7);
    
    	// 해당 요소 선택
    	var monthlyVisitorsTitle = document.getElementById("monthlyVisitors");
    	var monthlyRevenueTitle = document.getElementById("monthlyRevenue");
    
    	// 제목 업데이트
    	monthlyVisitorsTitle.textContent = "월간 접속자 수 (" + currentDate + ")";
    	monthlyRevenueTitle.textContent = "월간 매출액 (" + currentDate + ")";
    	
		var yymm = new Date().toISOString().slice(0,8);
	    
	    var dailyVisitorDataForSellers = [];
	    <c:forEach items="${dailyVisitorDataSeller}" var="dailyVisitorSeller">
	    	dailyVisitorDataForSellers.push({ DAY: yymm+${dailyVisitorSeller.DAY}, VISITOR_COUNT: ${dailyVisitorSeller.DAYCOUNT} });
	    </c:forEach>

	    var dailyVisitorDataForCustomers = [];
	    <c:forEach items="${dailyVisitorDataCustomer}" var="dailyVisitorCustomer">
	    	dailyVisitorDataForCustomers.push({ DAY: yymm+${dailyVisitorCustomer.DAY}, VISITOR_COUNT: ${dailyVisitorCustomer.DAYCOUNT} });
	    </c:forEach>
	    
	    console.log(dailyVisitorDataForSellers);
	    console.log(dailyVisitorDataForCustomers);
	
	    var dailyRevenueData = [150, 200, 250, 300, 350, 400, 450];
	
	    function getVisitorCounts(data) {
	        var counts = Array(last_day).fill(0);
	        data.forEach(function(item) {
	            var day = parseInt(item.DAY.split('-')[2], 10);
	            counts[day - 1] = item.VISITOR_COUNT;
	        });
	        return counts;
	    }
	
	    var visitorsChart = new Chart(ctxVisitors, {
	        type: 'line',
	        data: {
	            labels: labels,
	            datasets: [{
	                label: 'Visitors (Sellers)',
	                backgroundColor: 'rgba(75, 192, 192, 0.2)',
	                borderColor: 'rgba(75, 192, 192, 1)',
	                data: getVisitorCounts(dailyVisitorDataForSellers)
	            }, {
	                label: 'Visitors (Customers)',
	                backgroundColor: 'rgba(153, 102, 255, 0.2)',
	                borderColor: 'rgba(153, 102, 255, 1)',
	                data: getVisitorCounts(dailyVisitorDataForCustomers)
	            }]
	        },
	        options: {}
	    });
		    	    	    
	    
	    	   
	    
	    var ctxDailyRevenue = document.getElementById('dailyRevenueChart').getContext('2d');

	    var dailyRevenueChartTotalData = [];
	    <c:forEach items="${dailyRevenueChart}" var="dailyRevenue">
	        dailyRevenueChartTotalData.push({ DAY: yymm + ${dailyRevenue.DAY}, TOTAL: ${dailyRevenue.TOTAL} });
	    </c:forEach>

	    console.log(dailyRevenueChartTotalData);

	    var dailyRevenueChart = new Chart(ctxDailyRevenue, {
	        type: 'bar',
	        data: {
	            labels: labels,
	            datasets: [{
	                label: 'Daily Revenue (total)',
	                backgroundColor: 'rgba(75, 192, 192, 0.2)',
	                borderColor: 'rgba(75, 192, 192, 1)',
	                data: calculateDailyRevenueTotal(dailyRevenueChartTotalData)
	            }]
	        },
	        options: {}
	    });

	    function calculateDailyRevenueTotal(data) {
	        var counts = Array(last_day).fill(0);
	        data.forEach(function(item) {
	            var day = parseInt(item.DAY.split('-')[2], 10);
	            counts[day - 1] = item.TOTAL;
	        });
	        return counts;
	    }
	});
		
	</script>
</head>
<body>
	<jsp:include page="common.jsp" />
	<div class="content">
		<div class="container-fluid">
			<div class="row">
				<div class="col-lg-4 col-md-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">총 가입 판매자 수</h5>
							<h6 class="card-subtitle mb-2 text-muted">${seller_total}명</h6>
							<p class="card-text">${seller_monthly_increaseRate}increase</p>
							<p class="card-text">${seller_monthly_increase_rate}%
								increase</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">총 가입 고객 수</h5>
							<h6 class="card-subtitle mb-2 text-muted">${customer_total}명</h6>
							<p class="card-text">${customer_monthly_increaseRate}
								increase</p>
							<p class="card-text">${customer_monthly_increase_rate}%
								increase</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">총 수익금액</h5>
							<h6 class="card-subtitle mb-2 text-muted">${total_money_amount}원</h6>
							<p class="card-text">${total_money_amount_increase_rate}%
								increase</p>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-6 col-md-12">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title" id="monthlyVisitors"></h5>
							<div class="chart-container">
								<canvas id="visitorsChart"></canvas>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-md-12">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title" id="monthlyRevenue"></h5>
							<div class="chart-container">
								<canvas id="dailyRevenueChart"></canvas>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="table-container">
				<h5 class="mb-4">판매자 목록</h5>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>판매자 아이디</th>
							<th>판매자 명</th>
							<th>이메일</th>
							<th>H.P</th>
							<th>Brand</th>
							<th>생년월일</th>
							<th>마지막 접속일</th>
							<th>성별</th>
							<th>생성 날짜</th>
							<th colspan="2">상세보기 / 삭제</th>
						</tr>
					</thead>
					<tbody>
						<!-- 최대 5명의 판매자 정보 출력-->
						<c:forEach var="seller" items="${sellers}" varStatus="status">
							<c:if test="${status.count <= 5}">
								<tr>
									<td><a
										href="search_seller_product_brand?member_id=${seller.member_id}">${seller.member_id}</a></td>
									<td>${seller.member_name}</td>
									<td>${seller.email}</td>
									<td>${seller.phone}</td>
									<td>${seller.brand}</td>
									<td>${seller.birth_date}</td>
									<td>${seller.last_access}</td>
									<td>${seller.gender}</td>
									<td>${seller.create_date}</td>
									<td colspan="2">
										<button class="btn btn-sm"
											onclick="location.href='admin_seller_info?member_id=${seller.member_id}'">상세
											보기</button>
										<button class="btn btn-sm"
											onclick="location.href='admin_seller_delete?returnUrl=adminPage&member_id=${seller.member_id}'">삭제</button>
									</td>
								</tr>
							</c:if>
						</c:forEach>
						<c:if test="${empty sellers}">
							<tr>
								<td colspan="11" class="text-center">판매자 정보가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>

			<div class="card">
				<div class="card-body">
					<h5 class="card-title">세이렌 인기상품 TOP 10</h5>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>순위</th>
								<th>판매량</th>
								<th>상품사진</th>
								<th>상품명</th>
								<th>상품 설명</th>
								<th>가격</th>
								<th>옵션</th>
								<th>재고</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="previousSales" value="-1" />
							<c:set var="rank" value="0" />
							<c:set var="displayRank" value="0" />
							<c:forEach var="topproduct" items="${topProducts}"
								varStatus="status">
								<c:choose>
									<c:when test="${topproduct.TOTAL_SALES != previousSales}">
										<c:set var="displayRank" value="${rank + 1}" />
									</c:when>
								</c:choose>
								<tr>
									<td>${displayRank}</td>
									<!-- 동적인 순위 표시 -->
									<td>${topproduct.TOTAL_SALES}</td>
									<td><a href="admin_seller_prod?id=${topproduct.MEMBER_ID}">
											<img src="${topproduct.IMG_ID}" alt="${topproduct.PROD_NAME}"
											style="width: 50px;">
									</a></td>
									<td><a href="admin_seller_prod?id=${topproduct.MEMBER_ID}">${topproduct.PROD_NAME}</a>
									</td>
									<td>${topproduct.PROD_DESC}</td>
									<td>${topproduct.PROD_PRICE}</td>
									<td>${topproduct.OPT_VALUE}</td>
									<td>${topproduct.STOCK}</td>
									<td>${fn:substring(topproduct.PROD_ADDED_DATE, 0, 10)}</td>
								</tr>
								<c:set var="rank" value="${displayRank}" />
								<c:set var="previousSales" value="${topproduct.TOTAL_SALES}" />
							</c:forEach>
							<c:if test="${empty topProducts}">
								<tr>
									<td colspan="8" class="text-center">판매량 데이터가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
				</div>
			</div>

		</div>
	</div>
</body>
</html>