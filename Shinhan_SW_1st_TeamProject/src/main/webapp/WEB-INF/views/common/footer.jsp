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
main {
	flex: 1;
	/* main 요소가 남은 공간을 모두 차지하도록 합니다. 이렇게 하면 footer가 항상 페이지 하단에 위치하게 됩니다 */
}

footer {
	background-color: #333; /* 배경색을 어두운 회색으로 설정합니다 */
	color: white; /* 텍스트 색상을 흰색으로 설정합니다 */
	text-align: center; /* 텍스트를 가운데 정렬합니다 */
	padding: 20px 0; /* 위아래로 20px의 패딩을 추가합니다 */
	width: 100%; /* footer가 페이지 전체 너비를 차지하도록 합니다 */
}

footer .footer-line {
	margin: 10px 0; /* 위아래로 10px의 마진을 추가합니다 */
}

footer .footer-text {
	margin: 5px 0; /* 위아래로 5px의 마진을 추가합니다 */
}

footer .footer-logo {
	font-size: 2em; /* 폰트 크기를 2em으로 설정합니다 */
	font-weight: bold; /* 폰트를 굵게 설정합니다 */
	margin-top: 20px; /* 위쪽에 20px의 마진을 추가합니다 */
}

footer .footer-links {
	margin-top: 10px; /* 위쪽에 10px의 마진을 추가합니다 */
}

footer .footer-links a {
	color: #fff; /* 링크 텍스트 색상을 흰색으로 설정합니다 */
	text-decoration: none; /* 링크의 밑줄을 제거합니다 */
	margin: 0 10px; /* 좌우에 10px의 마진을 추가하여 링크 간의 간격을 만듭니다 */
}
</style>
</head>
<body>

    <main>
        <!-- 페이지의 주요 콘텐츠가 여기에 들어갑니다 -->
    </main>
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
            77 ANT 빌딩 1층, 월드컵북로4길 마포구 서울특별시(동교동) 대표 : 이종경 사업자등록번호: 178-59-41720 사업자정보확인 통신판매업신고: 2015-서울동교-02894
        </div>
        <div class="footer-text">
            호스팅서비스: SAREN(주)패션부문 KG이니시스 구매안전서비스 이용확인 서비스가입사실확인
        </div>
        <div class="footer-text">
            대표전화 1599-0007(유료) 080-700-1472(무료)
        </div>
        <div class="footer-text">
            Copyright © SHINHAN BANK. All rights reserved.
        </div>
    </footer>
</body>
</html>
