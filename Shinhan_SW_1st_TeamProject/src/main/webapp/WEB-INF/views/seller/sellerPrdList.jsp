<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자판매물품리스트</title>
<!-- 본문 css -->
<link rel="stylesheet" href="${path}/resources/css/style.css">
<!-- 헤더,푸터 css -->
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">

<!-- jquery 연결 -->
    <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/seller_prdList.css" />

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
		<section id="section">
			<h2>마이페이지</h2>
			<hr />
			<div class="user-info">
				<p>김철수</p>
				<p>573-50-00882</p>
			</div>
			<!--판매 상품 목록 리스트-->
			<div class="product-list">
				<h3>판매 상품 목록</h3>
				<table>
					<thead>
						<tr>
							<th></th>
							<th>상품등록번호</th>
							<th>상품명</th>
							<th>가격</th>
							<th>재고량</th>
							<th>수정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="sStock" items="${stockSList}">
							<tr>
								<td>${sStock.stockid}</td>
								<td>${sStock.prd_name}</td>
								<td>${sStock.prod_price}</td>
								<td>${sStock.s_p_stock}</td>
								<td><button>수정</button></td>
							</tr>
						</c:forEach>
						<!-- <tr>
							<td><input type="checkbox" /></td>
							<td><input type="text" placeholder="상품번호1" /></td>
							<td><input type="text" placeholder="상품명1" /></td>
							<td><input type="number" placeholder="35000" /></td>
							<td><input type="number" placeholder="35" /></td>
							<td><button>수정</button></td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td><input type="text" placeholder="상품번호1" /></td>
							<td><input type="text" placeholder="상품명1" /></td>
							<td><input type="number" placeholder="35000" /></td>
							<td><input type="number" placeholder="35" /></td>
							<td><button>수정</button></td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td><input type="text" placeholder="상품번호1" /></td>
							<td><input type="text" placeholder="상품명1" /></td>
							<td><input type="number" placeholder="35000" /></td>
							<td><input type="number" placeholder="35" /></td>
							<td><button>수정</button></td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td><input type="text" placeholder="상품번호1" /></td>
							<td><input type="text" placeholder="상품명1" /></td>
							<td><input type="number" placeholder="35000" /></td>
							<td><input type="number" placeholder="35" /></td>
							<td><button>수정</button></td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td><input type="text" placeholder="상품번호1" /></td>
							<td><input type="text" placeholder="상품명1" /></td>
							<td><input type="number" placeholder="35000" /></td>
							<td><input type="number" placeholder="35" /></td>
							<td><button>수정</button></td>
						</tr> -->
					</tbody>
				</table>
				<div class="actions">
					<button>선택 상품 삭제</button>
					
				</div>
			</div>
			<div class="product-list">
				<h3>대여 상품 목록</h3>
				<table>
					<thead>
						<tr>
							<th></th>
							<th>상품등록번호</th>
							<th>상품명</th>
							<th>가격</th>
							<th>재고량</th>
							<th>수정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="rStock" items="${stockRList}">
							<tr>
								<td>${rStock.stockid}</td>
								<td>${rStock.prd_name}</td>
								<td>${rStock.prod_price}</td>
								<td>${rStock.r_p_stock}</td>
								<td><button>수정</button></td>
							</tr>
						</c:forEach>
						<!-- <tr>
							<td><input type="checkbox" /></td>
							<td><input type="text" placeholder="상품번호1" /></td>
							<td><input type="text" placeholder="상품명1" /></td>
							<td><input type="number" placeholder="35000" /></td>
							<td><input type="number" placeholder="35" /></td>
							<td><button>수정</button></td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td><input type="text" placeholder="상품번호1" /></td>
							<td><input type="text" placeholder="상품명1" /></td>
							<td><input type="number" placeholder="35000" /></td>
							<td><input type="number" placeholder="35" /></td>
							<td><button>수정</button></td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td><input type="text" placeholder="상품번호1" /></td>
							<td><input type="text" placeholder="상품명1" /></td>
							<td><input type="number" placeholder="35000" /></td>
							<td><input type="number" placeholder="35" /></td>
							<td><button>수정</button></td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td><input type="text" placeholder="상품번호1" /></td>
							<td><input type="text" placeholder="상품명1" /></td>
							<td><input type="number" placeholder="35000" /></td>
							<td><input type="number" placeholder="35" /></td>
							<td><button>수정</button></td>
						</tr>
						<tr>
							<td><input type="checkbox" /></td>
							<td><input type="text" placeholder="상품번호1" /></td>
							<td><input type="text" placeholder="상품명1" /></td>
							<td><input type="number" placeholder="35000" /></td>
							<td><input type="number" placeholder="35" /></td>
							<td><button>수정</button></td>
						</tr> -->
					</tbody>
				</table>
				<div class="actions">
					<button>선택 상품 삭제</button>
					
				</div>
			</div>
			<button onclick="location.href='${path}/seller/AddProduct.do'">상품
						등록</button>
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