<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<c:set var="path" value="${pageContext.servletContext.contextPath}" />
	<title>관리자 페이지</title>

<style>
@charset "UTF-8";
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f8f9fa; /* 통일된 배경색 */
}

.sidebar {
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    width: 250px;
    background-color: #343a40;
    color: #fff;
    padding-top: 20px;
}

.sidebar a {
    color: #fff;
    text-decoration: none;
    display: block;
    padding: 10px 20px;
}

.sidebar img {
    padding: 10px 20px;
    width: 100%; /* 원하는 너비 */
    height: auto; /* 높이는 비율에 맞게 자동 조절 */
    max-width: 100%; /* 최대 너비 설정 */
}

.sidebar a:hover {
    background-color: #495057;
}

.sidebar .dropdown-btn {
    color: white;
    padding: 10px 20px;
    text-decoration: none;
    display: block;
    background: none;
    border: none;
    outline: none;
    width: 100%;
    text-align: left;
    cursor: pointer;
    font-size: 16px;
    position: relative;
}

.sidebar .dropdown-container {
    display: none;
    background-color: #262626;
    padding-left: 8px;
}

.sidebar .dropdown-btn:hover + .dropdown-container,
.sidebar .dropdown-container:hover {
    display: block;
}

.header {
    width: calc(100% - 250px);
    margin-left: 250px;
    background-color: #f8f9fa;
    color: black;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header .search-container {
    display: flex;
    align-items: center;
}

.header .search-box {
    max-width: 300px;
    width: 100%;
    height: 38px; /* 검색창 높이를 줄임 */
    margin-right: 10px;
}

.header .account {
    position: relative;
}

.header .account-name {
    cursor: pointer;
    padding: 10px 20px;
    background-color: #f8f9fa;
    border: none;
    color: black;
    font-size: 16px;
}

.header .dropdown-account {
    display: none;
    position: absolute;
    right: 0;
    background-color: #f8f9fa;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.header .dropdown-account a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.header .dropdown-account a:hover {
    background-color: #ddd;
}

.header .account:hover .dropdown-account {
    display: block;
}

.content {
    margin-top: 60px;
    margin-left: 250px;
    padding: 20px;
    width: calc(100% - 250px);
    background-color: #f8f9fa;
}

.card {
    margin-bottom: 20px;
}

.chart-container {
    position: relative;
    height: 400px; /* 높이를 크게 설정 */
    width: 100%; /* 너비를 꽉 차게 설정 */
}

.table-container {
    margin-top: 20px;
}

.btn {
    background-color: #007bff;
    color: white;
    height: 38px; /* 검색 버튼 높이를 검색창과 맞춤 */
}

.card .card-title {
    font-size: 1.25rem;
    margin-bottom: 1rem;
}

.card .card-subtitle {
    font-size: 1rem;
    color: #6c757d;
}

.card .card-text {
    font-size: 0.875rem;
    color: #6c757d;
}

.no-data-message {
    text-align: center;
    color: #6c757d;
    margin-top: 20px;
}

.search-container {
	width: 50%;
}

.search-container form {
	width: 100%;
}

.input-group {
	width: 80%;
}

.form-control {
    display: inline-block;
    width: auto;
    vertical-align: middle;
}

.form-control-search-box {
    display: inline-block;
    width: auto;
    flex-grow: 1;
    vertical-align: middle;
}

.input-group .form-control {
    width: auto;
    flex: 0 1 auto;
}

.search-results-list {
    list-style-type: none; /* 목록 항목 앞에 기호를 없앰 */
    margin-top: 10px;
    padding-left: 0; /* 내부 패딩 제거 */
    max-height: 250px; /* 최대 높이 설정 */
    overflow-y: auto; /* 내용이 넘칠 경우 스크롤바 표시 */
    width: 100%; /* 전체 너비 */
}

.search-results-list li {
    padding: 8px;
    border-bottom: 1px solid #ccc; /* 각 항목을 구분짓는 선 */
}

.search-results-list li:hover {
    background-color: #f8f8f8; /* 마우스 오버 시 배경 색상 변경 */
}

</style>
<script>
document.addEventListener('DOMContentLoaded', function() {
    var ctxVisitors = document.getElementById('visitorsChart').getContext('2d');
    var last_day = new Date(2024, 11, 0).getDate(); // 11월을 설정하면 12월의 마지막 날을 얻을 수 있습니다.
    var labels = [];
    for (let i = 1; i <= last_day; i++) {
        labels.push(i);
    }

    var dailyVisitorDataForSellers = [
        { DAY: '2024-12-01', VISITOR_COUNT: 10 },
        { DAY: '2024-12-02', VISITOR_COUNT: 15 },
        { DAY: '2024-12-03', VISITOR_COUNT: 12 },
        { DAY: '2024-12-04', VISITOR_COUNT: 20 },
        { DAY: '2024-12-05', VISITOR_COUNT: 18 },
        { DAY: '2024-12-06', VISITOR_COUNT: 25 },
        { DAY: '2024-12-07', VISITOR_COUNT: 30 }
    ];

    var dailyVisitorDataForCustomers = [
        { DAY: '2024-12-01', VISITOR_COUNT: 5 },
        { DAY: '2024-12-02', VISITOR_COUNT: 8 },
        { DAY: '2024-12-03', VISITOR_COUNT: 7 },
        { DAY: '2024-12-04', VISITOR_COUNT: 10 },
        { DAY: '2024-12-05', VISITOR_COUNT: 12 },
        { DAY: '2024-12-06', VISITOR_COUNT: 15 },
        { DAY: '2024-12-07', VISITOR_COUNT: 20 }
    ];

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
    var dailyRevenueChart = new Chart(ctxDailyRevenue, {
        type: 'bar',
        data: {
            labels: labels,
            datasets: [{
                label: 'Daily Revenue',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                borderColor: 'rgba(75, 192, 192, 1)',
                data: dailyRevenueData
            }]
        },
        options: {}
    });
});
function f_search() {
    $.ajax({
        url: "search_results",
        data: {
            searchType: $("#searchType").val(),
            keyword: $("#keyword").val()
        },
        success: function(responsedata) {
            var resultsHtml = '';
            if (responsedata.length === 0) {
                resultsHtml = '<li>No results found.</li>';
            } else {
                responsedata.forEach(function(item) {
                    resultsHtml += '<li>' + item.member_name + ' (' + item.member_brand + ')</li>';
                });
            }
            $('#searchResults').html(resultsHtml);
        }
    });
}

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
							<p class="card-text">${seller_monthly_increaseRate} increase </p>
							<p class="card-text">${seller_monthly_increase_rate}% increase</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">총 가입 고객 수</h5>
							<h6 class="card-subtitle mb-2 text-muted">${customer_total}명</h6>
							<p class="card-text">${customer_monthly_increaseRate} increase </p>
							<p class="card-text">${customer_monthly_increase_rate}% increase</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">총 수익금액</h5>
							<h6 class="card-subtitle mb-2 text-muted">${total_money_amount}원</h6>
							<p class="card-text">${total_money_amount_increase_rate}% increase</p>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-6 col-md-12">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">월간 접속자 수</h5>
							<div class="chart-container">
								<canvas id="visitorsChart"></canvas>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-6 col-md-12">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">일일 수익</h5>
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
							<th>Brand</th>
							<!-- <th>Status</th> -->
							<th>Start Date</th>
							<th>수정 / 삭제</th>
						</tr>
					</thead>
					<tbody>
						<!-- 최대 5명의 판매자 정보 출력-->
						<c:forEach var="seller" items="${sellers}" varStatus="status">
							<c:if test="${status.count <= 5}">
								<tr>
									<td><a href="admin_seller_prod?member_id=${seller.member_id}">${seller.member_id}</a></td>
									<td>${seller.member_name}</td>									
									<td>${seller.brand}</td>
									<%-- <td>${seller_status}</td> --%>
									<td>${seller.create_date}</td>
									<td>
										<button class="btn btn-sm"
											onclick="location.href='admin_seller_info?member_id=${seller.member_id}'">수정</button>
										<button class="btn btn-sm"
											onclick="location.href='admin_seller_delete.jsp?id=${seller.member_id}'">삭제</button>
									</td>
								</tr>
							</c:if>
						</c:forEach>
						<c:if test="${empty sellers}">
							<tr>
								<td colspan="6" class="text-center">판매자 정보가 없습니다.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
				<div class="text-right">
					<a href="admin_seller_list" class="btn btn-primary">자세히 보기</a>
				</div>
			</div>
			<div class="card">
				<div class="card-body">
					<h5 class="card-title">세이렌 판매량 TOP 10</h5>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Preview</th>
								<th>Product</th>
								<th>Price</th>
								<th>Sold</th>
								<th>Revenue</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="product" items="${topProducts}">
								<tr>
									<td><a href="admin_seller_detail?id=${product.sellerId}">
									<img src="${product.image}" alt="${product.name}" style="width: 50px;"></a></td>
									<td><a href="admin_seller_detail?id=${product.sellerId}">${product.name}</a></td>
									<td>${product.price}</td>
									<td>${product.sold}</td>
									<td>${product.revenue}</td>
								</tr>
							</c:forEach>
							<c:if test="${empty topProducts}">
								<tr>
									<td colspan="5" class="text-center">판매량 데이터가 없습니다.</td>
								</tr>
							</c:if>
						</tbody>
					</table>
					<div class="text-right">
						<a href="admin_seller_list" class="btn btn-primary">자세히 보기</a>
					</div>
				</div>
			</div>

		</div>
	</div>	
</body>
</html>
