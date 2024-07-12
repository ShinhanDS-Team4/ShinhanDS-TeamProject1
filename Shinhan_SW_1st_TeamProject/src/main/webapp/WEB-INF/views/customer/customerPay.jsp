<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
	function selectAddr() {
		var selectedRadio = document
				.querySelector('input[name="address"]:checked');
		if (selectedRadio) {
			// 선택된 라디오 버튼의 값 (address ID)을 가져옵니다.
			var addr_num = selectedRadio.value;
			var order_id = $('#orderId').val();
			alert(addr_num);
			$.ajax({
				url : "/shoppingmall/customer/applyAddress.do",
				type : 'POST',
				contentType : 'application/json',
				data : JSON.stringify({
					addr_num : addr_num,
					order_id : order_id
				}),
				success : function(response) {
					if (response === "Address Saved") {
						alert('선택하신 주소가 적용되었습니다');
						location.reload();
					} else {
						alert('선택하신 주소 적용에 실패하였습니다');
					}
				},
				error : function() {
					alert('서버 요청 중 오류가 발생했습니다.');
				}
			});

		} else {
			// 선택된 라디오 버튼이 없을 때의 메시지.
			alert("Not selected");
		}
	}

	function applyCoupon() {
		var selectedCouponId = $('#selectedCoupon').val();
		var orderPrice = $('#orderPrice').text();
		var customerID = '${memberInfo.member_id}';

		console.log(selectedCouponId);
		console.log(orderPrice);
		console.log(customerID);
		

		// 쿠폰 남은 개수 확인
	    $.ajax({
	        url: "${path}/coupons/checkCouponAvailability.do",
	        type: 'POST',
	        contentType: 'application/json',
			data:JSON.stringify({
				couponid : selectedCouponId,
			    customerid : customerID
			}),
	        success: function(response) {
	        	console.log(response);
	        	//쿠폰이 남아있으면 적용 로직 수행
	        	if(response>0){//1
	        		$.ajax({
	        			url : "${path}/customer/applyCoupon.do",
	        			type : 'POST',
	        			contentType : 'application/json',
	        			data : JSON.stringify({
	        				couponid : selectedCouponId,
	        			    customerid : customerID,
	        				orderPrice : orderPrice
	        			}),
	        			success : function(response) {
	        				console.log(response); // 응답 데이터를 로그로 출력하여 확인
							
	        				var discountedPrice = response.discountedPrice;
	        				var discount = response.discount;

	        				console.log(discountedPrice);
	        				console.log(discount);

	        				$('#discountAmount').text(discount);
	        				$('#finalPrice').text(discountedPrice);
	        				$('#couponselectedPrice').val(discountedPrice);
	        				$('#usePoint').val(0);
	        				$('#pointWillUse').text(0);
	        			},
	        			error : function() { 
	        				alert('서버 요청 중 오류가 발생 0');
	        			}
	        		});
	        	} else if(response == -1){ //-1
	        		alert('쿠폰을 사용하지 않습니다.');
	        	
	        		$('#discountAmount').text(0);
    				$('#finalPrice').text(orderPrice);
    				$('#couponselectedPrice').val(orderPrice);
    				$('#usePoint').val(0);
    				$('#pointWillUse').text(0);
	        	
	        	} else{ //0
	        		alert('선택하신 쿠폰을 모두 소진하였습니다.');
	        	}
	        	
	        },
	        error:function(){
	        	 alert('서버 요청 중 오류가 발생 2');
	        }
	    });
	}

	function applyPoint() {
		var availablePoint = parseInt($('#availPoint').val());
		var usePoint = parseInt($('#usePoint').val());
		var couponAppliedPrice = $('#couponselectedPrice').val();

		alert(usePoint);
		alert(couponAppliedPrice);
		
		if(availablePoint-usePoint >=0){
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
					$('#finalPrice').text(pointAppliedPrice);
					$('#pointWillUse').text(usedPoint);
				},
				error : function() {
					alert('서버 요청 중 오류가 발생했습니다.');
				}
			});
		}else{
			alert("보유하신 포인트 범위를 초과하셨습니다.");
		}
	}

	function cancelBtn() {
		var order_id = $('#orderId').val();
		
		alert(order_id);

		$.ajax({
			type : "POST",
			url : "/shoppingmall/customer/cancelOrderPay.do",
			data : {
				order_id : order_id
			},
			xhrFields: {
	            withCredentials: true // 크로스 도메인 요청에서도 쿠키를 포함하여 세션을 유지합니다.
	        },
			success : function(response) {
				if (response === "Canceled") {
					alert("주문을 취소하고 이전 페이지로 돌아갑니다.");
					window.history.back();
				} else {
					alert("주문 취소에 실패하였습니다.")
				}

			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("서버 요청 실패: " + errorThrown);
			}
		});
	}

	$().ready(
			function() {
				var IMP = window.IMP;
				IMP.init('imp31438144'); // 가맹점 식별코드 입력
				$("#orderBtn").on("click",function() {
					console.log("구매버튼");
					
					var order_id = '${orderInfo.order_id}';
					var userid = '${memberInfo.member_id}';
					var username = '${memberInfo.member_name}';
					var phone = '${memberInfo.phone}';
					var merchant_uid = 'orderPay_'+ order_id//DB에 주문ID로 저장될, 고유한 주문 ID
					var amount = $('#finalPrice').text();//결제 금액
					
					var coupon_id=parseInt($('#selectedCoupon').val());
					var point = parseInt($('#pointWillUse').text());
					var finalPrice = parseInt($('#finalPrice').text());

					IMP.request_pay({
						pg : "html5_inicis", // 등록된 pg사 (적용된 pg사는 KG이니시스)
						pay_method : "card",
						merchant_uid : merchant_uid, // 주문 고유 번호
						name : "상품 주문",
						amount : finalPrice,
						buyer_email : '${memberInfo.email}',
						buyer_name : username,
						buyer_tel : phone,
						buyer_addr : "서울특별시 강남구 신사동",
						buyer_postcode : "01181",
					},
					function(rsp) {
						if (rsp.success) {
							alert("결제 완료");
							
							//결제 완료 후, order_id, coupon_id, point, finalPrice를 가지고 sellPaySuccess로 이동
							window.location.href = "${path}/customer/sellPaySuccess.do?order_id=" + encodeURIComponent(order_id)+
									"&coupon_id=" + encodeURIComponent(coupon_id) +
									"&point=" + encodeURIComponent(point)+
									"&finalPrice=" + encodeURIComponent(finalPrice);
						} else {
							var msg = '결제에 실패하였습니다.';
							msg += '에러내용 : '+ rsp.error_msg;
							alert(msg);
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
						<th>주문번호</th>
						<th>상품명</th>
						<th>가격</th>
						<th>구매 수량</th>
						<th>최종가</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="brandProd" items="${brandandProdName}">
					<c:forEach var="orderDetail" items="${orderDetailList}">
						<tr>
							<!-- 주문번호 -->
							<td>
								<p>${orderDetail.order_id}</p>
							</td>
							
                        	
                        	<!-- 브랜드와 상품명 -->
							<td>
								<p>(${brandProd.BRAND}) ${brandProd.PROD_NAME}</p>
							</td>
							
							<!-- 가격 -->
							<td>
								<p>
									<fmt:formatNumber value="${orderDetail.order_product_price}"
										type="number" groupingUsed="true" />
									(원)
								</p>
							</td>
							
							<!-- 구매 수량 -->
							<td>
								<p>${orderDetail.order_num}(개)</p>
							</td>
							
							<!-- 최종가 -->
							<td>
								<p>
									<fmt:formatNumber
										value="${orderDetail.order_product_price * orderDetail.order_num}"
										type="number" groupingUsed="true" />
									(원)
								</p>
							</td>
						</tr>
					</c:forEach>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<div class="delivery-info">
			<h2>배송 정보</h2>

			<div class="form-group-wrap">
				<div>
					<div class="form-group">
						<label for="name">이름</label> <input type="text" id="name"
							name="name" value="${memberInfo.member_name}" readonly="readonly" />
					</div>
					<div class="form-group">
						<label for="phone">휴대폰</label> <input type="text" id="phone"
							name="phone" value="${memberInfo.phone}" readonly="readonly" />
					</div>
					<div class="form-group">
						<label for="addrList">배송지 선택</label>
						<table class="addrListClass">
							<thead>
								<tr>
									<th></th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="address" items="${addrList}">
									<tr>
										<td><input type="radio" name="address"
											value="${address.addr_num}" id="address_${address.addr_num}"
											<c:if test="${address.addr_num == orderInfo.addr_num}">checked</c:if>>
										</td>
										<td>${address.main_address}${address.sub_address}
											${address.detail_address}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<div class="form-group">
						<button type="button" class="select-button" onclick="selectAddr()">배송
							주소 선택</button>
					</div>
					<div class="form-group">
						<label for="coupon">쿠폰 선택</label> <select name="selectedCoupon"
							id="selectedCoupon">
							<option value=0>선택 안함</option>
							<c:forEach var="coupon" items="${couponList}">
								<option value="${coupon.coupon_id}">${coupon.coupon_name}</option>
							</c:forEach>
						</select>
						<!-- Hidden input to store selected coupon ID -->

						<input type="hidden" id="totalPrice" name="totalPrice"
							value="${orderInfo.total_price}" /> <input type="hidden"
							id="orderId" name="orderId" value="${orderInfo.order_id}" />
						<div class="buttons">
							<button type="button" class="select-button" id="apply_coupon"
								onclick="applyCoupon()">선택하기</button>
						</div>
					</div>


					<div class="form-group">
						<label for="pointLeft">보유 포인트</label> <input id="availPoint" type="number"
							value="${customerInfo.point}" readonly="readonly">
					</div>
					<div class="form-group">
						<label for="pointLeft">사용할 포인트</label> <input type="number"
							id="usePoint" name="usePoint" value="0">
						<div class="buttons">
							<button type="button" class="select-button" id="apply_point"
								onclick="applyPoint()">사용</button>
						</div>
					</div>

					<!-- hidden 처리되어 있는 쿠폰 적용 가격 -->
					<input id="couponselectDiscount" type="hidden"
						value="${couponselectDiscount}" readonly="readonly"> <input
						id="pointUseDiscount" type="hidden" value="0" readonly="readonly">

					<input id="couponselectedPrice" type="hidden"
						value="${couponSelectedPrice}" readonly="readonly"> <input
						id="pointUsedPrice" type="hidden" value="0" readonly="readonly">

					<div class="form-group">
						<input type="hidden" value="${orderInfo.total_price}"
							readonly="readonly">
					</div>
				</div>
				<div class="orderPay-info-box">
					<h3>결제 내용</h3>
					<div>
						<div>
							<div class="orderPay-info-text">
								<p>가격:</p>
								<p id="orderPrice">${orderInfo.total_price}</p>
							</div>
							<div class="orderPay-info-text">
								<p>배송비:</p>
								<p>0원</p>
							</div>
							<div class="orderPay-info-text">
								<p>쿠폰 할인 금액</p>
								<p id="discountAmount">0</p>
							</div>
							<div class="orderPay-info-text">
								<p>사용 포인트</p>
								<p id="pointWillUse">0</p>
							</div>
						</div>
						<div class="orderPay-info-totalPrice">
							<p>최종 결제 금액</p>
							<p id="finalPrice">
								<fmt:formatNumber value="${orderInfo.total_price}" type="number"
									groupingUsed="true"/>
							</p>
						</div>
					</div>
				</div>
			</div>
			<div class="payment-group">
				<button class="payment-button" id="orderBtn">결제하기</button>
				<button class="payment-button" id="cancelBtn" onclick="cancelBtn()">뒤로가기</button>
			</div>
		</div>
	</main>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>