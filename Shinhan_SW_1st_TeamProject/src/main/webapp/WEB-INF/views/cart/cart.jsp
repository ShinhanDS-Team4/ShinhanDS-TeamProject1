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
			        <div class="cart-item">
			            <div class="checkbox-container">
			                <input type="checkbox">
			            </div>
			            <div class="cart-item-details">
			                <div><strong>상품명:</strong>${cartProduct.PROD_NAME}</div>
			                <c:if test="${not empty cartProduct.opt_name1}">
				                <div><strong>옵션:</strong> ${cartProduct.opt_name1} : ${cartProduct.opt_value1}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.opt_name2}">
				                <div><strong>옵션:</strong> ${cartProduct.opt_name2} : ${cartProduct.opt_value2}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.opt_name3}">
				                <div><strong>옵션:</strong> ${cartProduct.opt_name3} : ${cartProduct.opt_value3}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.opt_name4}">
				                <div><strong>옵션:</strong> ${cartProduct.opt_name4} : ${cartProduct.opt_value4}</div>
				            </c:if>
				            <c:if test="${not empty cartProduct.opt_name5}">
				                <div><strong>옵션:</strong> ${cartProduct.opt_name5} : ${cartProduct.opt_value5}</div>
				            </c:if>
			            </div>
			            <div class="cart-item-price">총 가격 (원)</div>
			            <div class="item-options">
			                <button class="btn-option">옵션 변경</button>
			                <button class="btn-option">바로구매</button>
			            </div>
			            <div class="cart-item-remove">X</div>
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
            <button class="btn-purchase">주문하기</button>
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