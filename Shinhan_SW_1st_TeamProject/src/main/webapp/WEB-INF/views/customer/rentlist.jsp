<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>

<head>
<link rel="stylesheet" type="text/css" href="../resources/css/header_footer.css">
<meta charset="UTF-8">
<title>대여내역</title>
<style>
.header-inner {
    /* 헤더의 스타일 정의 */
}

.main-inner {
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

.order-detail {
    display: flex;
    align-items: center;
    margin-top: 20px;
    margin-bottom: 20px;
}

.order-details-container {
    display: flex;
    justify-content: space-between;
    align-items: flex-start;
    margin-top: 20px;
    margin-bottom: 20px;
}

.order-details {
    display: flex;
    align-items: flex-start;
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
    max-width: 200px; 
}

.product-info p {
    margin: 5px 0;
}

.order-status {
    font-weight: bold;
    margin-left: 20px;
}

.cancel-button {
    background-color: #555;
    color: #fff;
    border: none;
    border-radius: 3px;
    padding: 5px 10px;
    cursor: pointer;
}

.cancel-button:hover {
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

/* Cancel Popup Styles */
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

#yes-cancel-button, #yes-return-button {
    background-color: #6200EA;
    color: white;
}

#no-cancel-button, #no-return-button {
    background-color: #FFFFFF;
    color: black;
    border: 1px solid #000000;
}

