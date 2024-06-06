<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<%-- css --%>
<link rel="stylesheet" href="${path}/resources/css/mypage.css">
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<%-- jquery 연결 --%>
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
	<c:set var="path" value="${pageContext.servletContext.contextPath}" />
	<%--  <%@ include file="common/header.jsp" %> --%>
	<%-- 마이페이지 : 메인 --%>
	<div class="mypage_wrap">
		<div class="myinfo inner">
			<nav>
				<ul>
					<li>
						<h3>
							<a href="#">나의주문</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="#">나의대여</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="#">장바구니</a>
						</h3>
					</li>
					<li>
						<h3>
							<a href="#">나의글</a>
						</h3>
						<ul class="myinfo_submenu">
							<li><a href="#">문의글</a></li>
							<li><a href="#">리뷰</a></li>
						</ul>
					</li>
					<li>
						<h3>
							<a href="#">회원정보</a>
						</h3>
						<ul class="myinfo_submenu">
							<li><a href="#">정보수정</a></li>
							<li><a href="#">회원탈퇴</a></li>
						</ul>
					</li>
				</ul>
			</nav>
			<!-- 회원 탈퇴  -->
			<div class="mypage_here">
				<div class="section_wrap">
					<h1 class="myinfo_title">회원 탈퇴</h1>
					<div class="section myinfo_update">
						<h2 class="member_cancel">회원 탈퇴</h2>
						<div class="pw-check">
							<p>회원 탈퇴를 위해 비밀번호를 입력 하세요.</p>
							<input type="password" placeholder="비밀번호를 입력 해주세요."
								class="pw-check_input">
							<div>
								<button class="cancel">취소</button>
								<button class="confirm button">확인</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>