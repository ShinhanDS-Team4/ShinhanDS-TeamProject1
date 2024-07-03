<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>에러 페이지</title>
<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f8f9fa;
	color: #333;
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	height: 100vh;
	margin: 0;
}

.container {
	text-align: center;
	background-color: #fff;
	padding: 30px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

.logo {
	width: 200px; /* 적절한 크기로 설정 */
	margin-bottom: 20px;
}

h1 {
	color: #513AE4;
}

p {
	margin: 10px 0;
}

a {
	display: inline-block;
	margin-top: 20px;
	padding: 10px 20px;
	background-color: #007bff;
	color: #fff;
	text-decoration: none;
	border-radius: 5px;
}

a:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="container">
		<img src="${path}/resources/images/logo_main.png" alt="Logo"
			class="logo">
		<h1>오류가 발생했습니다</h1>
		<p>죄송합니다. 요청하신 페이지를 처리하는 중 오류가 발생했습니다.</p>
		<p>
			<strong>에러 코드:</strong> ${pageContext.errorData.statusCode}
		</p>
		<p>
			<strong>서블릿 이름:</strong> ${pageContext.errorData.servletName}
		</p>
		<a href="${pageContext.request.contextPath}/">홈으로 돌아가기</a>
	</div>
</body>
</html>