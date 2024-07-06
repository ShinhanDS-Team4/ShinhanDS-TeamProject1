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
		var orderid = $('#orderId').val();
		alert(selectedCouponId);
		alert(orderid);

		$.ajax({
			url : "/shoppingmall/customer/applyCoupon.do",
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

	function applyPoint() {
		var usePoint = $('#usePoint').val();
		var orderid = $('#orderId').val();

		alert(usePoint);
		alert(orderid);

		$.ajax({
			url : "/shoppingmall/customer/applyPoint.do",
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

	$("cancelBtn").on("click", function() {
		var order_id = $('#orderId').val();

		$.ajax({
			type : "POST",
			url : "/shoppingmall/customer/cancelOrderPay.do",
			data : {
				"order_id" : order_id
			},
			success : function(response) {
				if (response === "Canceled") {
					alert("주문을 취소하고 이전 페이지로 돌아갑니다.");
					history.back();
				} else {
					alert("주문 취소에 실패하였습니다.")
				}

			},
			error : function(jqXHR, textStatus, errorThrown) {
				alert("서버 요청 실패: " + errorThrown);
			}
		});
	});

	$().ready(function() {
		var IMP = window.IMP;
		IMP.init('imp31438144'); // 가맹점 식별코드 입력

		$("#orderBtn").on("click", function(){
			alert("구매버튼");
			var order_id = '${orderInfo.order_id}';
			var userid = '${memberInfo.member_id}';
			var username = '${memberInfo.member_name}';
			var phone = '${memberInfo.phone}';
			var merchant_uid = 'orderPay_'+ order_id//DB에 주문ID로 저장될, 고유한 주문 ID
			var amount = '${orderInfo.total_price}';//결제 금액
					
			IMP.request_pay({
				pg : "html5_inicis", // 등록된 pg사 (적용된 pg사는 KG이니시스)
				pay_method : "card",
				merchant_uid : merchant_uid, // 주문 고유 번호
				name : "상품 주문",
				amount : '${orderInfo.total_price}',
				buyer_email : '${memberInfo.email}',
				buyer_name : username,
				buyer_tel : phone,
				buyer_addr : "서울특별시 강남구 신사동",
				buyer_postcode : "01181",
			},function(rsp){
				if(rsp.success){
					alert("결제 완료");
					window.location.href = "/shoppingmall/customer/sellPaySuccess?order_id="+encodeURIComponent(order_id);
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
						<th>상품정보</th>
						<th>구매 수량</th>
						<th>최종가</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="orderDetail" items="${orderDetailList}">
						<tr>
							<td>
								<div class="product-details">
									<div class="info">
										<div class="left">
											<p>상품명</p>
										</div>
										<div class="right">
											<input type="text" placeholder="덩크로우" readonly="readonly"
												value="${orderDetail.s_stock_id}">
										</div>
									</div>
									<div class="info">
										<div class="left">
											<p>가격</p>
										</div>
										<div class="right">
											<input type="text" placeholder="10000" readonly="readonly"
												value="${orderDetail.order_product_price}">
										</div>
									</div>
								</div>
							</td>
							<td><p class="class">${orderDetail.order_num}</p></td>
							<td>
								<p>${orderDetail.order_product_price * orderDetail.order_num}</p>
							</td>

						</tr>
					</c:forEach>

				</tbody>

			</table>
		</div>



		<div class="delivery-info">
			<h2>배송 정보</h2>

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
							<th></th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="address" items="${addrList}">
							<tr>
								<td><input type="radio" name="address"
									value="${address.addr_num}" id="address_${address.addr_num}"
									<c:if test="${address.addr_num == selectedAddress}">checked</c:if>>
								</td>
								<td>${address.addr_num}</td>
								<td>${address.main_address}</td>
								<td>${address.sub_address}</td>
								<td>${address.detail_address}</td>
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
					<option value="선택안함">선택 안함</option>
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
				<label for="pointLeft">보유 포인트</label> <input type="number"
					value="${customerInfo.point}" readonly="readonly">
			</div>
			<div class="form-group">
				<label for="pointLeft">사용할 포인트</label> <input type="number"
					id="usePoint" name="usePoint">
				<div class="buttons">
					<button type="button" class="select-button" id="apply_point"
						onclick="applyPoint()">사용</button>
				</div>
			</div>
		</div>

		<div class="form-group">
			<label>최종 결제 금액</label> <input type="number"
				value="${orderInfo.total_price}" readonly="readonly">
		</div>
		<div class="payment-group">
			<button class="payment-button" id="orderBtn">결제하기</button>
			<button class="payment-button" id="cancelBtn">뒤로가기</button>
		</div>

	</main>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>