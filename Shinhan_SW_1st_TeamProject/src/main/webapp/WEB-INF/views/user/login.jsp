<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<head>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 페이지</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* 기존 스타일 그대로 유지 */
body {
	font-family: Arial, sans-serif;
	background-color: #ffffff;
	color: #fff;
	margin: 0;
	padding: 0;
	display: flex;
	flex-direction: column;
	align-items: center;
}

header {
	background-color: #fff;
	width: 100%;
	padding: 10px 0;
}

header .logo {
	font-size: 2em;
	font-weight: bold;
}

.login-container {
	background-color: #ffffff;
	color: #000;
	width: 400px;
	padding: 20px;
	border-radius: 10px;
	margin: 50px 0;
	text-align: center;
}

.login-container h1 {
	margin-bottom: 20px;
}

.login-container .tab {
	display: flex;
	justify-content: center;
	margin-bottom: 20px;
}

.login-container .tab div {
	padding: 10px 80px;
	cursor: pointer;
}

.login-container .tab .active {
	border-bottom: 2px solid #000;
}

.login-container form {
	display: none;
}

.login-container form.active {
	display: block;
}

.login-container .input-group {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 10px;
}

.login-container .input-fields {
	display: flex;
	flex-direction: column;
	width: calc(100% - 110px); /* 아이디와 비밀번호 필드의 너비를 동일하게 조정 */
}

.login-container input[type="text"], .login-container input[type="password"]
	{
	width: 100%; /* 입력 필드의 너비를 100%로 설정 */
	padding: 10px;
	margin: 5px 0;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box; /* 패딩과 테두리를 너비에 포함 */
}

.login-container input[type="checkbox"] {
	margin-right: 5px;
}

.login-container .login-btn {
	background-color: #000;
	color: #fff;
	padding: 10px;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	height: 87px; /* 버튼 높이를 필드 높이와 맞춤 */
	width: 100px;
	margin-left: 10px; /* 버튼과 입력 필드 사이의 간격을 조정 */
}

.login-container .login-btn:hover {
	background-color: #444;
}

.login-container .links {
	display: flex;
	justify-content: space-between;
	margin-top: 30px;
	padding: 30px;
	border: none;
	background-color: #D9D9D9;
}

.login-container .links a {
	color: #000;
	font-size: 12px;
	text-decoration: none;
}

.login-container .checkbox-container {
	display: flex;
	align-items: left;
	justify-content: flex-start; /* 왼쪽 정렬 */
	margin-top: 10px;
}

.login-container .input-fields .password-container {
	position: relative; /* 아이콘을 비밀번호 필드 내부에 위치시키기 위해 추가 */
	width: 100%;
}

.login-container .input-fields .password-container input {
	width: 100%; /* 비밀번호 필드의 너비를 100%로 설정 */
	padding-right: 40px; /* 아이콘 공간 확보 */
}

.login-container .input-fields .password-container .toggle-password {
	position: absolute;
	right: 10px;
	top: 50%; /* 수직 중앙 정렬 */
	transform: translateY(-50%); /* 수직 중앙 정렬 */
	cursor: pointer;
	width: 20px;
	height: 20px;
}

footer {
	background-color: #333;
	color: white;
	text-align: center;
	padding: 20px 0;
	width: 100%;
	margin-top: 50px;
}

footer .footer-line {
	margin: 10px 0;
}

footer .footer-text {
	margin: 5px 0;
}

footer .footer-logo {
	font-size: 2em;
	font-weight: bold;
	margin-top: 20px;
}

footer .footer-links {
	margin-top: 10px;
}

