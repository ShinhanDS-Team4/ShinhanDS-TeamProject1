<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<c:set var="path" value="${pageContext.servletContext.contextPath}" />
    <%-- 헤더,푸터 css --%>
	<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 확인</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #fff;
            color: #333;
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* 페이지 전체 높이 설정 */
        }
        .container {
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
        .instructions {
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        input[type="password"] {
            width: calc(100% - 20px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .btn-container {
            display: flex;
            justify-content: center;
            width: 100%;
        }
        .btn {
            padding: 10px 20px;
            margin: 5px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 1em;
            text-decoration: none;
            text-align: center;
        }
        .btn-cancel {
            background-color: #fff;
            color: #333;
            border: 1px solid #ccc;
        }
        .btn-confirm {
            background-color: #000;
            color: #fff;
        }
		footer {
			background-color: #333;
			color: white;
			text-align: center;
			padding: 20px 0;
			width: 100%;
			margin-top: auto;
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
            $('#verify-btn').on('click', function() {
                var enteredCode = $('#verification-code').val();
                var actualCode = '${verificationCode}';
                var userId = '${userId}';

                if (enteredCode === actualCode) {
                    $('#verification-section').hide();
                    $('#password-section').show();
                } else {
                    alert('인증번호가 올바르지 않습니다.');
                }
            });

            $('#reset-password-btn').on('click', function() {
                var newPassword = $('#new-password').val();
                var confirmPassword = $('#confirm-password').val();
                var userId = '${userId}';

                if (newPassword && confirmPassword && newPassword === confirmPassword) {
                    // 비밀번호 변경 로직을 서버로 전송
                    $.ajax({
                        url: '${path}/member_test/resetpassword',
                        type: 'POST',
                        data: { userId: userId, newPassword: newPassword },
                        success: function(response) {
                            if (response) {
                                alert('비밀번호가 성공적으로 변경되었습니다.');
                                window.location.href = '${path}/member_test/login.do';
                            } else {
                                alert('비밀번호 변경에 실패했습니다.');
                            }
                        },
                        error: function(xhr, status, error) {
                            console.error('Error: ' + error);
                            alert('서버 오류가 발생했습니다.');
                        }
                    });
                } else {
                    alert('비밀번호가 일치하지 않습니다.');
                }
            });
        });
    </script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
    <div class="container">
        <h1>이메일 인증</h1>
        <div id="verification-section">
            <input type="text" id="verification-code" placeholder="인증번호를 입력하세요">
            <button id="verify-btn" class="btn">확인</button>
        </div>
        <div id="password-section" style="display: none;">
            <input type="password" id="new-password" placeholder="새 비밀번호를 입력하세요">
            <input type="password" id="confirm-password" placeholder="새 비밀번호를 다시 입력하세요">
            <button id="reset-password-btn" class="btn">비밀번호 변경</button>
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
