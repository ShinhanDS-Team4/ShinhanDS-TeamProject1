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
		 	  </ul> 
		 	  
		 	   <div class="content-wrap">
		 	   		<div class="content box0">  <%-- 장바구니 아이템 --%>
		 	   			<span>아우터</span>
		 	   		     <div class="imgbox" id="outer">
							<img src="/saren/ProdImgFile/main/${prods.outer.prod_id}_image_1.jpg" alt="사진" onclick="location.href='${path}/prod/prod_detail/prod_id=${prods.outer.prod_id}'"/>
		 	   		     </div>
					</div>
		 	   		<div class="content box1">  <%-- 추천 아이템 --%>
		 	   			<span>재킷/베스트</span>
		 	   			 <div class="imgbox" id="jacket">
							<img src="/saren/ProdImgFile/main/${prods.jacket.prod_id}_image_1.jpg" alt="추천사진 예시" onclick="location.href='${path}/prod/prod_detail/prod_id=${prods.jacket.prod_id}'"  />
		 	   		     </div>
		 	   		</div>
		 	   		<div class="content box2">
		 	   			<span>니트</span>
		 	   			<div class="imgbox" id="neat">
							<img alt="" src="/saren/ProdImgFile/main/${prods.neat.prod_id}_image_1.jpg" onclick="location.href='${path}/prod/prod_detail/prod_id=${prods.neat.prod_id}'" />
		 	   		    </div>
		 	   		</div>
		 	   		<div class="content box3">
		 	   			<span>셔츠/블라우스</span>
						<div class="imgbox" id="shirt">
							<img alt="" src="/saren/ProdImgFile/main/${prods.shirt.prod_id}_image_1.jpg"  onclick="location.href='${path}/prod/prod_detail/prod_id=${prods.shirt.prod_id}'"/>
		 	   		    </div>
					</div>
		 	   		<div class="content box4">
		 	   			<span>티셔츠</span>
		 	   			<div class="imgbox" id="tshirt">
							<img alt="" src="/saren/ProdImgFile/main/${prods.tshirt.prod_id}_image_1.jpg"  onclick="location.href='${path}/prod/prod_detail/prod_id=${prods.tshirt.prod_id}'"/>
		 	   		    </div>
		 	   		</div>
		 	   		<div class="content box5">
		 	   			<span>팬츠</span>
						<div class="imgbox" id="pants">
							<img alt="" src="/saren/ProdImgFile/main/${prods.pants.prod_id}_image_1.jpg"  onclick="location.href='${path}/prod/prod_detail/prod_id=${prods.pants.prod_id}'"/>
		 	   		    </div>
					</div>
		 	   		<div class="content box6">
		 	   			<span>스커트</span>
						<div class="imgbox" id="skirt">
							<img alt="" src="/saren/ProdImgFile/main/${prods.skirt.prod_id}_image_1.jpg"  onclick="location.href='${path}/prod/prod_detail/prod_id=${prods.skirt.prod_id}'"/>
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
	 	    
	 	    $('#'+'${selected}').css('border', '4px double #000');
	 	   	
	 	});
 	  </script>
 	<%@ include file="../common/footer.jsp" %>
</body>
</html>