footer .footer-links a {
	color: #fff;
	text-decoration: none;
	margin: 0 10px;
}
</style>
<script>
$(function() {
		// 로컬 스토리지에서 저장된 아이디 불러오기
		if (localStorage.getItem('rememberMe') === 'true') {
			$('#remember-me').prop('checked', true);
			$('#member_id').val(localStorage.getItem('member_id'));
		}

		// 로그인 폼 제출 시 아이디 저장
		$('#customer-form').on('submit', function() {
			if ($('#remember-me').is(':checked')) {
				localStorage.setItem('rememberMe', true);
				localStorage.setItem('member_id', $('#member_id').val());
			} else {
				localStorage.removeItem('rememberMe');
				localStorage.removeItem('member_id');
			}
		});
		
		// 로그인 폼 제출 시 아이디 저장, 판매자용
		$('#seller-form').on('submit', function() {
			if ($('#remember-me').is(':checked')) {
				localStorage.setItem('rememberMe', true);
				localStorage.setItem('member_id', $('#member_id').val());
			} else {
				localStorage.removeItem('rememberMe');
				localStorage.removeItem('member_id');
			}
		});
	});

	// 비밀번호 토글 기능
	function togglePassword(id) {
		const passwordInput = document.getElementById(id);
		const type = passwordInput.getAttribute('type') === 'password' ? 'text'
				: 'password';
		passwordInput.setAttribute('type', type);
	}
	
    $(document).ready(function() {
        // 고객 탭 클릭 시
        $('#customer-tab').click(function() {
            $('#customer-tab').addClass('active');
            $('#seller-tab').removeClass('active');
            $('#customer-form').addClass('active');
            $('#seller-form').removeClass('active');
        });

        // 판매자 탭 클릭 시
        $('#seller-tab').click(function() {
            $('#seller-tab').addClass('active');
            $('#customer-tab').removeClass('active');
            $('#seller-form').addClass('active');
            $('#customer-form').removeClass('active');
        });
    });
</script>  
</head>
<body>
	 	<%@ include file="../common/header.jsp"%>
	 	<div class="login-container">
		<h1>로그인</h1>
		<div class="tab">
			<div id="customer-tab" class="active">고객</div>
			<div id="seller-tab">판매자</div>
		</div>
		<form id="customer-form" class="active"
			action="${path }/member_test/login.do" method="post">
			<div class="input-group">
				<div class="input-fields">
					<input type="text" id="member_id" name="member_id"
						placeholder="아이디">
					<div class="password-container">
						<input type="password" id="member_pw" name="member_pw"
							placeholder="비밀번호"> <img src="${path}/resources/images/eye-icon.png"
							class="toggle-password" onclick="togglePassword('member_pw')">
					</div>
				</div>
				<button class="login-btn" type="submit">로그인</button>
			</div>
			<div class="checkbox-container">
				<input type="checkbox" id="remember-me" name="rememberMe"> <label
					for="remember-me">아이디 저장</label>
			</div>
		</form>
		<form id="seller-form" action="${path }/member_test/login.do" method="post">
			<div class="input-group">
				<div class="input-fields">
					<input type="text" id="member_id" name="member_id" placeholder="사업자등록번호">
					<div class="password-container">
						<input type="password" id="sellerPassword" name="member_pw"
							placeholder="비밀번호"> <img src="${path}/resources/images/eye-icon.png"
							class="toggle-password"
							onclick="togglePassword('sellerPassword')">
					</div>
				</div>
				<button class="login-btn" type="submit">로그인</button>
			</div>
			<div class="checkbox-container">
				<input type="checkbox" id="remember-me-seller"
					name="rememberMeSeller"> <label for="remember-me-seller">사업자등록번호
					저장</label>
			</div>
		</form>
			<!-- 경고 메시지 출력 -->
			<c:if test="${not empty sessionScope.loginResult}">
				<script>
					alert('${sessionScope.loginResult}');
					<c:remove var="loginResult" scope="session"/>
				</script>
			</c:if>

		<div class="links">
			<a href="${path }/member_test/findid">아이디 찾기</a> <a
				href="${path }/member_test/findpassword">비밀번호 찾기</a> <a
				href="${path }/member_test/signup">회원가입</a>
		</div>
		
		
	</div>
	<footer>
		<div class="footer-line"></div>
		<div class="footer-text">회사소개 이용약관 개인정보처리방침 이메일무단수집거부 단체주문 제휴문의
			입점신청 멤버쉽 안내</div>
		<div class="footer-logo">saren</div>
		<div class="footer-links">
			<a href="#">고객센터</a> <a href="#">공지사항</a> <a href="#">매장찾기</a>
		</div>
		<div class="footer-text">서울특별시 강남구 남부순환로 2806 (도곡동) 대표 : 김태한
			사업자등록번호: 101-85-43800 사업자정보확인 통신판매업신고: 2015-서울강남-02894</div>
		<div class="footer-text">호스팅서비스: 삼성물산(주)패션부문 KG이니시스 구매안전서비스 이용확인
			서비스가입사실확인</div>
		<div class="footer-text">대표전화 1599-0007(유료) 080-700-1472(무료)</div>
		<div class="footer-text">Copyright ⓒ 2003 Samsung C&T
			Corporation. All rights reserved</div>
	</footer>
</body>
</html>