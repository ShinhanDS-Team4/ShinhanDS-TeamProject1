<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>대여주문 결제 페이지</title>
<!-- 본문 css -->
<link rel="stylesheet" href="${path}/resources/css/style.css">
<!-- 헤더,푸터 css -->
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<!-- jquery 연결 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/customerPay.css" />
<!-- PortOne 이니시스 결제 -->
<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
<%-- 카카오API --%>
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	
	function applyCoupon() {
		var selectedCouponId = $('#selectedCoupon').val();
		var orderid = $('#orderId').val();
		var orderPrice = $('#orderPrice').val();
		alert(selectedCouponId);
		alert(orderPrice);

		$.ajax({
			url : "/shoppingmall/customer/applyCoupon.do",
			type : 'POST',
			contentType : 'application/json',
			data : JSON.stringify({
				couponid : selectedCouponId,
				orderPrice : orderPrice
			}),
			success : function(response) {
				console.log(response);  // 응답 데이터를 로그로 출력하여 확인
				
				var discountedPrice = response.discountedPrice;
				var discount = response.discount;
				
				console.log(discountedPrice);
				console.log(discount);
				
				$('#discountAmount').val(discount);
				$('#finalPrice').val(discountedPrice);
				$('#couponselectedPrice').val(discountedPrice);
			},
			error : function() {
				alert('서버 요청 중 오류가 발생했습니다.');
			}
		});
	}
	
	function applyPoint(){
		var usePoint = $('#usePoint').val();
		var couponAppliedPrice = $('#couponselectedPrice').val();
		
		alert(usePoint);
		alert(couponAppliedPrice);
		
		$.ajax({
			url : "/shoppingmall/customer/applyPoint.do",
			type : 'POST',
			contentType : 'application/json',
			data : JSON.stringify({
				usePoint : usePoint,
				couponAppliedPrice : couponAppliedPrice
			}),
			success : function(response) {
				console.log(response);
				
				var usedPoint = response.usePoint;
				var pointAppliedPrice = response.pointAppliedPrice;
				
				$('#pointUseDiscount').val(usedPoint);
				$('#pointUsedPrice').val(pointAppliedPrice);
				$('#finalPrice').val(pointAppliedPrice);
			},
			error : function() {
				alert('서버 요청 중 오류가 발생했습니다.');
			}
		});
		
	}
	
	$("cancelBtn").on("click",function(){
		var order_id = $('#orderId').val();
		
		$.ajax({
			type:"POST",
			url:"/shoppingmall/customer/cancelRentPay.do",
			data:{
				"rental_code":order_id
			},success:function(response){
				if(response==="Canceled"){
					alert("주문을 취소하고 이전 페이지로 돌아갑니다.");
					history.back();
				}else{
					alert("주문 취소에 실패하였습니다.")
				}
				
			},error:function(jqXHR, textStatus, errorThrown) {
                alert("서버 요청 실패: " + errorThrown);
            }
		});
	});

	$().ready(function(){
		var IMP = window.IMP;
		IMP.init('imp31438144'); // 가맹점 식별코드 입력
		
		$("#orderBtn").on("click", function(){
			alert("구매버튼");
			var rental_code = '${rentInfo.rental_code}';
			var userid= '${memberInfo.member_id}';
			var username = '${memberInfo.member_name}';
			var phone='${memberInfo.phone}';
			var merchant_uid = 'rentPay_'+rental_code;//DB에 주문ID로 저장될, 고유한 주문 ID
			var amount = $('#finalPrice').val();//결제 금액
				
			IMP.request_pay({
               	pg: "html5_inicis",           // 등록된 pg사 (적용된 pg사는 KG이니시스)
               	pay_method: "card",
               	merchant_uid: merchant_uid, // 주문 고유 번호
               	name: "상품 주문",
               	amount: $('#finalPrice').val(),
               	buyer_email: '${memberInfo.email}',
               	buyer_name: username,
               	buyer_tel: phone,
               	buyer_addr: "서울특별시 강남구 신사동",
               	buyer_postcode: "01181",
           	}, function(response){
           		if (response.success){
           			alert("결제 완료");
       				window.location.href = "/shoppingmall/customer/rentPaySuccess?&rental_code="+encodeURIComponent(rental_code);
           		} else {
    				var msg = '결제에 실패하였습니다.';
    				msg += '에러내용 : ' + rsp.error_msg;
    			}
    			alert(msg);
			});
		});
	});
