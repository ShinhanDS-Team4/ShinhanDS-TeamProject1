<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<meta charset="UTF-8">
<title>공지사항/당첨자 발표</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<style>
/* Flexbox 레이아웃 설정 */
html, body {
    height: 100%;
    margin: 0;
    display: flex;
    flex-direction: column;
}

/* 컨테이너가 flex-grow를 사용하여 페이지 전체를 채우도록 설정 */
.container {
    flex: 1;
    display: flex;
    flex-direction: column;
    width: 70%;
    margin: 50px auto;
    background-color: #fff;
    padding: 20px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

/* header의 스타일을 정의, 텍스트를 가운데 정렬하고 아래쪽 여백을 30px로 설정 */
h1 {
    text-align: center;
    margin-bottom: 30px;
    font-size: 24px;
}

/* 검색 상자의 스타일을 정의, 플렉스 박스를 사용하여 오른쪽 정렬 */
.search-box {
    display: flex;
    justify-content: flex-end;
    margin-bottom: 20px;
}

/* 검색 입력 필드의 스타일을 정의, 너비를 300px로 설정하고 패딩과 테두리를 설정 */
.search-box input[type="text"] {
    width: 300px;
    padding: 10px;
    margin-right: 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
}

/* 검색 버튼의 스타일을 정의, 배경색과 텍스트 색상을 설정하고 테두리를 없애며 모서리를 둥글게 설정 */
.search-box input[type="submit"] {
    padding: 10px 20px;
    background-color: #007bff;
    color: #fff;
    border: none;
    border-radius: 5px;
    cursor: pointer;
}

/* 테이블의 스타일을 정의, 전체 너비를 사용하고 경계선을 설정 */
table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

/* 테이블의 헤더와 데이터 셀의 경계선을 설정 */
table, th, td {
    border: 1px solid #ddd;
}

/* 테이블 헤더와 데이터 셀의 패딩과 텍스트 정렬을 설정 */
th, td {
    padding: 15px;
    text-align: left;
    cursor: pointer;
}

/* 테이블 헤더의 배경색을 연한 회색으로 설정 */
th {
    background-color: #f4f4f4;
}

/* 짝수 행의 배경색을 연한 회색으로 설정 */
tbody tr:nth-child(even) {
    background-color: #f9f9f9;
}

/* 행에 마우스를 올렸을 때 배경색을 연한 회색으로 설정 */
tbody tr:hover {
    background-color: #f1f1f1;
}

/* 페이지네이션 컨테이너를 가운데 정렬하고 상단 여백을 설정 */
.pagination {
    text-align: center;
    margin-top: 20px;
}

/* 페이지 링크의 스타일을 정의, 여백과 패딩을 설정하고 테두리와 모서리를 둥글게 설정 */
.pagination a {
    margin: 0 5px;
    text-decoration: none;
    color: #007bff;
    padding: 5px 10px;
    border: 1px solid #ddd;
    border-radius: 5px;
}

/* 페이지 링크에 마우스를 올렸을 때 배경색과 텍스트 색상을 설정 */
.pagination a:hover {
    background-color: #007bff;
    color: #fff;
}

/* 현재 페이지 링크를 강조하기 위해 굵게 표시하고 밑줄을 추가 */
.current {
    font-weight: bold;
    text-decoration: underline;
}

/* 공지사항 내용을 표시할 섹션의 스타일을 정의 */
.notice-content {
    display: none;
    margin-top: 20px;
    padding: 20px;
    border: 1px solid #ddd;
    background-color: #f9f9f9;
}

/* 뒤로 가기 버튼의 스타일을 정의 */
.back-button {
    display: flex;
    align-items: center;
    margin-bottom: 20px;
    cursor: pointer;
    color: #007bff;
    font-size: 16px;
}

.back-button svg {
    margin-right: 5px;
}

/* footer 스타일 설정 */
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
        // JavaScript 함수를 정의하여 공지사항 클릭 이벤트를 처리
        //$("#" + noticeId) <- 이거 고급기술인듯, 잘 알아두자.
        function showNoticeContent(noticeId) {
        	let title, date, content;
        	title = $("#" + noticeId).attr("data-title");
        	date = $("#" + noticeId).attr("data-date");
        	content = $("#" + noticeId).attr("data-content");
            // 특수 문자 및 줄 바꿈 처리
            content = content.replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/\n/g, "<br>");

            // 테이블과 페이지네이션 숨기기
            document.getElementById("notice-table").style.display = "none";
            document.getElementById("pagination").style.display = "none";

            // 공지사항 내용 표시하기
            var contentDiv = document.getElementById("notice-content");
            contentDiv.style.display = "block";
            contentDiv.innerHTML = '<div class="back-button" onclick="showNoticeTable()">' +
                    '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-left" viewBox="0 0 16 16">' +
                        '<path fill-rule="evenodd" d="M5.854 4.146a.5.5 0 0 1 0 .708L2.707 8H15.5a.5.5 0 0 1 0 1H2.707l3.147 3.146a.5.5 0 0 1-.708.708l-4-4a.5.5 0 0 1 0-.708l4-4a.5.5 0 0 1 .708 0z"/>' +
                    '</svg>뒤로 가기</div>' +
                '<h3>' + title + '</h3>' +
                '<p>날짜: ' + date + '</p>' +
                '<p>' + content + '</p>';
        }

        // 테이블과 페이지네이션 다시 표시하기
        function showNoticeTable() {
            document.getElementById("notice-table").style.display = "table";
            document.getElementById("pagination").style.display = "block";
            document.getElementById("notice-content").style.display = "none";
        }
    </script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
    <div class="container">
        <h1>공지사항/당첨자 발표</h1>
        <div class="search-box">
            <form action="notices" method="get">
                <input type="text" name="query" placeholder="공지사항/당첨자발표 검색" value="${query}">
                <input type="submit" value="검색">
            </form>
        </div>
        <table id="notice-table">
            <thead>
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>등록일</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="notice" items="${notices}" varStatus="status">
                    <tr 
                    id="notice${status.index}"
                    data-title= "${notice.not_title}"
                    data-date="${notice.not_date}"
                    data-content = "${notice.not_content}"
                    onclick="showNoticeContent('notice${status.index}')">
                        <td>${notice.not_id}</td>
                        <td><c:out value="${notice.not_title}"/></td>
                        <td><c:out value="${notice.not_date}"/></td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
        <div id="notice-content" class="notice-content">
            <!-- 공지사항 내용이 여기에 표시됩니다 -->
        </div>
        <div id="pagination" class="pagination">
            <c:choose>
                <c:when test="${totalPages > 1}">
                    <a href="notices?page=1&query=${query}">&lt;&lt;</a>
                    <c:forEach var="i" begin="1" end="${totalPages}" step="1">
                        <c:if test="${i >= currentPage - 2 && i <= currentPage + 2}">
                            <a href="notices?page=${i}&query=${query}" class="${i == currentPage ? 'current' : ''}">${i}</a>
                        </c:if>
                    </c:forEach>
                    <a href="notices?page=${totalPages}&query=${query}">&gt;&gt;</a>
                </c:when>
                <c:otherwise>
                    <a href="#" class="current">1</a>
                </c:otherwise>
            </c:choose>
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
