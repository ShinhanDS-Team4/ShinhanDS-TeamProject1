<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<%-- css --%>
<link rel="stylesheet" href="${path}/resources/css/cart.css">
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<%-- jquery 연결 --%>
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
	
<script>
function changeAmountPopUp(cart_id){
	var cart_amout= document.getElementById("cart_amount_" + cart_id).value;
	
	$.ajax({
		type:'post',
		url:"${path}/cart/changeCartAmount.do",
		contentType: 'application/json',
		data:JSON.stringify({
			cart_id: cart_id,
		    cart_amount: cart_amount
		}),
		success:function(response){
			if(response === "CartAmount Updated"){
				alert("수량이 변경되었습니다.");
				location.reload();
			}else{
				alert("수량 변경 실패");
			}
		},
		error:function(){
			alert('서버 요청 중 오류 발생');
		}
	});
}

function removeCartItem(cart_id){
	$.ajax({
		type:'post',
		url:'${path}/cart/deleteCart.do',
		contentType: 'application/json',
		data:JSON.stringify({
			cart_id:cart_id
		}),
		success:function(response){
			if(response==="cart Deleted"){
				alert("장바구니에서 삭제되었습니다.");
				location.reload();
			}else{
				alert("선택한 장바구니 삭제 실패");
			}
		},
		error:function(){
			alert('서버 요청 중 오류 발생');
		}
	});
}

function submitOrder() {
    var cartIds = [];
    var cartItems = document.querySelectorAll('.order-cart-item');

    cartItems.forEach(function(cartItem) {
        var cartId = cartItem.getAttribute('data-cart-id');
        cartIds.push(cartId);
    });

    console.log("Selected cart IDs: ", cartIds); // 콘솔에 cartIds 배열 출력 (디버깅 용도)

    // 여기에 AJAX 호출 또는 폼 제출 코드 추가
    $.ajax({
        type: 'post',
        url: '${path}/cart/createOrder.do',
        contentType: 'application/json',
        data: JSON.stringify({ cartIds: cartIds }),
        success: function(response) {
            alert("주문 페이지로 이동합니다.")
          	//주문페이지로 이동
            location.href = "${path}/customer/orderPay.do?order_id=" + response.order_id;
        },
        error: function(xhr, status, error) {
            // 에러 처리
            console.error("AJAX request failed: " + status + ", " + error);
        }
    });
}