</script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
		<h1>주문/결제</h1>
		<div id="orderList" class="orderList-table">
			<table id="orderTable">
				<thead>
					<tr>
						<th>대여 번호</th>
						<th>상품명</th>
						<th>대여 가격</th>
						<th>구매 수량</th>
						<th>최종가</th>
					</tr>
				</thead>
				<tbody>
					<c:set var="prodName" value="${rentBrandandProdName['PROD_NAME']}" />
					<c:set var="brand" value="${rentBrandandProdName['BRAND']}" /> 
					<c:forEach var="rentDetail" items="${rentDetailList}">
						<tr>
							<td>
								<p>${rentDetail.rental_code}</p>
							</td>
							<td>
								<p>(${brand}) ${prodName}</p> 
							</td>
							<td>
								<p>
									<fmt:formatNumber value="${rentDetail.rent_product_price}" type="number" groupingUsed="true" />(원)
								</p>
							</td>
							<td>
								<p>${rentDetail.rent_num}(개)</p>
							</td>
							<td>
								<p>
									<fmt:formatNumber value="${rentDetail.rent_product_price * rentDetail.rent_num}" type="number" groupingUsed="true" />(원)
								</p>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="delivery-info">
			<h2>배송자 정보</h2>
			<div class="form-group-wrap">
				<div>
					<div class="form-group">
						<label for="name">이름</label> <input type="text" id="name" readonly="readonly"
							name="name" value="${memberInfo.member_name}" />
					</div>
					<div class="form-group">
						<label for="phone">휴대폰</label> <input type="text" id="phone" readonly="readonly"
							name="phone" value="${memberInfo.phone}" />
					</div>
		
					<div class="form-group">
						<label for="coupon">쿠폰 선택</label> <select name="selectedCoupon"
							id="selectedCoupon">
							<option value="선택안함">선택 안함</option>
							<c:forEach var="coupon" items="${couponList}">
								<option value="${coupon.coupon_id}">${coupon.coupon_name}</option>
							</c:forEach>
						</select>
						<!-- Hidden input to store selected coupon ID -->
		
						<input type="hidden" id="totalPrice" name="totalPrice" value="${rentInfo.total_rent_price}" />
							<input type="hidden" id="orderId" name="orderId" value="${rentInfo.rental_code}" />
						<div class="buttons">
							<button type="button" class="select-button" id="apply_coupon" onclick="applyCoupon()">선택하기</button>
						</div>
		
					</div>
		
					<div class="form-group">
						<label for="pointLeft">보유 포인트</label> <input type="number" readonly="readonly"
							value="${customerInfo.point}">
					</div>
					<div class="form-group">
						<label for="pointLeft">사용할 포인트</label> <input type="number"
							id="usePoint" name="usePoint">
						<div class="buttons">
							<button type="button" id="apply_point" class="select-button" onclick="applyPoint()">사용</button>
						</div>
					</div>
				</div>
		
				<div class="orderPay-info-box">
					<h3>결제 내용</h3>
					<div>
						<div>
							<div class="orderPay-info-text">
								<p>가격: </p>
								<c:forEach var="rentDetail" items="${rentDetailList}">
									<p>
									  <fmt:formatNumber value="${rentDetail.rent_product_price * rentDetail.rent_num}" type="number" groupingUsed="true" />원
							  		</p>
								</c:forEach>
							</div>
							<div class="orderPay-info-text">
								<p>배송비: </p>
								<p>0원</p>
							</div>
							<div class="orderPay-info-text">
								<p>쿠폰 할인 금액</p>
								<p>0</p>
							</div>
							<div class="orderPay-info-text">
								<p>사용할 포인트</p>
								<p>0</p>
							</div>
						</div>
						<div class="orderPay-info-totalPrice">
							<p>최종 결제 금액 </p>
							<c:set var="totalRentPrice" value="${rentDetail.rent_product_price * rentDetail.rent_num}" />
							<p>
							   <fmt:formatNumber value="${totalRentPrice}" type="number" groupingUsed="true" />원
							</p>
						</div>
					</div>
				</div>
			</div>	
			<div class="form-group">
				<%-- 최종 결제 금액 --%>
				<input type="hidden" value="${rentInfo.total_rent_price}" readonly="readonly">
			</div>
			<div class="payment-group">
				<button class="payment-button" id="orderBtn">결제하기</button>
				<%-- <button class="payment-button" id="cancelBtn">뒤로가기</button> --%>
			</div>

		</div>
		
		<div class="form-group">
			<label>대여 금액</label>
			<input id="orderPrice" type="number" value="${rentInfo.total_rent_price}" readonly="readonly">
		</div>
		<div class="form-group">
			<label>쿠폰 할인 금액</label>
			<input id="discountAmount" type="number" value="0" readonly="readonly">
		</div>
		
		<!-- hidden 처리되어 있는 쿠폰 적용 가격 -->
		<input id="couponselectDiscount" type="hidden" value="${couponselectDiscount}" readonly="readonly">
		<input id="pointUseDiscount" type="hidden" value="0" readonly="readonly">
		
		<input id="couponselectedPrice" type="hidden" value="${couponSelectedPrice}" readonly="readonly">
		<input id="pointUsedPrice" type="hidden" value="0" readonly="readonly">

		<div class="form-group">
			<label>최종 결제 금액</label>
			<input id="finalPrice" type="number" readonly="readonly" value="${rentInfo.total_rent_price}">
		</div>
		<div class="payment-group">
			<button class="payment-button" id="orderBtn">결제하기</button>
			<button class="payment-button" id="cancelBtn">뒤로가기</button>
		</div>
	</main>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>