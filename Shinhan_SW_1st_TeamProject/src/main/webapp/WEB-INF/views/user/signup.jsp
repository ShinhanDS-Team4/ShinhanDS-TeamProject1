<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <c:set var="path" value="${pageContext.servletContext.contextPath}" />
    <!-- 헤더,푸터 css -->
    <link rel="stylesheet" href="${path}/resources/css/header_footer.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #ffffff;
            color: #333;
        }
        header {
            background-color: #fff;
            padding: 10px 0;
        }
        header .logo {
            font-size: 2em;
            font-weight: bold;
        }
        .navbar {
            text-align: center;
            padding: 10px 0;
            border-bottom: 1px solid #eee;
        }
        .navbar a {
            margin: 0 15px;
            text-decoration: none;
            color: #333;
        }
        .container {
            max-width: 600px;
            height: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* 공간을 고르게 나눔 */
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
            flex-grow: 1;
            justify-content: space-between; /* 공간을 고르게 나눔 */
        }
        .form-group {
            display: flex;
            flex-direction: row;
            align-items: center;
            margin-bottom: 15px;
        }
        .form-group label {
            flex: 0 0 150px; /* 고정된 너비 설정 */
            font-weight: bold;
        }
        .form-group input[type="text"],
        .form-group input[type="password"],
        .form-group input[type="email"],
        .form-group input[type="date"],
        .form-group select {
            flex: 1;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .radio-group, .checkbox-group {
            /* margin-bottom: 15px; 삭제 */
        }
        .radio-group label,
        .checkbox-group label {
            margin-right: 10px;
        }
        .radio-group input,
        .checkbox-group input {
            margin-right: 5px;
        }
        .btn {
            padding: 10px;
            background-color: #513AE4;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #4331B7;
        }
        .error-message {
            font-size: 0.9em;
            margin-top: -10px;
            margin-bottom: 15px;
        }
        .error-message.red {
            color: red;
        }
        .error-message.green {
            color: green;
        }
        .email-container {
            display: flex;
            flex-direction: row;
            align-items: center;
        }
        .email-container input[type="email"] {
            flex: 1;
            margin-right: 10px;
        }
        .address-container {
            display: flex;
            flex-direction: column;
        }
        .hidden {
            display: none;
        }
        footer {
            background-color: #333;
            color: white;
            text-align: center;
            padding: 20px 0;
            margin-top: 20px;
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
    </style>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script>
    $(document).ready(function() {
        var verificationCode = '';

        // 초기 상태: 브랜드 input 숨기기
        $('#brand-group').addClass('hidden');

        // 구분 선택에 따라 아이디 레이블 변경 및 브랜드 input 표시/숨기기
        $('#member_type').on('change', function() {
            var selectedType = $(this).val();
            if (selectedType == '2') {
                $('label[for="member_id"]').text('사업자등록번호');
                $('#brand-group').removeClass('hidden');
            } else {
                $('label[for="member_id"]').text('아이디');
                $('#brand-group').addClass('hidden');
            }
        });

        // 이메일 인증번호 받기
        $('#email-verify-btn').on('click', function() {
            var email = $('#email').val();
            if (email) {
                $.ajax({
                    url: '${path}/member_test/sendEmailVerification',
                    type: 'POST',
                    data: { email: email },
                    success: function(response) {
                        if (response.success) {
                            verificationCode = response.verificationCode;
                            alert('인증번호가 이메일로 전송되었습니다.');
                            $('#email-verification-popup').show();
                        } else {
                            alert('이메일 전송에 실패했습니다.');
                        }
                    }
                });
            } else {
                alert('이메일을 입력해주세요.');
            }
        });

        // 이메일 인증번호 확인
        $('#verify-code-btn').on('click', function() {
            var enteredCode = $('#verification-code').val();
            if (enteredCode === verificationCode) {
                alert('이메일 인증이 완료되었습니다.');
                $('#email').prop('readonly', true);
                $('#email-verification-popup').hide();
            } else {
                alert('인증번호가 올바르지 않습니다.');
            }
        });

        // 비밀번호 확인 기능
        $('#confirm-password').on('input', function() {
            var password = $('#member_pw').val();
            var confirmPassword = $(this).val();
            if (password === '' || confirmPassword === '') {
                $('#password-error').text('').removeClass('red green');
            } else if (password !== confirmPassword) {
                $('#password-error').text('비밀번호가 다릅니다.').removeClass('green').addClass('red');
            } else {
                $('#password-error').text('비밀번호가 일치합니다.').removeClass('red').addClass('green');
            }
        });

        // 주소 입력 버튼 클릭 시 카카오 API 호출
        $('#address-btn').on('click', function() {
            new daum.Postcode({
                oncomplete: function(data) {
                    var addr = ''; // 주소 변수
                    var extraAddr = ''; // 참고항목 변수

                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        addr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        addr = data.jibunAddress;
                    }

                    // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                    if (data.userSelectedType === 'R') {
                        if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                            extraAddr += data.bname;
                        }
                        if (data.buildingName !== '' && data.apartment === 'Y') {
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        if (extraAddr !== '') {
                            extraAddr = ' (' + extraAddr + ')';
                        }
                    }

                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                    document.getElementById('zipcode').value = data.zonecode;
                    document.getElementById("main_address").value = addr;
                    document.getElementById("sub_address").value = extraAddr;
                    document.getElementById("detail_address").focus();
                }
            }).open();
        });

        // 회원가입 폼 제출
        $('form').on('submit', function(event) {
            var password = $('#member_pw').val();
            var confirmPassword = $('#confirm-password').val();
            var emailVerified = $('#email').prop('readonly');
            var allFieldsFilled = true;
            var errorMessage = '모든 칸을 기입해주세요.';

            // 필수 입력 칸 체크
            $('input[required]').each(function() {
                if ($(this).val() === '') {
                    allFieldsFilled = false;
                    return false; // 필수 입력 칸이 비어 있으면 루프 종료
                }
            });

            if (!emailVerified) {
                event.preventDefault();
                $('#email-error').text('이메일을 인증해 주세요.');
            } else if (password === '' || confirmPassword === '' || password !== confirmPassword) {
                event.preventDefault();
                $('#password-error').text('비밀번호를 설정해주세요.').removeClass('green').addClass('red');
            } else if (!allFieldsFilled) {
                event.preventDefault();
                $('#form-error').text(errorMessage).addClass('red');
            } else {
                alert('회원가입 완료!');
            }
        });
    });
    </script>
