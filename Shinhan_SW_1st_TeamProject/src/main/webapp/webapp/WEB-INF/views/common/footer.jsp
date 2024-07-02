<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<%-- footer --%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Footer Example</title>
    <style>
        footer {
            background-color: #333;
            color: white;
            text-align: left;
            padding: 20px 0;
        }
        .footer-line {
            border-top: 1px solid #555;
            margin: 10px 0;
        }
        .footer-text {
            margin: 5px 0;
            margin-left: 20px;
        }
        .footer-logo {
            font-size: 2em;
            font-weight: bold;
            text-align: left;
            margin-left: 20px;
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <!-- 기타 내용 -->

    <footer>
        <div class="footer-line"></div>
        <div class="footer-text">회사소개 이용약관 개인정보처리방침 이메일무단수집거부 단체주문 제휴문의 입점신청 멤버쉽 안내</div>
        <div class="footer-logo">saren</div>
    </footer>
</body>
</html>
