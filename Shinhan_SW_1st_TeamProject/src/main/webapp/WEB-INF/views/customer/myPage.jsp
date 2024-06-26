<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고객 마이페이지-프로필</title>
<%-- css --%>
<link rel="stylesheet" href="${path}/resources/css/mypage.css">
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<%-- jquery 연결 --%>
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<style>
.hidden{
	display: none;
}
</style>
<body>

	<%@ include file="../common/header.jsp" %>
	<%-- 마이페이지 : 메인 --%>
	<div class="mypage_wrap">
		<div class="myinfo inner">
			<nav>
				<ul>
					<li>
						<h3>
							<a href="${path}/customer/orderlist">나의주문</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="${path}/customer/rentlist">나의대여</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="${path}/cart/cart">장바구니</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="${path}/board/reviewjsp">나의글</a>
						</h3>
						<ul class="myinfo_submenu">
							<li><a href="${path}/qna/myqna.do">문의글</a></li>
							<li><a href="${path}/board/reviewjsp">리뷰</a></li>
						</ul>
					</li>
					<li>
						<h3>
							<a href="javascript:#void">회원정보</a>
						</h3>
						<ul class="myinfo_submenu">
							<li><a href="${path}/customer/myInfoUpdate.do">정보수정</a></li>
							<li><a href="${path}/customer/memberDelete.do">회원탈퇴</a></li>
						</ul>
					</li>
				</ul>
			</nav>
			<div class="mypage_here">
				<%-- 프로필 --%>
				<div class="profile_wrap">
					<h1 class="myinfo_title">마이페이지</h1>
					<div class="profile">
						<div class="profile_info">
							<div class="profile_img">
								<p>WELCOME</p>
							</div>
							<div class="profile_text">
								<h3>
									세이렌 님 <span>(saren123)</span>
								</h3>
								<div class="profile_text_box">
									<p>
										보유포인트: <span>5000p</span>
									</p>
									<p>
										회원등급: <span>Gold</span>
									</p>
									<button class="detail_btn">자세히 보기</button>
								</div>
								<p>
									<a href="${path}/board/reviewjsp" class="go_review">작성한 리뷰 보기</a>
								</p>
								<div class="links">
									<a href="#">주문내역 <span>1 건</span></a> 
									<a href="#">대여내역 <span>1 건</span></a> 
									<a href="#">문의내역 <span>1 건</span></a>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%-- 주문 내역 --%>
				<div class="profile_wrap">
					<h1 class="myinfo_title">주문 내역</h1>
					<div class="info_text">
						<%-- 주문 내역 없을 경우 --%>
						<p class="hidden">현재 진행중인 주문 내역이 없습니다.</p>
						<%-- 주문 내역 있는 경우 --%>
						<table class="order_table">
							<thead>
								<tr>
									<th>상품</th>
									<th>상품정보</th>
									<th>할인/혜택</th>
									<th>배송 정보</th>
									<th>주문금액</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><img src="./images/product1.png" alt="상품 이미지"
										width="100"></td>
									<td class="product-info"><strong>브랜드명</strong><br>
										상품이름입니다상품이름상품이름<br> 색상(남색), 크기(L)<br> 1개</td>
									<td>39,200원<br>할인쿠폰(5%)
									</td>
									<td>무료배송</td>
									<td class="price">744,800원</td>
								</tr>
								<tr>
									<td><img src="./images/product1.png" alt="상품 이미지"
										width="100"></td>
									<td class="product-info"><strong>브랜드명</strong><br>
										상품이름입니다상품이름상품이름<br> 색상(남색), 크기(L)<br> 1개</td>
									<td>39,200원<br>할인쿠폰(5%)
									</td>
									<td>무료배송</td>
									<td class="price">744,800원</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
				<%-- 대여 내역 --%>
				<div class="profile_wrap">
					<h1 class="myinfo_title">대여 내역</h1>
					<div class="info_text">
						<%-- 대여 내역 없을 경우 --%>
						<p>현재 진행중인 대여 내역이 없습니다.</p>
						<%-- 대여 내역 있을 경우 table 생성 --%>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>