</head>
<body>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
    <%@ include file="../common/header.jsp" %>
    <div class="container">
        <h1>회원가입</h1>
        <div id="form-error" class="error-message red"></div>
        <form method="post" accept-charset="UTF-8" action="${path}/member_test/signup">
            <div class="form-group">
                <label for="member_type">구분</label>
                <select id="member_type" name="member_type">
                    <option value="1">고객</option>
                    <option value="2">판매자</option>
                </select>
            </div>
            <div class="form-group">
                <label for="member_id">아이디</label>
                <input type="text" id="member_id" name="member_id" placeholder="영문, 숫자, 특수문자('_')만 입력 가능" required>
            </div>
            <div class="form-group">
                <label for="member_pw">비밀번호</label>
                <input type="password" id="member_pw" name="member_pw" placeholder="영문, 숫자, 특수문자 조합 9자리 이상" required>
            </div>
            <div class="form-group">
                <label for="confirm-password">비밀번호 확인</label>
                <input type="password" id="confirm-password" name="confirmPassword" required>
            </div>
            <div id="password-error" class="error-message"></div>
            <div class="form-group">
                <label for="member_name">이름</label>
                <input type="text" id="member_name" name="member_name" required>
            </div>
            <div class="form-group">
                <label for="phone">휴대폰 번호</label>
                <input type="text" id="phone" name="phone" placeholder="01012345678, ('-'를 빼고 입력해주세요)" pattern="[0-9]{11}" required>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <div class="email-container">
                    <input type="email" id="email" name="email" required>
                    <button type="button" id="email-verify-btn" class="btn">인증번호 받기</button>
                </div>
            </div>
            <div id="email-error" class="error-message red"></div>
            <div class="form-group">
                <label for="birth_date">생년월일</label>
                <input type="date" id="birth_date" name="birth_date" required>
            </div>
            <div class="form-group radio-group">
                <label>성별</label>
                <input type="radio" id="male" name="gender" value="M" required>
                <label for="male">남성</label>
                <input type="radio" id="female" name="gender" value="F" required>
                <label for="female">여성</label>
            </div>
            <div class="form-group">
                <label for="zipcode">주소</label>
                <button type="button" id="address-btn" class="btn address-button">주소 입력</button>
                <input type="text" id="zipcode" name="zipcode" placeholder="우편번호" readonly required>
            </div>
            <div class="form-group">
                <label for="main_address"></label>
                <input type="text" id="main_address" name="main_address" placeholder="주소" readonly required>
            </div>
            <div class="form-group">
                <label for="detail_address"></label>
                <input type="text" id="detail_address" name="detail_address" placeholder="상세주소" required>
            </div>
            <div class="form-group">
                <label for="sub_address"></label>
                <input type="text" id="sub_address" name="sub_address" placeholder="참고주소">
            </div>
            <div class="form-group hidden" id="brand-group">
                <label for="brand">브랜드</label>
                <input type="text" id="brand" name="brand">
            </div>
            <button type="submit" class="btn">가입하기</button>
        </form>
    </div>

    <!-- 이메일 인증 팝업 -->
    <div id="email-verification-popup" style="display:none;">
        <div style="background:rgba(0,0,0,0.5);position:fixed;top:0;left:0;width:100%;height:100%;z-index:10;"></div>
        <div style="background:#fff;position:fixed;top:50%;left:50%;transform:translate(-50%,-50%);padding:20px;z-index:20;">
            <h2>이메일 인증</h2>
            <input type="text" id="verification-code" placeholder="인증번호를 입력하세요">
            <button id="verify-code-btn" class="btn">확인</button>
        </div>
    </div>

    <footer>
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
