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
<style type="text/css">
 .cart-container{
 	margin: 80px auto;
 }
</style>	
</head>
<body>
	<%@ include file="../common/header.jsp" %>	
	
	 <div class="cart-container inner">
        <h1>장바구니</h1>
        <div class="cart-header">
            <div>구매(개수)</div>
        </div>        
        <div>
	        <%-- 구매 상품 장바구니 리스트 --%>
	        <div class="sellCartList">
		        <c:forEach items="${cartProdInfo}" var="cartProduct">
			        <div class="cart-item">
			        	<div>
			        		${cartProduct.CART_ID}
			        	</div>
			            <div class="cart-item-details">
			                <div><strong>상품명:</strong>${cartProduct.PROD_NAME}(${cartProduct.CART_AMOUNT} 개)</div>
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
			            <div class="cart-item-price">
			              <span>총 가격</span> 
			              <c:set var="totalPrice" value="${cartProduct.CART_AMOUNT * cartProduct.PROD_PRICE}"/>
               				<span class="total-price-this">${totalPrice}<span>(원)
			            </div>
			            <div class="cart-item-remove">X</div>
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
	            <button class="btn-purchase">주문하기</button>
	        </div>
         </div>
         
         <h1>대여 상품</h1>
         <div class="cart-header">
            <div>대여(개수)</div>
        </div>
         <div>
	        <%-- 대여 상품 장바구니 리스트 --%>
	        <div class="sellCartList">
		        <c:forEach items="${cartRentProdInfo}" var="rentCartProduct">
			        <div class="cart-item">
			            <div class="cart-item-details">
			                <div><strong>상품명:</strong>
			                ${rentCartProduct.PROD_NAME} (${rentCartProduct.CART_AMOUNT} 개)
			                </div>
			                <c:if test="${not empty rentCartProduct.OPT_NAME1}">
				                <div><strong>옵션:</strong> ${rentCartProduct.OPT_NAME1} : ${rentCartProduct.OPT_VALUE1}</div>
				            </c:if>
				            <c:if test="${not empty rentCartProduct.OPT_NAME2}">
				                <div><strong>옵션:</strong> ${rentCartProduct.OPT_NAME2} : ${rentCartProduct.OPT_VALUE2}</div>
				            </c:if>
				            <c:if test="${not empty rentCartProduct.OPT_NAME3}">
				                <div><strong>옵션:</strong> ${rentCartProduct.OPT_NAME3} : ${rentCartProduct.OPT_VALUE3}</div>
				            </c:if>
				            <c:if test="${not empty rentCartProduct.OPT_NAME4}">
				                <div><strong>옵션:</strong> ${rentCartProduct.OPT_NAME4} : ${rentCartProduct.OPT_VALUE4}</div>
				            </c:if>
				            <c:if test="${not empty rentCartProduct.OPT_NAME5}">
				                <div><strong>옵션:</strong> ${rentCartProduct.OPT_NAME5} : ${rentCartProduct.OPT_VALUE5}</div>
				            </c:if>
			            </div>
			            <div class="cart-item-price">
			              <span>총 가격</span> 
			              <c:set var="totalPrice" value="${rentCartProduct.CART_AMOUNT * 30000}"/>
               				<span class="total-price-this">${totalPrice}<span>(원)
			            </div>
			            <div class="cart-item-remove">X</div>
			             <c:set var="totalSum" value="${totalSum + totalPrice}" />
			        </div>
		        </c:forEach>
	        </div>
	        <div class="cart-summary">
	            <div class="cart-summary-details">
	                <div class="summary-item">
	                    <div>결제 예정 금액</div>
	                    <div>총 ${countRentproduct}건</div>
	                </div>
	                <!-- <div>
	               		<p>
	                    <span>468,000원</span> <span>+원</span><span>0원</span> <span>=</span>
	                    </p>
	                </div> -->
	                <div class="summary-item">
	                    <div class="summary-total">${totalSum}원</div>
	                </div>
	            </div>
	            <button class="btn-purchase">주문하기</button>
	        </div>
         </div>
         
         <div class="note">
            * 품질 보증기간은 구입 후 30일입니다.<br>
            * 보증기간 이내 무상 수선이 가능합니다.<br>
            * 착용 흔적이 있는 제품은 교환/반품이 불가합니다.<br>
            * SAREN SHOP은 전자상거래법을 준수합니다.<br>
            * 소비자의 부주의로 인한 제품 손상은 보상 처리되지 않습니다.
         </div>
    </div>
	<%@ include file="../common/footer.jsp" %>
</body>
</html>