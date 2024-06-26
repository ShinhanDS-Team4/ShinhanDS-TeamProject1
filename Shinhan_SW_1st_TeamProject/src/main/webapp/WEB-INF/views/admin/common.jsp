<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<div class="sidebar">
	<h2 class="text-center">
		<a href="admin_page"> <img
			src="${path}/resources/images/logo_main.png" alt="메인로고" class="logo"></a>
	</h2>
	<a href="admin_page">Dashboard</a>
	<button class="dropdown-btn">판매자</button>
	<div class="dropdown-container">
		<a href="admin_seller_list">판매자 목록</a> 
		<a href="admin_seller_register">판매자 등록</a> 
		<a href="admin_seller_detail">판매자 상세</a>
	</div>
	<button class="dropdown-btn">고객</button>
	<div class="dropdown-container">
		<a href="admin_customer_list">고객 목록</a> <a
			href="admin_customer_register">고객 등록</a> <a
			href="admin_customer_detail">고객 상세</a>
	</div>
	<button class="dropdown-btn">공지사항</button>
	<div class="dropdown-container">
		<a href="admin_notice_list">공지사항 목록</a> <a
			href="admin_notice_register">공지사항 등록</a> <a
			href="admin_notice_detail">공지사항 상세</a>
	</div>
	<a href="admin_faq.jsp">F.A.Q</a>
</div>

<div class="header">
	<div class="search-container">		
			<div class="input-group">
				<select class="form-control" name="searchType" id="searchType"
					style="max-width: 150px;">
					<option value="id">아이디 검색</option>
					<option value="name">이름 검색</option>
					<option value="brand">브랜드 검색</option>
				</select> <input type="text" class="form-control-search-box" name="keyword" id="keyword"
					placeholder="검색어를 입력하세요">
				<div class="input-group-append">
					<input class="btn btn-primary" type="button" onclick="f_search()" value="검색">
				</div>
			</div>		
	</div>
	<!-- <div class="search-container">
			<form action="search_results.jsp" method="get">
				<div class="input-group">
					<input type="text" class="form-control-search-box" name="query"
						placeholder="판매자 또는 고객 검색">
					<div class="input-group-append">
						<button class="btn btn-primary" type="submit">검색</button>
					</div>
				</div>
			</form>
		</div> -->
	<div class="account">
		<button class="account-name">${admin_name}</button>
		<div class="dropdown-account">
			<a href="admin_mypage">내 정보</a> <a href="admin_logout">로그아웃</a>
		</div>
	</div>
</div>

<script>
	function f_search() {
		alert("검색");
		$.ajax({
			url: "search_results",
			data: {
				searchType: $("#searchType").val(),
				keyword: $("#keyword").val()
			},
			success: function(responsedata){
				alert(responsedata)
			}
		});
	}
</script>