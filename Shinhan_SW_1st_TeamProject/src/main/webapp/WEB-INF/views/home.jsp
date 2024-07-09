<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<html>
<head>
    <title>Saren Home</title>
    <!-- 본문 css -->
    <link rel="stylesheet" href="${path}/resources/css/style.css">
    <!-- 헤더,푸터 css -->
    <link rel="stylesheet" href="${path}/resources/css/header_footer.css">
    <!-- jquery 연결 -->
    <script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
    <!-- Slick 불러오기 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/slick-carousel/1.9.0/slick-theme.min.css">
    <!-- Slick 직접 연결 -->
    <link rel="stylesheet" href="${path}/resources/slick/slick-theme.css">
    <link rel="stylesheet" href="${path}/resources/slick/slick.css">
    <script src="${path}/resources/slick/slick.min.js"></script>
    
    <!-- 팝업창 CSS -->
    <style>
	    .pop-btn-box{
	        position: fixed;
		    bottom: 10px;
		    right: 10px;
		    z-index: 100;
	    }
        .popup {
            display: none; 
            position: fixed; 
            left: 50%; 
            top: 50%; 
            transform: translate(-50%, -50%); 
            padding: 20px; 
            background: white; 
            z-index: 1000;
            width: 400px; /* 팝업창 너비 설정 */
            height: 300px; /* 팝업창 높이 설정 */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* 그림자 추가 */
            border-radius: 10px; /* 모서리 둥글게 */
            border:10px solid #fff;
        }
        .popup-overlay {
            display: none; 
            position: fixed; 
            top: 0; 
            left: 0; 
            width: 100%; 
            height: 100%; 
            background: rgba(0,0,0,0.5); 
            z-index: 999; 
        }
        .popup h2 {
            margin-top: 0;
        }
        .popup .content {
          
        }
        .alert {
            padding: 20px;
            background-color: #f44336;
            color: white;
            margin-bottom: 15px;
            display: none; /* 처음에는 숨김 처리 */
        }
        .popup .alert {
            padding: 20px;
            color: white;
            margin-bottom: 15px;
            display: none; /* 처음에는 숨김 처리 */
            border-radius: 5px; /* 모서리 둥글게 */
            text-align: center;
        }
        #receiveCouponBtn{
     	    border: none;
		    background-color: #c70f0f;
		    color: #fff;
		    font-weight: bold;
		    padding: 20px 30px;
		    font-size: 16px;
		    border-radius: 5px;
		    width: 100%;
	        font-size: 20px;
        }
        #closePopupBtn{
       	    position: absolute;
		    top: 20px;
		    right: 20px;
		    border: none;
		    background-color: transparent;
   			font-size: 20px;
   			
        }
        
        .popup .content>h1{
       	    padding-top: 20px;
       	    font-size: 35px;
        }
        .popup .content>h3{
       	     padding: 40px 0px 20px;
   			 color: #ccc;
       	    
        }
         .popup .content>h2{
	        padding-bottom: 20px;
        }
    </style>
