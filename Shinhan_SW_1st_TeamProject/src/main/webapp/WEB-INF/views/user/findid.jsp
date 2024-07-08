<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%-- css --%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<%-- jquery 연결 --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>아이디 / 비밀번호 찾기</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #fff;
	color: #333;
	display: flex;
	flex-direction: column;
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


.id_container {
	max-width: 600px;
	margin: 50px auto;
	padding: 20px;
	background-color: #fff;
	text-align: center;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

h1 {
	margin-bottom: 20px;
}

.tab {
	display: flex;
	justify-content: center;
	margin-bottom: 20px;
}

.tab div {
	padding: 10px 20px;
	cursor: pointer;
	border-bottom: 2px solid transparent;
}

.tab .active {
	border-bottom: 2px solid #000;
}

form {
	display: flex;
	flex-direction: column;
	align-items: center;
}

label {
	margin-bottom: 5px;
	font-weight: bold;
	display: block;
}

input[type="text"], input[type="email"] {
	width: calc(100% - 20px);
	padding: 10px;
	margin-bottom: 15px;
	border: 1px solid #ccc;
	border-radius: 5px;
}

.btn {
	padding: 10px 20px;
	text-decoration: none;
	color: #fff;
	border-radius: 5px;
	font-size: 1em;
	cursor: pointer;
	border: none;
}

.btn-confirm {
	background-color: #000;
	margin-bottom: 20px;
	width: calc(100% - 20px);
}

.btn-confirm:hover {
	background-color: #333;
}

.btn-pass {
	background-color: #6c63ff;
	width: 100%;
	padding: 15px;
	font-size: 1.2em;
}

.btn-pass:hover {
	background-color: #5555ff;
}

.or {
	margin: 20px 0;
}

.note {
	color: red;
	margin-top: 20px;
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
$(document).ready(function() {
    $('form').on('submit', function(event) {
        event.preventDefault(); // 폼의 기본 제출 동작을 막습니다.
        var name = $('input[placeholder="이름"]').val(); // 이름 입력값을 가져옵니다.
        var phone = $('input[placeholder="휴대폰 번호 (\'-\'없이 입력)"]').val(); // 휴대폰 번호 입력값을 가져옵니다.
        
        $.ajax({
            url: '${path}/member_test/findid', // 서버로 보낼 URL입니다.
            type: 'POST', // POST 요청을 사용합니다.
            data: {
                name: name,
                phone: phone
            },
            success: function(response) {
                var memberId = response.member_id; // 서버에서 반환한 회원 ID를 가져옵니다.
                var displayName = name + '(' + phone + ') 님의 ID';
                console.log(memberId);
                console.log(displayName);
                console.log(`값이 불러와지는가? : ${memberID}`);
                $('.id_container').html(
                	    '<h1>아이디 / 비밀번호 찾기</h1>' +
                	    '<div class="tab">' +
                	        '<div id="idfind-tab" class="active">아이디 찾기</div>' +
                	        '<div id="passwordfind-tab">비밀번호 찾기</div>' +
                	    '</div>' +
                	    '<p><strong>' + displayName + '</strong></p>' +
                	    '<p><strong>ID 표시 위치: <span style="color: blue;">' + memberId + '</span></strong></p><hr>' +
                	    '<button onclick="window.location.href=\'' + '${path}/member_test/login.do' + '\'" class="btn btn-pass">로그인</button>'
                	    ); // HTML 내용을 업데이트하여 결과를 표시합니다.
            },
            error: function(xhr, status, error) {
                alert('아이디를 찾을 수 없습니다. 정보를 확인하고 다시 시도하세요.'); // 오류가 발생하면 경고 메시지를 표시합니다.
                console.log("Error: " + error); // 오류 메시지를 콘솔에 출력합니다.
                console.log("Status: " + status); // 상태 코드를 콘솔에 출력합니다.
                console.dir(xhr); // XMLHttpRequest 객체를 콘솔에 출력합니다.
            }
        });
    });
});
</script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<div class="id_container">
	    <h1>아이디 / 비밀번호 찾기</h1>
	    <div class="tab">
	        <div id="idfind-tab" class="active">아이디 찾기</div>
	        <div id="passwordfind-tab">비밀번호 찾기</div>
	    </div>
	    <form action="${path}/member_test/findid" method="post">
	        <input type="text" id="name" name="name" placeholder="이름">
	        <input type="text" id="phone" name="phone" placeholder="휴대폰 번호 ('-'없이 입력)">
	        <button type="submit" class="btn btn-confirm">확인</button>
	    </form>
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
