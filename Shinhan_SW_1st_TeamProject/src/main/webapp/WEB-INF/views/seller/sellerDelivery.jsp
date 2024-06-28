<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자_판매&배송</title>
<!-- 본문 css -->
<link rel="stylesheet" href="${path}/resources/css/style.css">
<!-- 헤더,푸터 css -->
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<!-- jquery 연결 -->
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Slick 불러오기 -->

<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/seller_Delivery.css" />
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>

		<aside>
			<ul>
				<li><a onclick="location.href='${path}/seller/MainPage.do'">통계</a></li>
				<li><a onclick="location.href='${path}/seller/PrdList.do'">판매/대여
						상품 목록</a></li>
				<li><a onclick="location.href='${path}/seller/DeliveryList.do'">주문/배송</a></li>
				<li><a onclick="location.href='${path}/seller/Q&AList.do'">문의
						목록</a></li>
			</ul>
		</aside>
		<section>
			<h2>마이페이지</h2>
			<hr />
			<div class="user-info">
				<p>김철수</p>
				<p>573-50-00882</p>
			</div>
			<!-- 주문/배송 -->
			<div class="product-list">
				<h3>판매 상품 주문 리스트</h3>
				<table>
					<thead>
						<tr>
							<th></th>
							<th>주문상세ID</th>
							<th>상품재고ID</th>
							<th>가격</th>
							<th>주문 수량</th>
							<th>주문상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="order_detail" items="${orderDetailList}">
							<tr>
								<td><input type="checkbox"/></td>
								<td>${order_detail.orderdetail_id}</td>
								<td>${order_detail.s_stock_id}</td>
								<td>${order_detail.order_product_price}</td>
								<td>${order_detail.order_num}</td>
								<td>${order_detail.order_state}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class="actions">
					<select>
						<option>결제대기</option>
						<option>결제완료</option>
						<option>배송준비중</option>
						<option>배송중</option>
						<option>배송완료</option>
						<option>교환요청</option>
						<option>교환완료</option>						
						<option>환불요청</option>
						<option>환불완료</option>
					</select>
					<button>일괄처리</button>
					<button>선택 내역 삭제</button>
				</div>
			</div>
			
			<!-- 대여 -->
			<div class="product-list">
				<h3>대여 상품 주문 리스트</h3>
				<table>
					<thead>
						<tr>
							<th></th>
							<th>주문상세ID</th>
							<th>상품재고ID</th>
							<th>가격</th>
							<th>주문 수량</th>
							<th>주문상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="rent_detail" items="${rentDetailList}">
							<tr>
								<td><input type="checkbox"/></td>
								<td>${rent_detail.rentdetail_id}</td>
								<td>${order_detail.r_stock_id}</td>
								<td>${order_detail.rent_product_price}</td>
								<td>${order_detail.rent_num}</td>
								<td>${order_detail.rent_state}</td>
							</tr>
						</c:forEach>
						<!-- <tr>
							<td><input type="checkbox" /></td>
							<td><a href="#">1187</a></td>
							<td>78000</td>
							<td>결제대기</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td><a href="#">1188</a></td>
							<td>78000</td>
							<td>결제대기</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td><a href="#">1189</a></td>
							<td>78000</td>
							<td>결제대기</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td><a href="#">1190</a></td>
							<td>78000</td>
							<td>결제대기</td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td><a href="">1191</a></td>
							<td>78000</td>
							<td>결제대기</td>
						</tr> -->
					</tbody>
				</table>
				<div class="actions">
					<select>
						<option>결제대기</option>
						<option>결제완료</option>
						<option>배송준비중</option>
						<option>배송중</option>
						<option>배송완료</option>
						<option>교환요청</option>
						<option>교환완료</option>						
						<option>환불요청</option>
						<option>환불완료</option>
					</select>
					<button>일괄처리</button>
					<button>선택 내역 삭제</button>
				</div>
			</div>
		</section>
		<aside class="notifications">
			<div class="notify_icon">
				<img src="${path}/resources/images/bell.png" alt="알림"
					class="bell_icon" />
				<div class="icon">
					<span>15</span>
				</div>
				<div class="popup">
					<p>결제 완료 주문 : 5건</p>
					<p>결제 대기 주문 : 23건</p>
				</div>
			</div>
		</aside>
	</main>
	<script>
		document.querySelector(".notifications .bell_icon").addEventListener(
				"click",
				function() {
					document.querySelector(".notifications .popup").classList
							.toggle("show");
				});
	</script>
	<style>
.notifications .popup.show {
	display: block;
}
</style>
</body>
</html>