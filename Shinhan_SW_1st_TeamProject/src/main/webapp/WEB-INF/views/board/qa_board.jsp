<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Header</title>
<%-- css --%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<%-- 본문 css --%>
<link rel="stylesheet" href="${path}/resources/css/style.css">
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<%-- 사이드바 css --%>
<link rel="stylesheet" href="${path}/resources/css/mypage.css">
<%-- jquery 연결 --%>
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<style>
body {
	font-family: Arial, sans-serif;
}

.inner {
	width: 80%;
	margin: 0 auto;
}

h1 {
	text-align: center;
	margin-top: 20px;
	font-size: 24px;
}

.review-container {
	margin-top: 40px;
	display: flex;
	justify-content: space-between;
}

.sidebar {
	width: 110px;
	margin-right: 20px;
}

.sidebar ul {
	list-style: none;
	padding: 0;
}

.sidebar ul li {
	margin: 10px 0;
}

.sidebar ul li a {
	text-decoration: none;
	color: #000;
	font-size: 18px;
}

.review-content {
	flex-grow: 1;
	margin-left: 20px;
}

.review-header {
	display: flex;
	align-items: center;
	justify-content: center;
	border-bottom: 2px solid #000;
	padding-bottom: 10px;
}

.review-header h2 {
	margin: 0;
	font-size: 20px;
	font-weight: bold;
}

.review-table {
	width: 100%;
	margin-top: 20px;
	border-collapse: collapse;
}

.review-table th, .review-table td {
	border: 1px solid #ccc;
	padding: 10px;
	text-align: center;
}

.review-table th {
	background-color: #6a0dad;
	color: #fff;
}

.review-table tr:nth-child(even) {
	background-color: #f9f9f9;
}

.accordion-content {
	display: none;
	background-color: #f9f9f9;
}

.accordion-content.active {
	display: table-row;
}

.accordion-content td {
	padding: 10px;
	border-top: 1px solid #ddd;
}

.accordion-content p {
	margin: 0;
}

.accordion-content img {
	max-width: 100px;
	display: block;
	margin: 0 auto 10px;
}

.main-content {
	margin-left: 20px;
	flex-grow: 1;
}

.main-content-header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	border-bottom: 2px solid #000;
	margin-bottom: 20px;
}

.main-content-header h2 {
	font-size: 24px;
	font-weight: bold;
	margin: 0;
}

.main-content-header a {
	font-size: 24px;
	font-weight: bold;
	text-decoration: none;
	color: #000;
}

.faq-list {
	list-style: none;
	padding: 0;
}

.faq-list li {
	margin-bottom: 10px;
	font-size: 18px;
}

.faq-list li a {
	text-decoration: none;
	color: #000;
}

hr {
	margin-bottom: 30px;
}
</style>
</head>

