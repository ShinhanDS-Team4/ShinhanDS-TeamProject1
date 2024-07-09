<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SAREN 코디 추천</title>
	<!-- CSS -->
	<link rel="stylesheet" href="${path}/resources/css/coordination.css">
	<!-- 헤더,푸터 css -->
	<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
	<!-- jquery 연결 -->
	<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
 	<%@ include file="../common/header.jsp" %>
      <div class="container inner">
	 	  <h1 class="main-title">🗨️AI로 만나는 완벽한 스타일, 나만의 코디 메이트</h1>
	 	  <p>지금 바로 AI 옷 코디 추천 서비스를 체험해보세요! 당신의 옷장이 새롭게 변신할 것입니다.</p>
	      <div class="container-wrapper">
				<!-- 광고문구 -->
		       <div class="copy-right-wrapper">
		        <h1 class="speech-bubble-icon hidden">🗨️</h1>
		       	<h1 class="copyTitle">
		       	장바구니에 담긴 옷만으로 만족하실 수 없나요? 
		       	<br>AI가 당신의 쇼핑 경험을 한 단계 업그레이드 해드립니다!</h1>
		       	<p class="subCopyTitle">옷장 속 아이템과 조화롭게 어울리는 패션을 쉽게 찾아보세요.</p>
		       	<p class="img-gift">
		       		<img src="${path}/resources/images/undraw_gifts.svg" 
		       		alt="일러스트" />
		       	</p>
		      </div>
				
		      <div class="cart-list-wrapper">
		    	   <h3>나의 장바구니</h3>
		       		<%-- 장바구니가 비었을 경우 --%>
				    <c:if test="${empty cartProdInfo}">
				        <ul class="no-cart-list">
				            <li>
				                <p>장바구니에 담긴 상품이 없습니다.</p>
				                <a href="${path}/prod/productlist">상품 보러가기</a>
				            </li>
				        </ul>
				    </c:if>
				    
				    <%-- 장바구니에 상품이 있을 경우 --%>
				    <c:if test="${not empty cartProdInfo}">
				        <ul class="cart-list">
				            <c:forEach var="cartProduct" items="${cartProdInfo}">
				                <li>
				                    <table>
				                        <tbody>
				                            <tr>
				                                <td>
				                                    <c:choose>
				                                        <c:when test="${not empty cartProduct.PROD_ID}">
				                                            <img src="/saren/ProdImgFile/main/${cartProduct.PROD_ID}_image_1.jpg" 
				                                                 alt="메인이미지"
				                                                 style="width:100px; height:100px;" />
				                                        </c:when>
				                                        <c:otherwise>
				                                            <img src="${path}/resources/images/no-prod-img.png" 
				                                                 alt="기본이미지(100x100)" />
				                                        </c:otherwise>
				                                    </c:choose>
				                                </td>
				                                <td>
				                                    <p class="product-name">${cartProduct.PROD_NAME}</p>
				                                    <input id="prod_id" type="hidden" value="${cartProduct.PROD_ID}" />
				                                </td>
				                                <td>${cartProduct.CART_AMOUNT}(개)</td>
				                                <td>${cartProduct.PROD_PRICE}(원)</td>
				                                <td>
				                                    <button id="recommendBtn" type="button">추천받기</button>
				                                </td>
				                            </tr>
				                        </tbody>
				                    </table>
				                </li>
				            </c:forEach>
				        </ul>
				    </c:if>
		       </div>
	       </div>
      </div>
 	<%@ include file="../common/footer.jsp" %>
 	<script type="text/javascript">
 	$(function () {
 		$('#recommendBtn').on('click', function() {

 	        var prod_id = $('#prod_id').val(); // 카트 ID 값을 가져옴
 	        

 	        location.href = "${path}/customer/recommend.do?prod_id=" + prod_id;
 	    });

	});
 	</script>
</body>
</html>