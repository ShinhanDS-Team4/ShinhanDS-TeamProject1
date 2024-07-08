<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자메인</title>
<!-- 본문 css -->
<link rel="stylesheet" href="${path}/resources/css/style.css">
<!-- 헤더,푸터 css -->
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<!-- jquery 연결 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- Slick 불러오기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<!-- Slick 직접 연결 -->
<link rel="stylesheet" href="${path}/resources/slick/slick-theme.css">
<link rel="stylesheet" href="${path}/resources/slick/slick.css">
<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/sellerMain.css" />
<script src="${path}/resources/slick/slick.min.js"></script>

</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
		<aside>
			<ul>
				<li><a onclick="location.href='${path}/seller/MainPage.do'">통계</a></li>
				<li><a onclick="location.href='${path}/seller/PrdList.do'">판매/대여 상품 목록</a></li>
				<li><a onclick="location.href='${path}/seller/DeliveryList.do'">주문/배송</a></li>
				<li><a onclick="location.href='${path}/seller/Q&AList.do'">문의 목록</a></li>
			</ul>
		</aside>

		<section id="section">

			<div class="profile_wrap">
					<h1 class="myinfo_title">마이페이지</h1>
					<div class="profile">
						<div class="profile_info">
							<div class="profile_img">
								<p>WELCOME</p>
							</div>
							<div class="profile_text">
								<h3>
									${member.member_name}님 <span>(${member.member_id})</span> <span class="birthText">${member.birth_date}</span>
								</h3>
								<%-- <div class="profile_text_box">
									<p>
										보유포인트: <span>${myPoints.point != 0 ? myPoints.point : 0 }p</span>
									</p>
									<p>
										회원등급: <span>${myPoints.member_level}</span>
									</p>
									<button class="detail_btn">자세히 보기</button>
								</div>
								<p>
									<a href="${path}/board/myreview.do" class="go_review">작성한 리뷰 보기</a>
								</p>
								<div class="links">
									<a href="javascript:#void">주문내역 <span>${orderCount != 0 ? orderCount : 0} 건</span></a> 
									<a href="javascript:#void">대여내역 <span>${rentCount != 0 ? rentCount : 0} 건</span></a>
									<a href="javascript:#void">문의내역 <span>${inqCount != 0 ? inqCount : 0} 건</span></a>
								</div> --%>
							</div>
						</div>
					</div>
				</div>
		</section>
		<%-- <aside class="notifications">
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
		</aside> --%>
	</main>
</body>
</html>