</head>
<body>
    <%@ include file="./common/header.jsp" %>
    <div class="pop-btn-box">
      <!-- 팝업창을 띄우는 버튼
      <button id="popupBtn">팝업 열기</button> -->
      <img id="popupBtn"  alt="쿠폰" src="${path}/resources/images/icons-gift-cupon.png">
    </div>
    <div id="container">
        <div class="inner">
            <ul class="banner_wrap">
                <li>
                    <div class="bannerImg">
                        <img src="${path}/resources/images/mainbanner/1.jpg" alt="">
                        <div class="bannerText">
                            <p class="title">당신의 스타일, 한층 더 특별하게</p>
                            <p>새롭게 출시된 스타일을 만나보세요</p>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bannerImg">
                        <img src="${path}/resources/images/mainbanner/2.jpg" alt="">
                        <div class="bannerText">
                            <p class="title">계절을 앞서는 감각</p>
                            <p>새롭게 출시된 스타일을 만나보세요</p>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bannerImg">
                        <img src="${path}/resources/images/mainbanner/3.jpg" alt="">
                        <div class="bannerText">
                            <p class="title">새로운 시즌, 새로운 나를 위한 컬렉션</p>
                            <p>새롭게 출시된 스타일을 만나보세요</p>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bannerImg">
                        <img src="${path}/resources/images/mainbanner/4.jpg" alt="">
                        <div class="bannerText">
                            <p class="title">당신의 옷장에 필요한 모든 것</p>
                            <p>새롭게 출시된 스타일을 만나보세요</p>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bannerImg">
                        <img src="${path}/resources/images/mainbanner/5.jpg" alt="">
                        <div class="bannerText">
                            <p class="title">새로운 시즌, 새로운 나를 위한 컬렉션</p>
                            <p>새롭게 출시된 스타일을 만나보세요</p>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bannerImg">
                        <img src="${path}/resources/images/mainbanner/6.jpg" alt="">
                        <div class="bannerText">
                            <p class="title">스타일 변신의 완벽한 기회</p>
                            <p>새롭게 출시된 스타일을 만나보세요</p>
                        </div>
                    </div>
                </li>
            </ul>
            
            <%-- 판매량별 16개 인기상품 슬라이드 --%>
            <section>
               <h2 class="main_title">전체 인기 상품</h2>
               <div class="main_product_list">
                   <ul>
                   	<c:forEach items="${bestItems}" var="bestItem">
                   		 <li>
                         <%--   <a href="javascript:#void">
                           	   <img src="http://localhost:9090/saren/ProdImgFile/desc/${bestItem.IMAGE_ID}" alt="${bestItem.IMAGE_ID}">	
                           </a>
                            --%>
                           <c:choose>
                               <c:when test="${not empty bestItems}">
                                <a href="javascript:#void">
                                   <img src="http://localhost:9090/saren/ProdImgFile/main/${bestItem.IMG_ID}" 
                                        alt="메인이미지" />
                                 </a>
                               </c:when>
                               <c:otherwise>
                             	  <a href="javascript:#void">
                                   <img src="${path}/resources/images/no-prod-img.png" 
                                        alt="기본이미지(100x100)" />
                                  </a>	
                               </c:otherwise>
                           </c:choose>
                           
                           <div class="product_text">
                               <p class="brand">${bestItem.BRAND}</p>
                               <p class="product_name">${bestItem.PROD_NAME}</p>
                               <p class="product_price">${bestItem.PROD_PRICE}원</p>
                           </div>
                       </li>
                   	</c:forEach>
                   </ul>
               </div>
           </section>
        </div>
    </div>

    <!-- 팝업창 HTML -->
    <div class="popup-overlay" id="popupOverlay"></div>
    <div class="popup" id="popup"> 
        <div class="alert" id="popupAlert"></div> <!-- 알림 메시지 추가 -->
        <div class="content">
            <h1><c:out value="${event.event_title}" />🎉</h1>
            <h2><c:out value="${event.event_content}" /></h2>
            <h3><c:out value="${event.event_date}" /></h3>
            <form id="couponForm" action="${path}/coupons/receive" method="post">
                <input type="hidden" name="coupon_id" value="${coupon.coupon_id}"> 
                <input type="hidden" name="coupon_name" value="${coupon.coupon_name}">
                <input type="hidden" name="discount_rate" value="${coupon.discount_rate}">
                <input type="hidden" name="quantity" value="${coupon.quantity}">
                <button type="button" id="receiveCouponBtn">쿠폰받기</button>
            </form>
        </div>
        <div>
	        <label><input type="checkbox" id="popupTodayNoShow"> 오늘 하루 그만 보기</label>
	        <button id="closePopupBtn">X</button>
        </div>
    </div>
  <script>
    /* 메인 배너 슬릭 슬라이더 */
    var jq = $.noConflict();
    jq(document).ready(function(){
        jq('.banner_wrap').slick({
            infinite: true,
            slidesToShow: 3, 
            slidesToScroll: 3, 
            autoplay: true,
            autoplaySpeed: 3000,
            dots: true,
            arrows : true
        });
        
        jq('.main_product_list>ul').slick({
            infinite: true,
            slidesToShow: 4, // 한번에 보여줄 슬라이드 수
            slidesToScroll: 1, // 한번에 스크롤할 슬라이드 수
            rows: 2,
            autoplay: true,
            autoplaySpeed: 4500,
            dots: true
        });
        
        // 팝업창 제어
        jq('#popupBtn').click(function() {
            jq('#popupOverlay').fadeIn();
            jq('#popup').fadeIn();
        });

        jq('#closePopupBtn').click(function() {
            jq('#popupOverlay').fadeOut();
            jq('#popup').fadeOut();
            if (jq('#popupTodayNoShow').is(':checked')) {
                setCookie('popupNoShow', 'true', 1);
            }
        });

        jq('#popupOverlay').click(function() {
            jq('#popupOverlay').fadeOut();
            jq('#popup').fadeOut();
        });

        // 쿠키 확인
        if (getCookie('popupNoShow') !== 'true') {
            jq('#popupOverlay').fadeIn();
            jq('#popup').fadeIn();
        }


        jq('#receiveCouponBtn').click(function() {
            console.log("쿠폰 받기 버튼 클릭됨");  
            jq.ajax({
                url: "${path}/coupons/checkLogin",
                type: "POST",
                success: function(loggedIn) {
                    console.log("로그인 상태:", loggedIn); // 디버깅용 로그  
                    
                    if (loggedIn) {
                        $.ajax({
                            url: "${path}/coupons/receive",
                            type: "POST",
                            data: $("#couponForm").serialize(),
                            success: function(response) {
                                showAlert(response.message, response.status === "success");
                            },
                            error: function(xhr, status, error) {
                                console.error("AJAX 요청 실패:", status, error); // 디버깅용 로그
                                showAlert("쿠폰 발급 요청에 실패했습니다.", false);
                            }
                        });
                    } else {
                        if (confirm("로그인 후 쿠폰을 받을 수 있습니다. 로그인하시겠습니까?")) {
                            location.href = "${path}/member_test/login.do";
                        }
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX 요청 실패:", status, error); // 디버깅용 로그
                }
            });
        });

    });

    function setCookie(name, value, days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        var expires = "expires=" + date.toUTCString();
        document.cookie = name + "=" + value + ";" + expires + ";path=/";
    }

    function getCookie(name) {
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for (var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) === ' ') c = c.substring(1, c.length);
            if (c.indexOf(nameEQ) === 0) return c.substring(nameEQ.length, c.length);
        }
        return null;
    }

    function showAlert(message, isSuccess) {
        alert(message);
        if (isSuccess) {
            jq('#popupOverlay').fadeOut();
            jq('#popup').fadeOut();
        }
    }
</script>

<%@ include file="./common/footer.jsp" %>

</body>
</html>
