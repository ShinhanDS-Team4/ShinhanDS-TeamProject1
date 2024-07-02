<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객 주문 내역</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
	<jsp:include page="common.jsp" />
	<div class="content">
		<div class="container-fluid">
			<h1>고객 주문 내역</h1>
			<div class="mb-3">
				<input type="text" id="searchInput" class="form-control"
					placeholder="고객 ID 검색">
			</div>
			<div class="table-responsive">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>주문 ID</th>
							<th>상품명</th>
							<th>수량</th>
							<th>가격</th>
							<th>주문 날짜</th>
							<th>상태</th>
						</tr>
					</thead>
					<tbody id="orderTableBody">
						<tr>
							<td colspan="6" class="text-center">주문 내역을 검색해주세요.</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script>
		$(document)
				.ready(
						function() {
							$('#searchInput')
									.on(
											'input',
											function() {
												var searchQuery = $(this).val();
												if (searchQuery.length > 0) {
													$
															.ajax({
																url : 'search_orders',
																method : 'GET',
																data : {
																	customer_id : searchQuery
																},
																success : function(
																		response) {
																	$(
																			'#orderTableBody')
																			.html(
																					response);
																},
																error : function() {
																	alert('검색에 실패했습니다.');
																}
															});
												} else {
													$('#orderTableBody')
															.html(
																	'<tr><td colspan="6" class="text-center">주문 내역을 검색해주세요.</td></tr>');
												}
											});
						});
	</script>
</body>
</html>
