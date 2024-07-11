<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
        $(document).ready(function () {
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

            // Add event listeners to refund buttons
            $('.refund-button').on('click', function () {
                var orderId = $(this).data('order-id');
                showRefundPopup(orderId);
            });

            // Submit the refund form via AJAX
            $('#yes-refund-button').on('click', function () {
                var orderId = $('#refund-order-id').val();

                $.ajax({
                    type: 'POST',
                    url: 'refund.do',
                    data: { orderId: orderId },
                    success: function (response) {
                        if (response === 'success') {
                            hideRefundPopup();
                            showRefundCompletePopup();
                            setTimeout(function() {
                                location.reload();
                            }, 2000);  
                        }
                    },
                    error: function (error) {
                        alert("Error: " + error);
                    }
                });
            });

            $('#no-refund-button').on('click', hideRefundPopup);

            $('#refund-complete-popup .popup-button').on('click', hideRefundCompletePopup);
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
                                <fmt:formatDate value="${order.order_date}" pattern="yyyy.MM.dd" />
                            </p>
                        </div>

                        <c:set var="details" value="${orderDetailsMap[order.order_id]}" />

                        <div class="order-details">
                            <c:forEach var="detail" items="${details}">

                                <div class="product-detail">
                                    <div class="product-detail-box">
                                        <img src="http://localhost:9090/saren/ProdImgFile/main/${detail.img_id}.png" alt="상품 이미지">
                                        <div class="product-info">
                                            <p>${detail.brand}</p>
                                            <h3>${detail.prod_name}</h3>
                                            <p>
                                                옵션:
                                                <c:set var="options" value="" />
                                                <c:forEach items="${optionList}" var="option">
                                                    <c:if test="${detail.opt_id1 == option.opt_id && detail.prod_id == option.prod_id}">
                                                        <c:set var="options" value="${options}${options == '' ? '' : '/'}${option.opt_value}" />
                                                    </c:if>
                                                    <c:if test="${detail.opt_id2 == option.opt_id && detail.prod_id == option.prod_id}">
                                                        <c:set var="options" value="${options}${options == '' ? '' : '/'}${option.opt_value}" />
                                                    </c:if>
                                                    <c:if test="${detail.opt_id3 == option.opt_id && detail.prod_id == option.prod_id}">
                                                        <c:set var="options" value="${options}${options == '' ? '' : '/'}${option.opt_value}" />
                                                    </c:if>
                                                    <c:if test="${detail.opt_id4 == option.opt_id && detail.prod_id == option.prod_id}">
                                                        <c:set var="options" value="${options}${options == '' ? '' : '/'}${option.opt_value}" />
                                                    </c:if>
                                                    <c:if test="${detail.opt_id5 == option.opt_id && detail.prod_id == option.prod_id}">
                                                        <c:set var="options" value="${options}${options == '' ? '' : '/'}${option.opt_value}" />
                                                    </c:if>
                                                </c:forEach>
                                                ${options}
                                            </p>
                                            <p>${detail.order_product_price}원</p>
                                            <p>수량: ${detail.order_num}개</p>
                                        </div>
                                    </div>
                                    <span class="order-status">
                                        <c:choose>
                                            <c:when test="${detail.order_state == '결제대기'}">문의 필요</c:when>
                                            <c:when test="${detail.order_state == '결제완료'}">결제 완료</c:when>
                                            <c:when test="${detail.order_state == '주문취소'}">취소 완료</c:when>
                                            <c:when test="${detail.order_state == '배송준비중'}">배송 준비중</c:when>
                                            <c:when test="${detail.order_state == '배송중'}">배송중</c:when>
                                            <c:when test="${detail.order_state == '배송완료'}">
                                                배송 완료
                                                <a href="${path}/review/write.do">
                                                    <button class="review-button" data-orderdetail-id="${detail.orderdetail_id}">리뷰작성</button>
                                                </a>
                                                <button class="refund-button" data-order-id="${order.order_id}">환불 신청</button>
                                            </c:when>
                                            <c:when test="${detail.order_state == '환불신청'}">환불 신청</c:when>
                                            <c:when test="${detail.order_state == '환불완료'}">환불 완료</c:when>
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
            <div id="refund-popup" class="popup" style="display:none;">
                <div class="popup-content">
                    <div class="popup-header">
                        <span class="popup-icon">!</span>
                    </div>
                    <div class="popup-body">
                        <p>환불 신청하시겠습니까?</p>
                    </div>
                    <div class="popup-footer">
                        <form id="refund-form" method="post" action="refund.do">
                            <input type="hidden" id="refund-order-id" name="orderId" value="${order.order_id}">
                            <button type="button" class="popup-button" id="yes-refund-button">예</button>
                            <button type="button" class="popup-button" id="no-refund-button">아니오</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 환불 완료 알림 -->
            <div id="refund-complete-popup" class="popup" style="display:none;">
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
        </main>
        <%@ include file="../common/footer.jsp"%>
    </div>

</body>

</html>
