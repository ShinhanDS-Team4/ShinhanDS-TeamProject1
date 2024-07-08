<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> <!-- fmt 태그 라이브러리 추가 -->
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" type="text/css" href="${path}/resources/css/header_footer.css">
<link rel="stylesheet" type="text/css" href="${path}/resources/css/orderlist.css">
<meta charset="UTF-8">
<title>주문내역</title>
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
        $('#yes-refund-button').on('click', function() {
            var orderId = $('#refund-order-id').val();

            $.ajax({
                type: 'POST',
                url: 'refund.do',
                data: { orderId: orderId },
                success: function(response) {
                    if (response === 'success') {
                        hideRefundPopup();
                        showRefundCompletePopup();
                        location.reload();
                    }
                },
                error: function(error) {
                    alert("Error: " + error);
                }
            });
        });

        $('#no-refund-button').on('click', hideRefundPopup);

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
                data: { 
                    orderId: orderId 
                },
                success: function(response) {
                    if (response === 'success') {
                        hideCancelPopup();
                        showCancelCompletePopup();
                        location.reload();
                    }
                },
                error: function(error) {
                    alert("Error: " + error);
                }
            });
        });

        $('#no-cancel-button').on('click', hideCancelPopup);

        $('#cancel-complete-popup .popup-button').on('click', hideCancelCompletePopup);

        /*
        $('.review-button').on('click', function() {
            var orderDetailId = $(this).data('orderdetail-id');
            /* window.location.href = 'http://localhost:9090/shoppingmall/review/write.do?orderDetailId=' + orderDetailId; */
            /* window.location.href = 'http://localhost:9090/shoppingmall/review/write.do;  */
        }); 
        */
    });
</script>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

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
								<fmt:formatDate value="${order.order_date}" pattern="yyyy.MM.dd" />
							</p>
						</div>

						<c:set var="details" value="${orderDetailsMap[order.order_id]}" />

						<div class="order-details">
							<c:forEach var="detail" items="${details}">

								<div class="product-detail">
									<div class="product-detail-box">
										<%-- <img src="${detail.img_id}" alt="상품 이미지"> --%>
										<img src="http://localhost:9090/saren/ProdImgFile/main/${detail.img_id}.png" alt="상품 이미지">
										<div class="product-info">
											<p>${detail.brand}</p>
											<h3>${detail.prod_name}</h3>
											<p>
												옵션:
												<!-- 빈 문자열 생성 -->
												<c:set var="options" value="" />

												<!-- optionList를 순회하며 조건 검사 및 옵션 추가 -->
												<c:forEach items="${optionList}" var="option">
													<c:if
														test="${detail.opt_id1 == option.opt_id && detail.prod_id == option.prod_id}">
														<c:set var="options"
															value="${options}${options == '' ? '' : '/'}${option.opt_value}" />
													</c:if>
													<c:if
														test="${detail.opt_id2 == option.opt_id && detail.prod_id == option.prod_id}">
														<c:set var="options"
															value="${options}${options == '' ? '' : '/'}${option.opt_value}" />
													</c:if>
													<c:if
														test="${detail.opt_id3 == option.opt_id && detail.prod_id == option.prod_id}">
														<c:set var="options"
															value="${options}${options == '' ? '' : '/'}${option.opt_value}" />
													</c:if>
													<c:if
														test="${detail.opt_id4 == option.opt_id && detail.prod_id == option.prod_id}">
														<c:set var="options"
															value="${options}${options == '' ? '' : '/'}${option.opt_value}" />
													</c:if>
													<c:if
														test="${detail.opt_id5 == option.opt_id && detail.prod_id == option.prod_id}">
														<c:set var="options"
															value="${options}${options == '' ? '' : '/'}${option.opt_value}" />
													</c:if>
												</c:forEach>

												<!-- 옵션 출력 -->
												${options}

											</p>
											<p>${detail.order_product_price}원</p>
											<p>수량: ${detail.order_num}개</p>
										</div>
									</div>
									<span class="order-status"> <c:choose>
											<c:when test="${detail.order_state == 'pay_pending'}">문의 필요</c:when>
											<c:when test="${detail.order_state == 'pay_completed'}">결제 완료</c:when>
											<c:when test="${detail.order_state == 'cancelled'}">취소 완료</c:when>
											<c:when test="${detail.order_state == 'deliver_prep'}">배송 준비중</c:when>
											<c:when test="${detail.order_state == 'delivering'}">배송중</c:when>
											<c:when test="${detail.order_state == 'delivered'}">
                                                배송 완료
                                                <a
													href="${path}/review/write.do">
													<button class="review-button"
														data-orderdetail-id="${detail.orderdetail_id}">리뷰작성</button>
												</a>
											</c:when>
											<c:when test="${detail.order_state == 'ref_requested'}">환불 신청</c:when>
											<c:when test="${detail.order_state == 'refunded'}">환불 완료</c:when>
											<c:otherwise>알 수 없음</c:otherwise>
										</c:choose>
									</span>
								</div>
							</c:forEach>
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
							<button type="button" class="popup-button" id="yes-refund-button">예</button>
							<button type="button" class="popup-button" id="no-refund-button">아니오</button>
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
