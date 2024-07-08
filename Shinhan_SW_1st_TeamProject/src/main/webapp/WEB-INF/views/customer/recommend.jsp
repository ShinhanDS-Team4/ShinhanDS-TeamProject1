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
 	  <div class="container-wrap">
	      <div class="container inner">
		 	  <h1 class="main-title">SAREN 나만의 코디 추천</h1>
		 	  <p>옷장 속 아이템과 조화롭게 어울리는 패션을 쉽게 찾아보세요.</p>
		 	  <ul class="category-name">
		 	  	  <li><a href="javascript:#void">카테고리</a></li>
			 	  <li><a href="javascript:#void">카테고리</a></li>
			 	  <li><a href="javascript:#void">카테고리</a></li>
		 	  </ul> 
		 	  
		 	   <div class="content-wrap">
		 	   		<div class="content box0">  <%-- 장바구니 아이템 --%>
		 	   		     <div class="imgbox">
							<img src="http://localhost:9090/saren/ProdImgFile/main/${prodInfoByCartId.IMG_ID}" alt="사진" />
		 	   		     </div>
					</div>
		 	   		<div class="content box1">  <%-- 추천 아이템 --%>
		 	   			 <div class="imgbox">
							<img src="${path}/resources/images/testImg/testimg1.jpg" alt="추천사진 예시" />
		 	   		     </div>
		 	   		</div>
		 	   		<div class="content box2">
		 	   			<div class="imgbox">
							<img alt="" src="추천사진" />
		 	   		    </div>
		 	   		</div>
		 	   		<div class="content box3">
						<div class="imgbox">
							<img alt="" src="추천사진" />
		 	   		    </div>
					</div>
		 	   </div>
	      </div> 	  
 	  </div>
 	  <script type="text/javascript">
	 	 $(document).ready(function() {
	 	    $('.content').on('mouseenter', function() {
	 	        $(this).css('z-index', 20);
	 	    }).on('mouseleave', function() {
	 	        $(this).css('z-index', '');
	 	    });
	 	});
 	  </script>
 	<%@ include file="../common/footer.jsp" %>
</body>
</html>