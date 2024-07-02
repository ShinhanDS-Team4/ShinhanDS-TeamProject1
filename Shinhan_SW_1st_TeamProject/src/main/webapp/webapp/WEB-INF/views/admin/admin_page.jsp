<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<style>
body {
	font-family: Arial, sans-serif;
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

.sidebar a:hover {
	background-color: #495057;
}

.content {
	margin-left: 250px;
	padding: 20px;
}

.card {
	margin-bottom: 20px;
}

.chart-container {
	position: relative;
	height: 200px;
}

.table-container {
	margin-top: 20px;
}

.btn {
	background-color: #007bff;
	color: white;
}

.search-container {
	display: flex;
	justify-content: flex-end;
	margin-bottom: 20px;
}

.search-box {
	max-width: 300px;
	width: 100%;
}
</style>
</head>
<body>

	<div class="sidebar">
		<h2 class="text-center">
			<a href="adminpage">NiceAdmin</a>
		</h2>
		<a href="adminpage">Dashboard</a> <a href="admin_seller_list">판매자
			목록</a> <a href="admin_seller_register">판매자 등록</a> <a
			href="admin_seller_detail">판매자 상세</a> <a href="admin_faq">F.A.Q</a>
	</div>

	<div class="content">
		<div class="container-fluid">
			<div class="search-container">
				<form action="search_results.jsp" method="get">
					<div class="input-group">
						<input type="text" class="form-control search-box" name="query"
							placeholder="판매자 또는 고객 검색">
						<div class="input-group-append">
							<button class="btn btn-primary" type="submit"
								onclick=location.href='admin_seller_list'>검색</button>
						</div>
					</div>
				</form>
			</div>
			<div class="row">
				<div class="col-lg-4 col-md-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">총 가입 판매자 수</h5>
							<h6 class="card-subtitle mb-2 text-muted">$(seler_total)명</h6>
							<!-- 회원가입한 판매자 수 -->
							<p class="card-text">8% increase</p>
							<!-- 한달 기준으로 회원가입한 판매자 증가 치 -->
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">총 가입 고객 수</h5>
							<h6 class="card-subtitle mb-2 text-muted">$(customer_total)명</h6>
							<!-- 회원가입한 고객 수 -->
							<p class="card-text">8% increase</p>
							<!-- 한달 기준으로 회원가입한 고객 증가 치 -->
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">총 수익금액</h5>
							<h6 class="card-subtitle mb-2 text-muted">$$(money_total)원</h6>
							<!-- 쇼핑몰에서 주문한 총 금액-->
							<p class="card-text">12% decrease</p>
							<!-- 한달 기준으로 총 주문 금액 증가 치-->
						</div>
					</div>
				</div>
			</div>

			<div class="card">
				<div class="card-body">
					<h5 class="card-title">월간 접속자 수</h5>
					<!-- 연간, 월간, 주간, 일간을 선택하여 접속한 고객 수를 확인-->
					<div class="chart-container">
						<canvas id="visitorsChart"></canvas>
					</div>
				</div>
			</div>

			<div class="table-container">
				<h5 class="mb-4">판매자 목록</h5>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>판매자명</th>
							<th>Price</th>
							<th>Brand</th>
							<th>Status</th>
							<th>Start Date</th>
							<th>수정 / 삭제</th>
						</tr>
					</thead>
					<tbody>
						<!-- 판매자 정보 출력-->
						<tr>
							<td><a href="admin_seller_detail" />Unity Pugh</td>
							<td>9958</td>
							<td>Curicó</td>
							<td>access</td>
							<td>2009/01/17</td>
							<td>
								<button class="btn btn-sm" onclick=location.href='admin_seller_update.html'>수정</button>
								<button class="btn btn-sm" onclick=location.href='#'>삭제</button>
							</td>
						</tr>
					</tbody>
				</table>
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
							<tr>
								<td><img src="product1.jpg" alt="Product 1"
									style="width: 50px;"></td>
								<!-- 제품 이미지-->
								<td>Ut inventore ipsa voluptas nulla</td>
								<!-- 제품명 -->
								<td>$64</td>
								<!-- 제품 가격 -->
								<td>124</td>
								<!-- 주문량 -->
								<td>$5,828</td>
								<!-- 총 판매 가격-->
							</tr>
						</tbody>
					</table>
				</div>
			</div>

		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script>
        var ctx = document.getElementById('visitorsChart').getContext('2d');
        var visitorsChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: ['00:00', '01:00', '02:00', '03:00', '04:00', '05:00', '06:00'],
                datasets: [{
                    label: 'Sales',
                    backgroundColor: 'rgba(255, 99, 132, 0.2)',
                    borderColor: 'rgba(255, 99, 132, 1)',
                    data: [12, 19, 3, 5, 2, 3, 7]
                }, {
                    label: 'Revenue',
                    backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    data: [2, 3, 20, 5, 1, 4, 10]
                }, {
                    label: 'Customers',
                    backgroundColor: 'rgba(75, 192, 192, 0.2)',
                    borderColor: 'rgba(75, 192, 192, 1)',
                    data: [3, 10, 13, 15, 22, 30, 45]
                }]
            },
            options: {}
        });
    </script>
</body>
</html>
