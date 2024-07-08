<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%-- css --%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<%-- 본문 css --%>
<link rel="stylesheet" href="${path}/resources/css/style.css">
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<%-- 사이드바 css --%>
<link rel="stylesheet" href="${path}/resources/css/mypage.css">
<%-- jquery 연결 --%>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #FFF;
            color: #333;
            display: flex;
            flex-direction: column;
        }
        .password_container {
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
        input[type="text"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn-confirm {
            background-color: #000;
            color: #fff;
            padding: 10px;
            width: calc(100% - 20px);
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-bottom: 20px;
        }
        .btn-confirm:hover {
            background-color: #333;
        }
        .btn-email {
            background-color: #6c63ff;
            color: #fff;
            padding: 15px 40px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1.2em;
            opacity: 0;
            pointer-events: none;
        }
        .btn-email.active {
            opacity: 1;
            pointer-events: auto;
        }
        .highlight-line {
            width: 100%;
            height: 2px;
            background-color: #ccc;
            margin: 20px 0;
        }
        .contact-info {
            margin-top: 20px;
            font-size: 0.9em;
            color: #666;
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
            border-top: 1px solid #555;
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
        .phone-icon {
    	width: 25px; /* 원하는 너비로 조정 */
   		height: auto; /* 비율 유지를 위해 자동 설정 */
}
    </style>
	<script>
	    $(document).ready(function() {
	        $('#confirm-btn').on('click', function(event) {
	            event.preventDefault();
	            var userId = $('#user-id').val();
	
	            if (userId) {
	                $.ajax({
	                    url: '${path}/member_test/findpassword',
	                    type: 'POST',
	                    data: { userId: userId },
	                    success: function(response) {
	                        if (response) { // 서버 응답이 true인 경우
	                            $('.btn-email').addClass('active');
	                            $('.btn-email').attr('data-user-id', userId); // 버튼에 사용자 ID를 데이터 속성으로 추가
	                        } else {
	                            alert('존재하지 않는 아이디입니다.');
	                        }
	                    },
	                    error: function(xhr, status, error) {
	                        console.error('Error: ' + error);
	                        alert('서버 오류가 발생했습니다.');
	                    }
	                });
	            } else {
	                alert('아이디를 입력하세요.');
	            }
	        });
	        
	        $('.btn-email').on('click', function() {
	            var userId = $(this).attr('data-user-id');
	            if (userId) {
	                window.location.href = '${path}/member_test/verifypassword?userId=' + userId;
	            }
	        });
	    });
	</script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
    <div class="password_container">
        <h1>아이디 / 비밀번호 찾기</h1>
        <div class="tab">
            <div>아이디 찾기</div>
            <div class="active">비밀번호 찾기</div>
        </div>
        <form>
            <input type="text" id="user-id" placeholder="아이디">
            <button id="confirm-btn" class="btn-confirm">확인</button>
        </form>
        <div class="highlight-line"></div>
        <button class="btn-email">이메일 인증으로 찾기</button>
        <div class="contact-info">
            <p><img src="${path}/resources/images/phone_icon.png" alt="전화 아이콘" class="phone-icon"> 1599-0007 (평일 09:00 - 18:00)</p>
        </div>
    </div>
    <footer>
        <div class="footer-line"></div>
        <div class="footer-text">회사소개 이용약관 개인정보처리방침 이메일무단수집거부 단체주문 제휴문의 입점신청 멤버쉽 안내</div>
        <div class="footer-logo">saren</div>
        <div class="footer-links">
            <a href="#">고객센터</a>
            <a href="#">공지사항</a>
            <a href="#">매장찾기</a>
        </div>
        <div class="footer-text">
            서울특별시 강남구 남부순환로 2806 (도곡동) 대표 : 김태한 사업자등록번호: 101-85-43800 사업자정보확인 통신판매업신고: 2015-서울강남-02894
        </div>
        <div class="footer-text">
            호스팅서비스: 삼성물산(주)패션부문 KG이니시스 구매안전서비스 이용확인 서비스가입사실확인
        </div>
        <div class="footer-text">
            대표전화 1599-0007(유료) 080-700-1472(무료)
        </div>
        <div class="footer-text">
            Copyright ⓒ 2003 Samsung C&T Corporation. All rights reserved
        </div>
    </footer>
</body>
</html>
