<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SAREN 코디 추천</title>
	<!-- CSS -->
	<link rel="stylesheet" href="${path}/resources/css/coordination.css">
	<!-- 헤더,푸터 css -->
	<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
	<!-- jquery 연결 -->
	<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</head>
<body>
 	<%@ include file="../common/header.jsp" %>
      <div class="container inner">
	 	  <h1 class="main-title">제목</h1>
	 	
      </div>
 	<%@ include file="../common/footer.jsp" %>
</body>
</html>