/* Cancel Complete Popup Styles */
#cancel-complete-popup {
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
        // Function to show the cancel popup
        function showCancelPopup(rentalCode) {
            $('#cancel-popup').css('display', 'flex');
            $('#cancel-rental-code').val(rentalCode); // Set the hidden input value
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

        // Add event listeners to cancel buttons
        $('.cancel-button').on('click', function() {
            var rentalCode = $(this).data("data-order-id");
            showCancelPopup(rentalCode);
        });

        // Submit the cancel form via AJAX
        $('#yes-cancel-button').on('click', function() {
            var rentalCode = $('#cancel-rental-code').val();
            $.ajax({
                type: 'POST',
                url: 'cancelRent.do',
                data: {
                    rentalCode: rentalCode
                },
                success: function(response) {
                    if (response === 'success') {
                        hideCancelPopup();
                        showCancelCompletePopup();
                        setTimeout(function() {
                            location.reload();
                        }, 2000); // 2초 후 페이지 새로고침
                    } else {
                        alert("대여 취소에 실패했습니다.");
                    }
                },
                error: function(error) {
                    alert("Error: " + error);
                }
            });
        });

        // Function to show the return popup
        function showReturnPopup(rentalCode) {
            $('#return-popup').css('display', 'flex');
            $('#return-rental-code').val(rentalCode); // Set the hidden input value
        }

        // Function to hide the return popup
        function hideReturnPopup() {
            $('#return-popup').hide();
        }

        // Function to show the return complete popup
        function showReturnCompletePopup() {
            $('#return-complete-popup').css('display', 'flex');
        }

        // Function to hide the return complete popup
        function hideReturnCompletePopup() {
            $('#return-complete-popup').hide();
        }

        // Add event listeners to return buttons
        $('.refund-button').on('click', function() {
            var rentalCode = $(this).attr('data-order-id');
            showReturnPopup(rentalCode);
        });

        // Submit the return form via AJAX
        $('#yes-return-button').on('click', function() {
            var rentalCode = $('#return-rental-code').val();
            $.ajax({
                type: 'POST',
                url: 'returnRent.do',
                data: {
                    rentalCode: rentalCode
                },
                success: function(response) {
                    if (response === 'success') {
                        hideReturnPopup();
                        showReturnCompletePopup();
                        setTimeout(function() {
                            location.reload();
                        }, 2000); // 2초 후 페이지 새로고침
                    } else {
                        alert("반납에 실패했습니다.");
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.error('AJAX request failed. Status:', textStatus, 'Error:', errorThrown);
                    console.error('Response text:', jqXHR.responseText);
                    alert("AJAX request failed. Status: " + textStatus + " Error: " + errorThrown + " Response: " + jqXHR.responseText);
                }
            });
        });

        $('#no-return-button').on('click', hideReturnPopup);
        $('#return-complete-popup .popup-button').on('click', hideReturnCompletePopup);
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
        <main class="main-content main-inner">
            <h2>대여 내역</h2>

            <div class="divider-between-title-and-order"></div>

            <c:forEach var="order" items="${rentAllOrders}">
                <section class="order">
                    <div class="order-group">
                        <div class="order-text">
                            <p class="order-date">대여 시작일: <fmt:formatDate value="${order.rent_start_date}" pattern="yyyy.MM.dd"/></p>
                            <c:choose>
                                <c:when test="${order.rent_state == '대여신청완료' or order.rent_state == '대여중' or order.rent_state == '반납중'}">
                                    <p>반납 예정일: <fmt:formatDate value="${order.rent_due_date}" pattern="yyyy.MM.dd"/></p>
                                </c:when>
                                <c:when test="${order.rent_state == '반납완료'}">
                                    <p>반납 일자: <fmt:formatDate value="${order.return_date}" pattern="yyyy.MM.dd"/></p>
                                </c:when>
                            </c:choose>
                        </div>

                        <c:forEach var="detail" items="${rentDetailsMap[order.rental_code]}">

                            <div class="order-details-container">

                                <div class="order-details">
                                    <img src="${detail.img_id}" alt="상품 이미지">
                                    <div class="product-info">
                                        <p>${detail.brand}</p>
                                        <h3>${detail.prod_name}</h3>
                                        <p>
                                            옵션:
                                            <!-- 빈 문자열 생성 -->
                                            <c:set var="options" value="" />

                                            <!-- optionList를 순회하며 조건 검사 및 옵션 추가 -->
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

                                            <!-- 옵션 출력 -->
                                            ${options}

                                        </p>
                                        <p>${detail.rent_product_price}원</p>
                                        <p>수량: ${detail.rent_num}개</p>
                                        <c:choose>
                                            <c:when test="${detail.rent_state == 'on_rent'}">
                                                <button class="refund-button" data-order-id="${detail.rentdetail_id}">반납하기</button>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                                <span class="order-status"> <c:choose>
                                        <c:when test="${detail.rent_state == 'pay_completed'}">대여신청완료</c:when>
                                        <c:when test="${detail.rent_state == 'rent_requested'}">대여신청완료</c:when>
                                        <c:when test="${detail.rent_state == 'cancelled'}">대여취소</c:when>
                                        <c:when test="${detail.rent_state == 'on_rent'}">대여중</c:when>
                                        <c:when test="${detail.rent_state == 'returning'}">반납중</c:when>
                                        <c:when test="${detail.rent_state == 'returned'}">반납 완료</c:when>
                                        <c:otherwise>알 수 없음</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </c:forEach>
                    </div>
                </section>

                <div class="divider-between-sections"></div>

                <section class="order-price">
                    <div class="total-section">
                        <p class="total-amount">
                            총 대여금액: <span>${order.total_rent_price}원</span>
                        </p>
                    </div>
                </section>

                <div class="divider-between-orders"></div>
            </c:forEach>

            <!-- 전체 대여취소신청 알림 -->
            <div id="cancel-popup" class="popup">
                <div class="popup-content">
                    <div class="popup-header">
                        <span class="popup-icon">!</span>
                    </div>
                    <div class="popup-body">
                        <p>취소 신청하시겠습니까?</p>
                    </div>
                    <div class="popup-footer">
                        <form id="cancel-form" method="post" action="cancelRent.do">
                            <input type="hidden" id="cancel-rental-code" name="rentalCode" value="">
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

            <!-- 반납신청 알림 -->
            <div id="return-popup" class="popup">
                <div class="popup-content">
                    <div class="popup-header">
                        <span class="popup-icon">!</span>
                    </div>
                    <div class="popup-body">
                        <p>반납 신청하시겠습니까?</p>
                    </div>
                    <div class="popup-footer">
                        <form id="return-form" method="post" action="returnRent.do">
                            <input type="hidden" id="return-rental-code" name="rentalCode" value="">
                            <button type="button" class="popup-button" id="yes-return-button">예</button>
                            <button type="button" class="popup-button" id="no-return-button">아니오</button>
                        </form>
                    </div>
                </div>
            </div>

            <!-- 반납 완료 알림 -->
            <div id="return-complete-popup" class="popup">
                <div class="popup-content">
                    <div class="popup-header">
                        <span class="popup-icon">!</span>
                    </div>
                    <div class="popup-body">
                        <p>반납 신청이 완료되었습니다.</p>
                    </div>
                    <div class="popup-footer">
                        <button class="popup-button" id="close-return-complete-popup">닫기</button>
                    </div>
                </div>
            </div>

        </main>
        <%@ include file="../common/footer.jsp"%>
    </div>
</body>

</html>
