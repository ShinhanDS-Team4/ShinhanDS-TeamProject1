<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Header</title>
<!-- css -->
<%-- css --%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<%-- 본문 css --%>
<link rel="stylesheet" href="${path}/resources/css/style.css">
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
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

/* 번호 속성 너비 설정 */
.review-table th:nth-child(1) {
	width: 10%; /* 총 테이블 너비의 10% */
}

/* 상품명 속성 너비 설정 */
.review-table th:nth-child(2) {
	width: 20%; /* 총 테이블 너비의 20% */
}

/* 제목 속성 너비 설정 */
.review-table th:nth-child(3) {
	width: 50%; /* 총 테이블 너비의 50% */
}

.review-table th:nth-child(4) {
	width: 20%; /* 총 테이블 너비의 20% */
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
	transition: max-height 0.5s ease-out;
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
</style>
</head>

<body>
	<%@ include file="../common/header.jsp"%>
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
							<li><a href="${path}/adminqna/myqna.do">문의글</a></li>
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
			<div class="review-container inner">
				<div class="review-content">
					<div class="review-header">
						<h2>나의 리뷰</h2>
					</div>
					<div class="review-table-container">
						<table class="review-table">
							<thead>
								<tr>
									<th>번호</th>
									<th>상품명</th>
									<th>제목</th>
									<th>등록일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="reviews" items="${reviews}">
									<tr class="accordion-trigger">
										<td>10</td>
										<td>티셔츠</td>
										<td>${reviews.review_title}</td>
										<td>${reviews.review_date}</td>
									</tr>
									<tr class="accordion-content">
										<td colspan="2"><img src="${reviews.review_img}"
											alt="이미지"></td>
										<td colspan="2">${reviews.review_content}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- JavaScript for accordion functionality -->
    <script>
        // Get all accordion trigger rows
        var accordionTriggers = document.querySelectorAll('.accordion-trigger');

        // Add click event listener to each trigger row
        accordionTriggers.forEach(function (trigger) {
            trigger.addEventListener('click', function () {
                // Toggle the active class on the next element (accordion content)
                var content = trigger.nextElementSibling;
                content.classList.toggle('active');
            });
        });
    </script>
</body>

</html>