<body>
	<header>
		<div class="header_top inner">
			<div class="leftGnb">
				<h1 class="logo">
					<a href="${path}/"> <img
						src="${path}/resources/images/logo_main.png" alt="매안로고">
					</a>
				</h1>
				<%-- 상품 검색창 --%>
				<form action="${path}/" class="search_form">
					<label for="search_wrap"> <input name="search_input"
						type="search" /> <img
						src="${path}/resources/images/icon_serch.png" alt="돋보기 아이콘"
						class="search_img" />
					</label>
				</form>
			</div>
			<div class="rightGnb">
				<ul>
					<li><a href="${path}/user/login"> <img
							src="${path}/resources/images/icon-login.gif" alt="로그인">로그인
					</a></li>
					<li><a href="${path}/user/signup"><img
							src="${path}/resources/images/icon-sign-in.png" alt="회원가입">회원가입</a>
					</li>
					<li><a href="${path}/customer/myPage.do"><img
							src="${path}/resources/images/icon-user.png" alt="마이페이지">마이페이지</a>
						<%-- 문의 답변오면 나타나는 알림 --%> <%-- <span class="hidden">N</span> --%>
					</li>
					<li><a href="${path}/cart/cart"><img
							src="${path}/resources/images/icon-shopping.png" alt="장바구니">장바구니</a>
					</li>
				</ul>
			</div>
		</div>
		<div class="header_bottom">
			<div class="menu_wrap inner">
				<%-- 메인 메뉴 카테고리 --%>
				<ul class="left_menu">
					<li data-menu="0"><a href="${path}/customer/productlist"
						class="category_name">여성</a></li>
					<li data-menu="1"><a href="${path}/customer/productlist"
						class="category_name">남성</a></li>
					<li data-menu="2"><a href="${path}/customer/productlist"
						class="category_name">키즈</a></li>
					<li data-menu="3"><a href="${path}/customer/productlist"
						class="category_name">럭셔리</a></li>
					<li data-menu="4"><a href="${path}/customer/productlist"
						class="category_name">키즈</a></li>
					<li data-menu="5"><a href="${path}/customer/productlist"
						class="category_name">스포츠</a></li>
					<li data-menu="6"><a href="${path}/customer/productlist"
						class="category_name">가방&신발</a></li>
				</ul>
				<%-- 오른쪽 메뉴 --%>
				<ul class="right_menu">
					<li><a href="javascript:#void" class="highlight">AI추천코디</a></li>
					<li><a href="${path}/customer/productlist" class="highlight">옷대여</a></li>
					<li><a href="${path}/board/qna">Q&A</a></li>
					<li><a href="{path}/board/board">공지사항</a></li>
				</ul>
			</div>
			<%-- 서브 메뉴 부분  --%>
			<div class="menu_pan inner">
				<div class="dropdown_nav">
					<ul>
						<li><a href="#">신상품</a></li>
						<li><a href="#">전체 상품</a></li>
						<li><a href="#">아우터</a></li>
						<li><a href="#">재킷/베스트</a></li>
						<li><a href="#">니트</a></li>
						<li><a href="#">셔츠/블라우스</a></li>
						<li><a href="#">티셔츠</a></li>
						<li><a href="#">원피스</a></li>
						<li><a href="#">팬츠</a></li>
						<li><a href="#">스커트</a></li>
						<li><a href="#">쥬얼리/시계</a></li>
					</ul>
					<ul>
						<li><a href="#">신상품</a></li>
						<li><a href="#">전체 상품</a></li>
						<li><a href="#">정장</a></li>
						<li><a href="#">아우터</a></li>
						<li><a href="#">재킷/베스트</a></li>
						<li><a href="#">니트</a></li>
						<li><a href="#">셔츠/블라우스</a></li>
						<li><a href="#">티셔츠</a></li>
						<li><a href="#">원피스</a></li>
						<li><a href="#">팬츠</a></li>
					</ul>
					<ul>
						<li><a href="#">신상품</a></li>
						<li><a href="#">전체 상품</a></li>
						<li><a href="#">남아</a></li>
						<li><a href="#">여아</a></li>
					</ul>
					<ul>
						<li><a href="#">신상품</a></li>
						<li><a href="#">전체 상품</a></li>
						<li><a href="#">여성의류</a></li>
						<li><a href="#">여성가방/지갑</a></li>
						<li><a href="#">여성슈즈</a></li>
						<li><a href="#">여성 쥬얼리/시계</a></li>
						<li><a href="#">남성의류</a></li>
						<li><a href="#">남성가방/지갑</a></li>
						<li><a href="#">남성슈즈</a></li>
						<li><a href="#">선글라스/안경테</a></li>
					</ul>
					<ul>
						<li><a href="#">신상품</a></li>
						<li><a href="#">전체 상품</a></li>
						<li><a href="#">아우터</a></li>
						<li><a href="#">재킷/베스트</a></li>
						<li><a href="#">니트</a></li>
						<li><a href="#">셔츠/블라우스</a></li>
						<li><a href="#">티셔츠</a></li>
						<li><a href="#">원피스</a></li>
						<li><a href="#">팬츠</a></li>
						<li><a href="#">스커트</a></li>
						<li><a href="#">쥬얼리/시계</a></li>
					</ul>
					<ul>
						<li><a href="#">신상품</a></li>
						<li><a href="#">전체 상품</a></li>
						<li><a href="#">아웃도어/캠핑</a></li>
						<li><a href="#">피트니스</a></li>
					</ul>
					<ul>
						<li><a href="#">신상품</a></li>
						<li><a href="#">전체 상품</a></li>
						<li><a href="#">여성 가방</a></li>
						<li><a href="#">여성 슈즈</a></li>
						<li><a href="#">남성 가방</a></li>
						<li><a href="#">남성 슈즈</a></li>
					</ul>
				</div>
			</div>
		</div>
	</header>
	<script>
		$(function() {
			//$.noConflict(); //제이쿼리 충돌방지
			//메뉴 드롭 다운
			var isFirstHover = true; // 처음 마우스를 올리는지 여부를 추적

			$(".left_menu > li").on("mouseenter", function() {
				var menuIndex = $(this).data("menu"); // data-menu 속성 값을 가져옴

				if (isFirstHover) {
					$(".dropdown_nav ul").stop().animate({
						height : "0"
					}, 500); // 모든 서브메뉴 높이 0으로 설정
					$(".dropdown_nav ul").eq(menuIndex).stop().animate({
						height : "400px"
					}, 500);
					$(".dropdown_nav").stop().animate({
						height : "400px"
					}, 500); // 서브메뉴 표시
					isFirstHover = false; // 이후 마우스 이동 시 애니메이션 제거
				} else {
					$(".dropdown_nav ul").css("height", "0"); // 모든 서브메뉴 높이 0으로 설정
					$(".dropdown_nav ul").eq(menuIndex).css("height", "400px");
					$(".dropdown_nav").css("height", "400px"); // 서브메뉴 표시
				}
			});

			$(".menu_pan").on("mouseleave", function() {
				// 마우스가 떠났을 때 서브메뉴 높이 초기화
				$(".dropdown_nav ul").css("height", "0");
				$(".dropdown_nav").css("height", "0");
				isFirstHover = true; // 마우스를 떠났을 때 다시 애니메이션 활성화
			});

		});
	</script>
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
							<a href="${path}/board/review.do">나의글</a>
						</h3>
						<ul class="myinfo_submenu">
							<li><a href="javascript:#void">문의글</a></li>
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
			<div class="main-content">
				<div class="main-content-header">
					<h2>나의 문의</h2>
					<a href="YOUR_LINK_HERE">+</a>
				</div>
				<ul class="faq-list">
					<li><a href="#">회원 탈퇴는 어떻게 하나요?</a>
						<hr></li>
					<li><a href="#">아이디와 비밀번호가 기억나지 않아요.</a>
						<hr></li>
					<li><a href="#">구매했던 제품과 가격이 달라졌어요. 차액 환불이 되나요?</a>
						<hr></li>
					<li><a href="#">출고가 지연된다는 알림을 받았어요.</a>
						<hr></li>
					<li><a href="#">배송 완료 상품을 받지 못했어요.</a>
						<hr></li>
					<li><a href="#">송장조회 확인이 안되고 있어요.</a>
						<hr></li>
					<li><a href="#">배송 조회는 어떻게 하나요?</a>
						<hr></li>
					<li><a href="#">교차 보상 지폐 제도가 무엇인가요?</a>
						<hr></li>
					<li><a href="#">일반 배송 상품은 언제 배송 되나요?</a>
						<hr></li>
					<li><a href="#">반송장을 입력하라고 하는데, 반송장 입력 버튼이 보이지 않아요.</a>
						<hr></li>
					<li><a href="#">포장(택배) 박스, 상품/상품 박스가 파손되어 배송되었어요.</a>
						<hr></li>
					<li><a href="#">상품을 받았는데 교환하고 싶어요.</a>
						<hr></li>
					<li><a href="#">주문을 취소(환불)하고 싶어요.</a>
						<hr></li>
				</ul>
			</div>
		</div>
	</div>
</body>

</html>
