<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자_상품수정</title>
<!-- 본문 css -->
<link rel="stylesheet" href="${path}/resources/css/style.css">
<!-- 헤더,푸터 css -->
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<!-- jquery 연결 -->
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- Slick 불러오기 -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
<!-- Slick 직접 연결 -->
<link rel="stylesheet" href="${path}/resources/slick/slick-theme.css">
<link rel="stylesheet" href="${path}/resources/slick/slick.css">
<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/orderSuccess.css" />
<script src="${path}/resources/slick/slick.min.js"></script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
		<div class="container">
			<h1>주문이 완료되었습니다!</h1>
			<a href="#" class="button">마이페이지로</a>
		</div>
	</main>
</body>
</html>