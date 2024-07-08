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
<script>
function openPopup(url) {
	//팝업 창 열기
    window.open(url, 'popupWindow', 'width=1000,height=1000,scrollbars=yes');
}
</script>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
	<div class="mypage_wrap">
		<div class="myinfo inner">
			<nav>
				<ul>
					<li>
						<h3>
							<a href="${path}/customer/orderlist.do">나의주문</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="${path}/customer/rentlist.do">나의대여</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="${path}/cart/cart.do">장바구니</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="${path}/review/myreview.do">나의글</a>
						</h3>
						<ul class="myinfo_submenu">
							<li><a href="${path}/adminqna/myqna.do">문의글</a></li>
							<li><a href="${path}/review/myreview.do">리뷰</a></li>
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
					<%-- +기호를 클릭할 때 openPopup함수를 호출, javascript:void(0)는 페이지 리로드 방지용 --%>
					<a href="javascript:void(0)" onclick="openPopup('${path}/adminqna/writeqna.do')">+</a>
				</div>
				<ul class="faq-list">
			        <c:forEach items="${adminInq}" var="admin">
			            <li style="position: relative;">
			                <a href="javascript:void(0);" 
			                   onclick="openPopup('${path}/adminqna/updateqna.do?admin_inq_id=${admin.admin_inq_id}')">
			                    ${admin.admin_inq_title}
			                </a>
			                <c:if test="${not empty admin.admin_reply}">
			                    <a href="javascript:void(0);" 
			                       onclick="openPopup('${path}/adminqna/admin_reply.do?admin_inq_id=${admin.admin_inq_id}')" 
			                       style="background-color: green; color: white; border: none; padding: 5px 10px; 
			                              text-decoration: none; position: absolute; right: 0; 
			                              transform: translateY(-50%); border-radius: 10px;">
			                        답변완료
			                    </a>
			                </c:if>
			                <hr>
			            </li>
			        </c:forEach>
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