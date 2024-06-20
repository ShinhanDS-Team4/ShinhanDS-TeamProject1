<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f9f9f9;
            color: #333;
        }
        header {
            background-color: #fff;
            padding: 10px 0;
            text-align: center;
            border-bottom: 1px solid #ccc;
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
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="password"],
        input[type="email"],
        input[type="date"],
        select {
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .radio-group, .checkbox-group {
            margin-bottom: 15px;
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
            background-color: #333;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .btn:hover {
            background-color: #555;
        }
        .form-group {
            margin-bottom: 15px;
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
</head>
<body>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
    <header>
        <div class="logo">saren</div>
    </header>

    <nav class="navbar">
        <a href="#">여성</a>
        <a href="#">남성</a>
        <a href="#">키즈</a>
        <a href="#">악세서리</a>
        <a href="#">기타</a>
    </nav>

    <div class="container">
        <h1>회원가입</h1>
        <form method="post" accept-charset="UTF-8" action="${path }/member_test/signup.do">
            <div class="form-group">
                <label for="user-type">구분</label>
                <select id="member_type" name="member_type">
                    <option value="1">고객</option>
                    <option value="2">판매자</option>
                </select>
			    <script>
			    	//고객과 판매자 값을 숫자로 바꾸는 스크립트
				 function getSelectedValue() {
				    // select 요소를 가져옵니다
				    var selectElement = document.getElementById('member_type');
				    
				    // 선택된 옵션의 value를 가져옵니다
				    var selectedValue = selectElement.options[selectElement.selectedIndex].value;
				    
				    // value를 숫자로 변환합니다
				    var numericValue = parseInt(selectedValue, 10);
				    
				    // 결과를 콘솔에 출력합니다
				    console.log(numericValue);
				  }
				
				  // 페이지 로드 시 선택된 값을 출력합니다
				  window.onload = function() {
				    getSelectedValue();
				  };
				
				  // 선택이 변경될 때 값을 출력합니다
				  document.getElementById('mySelect').onchange = function() {
				    getSelectedValue();
				  };
			    </script>
            </div>
            <div class="form-group">
                <label for="username">아이디</label>
                <input type="text" id="member_id" name="member_id" placeholder="영문, 숫자, 특수문자('_')만 입력 가능">
            </div>
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="member_pw" name="member_pw" placeholder="영문, 숫자, 특수문자 조합 9자리 이상">
            </div>
            <div class="form-group">
                <label for="confirm-password">비밀번호 확인</label>
                <input type="password" id="confirm-password" name="confirmPassword">
            </div>
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="member_name" name="member_name">
            </div>
            <div class="form-group">
                <label for="phone">휴대폰 번호</label>
                <input type="text" id="phone" name="phone" placeholder="01012345678">
                <button type="button" class="btn">인증번호 받기</button>
            </div>
            <div class="form-group">
                <label for="email">이메일</label>
                <input type="email" id="email" name="email">
            </div>
            <div class="form-group">
                <label for="birthday">생년월일</label>
                <input type="date" id="birth_date" name="birth_date">
            </div>
            <div class="form-group radio-group">
                <label>성별</label>
                <input type="radio" id="male" name="gender" value="M">
                <label for="male">남성</label>
                <input type="radio" id="female" name="gender" value="F">
                <label for="female">여성</label>
            </div>
            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" id="address" name="address" placeholder="우편번호">
                <input type="text" id="detail-address" name="detailAddress" placeholder="상세주소">
            </div>
            <div class="form-group">
                <label for="brand">브랜드</label>
                <input type="text" id="brand" name="brand">
            </div>
            <button type="submit" class="btn">가입하기</button>
        </form>
    </div>

    <footer>
        <div class="footer-text">회사소개 이용약관 개인정보처리방침 이메일무단수집거부 단체주문 제휴문의 입점신청 멤버쉽 안내</div>
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
