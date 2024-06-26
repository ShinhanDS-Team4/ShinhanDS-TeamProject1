<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 페이지</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<link href="${path }/resources/css/admin/admin_page.css" rel="stylesheet">
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
							<p class="card-text">8% increase</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">총 가입 고객 수</h5>
							<h6 class="card-subtitle mb-2 text-muted">${customer_total}명</h6>
							<p class="card-text">8% increase</p>
						</div>
					</div>
				</div>
				<div class="col-lg-4 col-md-6">
					<div class="card">
						<div class="card-body">
							<h5 class="card-title">총 수익금액</h5>
							<h6 class="card-subtitle mb-2 text-muted">${money_total}원</h6>
							<p class="card-text">12% decrease</p>
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
									<td><a href="admin_seller_detail?id=${seller.member_id}">${seller.member_id}</a></td>
									<td>${seller.member_name}</td>									
									<td>${seller.member_brand}</td>
									<%-- <td>${seller_status}</td> --%>
									<td>${seller.member_seller_create_date}</td>
									<td>
										<button class="btn btn-sm"
											onclick="location.href='admin_seller_update.jsp?id=${seller.member_id}'">수정</button>
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
									<td><a
										href="admin_seller_detail?id=${product.sellerId}"><img
											src="${product.image}" alt="${product.name}"
											style="width: 50px;"></a></td>
									<td><a
										href="admin_seller_detail?id=${product.sellerId}">${product.name}</a></td>
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
				</div>
			</div>

		</div>
	</div>

	<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
	<script src="${path}/resources/css/admin/admin_page.js"></script>
</body>
</html>
