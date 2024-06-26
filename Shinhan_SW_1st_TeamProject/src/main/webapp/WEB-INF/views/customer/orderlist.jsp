<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" type="text/css"
	href="../resources/css/header_footer.css">
<meta charset="UTF-8">
<title>주문내역</title>
<style>
.inner {
	max-width: 1300px;
	margin: 0 auto;
}

body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #ffffff;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
}

.sidebar h2 {
	margin-top: 0;
}

.sidebar ul {
	list-style-type: none;
	padding: 0;
}

.sidebar ul li {
	margin-bottom: 10px;
}

.sidebar ul li a {
	text-decoration: none;
	color: #333;
	background-color: #fff;
	padding: 5px 10px;
	border-radius: 3px;
	display: block;
}

.sidebar ul li a:hover {
	background-color: #ddd;
}

.main-content {
	flex: 1;
	padding: 20px;
	background-color: white;
}

.main-content h2 {
	margin-top: 0;
}

section {
	margin-bottom: 20px;
	padding: 10px;
	background-color: #fff;
	border-radius: 5px;
	width: 1190px;
	margin: 0 auto;
}

section h3 {
	margin-top: 0;
}

footer {
	background-color: #333;
	color: #fff;
	text-align: center;
	padding: 10px 0;
}

.order-text {
	display: flex;
	justify-content: space-between;
}

.order {
	margin-bottom: 20px;
	padding: 10px;
	background-color: #fff;
	border-radius: 5px;
	width: 1190px;
	margin: 0 auto;
}

.order-group {
	display: flex;
	flex-direction: column;
}

.order-details {
	display: flex;
	align-items: center;
	margin-top: 20px;
	margin-bottom: 20px;
}

.order-date {
	margin-top: 10px;
}

.product-info {
	display: flex;
	flex-direction: column;
	margin-left: 20px;
}

.product-info img {
	max-width: 100px;
	max-height: 100px;
}

.product-info p {
	margin: 5px 0;
}

.order-text {
	display: flex;
	justify-content: space-between;
	width: calc(100% - 40px);
}

.order-status {
	margin-top: 10px;
	font-weight: bold;
}

.refund-button, .cancel-button {
	background-color: #555;
	color: #fff;
	border: none;
	border-radius: 3px;
	padding: 5px 10px;
	cursor: pointer;
}

.refund-button:hover, .cancel-button:hover {
	background-color: #666;
}

.divider {
	margin: 20px auto;
	width: 80%;
}

.total-section {
	text-align: center;
	margin: auto;
	max-width: 200px;
}

.total-amount, .accumulated-points {
	margin: 10px 0;
}

.total-amount span, .accumulated-points span {
	float: right;
}

.divider-between-orders, .divider-between-sections {
	width: 1190px;
	height: 0px;
	border: 3px solid #DFDFDF;
	margin: 20px auto;
}

.divider-between-sections {
	border: 1px solid #F0F0F0;
}

.divider-between-title-and-order {
	border-top: 3px solid #000000;
	margin-top: 20px;
	margin-bottom: 20px;
}

/* Refund Popup Styles */
.popup {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 1000;
	justify-content: center;
	align-items: center;
}

.popup-content {
	background-color: white;
	padding: 20px;
	text-align: center;
	max-width: 300px;
	width: 100%;
}

.popup-header {
	margin-bottom: 20px;
}

.popup-icon {
	font-size: 30px;
	font-weight: bold;
	color: black;
}

.popup-body {
	margin-bottom: 20px;
}

.popup-footer {
	display: flex;
	justify-content: space-around;
}

.popup-button {
	padding: 10px 20px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
}

#yes-button, #yes-cancel-button {
	background-color: #6200EA;
	color: white;
}

#no-button, #no-cancel-button {
	background-color: #FFFFFF;
	color: black;
	border: 1px solid #000000;
}

/* Refund Complete Popup Styles */
#refund-complete-popup, #cancel-complete-popup {
	display: none;
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 1000;
	justify-content: center;
	align-items: center;
}

