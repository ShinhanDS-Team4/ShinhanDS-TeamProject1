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

<script>
	$().ready(function() {
				var IMP = window.IMP;
				IMP.init('imp31438144'); // 가맹점 식별코드 입력
				$("#orderBtn").on("click",function() {
					alert("구매버튼");
					var userid = "bih63879";
					var username = "백인혁";
					var phone = "01075528293";

					var merchant_uid = "O" new Date().getTime();//DB에 주문ID로 저장될, 고유한 주문 ID
					var amount = 1;//결제 금액
					$.ajax({
						type : "POST",
						url : "/shoppingmall/customer/preparePayment",
						data : {
							"merchantUid" : merchant_uid,
							"amount" : amount
						},
						success : function(response) {
							if (response === "Payment amount registered successfully") {
								alert("결제금액 사전 등록 완료");
								//여기에서 이니시스 결제
								IMP.request_pay({
									pg : "html5_inicis", // 등록된 pg사 (적용된 pg사는 KG이니시스)
									pay_method : "card",
									merchant_uid : merchant_uid, // 주문 고유 번호
									name : "노르웨이 회전 의자",
									amount : 1,
									buyer_email : "beakinhyeok998@gmail.com",
									buyer_name : "백인혁",
									buyer_tel : "010-4242-4242",
									buyer_addr : "서울특별시 강남구 신사동",
									buyer_postcode : "01181",
								},function(response) {
									if (response.success) {
										$.ajax({
											type : "POST",
											url : "/shoppingmall/customer/verifyPayment",
											data : {
												"imp_uid" : response.imp_uid,
												"merchant_uid" : response.merchant_uid
											},
											success : function(
													if (verificationResult === "success") {
														alert("검증에서 이상 없음. 결제 완료");
														window.location.href = "/shoppingmall/customer/orderSuccess";
													} else {
														alert("검증에서 이상 발생. 결제 취소");
													}
											},
											error : function(jqXHR,textStatus,errorThrown) {
												alert("결제 검증 요청 실패: "+ errorThrown);
											}
										});
									} else {
										alert("결제에 실패하였습니다. 에러: "+ response.error_msg);
									}
								});
							} else {alert("사전결제 등록 실패")}
						},error : function(jqXHR,textStatus,errorThrown) {
							alert("결제 금액 사전 등록 요청 실패: "+ errorThrown);}
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
						<th></th>
						<th>상품정보</th>
						<th>구매 수량</th>
						<th>최종가</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="orderDetail" items="${orderDetailList}">
						<tr>
							<td><img class="productIMG" src="product1.jpg" alt="제품 이미지">
							</td>
							<td>
								<div class="product-details">
									<div class="info">
										<div class="left">
											<p>브랜드명</p>
										</div>
										<div class="right">
											<input type="text" placeholder="나이키">
										</div>
									</div>
									<div class="info">
										<div class="left">
											<p>상품명</p>
										</div>
										<div class="right">
											<input type="text" placeholder="덩크로우"
												value="${orderDetail.orderdetail_id}">
										</div>
									</div>
									<div class="info">
										<div class="left">
											<p>가격</p>
										</div>
										<div class="right">
											<input type="text" placeholder="10000"
												value="${orderDetail.order_product_price}">
										</div>
									</div>
								</div>
							</td>
							<td><input type="number" value="${orderDetail.order_num}">
							</td>
							<td>
								<p>${orderDetail.order_product_price * orderDetail.order_num}</p>
							</td>

						</tr>
					</c:forEach>
					<tr>
						<td><img class="productIMG" src="product1.jpg" alt="제품 이미지">
						</td>
						<td>
							<div class="product-details">
								<div class="info">
									<div class="left">
										<p>브랜드명</p>
									</div>
									<div class="right">
										<input type="text" placeholder="나이키">
									</div>
								</div>
								<div class="info">
									<div class="left">
										<p>상품명</p>
									</div>
									<div class="right">
										<input type="text" placeholder="덩크로우">
									</div>
								</div>
								<div class="info">
									<div class="left">
										<p>옵션</p>
									</div>
									<div class="right">
										<input type="text" placeholder="270_Black">
									</div>
								</div>
								<div class="info">
									<div class="left">
										<p>가격</p>
									</div>
									<div class="right">
										<input type="text" placeholder="150000">
									</div>
								</div>
							</div>
						</td>
						<td>
							<p>3000</p>
						</td>
						<td>
							<p>153000</p>
						</td>
					</tr>

					<tr>
						<td><img class="productIMG" src="product1.jpg" alt="제품 이미지">
						</td>
						<td>
							<div class="product-details">
								<div class="info">
									<div class="left">
										<p>브랜드명</p>
									</div>
									<div class="right">
										<input type="text" placeholder="나이키">
									</div>
								</div>
								<div class="info">
									<div class="left">
										<p>상품명</p>
									</div>
									<div class="right">
										<input type="text" placeholder="덩크로우">
									</div>
								</div>
								<div class="info">
									<div class="left">
										<p>옵션</p>
									</div>
									<div class="right">
										<input type="text" placeholder="270_Black">
									</div>
								</div>
								<div class="info">
									<div class="left">
										<p>가격</p>
									</div>
									<div class="right">
										<input type="text" placeholder="150000">
									</div>
								</div>
							</div>
						</td>
						<td>
							<div class="coupon">
								<select>
									<option>쿠폰 선택창</option>
									<option>쿠폰1</option>
									<option>쿠폰2</option>
									<option>쿠폰3</option>
								</select>
							</div>
						</td>
						<td>
							<p>3000</p>
						</td>
						<td>
							<p>153000</p>
						</td>
					</tr>

				</tbody>

			</table>
		</div>



		<div class="delivery-info">
			<h2>배송지 정보</h2>
			<form>
				<div class="form-group">
					<label for="name">이름</label> <input type="text" id="name"
						name="name" value="${memberInfo.member_name}" />
				</div>
				<div class="form-group">
					<label for="phone">휴대폰</label> <input type="text" id="phone"
						name="phone" value="${memberInfo.phone}" />
				</div>
				<div class="form-group">
					<label for="main_address">배송주소</label> <input type="text"
						id="main_address" name="main_address" />
					<button type="button" class="address-button">주소 찾기</button>
				</div>
				<div class="form-group">
					<label for="address">상세주소</label> <input type="text"
						id="detail_address" name="detail_address" />
				</div>
				<div class="form-group">
					<input type="checkbox" id="save-address" name="save-address" /> <label
						for="save-address">기본 배송지로 저장</label>
				</div>

				<div class="form-group">
					<label for="couponSelect">쿠폰 선택</label> <select>
						<option></option>
					</select>
				</div>
			</form>
		</div>

		<div class="order-total">
			<p>총 상품금액:&nbsp;&nbsp;${orderInfo.total_price} 원</p>
			<p>&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;</p>
			<p>총 할인금액:&nbsp;&nbsp;39,200원</p>
			<p>&nbsp;&nbsp;&nbsp;=&nbsp;&nbsp;&nbsp;</p>
			<p>총 주문금액:&nbsp;&nbsp;744,800원</p>
		</div>

		<div class="terms-and-payment">
			<h2>구매 및 결제대행서비스 이용약관</h2>
			<form>
				<div class="form-group">
					<input type="checkbox" id="agree1" name="agree1" /> <label
						for="agree1">개인정보 수집 및 이용 동의 <a href="#">약관보기</a></label>
				</div>
				<div class="form-group">
					<input type="checkbox" id="agree2" name="agree2" /> <label
						for="agree2">개인정보 제3자 제공 동의 <a href="#">약관보기</a></label>
				</div>
				<div class="form-group">
					<input type="checkbox" id="agree3" name="agree3" /> <label
						for="agree3">전자금융거래 이용약관 <a href="#">약관보기</a></label>
				</div>
				<div class="form-group">
					<input type="checkbox" id="agree4" name="agree4" /> <label
						for="agree4">주소정보 수집 및 이용 동의 <a href="#">약관보기</a></label>
				</div>
				<div class="form-group">
					<input type="checkbox" id="agree5" name="agree5" /> <label
						for="agree5">구매확인서 <a href="#">약관보기</a></label>
				</div>

			</form>
			<button class="payment-button" id="orderBtn">결제하기</button>
		</div>
	</main>
</body>
</html>