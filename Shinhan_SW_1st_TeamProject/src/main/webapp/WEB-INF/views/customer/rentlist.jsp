<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="../resources/css/header_footer.css">
    <meta charset="UTF-8">
    <title>대여내역</title> 
    <style> 
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
        #yes-return-button {
            background-color: #6200EA;
            color: white;
        }
        #no-return-button {
            background-color: #FFFFFF;
            color: black;
            border: 1px solid #000000;
        }
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(function() {
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
                var rentalCode = $(this).data('order-id');
                console.log("dd" + rentalCode);
                showReturnPopup(rentalCode);
            });

            // Submit the return form via AJAX
            $('#yes-return-button').on('click', function(e) {
                var rentalCode = $('#return-rental-code').val();
                console.log(rentalCode);
                $.ajax({
                    type: 'POST',
                    url: 'returnRent', // Adjust the URL if needed
                    data: {
                        rentalCode: rentalCode
                    },
                    success: function(response) {
                        if (response === 'success') {
                            hideReturnPopup();
                            showReturnCompletePopup();
                            setTimeout(function() {
                                location.reload();
                            }, 2000); // Reload the page after 2 seconds
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
        });
    </script>
</head>
<body>
    <%@ include file="../common/header.jsp"%>
    <div class="container">
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
                                        <p>${detail.rent_product_price}원</p>
                                        <p>수량: ${detail.rent_num}개</p>
                                        <c:choose>
                                            <c:when test="${detail.rent_state == '대여중'}">
                                                <button class="refund-button" data-order-id="${detail.rental_code}">반납하기</button>
                                            </c:when>
                                        </c:choose>
                                    </div>
                                </div>
                                <span class="order-status">
                                    <c:choose>
                                        <c:when test="${detail.rent_state == '대여신청완료'}">대여신청완료</c:when>
                                        <c:when test="${detail.rent_state == '대여취소'}">대여취소</c:when>
                                        <c:when test="${detail.rent_state == '대여중'}">대여중</c:when>
                                        <c:when test="${detail.rent_state == '반납중'}">반납중</c:when>
                                        <c:when test="${detail.rent_state == '반납완료'}">반납 완료</c:when>
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
                        <form id="return-form" method="post" action="returnRent">
                            <input type="hidden" id="return-rental-code" name="rentalCode" value="${order.rental_code}">
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
