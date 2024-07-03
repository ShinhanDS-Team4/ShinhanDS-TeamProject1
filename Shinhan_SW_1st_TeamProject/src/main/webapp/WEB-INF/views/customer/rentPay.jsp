<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문결제페이지</title>
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
		alert(selectedCouponId);
		alert(orderid);

		$.ajax({
			url : "/shoppingmall/customer/applyRentCoupon",
			type : 'POST',
			contentType : 'application/json',
			data : JSON.stringify({
				couponid : selectedCouponId,
				orderid : orderid
			}),
			success : function(response) {
				if (response === "Coupon applied") {
					alert('선택하신 쿠폰이 적용되었습니다');
					location.reload();
				} else {
					alert('선택하신 쿠폰 적용에 실패하였습니다');
				}
			},
			error : function() {
				alert('서버 요청 중 오류가 발생했습니다.');
			}
		});
	}
	
	function applyPoint(){
		var usePoint = $('#usePoint').val();
		var orderid = $('#orderId').val();
		
		alert(usePoint);
		alert(orderid);
		
		
		$.ajax({
			url : "/shoppingmall/customer/applyRentPoint",
			type : 'POST',
			contentType : 'application/json',
			data : JSON.stringify({
				point : usePoint,
				orderid : orderid
			}),
			success : function(response) {
				if (response === "Point Used") {
					alert('포인트를 사용하였습니다');
					location.reload();
				} else {
					alert('포인트 사용에 실패하였습니다');
				}
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
				var merchant_uid = 'rent_'+rental_code;//DB에 주문ID로 저장될, 고유한 주문 ID
				var amount = '${rentInfo.total_rent_price}';//결제 금액
				
				
				$.ajax({
					type:"POST",
					url:"/shoppingmall/customer/preparePayment",
					data:{
						"merchantUid":merchant_uid,
						"amount":amount	
					},
					success: function(response){
						if(response==="Payment amount registered successfully"){
							alert("결제금액 사전 등록 완료");
							//여기에서 이니시스 결제
							IMP.request_pay({
			                	pg: "html5_inicis",           // 등록된 pg사 (적용된 pg사는 KG이니시스)
			                	pay_method: "card",
			                	merchant_uid: merchant_uid, // 주문 고유 번호
			                	name: "상품 주문",
			                	amount: '${rentInfo.total_rent_price}',
			                	buyer_email: '${memberInfo.email}',
			                	buyer_name: username,
			                	buyer_tel: phone,
			                	buyer_addr: "서울특별시 강남구 신사동",
			                	buyer_postcode: "01181",
			            	}, function(response){
			            		if (response.success){
			                    	$.ajax({
			                    		type:"POST",
			                    		url:"/shoppingmall/customer/verifyPayment",
			                    		data:{
			                    			 "imp_uid":response.imp_uid,
			                                 "merchant_uid":response.merchant_uid
			                    		},
			                    		success : function(verificationResult){
			                    			if(verificationResult === "success"){
			                    				alert("검증에서 이상 없음. 결제 완료");	
			                    				window.location.href = "/shoppingmall/customer/rentPaySuccess?&rental_code=" + encodeURIComponent(rental_code);
			           
			                    			}else{
			                    				alert("검증에서 이상 발생. 결제 취소");
			                    			}
			                    		},
			                    		error: function(jqXHR, textStatus, errorThrown) {
	                                        alert("결제 검증 요청 실패: " + errorThrown);
	                                    }
			                    	});
			                	} else {
			                		alert("결제에 실패하였습니다. 에러: " + response.error_msg);
			                	}
			            	});
						}else{
							alert("사전결제 등록 실패")
						}
					},
					error: function(jqXHR, textStatus, errorThrown) {
	                    alert("결제 금액 사전 등록 요청 실패: " + errorThrown);
	                }
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
						<th>상품정보</th>
						<th>구매 수량</th>
						<th>최종가</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="rentDetail" items="${rentDetailList}">
						<tr>
							<td>
								<div class="product-details">
									<div class="info">
										<div class="left">
											<p>상품명</p>
										</div>
										<div class="right">
											<input type="text" placeholder="덩크로우" readonly="readonly"
												value="${rentDetail.r_stock_id}">
										</div>
									</div>
									<div class="info">
										<div class="left">
											<p>가격</p>
										</div>
										<div class="right">
											<input type="text" placeholder="10000" readonly="readonly"
												value="${rentDetail.rent_product_price}">
										</div>
									</div>
								</div>
							</td>
							<td><input type="number" value="${rentDetail.rent_num}">
							</td>
							<td>
								<p>${rentDetail.rent_product_price * rentDetail.rent_num}</p>
							</td>

						</tr>
					</c:forEach>

				</tbody>

			</table>
		</div>

		<div class="delivery-info">
			<h2>배송자 정보</h2>

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
					<button type="button" id="apply_coupon" onclick="applyCoupon()">선택하기</button>
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
					<button type="button" id="apply_point" onclick="applyPoint()">사용</button>
				</div>
			</div>
		</div>
`
		<div class="form-group">
			<label>최종 결제 금액</label> <input type="number" readonly="readonly"
				value="${rentInfo.total_rent_price}">
		</div>
		<button class="payment-button" id="orderBtn">결제하기</button>
		<button class="payment-button" id="cancelBtn">뒤로가기</button>
	</main>
</body>
</html>