.popup-content {
	background-color: white;
	padding: 20px;
	text-align: center;
	max-width: 300px;
	width: 100%;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		// Function to show the refund popup
		function showRefundPopup(orderId) {
			$('#refund-popup').css('display', 'flex');
			$('#refund-order-id').val(orderId); // Set the hidden input value
		}

		// Function to hide the refund popup
		function hideRefundPopup() {
			$('#refund-popup').hide();
		}

		// Function to show the refund complete popup
		function showRefundCompletePopup() {
			$('#refund-complete-popup').css('display', 'flex');
		}

		// Function to hide the refund complete popup
		function hideRefundCompletePopup() {
			$('#refund-complete-popup').hide();
		}

		// Function to show the cancel popup
		function showCancelPopup(orderId) {
			$('#cancel-popup').css('display', 'flex');
			$('#cancel-order-id').val(orderId); // Set the hidden input value
		}

		// Function to hide the cancel popup
		function hideCancelPopup() {
			$('#cancel-popup').hide();
		}

		// Function to show the cancel complete popup
		function showCancelCompletePopup() {
			$('#cancel-complete-popup').css('display', 'flex');
		}

		// Function to hide the cancel complete popup
		function hideCancelCompletePopup() {
			$('#cancel-complete-popup').hide();
		}

		// Add event listeners to refund buttons
		$('.refund-button').on('click', function() {
			var orderId = $(this).data('order-id');
			showRefundPopup(orderId);
		});

		// Submit the refund form via AJAX
		$('#yes-button').on('click', function() {
			var orderId = $('#refund-order-id').val();
			$.ajax({
				type: 'POST',
				url: 'refund.do',
				data: { orderId: orderId },
				success: function(response) {
					if (response === 'success') {
						hideRefundPopup();
						showRefundCompletePopup();
					}
				}
			});
		});

		$('#no-button').on('click', hideRefundPopup);

		$('#refund-complete-popup .popup-button').on('click', hideRefundCompletePopup);

		// Add event listeners to cancel buttons
		$('.cancel-button').on('click', function() {
			var orderId = $(this).data('order-id');
			showCancelPopup(orderId);
		});

		// Submit the cancel form via AJAX
		$('#yes-cancel-button').on('click', function() {
			var orderId = $('#cancel-order-id').val();
			$.ajax({
				type: 'POST',
				url: 'cancel.do',
				data: { orderId: orderId },
				success: function(response) {
					if (response === 'success') {
						hideCancelPopup();
						showCancelCompletePopup();
					}
				}
			});
		});

		$('#no-cancel-button').on('click', hideCancelPopup);

		$('#cancel-complete-popup .popup-button').on('click', hideCancelCompletePopup);
	});
