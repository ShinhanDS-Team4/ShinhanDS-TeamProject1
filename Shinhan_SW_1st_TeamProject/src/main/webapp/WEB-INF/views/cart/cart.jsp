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
function changeAmount(cart_id){
	var cart_amount= document.getElementById("cart_amount_" + cart_id).value;
	
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
	console.log(cart_id);
	
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
        data: JSON.stringify(cartIds),
        success: function(response) {
            alert("주문 페이지로 이동합니다.");
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
        data: JSON.stringify(cartIds),
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
	
	<div class="cart-container inner">
        <h1 class="cart-title">장바구니</h1>
         <div class="cart-header">
            <div>구매(개수)</div>
        </div>  
        <div>
	        <%-- 구매 상품 장바구니 리스트 --%>
	        <div class="sellCartList">
		        <c:forEach  var="cartProduct" items="${cartProdInfo}">
			        <div class="order-cart-item" data-cart-id="${cartProduct.CART_ID}">
			            <div class="cart-item-details">
			                <div><strong>상품명:</strong>${cartProduct.PROD_NAME}</div>
			                <c:if test="${not empty cartProduct.OPT_NAME1}">
				                <div><strong>옵션:</strong> ${cartProduct.OPT_NAME1} : ${cartProduct.OPT_VALUE1}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME2}">
				                <div><strong>옵션:</strong> ${cartProduct.OPT_NAME2} : ${cartProduct.OPT_VALUE2}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME3}">
				                <div><strong>옵션:</strong> ${cartProduct.OPT_NAME3} : ${cartProduct.OPT_VALUE3}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME4}">
				                <div><strong>옵션:</strong> ${cartProduct.OPT_NAME4} : ${cartProduct.OPT_VALUE4}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME5}">
				                <div><strong>옵션:</strong> ${cartProduct.OPT_NAME5} : ${cartProduct.OPT_VALUE5}</div>
				            </c:if>
			            </div>
			            주문 수량: <input type="number" id="cart_amount_${cartProduct.CART_ID}" value="${cartProduct.CART_AMOUNT}">
			            <div class="item-options">
			                <button class="btn-option" onclick="changeAmount(${cartProduct.CART_ID})">수량 변경</button>
			                <!-- <button class="btn-option" onclick="">바로구매</button> -->
			            </div>
		               <div class="cart-item-price">
			              <span>총 가격</span> 
			              <c:set var="totalPrice" value="${cartProduct.CART_AMOUNT * cartProduct.PROD_PRICE}"/>
               			  <span class="total-price-this">${totalPrice}<span>(원)
			            </div>
			            <div class="cart-item-remove" onclick="removeCartItem(${cartProduct.CART_ID})">X</div>
			            <c:set var="totalSumSell" value="${totalSumSell + totalPrice}" />
			        </div>
		        </c:forEach>
	        </div>
	        
	        <div class="cart-summary">
            	<div class="cart-summary-details">
                	<div class="summary-item">
                    	<div>결제 예정 금액</div>
                    	<div>총 ${countSellproduct}건</div>
                	</div>
                <div class="summary-item">
                    <div class="summary-total">${totalSumSell}원</div>
                </div>
            </div>
            <button class="btn-purchase" onclick="submitOrder()">주문하기</button>
      	  </div>
	        
	        <h1>장바구니(대여 상품)</h1>
	         <div class="cart-header">
	            <div>대여(개수)</div>
	        </div>
	        <%-- 대여 상품 장바구니 리스트 --%>
	        <div class="sellCartList">
		        <c:forEach items="${cartRentProdInfo}" var="rentCartProduct">
		        	<div class="rent-cart-item" data-cart-id="${rentCartProduct.CART_ID}">
			            <div class="cart-item-details">
			                <div><strong>상품명:</strong>${rentCartProduct.PROD_NAME}</div>
			                <c:if test="${not empty rentCartProduct.opt_name1}">
				                <div><strong>옵션:</strong> ${rentCartProduct.OPT_NAME1} : ${rentCartProduct.OPT_VALUE1}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME2}">
				                <div><strong>옵션:</strong> ${rentCartProduct.OPT_NAME2} : ${rentCartProduct.OPT_VALUE2}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME3}">
				                <div><strong>옵션:</strong> ${rentCartProduct.OPT_NAME3} : ${rentCartProduct.OPT_VALUE3}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME4}">
				                <div><strong>옵션:</strong> ${rentCartProduct.OPT_NAME4} : ${rentCartProduct.OPT_VALUE4}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.OPT_NAME5}">
				                <div><strong>옵션:</strong> ${rentCartProduct.OPT_NAME5} : ${rentCartProduct.OPT_VALUE5}</div>
				            </c:if>
			            </div>
			            주문 수량 : <input type="number" id="cart_amount_${rentCartProduct.CART_ID}" value="${rentCartProduct.CART_AMOUNT}">
			            <div class="item-options">
			                <button class="btn-option" onclick="changeAmount(${rentCartProduct.CART_ID})">수량 변경</button>
			                <!-- <button class="btn-option" onclick="">바로구매</button> -->
			            </div>
		              	<div class="cart-item-price">
			              <span>총 가격</span> 
			              <c:set var="totalPriceRent" value="${rentCartProduct.CART_AMOUNT * 30000}"/>
               				<span class="total-price-this">${totalPriceRent}<span>(원)
			            </div>
			            <div class="cart-item-remove" onclick="removeCartItem(${rentCartProduct.CART_ID})">X</div>
			            <c:set var="totalSum" value="${totalSum + totalPriceRent}" />
			        </div>
		        </c:forEach>
	        </div>
        </div>
        <div class="cart-summary">
            <div class="cart-summary-details">
                <div class="summary-item">
                    <div>결제 예정 금액</div>
                    <div>총 ${countRentproduct}건</div>
                </div>
                 <div class="summary-item">
                    <div class="summary-total">${totalSum}원</div>
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