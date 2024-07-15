<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<style>
@charset "UTF-8";
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f8f9fa; /* 통일된 배경색 */
}

.sidebar {
    height: 100vh;
    position: fixed;
    top: 0;
    left: 0;
    width: 250px;
    background-color: #343a40;
    color: #fff;
    padding-top: 20px;
}

.sidebar a {
    color: #fff;
    text-decoration: none;
    display: block;
    padding: 10px 20px;
}

.sidebar img {
    padding: 10px 20px;
    width: 100%; /* 원하는 너비 */
    height: auto; /* 높이는 비율에 맞게 자동 조절 */
    max-width: 100%; /* 최대 너비 설정 */
}

.sidebar a:hover {
    background-color: #495057;
}

.sidebar .dropdown-btn {
    color: white;
    padding: 10px 20px;
    text-decoration: none;
    display: block;
    background: none;
    border: none;
    outline: none;
    width: 100%;
    text-align: left;
    cursor: pointer;
    font-size: 16px;
    position: relative;
}

.sidebar .dropdown-container {
    display: none;
    background-color: #262626;
    padding-left: 8px;
}

.sidebar .dropdown-btn:hover + .dropdown-container,
.sidebar .dropdown-container:hover {
    display: block;
}

.header {
    width: calc(100% - 250px);
    margin-left: 250px;
    background-color: #f8f9fa;
    color: black;
    padding: 10px 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header .search-container {
    display: flex;
    align-items: center;
}

.header .search-box {
    max-width: 300px;
    width: 100%;
    height: 38px; /* 검색창 높이를 줄임 */
    margin-right: 10px;
}

.header .account {
    position: relative;
}

.header .account-name {
    cursor: pointer;
    padding: 10px 20px;
    background-color: #f8f9fa;
    border: none;
    color: black;
    font-size: 16px;
}

.header .dropdown-account {
    display: none;
    position: absolute;
    right: 0;
    background-color: #f8f9fa;
    min-width: 160px;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    z-index: 1;
}

.header .dropdown-account a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

.header .dropdown-account a:hover {
    background-color: #ddd;
}

.header .account:hover .dropdown-account {
    display: block;
}

.content {
    margin-top: 60px;
    margin-left: 250px;
    padding: 20px;
    width: calc(100% - 250px);
    background-color: #f8f9fa;
}

.card {
    margin-bottom: 20px;
}

.chart-container {
    position: relative;
    height: 400px; /* 높이를 크게 설정 */
    width: 100%; /* 너비를 꽉 차게 설정 */
}

.table-container {
    margin-top: 20px;
}

.btn {
    background-color: #007bff;
    color: white;
    height: 38px; /* 검색 버튼 높이를 검색창과 맞춤 */
}

.card .card-title {
    font-size: 1.25rem;
    margin-bottom: 1rem;
}

.card .card-subtitle {
    font-size: 1rem;
    color: #6c757d;
}

.card .card-text {
    font-size: 0.875rem;
    color: #6c757d;
}

.no-data-message {
    text-align: center;
    color: #6c757d;
    margin-top: 20px;
}

.search-container {
    position: relative;
    width: 50%;
}

.search-container form {
    width: 100%;
}

.input-group {
    width: 80%;
}

.form-control {
    display: inline-block;
    width: auto;
    vertical-align: middle;
}

.form-control-search-box {
    display: inline-block;
    width: auto;
    flex-grow: 1;
    vertical-align: middle;
}

.input-group .form-control {
    width: auto;
    flex: 0 1 auto;
}

.search-results-list {
    list-style-type: none; /* 목록 항목 앞에 기호를 없앰 */
    margin-top: 10px;
    padding-left: 0; /* 내부 패딩 제거 */
    max-height: 250px; /* 최대 높이 설정 */
    overflow-y: auto; /* 내용이 넘칠 경우 스크롤바 표시 */
    width: 100%; /* 전체 너비 */
    background-color: #fff;
    border: 1px solid #ccc;
    position: absolute;
    z-index: 1000;
}

.search-results-list li {
    padding: 8px;
    border-bottom: 1px solid #ccc; /* 각 항목을 구분짓는 선 */
}

.search-results-list li:hover {
    background-color: #f8f8f8; /* 마우스 오버 시 배경 색상 변경 */
}
</style>
<script>
function f_search() {
    $.ajax({
        url: "search_results",
        data: {
            searchType: $("#searchType").val(),
            keyword: $("#keyword").val()
        },
        success: function(responsedata) {
            var resultsHtml = '';
            if (responsedata.length === 0) {
                resultsHtml = '<li>No results found.</li>';
            } else {
                responsedata.forEach(function(item) {
                    resultsHtml += '<li>' + item.member_name + ' (' + item.member_brand + ')</li>';
                });
            }
            $('#searchResults').html(resultsHtml);
        }
    });
}
</script>

<div class="sidebar">
    <h2 class="text-center">
        <a href="admin_page"><img src="${path}/resources/images/logo_main.png" alt="메인로고" class="logo"></a>
    </h2>    
    
    <a href="admin_page">Dashboard</a>
    
    <button class="dropdown-btn">판매자</button>
    <div class="dropdown-container">
        <a href="admin_seller_list">판매자 목록</a> 
        <a href="admin_seller_register">판매자 등록</a> 
        <a href="admin_seller_prod">판매자 판매 상품</a>
        <a href="admin_seller_rent">판매자 대여 상품</a>
    </div>
    
    <button class="dropdown-btn">고객</button>
    <div class="dropdown-container">
        <a href="admin_customer_list">고객 목록</a> 
        <a href="admin_customer_orderlist">고객 주문 목록</a> 
        <a href="admin_customer_rentlist">고객 대여 목록</a> 
    </div>
    
    <button class="dropdown-btn">공지 / 이벤트 / 문의사항</button>
    <div class="dropdown-container">
        <a href="admin_notice_list">공지사항 목록</a>         
       	<a href="admin_event_list">이벤트 목록</a> 
       	<a href="admin_faq_list">문의 목록</a>        
    </div>    
</div>

<div class="header">
    <div id="searchResults" class="search-results"></div>
    <div class="account">
        <button class="account-name">${aDto.admin_name}</button>
        <div class="dropdown-account">
            <a href="admin_mypage">내 정보</a> 
            <a href="admin_logout">로그아웃</a>
        </div>
    </div>
</div>