</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<!-- Container Section -->
	<div class="container">
		<!-- Main Content Section -->
		<main class="main-content inner">
			<h2>주문 내역</h2>

			<div class="divider-between-title-and-order"></div>

			<c:forEach var="order" items="${allOrders}">
				<section class="order">
					<div class="order-group">
						<div class="order-text">
							<p class="order-date">
								주문일: ${order.order_date}
								<c:choose>
									<c:when test="${order.order_state == 'pay_pending' || order.order_state == 'pay_completed' || order.order_state == 'deliever_prep'}">
										<button class="cancel-button" data-order-id="${order.order_id}">취소신청</button>
									</c:when>
									<c:when test="${order.order_state == 'delievering' || order.order_state == 'delievered' }">
										<button class="refund-button" data-order-id="${order.order_id}">환불신청</button>
									</c:when>
								</c:choose>
							</p>
							<span class="order-status"> <c:choose>
									<c:when test="${order.order_state == 'pay_pending'}">결제 대기</c:when>
									<c:when test="${order.order_state == 'pay_completed'}">결제 완료</c:when>
									<c:when test="${order.order_state == 'deliever_prep'}">배송 준비중</c:when>
									<c:when test="${order.order_state == 'delievering'}">배송중</c:when>
									<c:when test="${order.order_state == 'delievered'}">배송 완료</c:when>
									<c:when test="${order.order_state == 'ref_requested'}">환불 신청</c:when>
									<c:when test="${order.order_state == 'refunded'}">환불 완료</c:when> 
									<c:otherwise>알 수 없음</c:otherwise>
								</c:choose>
							</span>
						</div>
						
						<c:set var="detail" value="${orderDetailsMap[order.order_id]}" />

						<div class="order-details">
							<img src="${detail.IMG_URL}" alt="상품 이미지">
							<div class="product-info">
								<h3>${detail.PROD_NAME}</h3>
								<p>${detail.BRAND}</p>
								<p>
									<c:forEach items="${optionList}" var="option">
										<c:if test="${detail.OPT_ID1 == option.opt_id}">
											${option.opt_value}
										</c:if>
									</c:forEach>
									/
									<c:forEach items="${optionList}" var="option">
										<c:if test="${detail.OPT_ID2 == option.opt_id}">
											${option.opt_value}
										</c:if>
									</c:forEach>
									/
									<c:forEach items="${optionList}" var="option">
										<c:if test="${detail.OPT_ID3 == option.opt_id}">
											${option.opt_value}
										</c:if>
									</c:forEach>
								</p> 
								<p>${detail.ORDER_PRODUCT_PRICE}원</p>
							</div>
						</div>

					</div>
				</section>

				<div class="divider-between-sections"></div>

				<section class="order-price">
					<div class="total-section">
						<p class="total-amount">
							총 주문금액: <span>${order.total_price}원</span>
						</p>
					</div>
				</section>

				<div class="divider-between-orders"></div>
			</c:forEach>

			<!-- 전체주문환불신청 알림 -->
			<div id="refund-popup" class="popup">
				<div class="popup-content">
					<div class="popup-header">
						<span class="popup-icon">!</span>
					</div>
					<div class="popup-body">
						<p>환불 신청하시겠습니까?</p>
					</div>
					<div class="popup-footer">
						<form id="refund-form" method="post" action="refund.do">
							<input type="hidden" id="refund-order-id" name="orderId" value="">
							<button type="button" class="popup-button" id="yes-button">예</button>
							<button type="button" class="popup-button" id="no-button">아니오</button>
						</form>
					</div>
				</div>
			</div>

			<!-- 환불 완료 알림 -->
			<div id="refund-complete-popup" class="popup">
				<div class="popup-content">
					<div class="popup-header">
						<span class="popup-icon">!</span>
					</div>
					<div class="popup-body">
						<p>환불이 완료되었습니다.</p>
					</div>
					<div class="popup-footer">
						<button class="popup-button" id="close-refund-complete-popup">닫기</button>
					</div>
				</div>
			</div>

			<!-- 전체주문취소신청 알림 -->
			<div id="cancel-popup" class="popup">
				<div class="popup-content">
					<div class="popup-header">
						<span class="popup-icon">!</span>
					</div>
					<div class="popup-body">
						<p>취소 신청하시겠습니까?</p>
					</div>
					<div class="popup-footer">
						<form id="cancel-form" method="post" action="cancel.do">
							<input type="hidden" id="cancel-order-id" name="orderId" value="">
							<button type="button" class="popup-button" id="yes-cancel-button">예</button>
							<button type="button" class="popup-button" id="no-cancel-button">아니오</button>
						</form>
					</div>
				</div>
			</div>

			<!-- 취소 완료 알림 -->
			<div id="cancel-complete-popup" class="popup">
				<div class="popup-content">
					<div class="popup-header">
						<span class="popup-icon">!</span>
					</div>
					<div class="popup-body">
						<p>취소가 완료되었습니다.</p>
					</div>
					<div class="popup-footer">
						<button class="popup-button" id="close-cancel-complete-popup">닫기</button>
					</div>
				</div>
			</div>

			<!-- 개별주문환불신청 알림 -->
			<div id="single-item-refund-popup" class="popup">
				<div class="popup-content">
					<div class="popup-header">
						<span class="popup-icon">!</span>
					</div>
					<div class="popup-body">
						<p>환불 신청하시겠습니까?</p>
					</div>
					<div class="popup-footer">
						<button class="popup-button" id="single-item-refund-yes-button">예</button>
						<button class="popup-button" id="single-item-refund-no-button">아니오</button>
					</div>
				</div>
			</div>

			<!-- 개별주문교환신청 알림 -->
			<div id="single-item-exchange-popup" class="popup">
				<div class="popup-content">
					<div class="popup-header">
						<span class="popup-icon">!</span>
					</div>
					<div class="popup-body">
						<p>교환 신청하시겠습니까?</p>
					</div>
					<div class="popup-footer">
						<button class="popup-button" id="single-item-exchange-yes-button">예</button>
						<button class="popup-button" id="single-item-exchange-no-button">아니오</button>
					</div>
				</div>
			</div>
		</main>
		<%@ include file="../common/footer.jsp"%>
	</div>

</body>

</html>