function submitRent() {
    var cartIds = [];
    var cartItems = document.querySelectorAll('.rent-cart-item');
    
    cartItems.forEach(function(cartItem) {
        var cartId = cartItem.getAttribute('data-cart-id');
        cartIds.push(cartId);
    });

    console.log("Selected cart IDs: ", cartIds); // 콘솔에 cartIds 배열 출력 (디버깅 용도)

    // 여기에 AJAX 호출 또는 폼 제출 코드 추가
    $.ajax({
        type: 'post',
        url: '${path}/cart/createRent.do',
        contentType: 'application/json',
        data: JSON.stringify({ cartIds: cartIds }),
        success: function(response) {
        	alert("주문 페이지로 이동합니다.")
        	location.href = "${path}/customer/rentPay.do?rental_code=" + response.rental_code;
        },
        error: function(xhr, status, error) {
            // 에러 처리
            console.error("AJAX request failed: " + status + ", " + error);
        }
    });
}
</script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>	
	
	 <div class="container">
        <h1>장바구니</h1>
        <div class="cart-header">
            <div>구매(개수)</div>
            <div>대여(개수)</div>
        </div>
        
        <div>
        	<div class="checkbox-container">
	            <input type="checkbox" checked>
	            <span>전체선택</span>
	        </div>
	        <%-- 구매 상품 장바구니 리스트 --%>
	        <div class="sellCartList">
	        	<form></form>
		        <c:forEach items="${cartProdInfoList}" var="cartProduct">
			        <div class="order-cart-item" data-cart-id="${cartProduct.CART_ID}">
			            <div class="cart-item-details">
			                <div><strong>상품명:</strong>${cartProduct.PROD_NAME}</div>
			                <c:if test="${not empty cartProduct.OPT_NAME1}">
				                <div><strong>옵션:</strong> ${cartProduct.OPT_NAME1} : ${cartProduct.opt_value1}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME2}">
				                <div><strong>옵션:</strong> ${cartProduct.OPT_NAME2} : ${cartProduct.opt_value2}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME3}">
				                <div><strong>옵션:</strong> ${cartProduct.OPT_NAME3} : ${cartProduct.opt_value3}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME4}">
				                <div><strong>옵션:</strong> ${cartProduct.OPT_NAME4} : ${cartProduct.opt_value4}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME5}">
				                <div><strong>옵션:</strong> ${cartProduct.OPT_NAME5} : ${cartProduct.opt_value5}</div>
				            </c:if>
			            </div>
			            주문 수량: <input type="number" id="cart_amount_${cartProduct.CART_ID}" value="${cartProduct.CART_AMOUNT}">
			            <div class="cart-item-price">총 가격 (원)</div>
			            <div class="item-options">
			                <button class="btn-option" onclick="changeAmountPopUp(${cartProduct.CART_ID})">수량 변경</button>
			                <!-- <button class="btn-option" onclick="">바로구매</button> -->
			            </div>
			            <div class="cart-item-remove" onclick="removeCartItem(${cartProduct.CART_ID})">X</div>
			        </div>
		        </c:forEach>
	        </div>
	        
	        <div class="cart-summary">
            	<div class="cart-summary-details">
                	<div class="summary-item">
                    	<div>결제 예정 금액</div>
                    	<div>총 2건</div>
                	</div>
                <div class="summary-item">
                    <div>468,000원</div>
                    <div>+</div>
                    <div>0원</div>
                    <div>=</div>
                    <div class="summary-total">468,000원</div>
                </div>
            </div>
            <button class="btn-purchase" onclick="submitOrder()">주문하기</button>
        </div>
	        
	        
	        <%-- 대여 상품 장바구니 리스트 --%>
	        <div class="sellCartList">
	        	<form></form>
		        <c:forEach items="${cartProdInfoList}" var="cartProduct">
			        <div class="rent-cart-item">
			            <div class="checkbox-container">
			                <input type="checkbox">
			            </div>
			            <div class="cart-item-details">
			                <div><strong>상품명:</strong>${cartProduct.PROD_NAME}</div>
			                <c:if test="${not empty cartProduct.opt_name1}">
				                <div><strong>옵션:</strong> ${cartProduct.opt_name1} : ${cartProduct.opt_value1}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME2}">
				                <div><strong>옵션:</strong> ${cartProduct.opt_name2} : ${cartProduct.opt_value2}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME3}">
				                <div><strong>옵션:</strong> ${cartProduct.opt_name3} : ${cartProduct.opt_value3}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME4}">
				                <div><strong>옵션:</strong> ${cartProduct.opt_name4} : ${cartProduct.opt_value4}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME5}">
				                <div><strong>옵션:</strong> ${cartProduct.opt_name5} : ${cartProduct.opt_value5}</div>
				            </c:if>
			            </div>
			            주문 수량 : <input type="number" id="cart_amount_${cartProduct.CART_ID}" value="${cartProduct.CART_AMOUNT}">
			            <div class="cart-item-price">총 가격 (원)</div>
			            <div class="item-options">
			                <button class="btn-option" onclick="changeAmountPopUp(${cartProduct.CART_ID})">수량 변경</button>
			                <!-- <button class="btn-option" onclick="">바로구매</button> -->
			            </div>
			            <div class="cart-item-remove" onclick="removeCartItem(${cartProduct.CART_ID})">X</div>
			        </div>
		        </c:forEach>
	        </div>
        </div>
        <div class="cart-summary">
            <div class="cart-summary-details">
                <div class="summary-item">
                    <div>결제 예정 금액</div>
                    <div>총 2건</div>
                </div>
                <div class="summary-item">
                    <div>468,000원</div>
                    <div>+</div>
                    <div>0원</div>
                    <div>=</div>
                    <div class="summary-total">468,000원</div>
                </div>
            </div>
            <button class="btn-purchase" onclick="submitRent()">주문하기</button>
        </div>
        <div class="note">
            * 품질 보증기간은 구입 후 30일입니다.<br>
            * 보증기간 이내 무상 수선이 가능합니다.<br>
            * 착용 흔적이 있는 제품은 교환/반품이 불가합니다.<br>
            * SSF SHOP은 전자상거래법을 준수합니다.<br>
            * 소비자의 부주의로 인한 제품 손상은 보상 처리되지 않습니다.
        </div>
    </div>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>