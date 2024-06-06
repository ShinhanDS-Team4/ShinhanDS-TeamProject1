<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
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
</head>
<body>
	   <%@ include file="../common/header.jsp" %>
       <div id="container">
        <div class="inner">
            <ul class="banner_wrap">
                <li>
                    <div class="bannerImg">
                        <img src="${path}/resources/images/mainbanner/1.jpg" alt="">
                        <div class="bannerText">
                            <p class="title">계절을 앞서는 감각</p>
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
                            <p class="title">계절을 앞서는 감각</p>
                            <p>새롭게 출시된 스타일을 만나보세요</p>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bannerImg">
                        <img src="${path}/resources/images/mainbanner/4.jpg" alt="">
                        <div class="bannerText">
                            <p class="title">계절을 앞서는 감각</p>
                            <p>새롭게 출시된 스타일을 만나보세요</p>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bannerImg">
                        <img src="${path}/resources/images/mainbanner/5.jpg" alt="">
                        <div class="bannerText">
                            <p class="title">계절을 앞서는 감각</p>
                            <p>새롭게 출시된 스타일을 만나보세요</p>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bannerImg">
                        <img src="${path}/resources/images/mainbanner/6.jpg" alt="">
                        <div class="bannerText">
                            <p class="title">계절을 앞서는 감각</p>
                            <p>새롭게 출시된 스타일을 만나보세요</p>
                        </div>
                    </div>
                </li>
            </ul>
            <section>
                <h2 class="main_title">인기 상품 상품</h2>
                <div class="main_product_list">
                    <ul>
                       <li>
                            <a href="#"><img src="${path}/resources/images/product1.png" alt="product"></a>
                            <div class="product_text">
                                <p class="brand">브랜드</p>
                                <p class="product_name">상품이름상품이름</p>
                                <p class="product_price">50,000원</p>
                            </div>
                        </li>
                         <li>
                            <a href="#"><img src="${path}/resources/images/product1.png" alt="product"></a>
                            <div class="product_text">
                                <p class="brand">브랜드</p>
                                <p class="product_name">상품이름상품이름</p>
                                <p class="product_price">50,000원</p>
                            </div>
                        </li> <li>
                            <a href="#"><img src="${path}/resources/images/product1.png" alt="product"></a>
                            <div class="product_text">
                                <p class="brand">브랜드</p>
                                <p class="product_name">상품이름상품이름</p>
                                <p class="product_price">50,000원</p>
                            </div>
                        </li> <li>
                            <a href="#"><img src="${path}/resources/images/product1.png" alt="product"></a>
                            <div class="product_text">
                                <p class="brand">브랜드</p>
                                <p class="product_name">상품이름상품이름</p>
                                <p class="product_price">50,000원</p>
                            </div>
                        </li> <li>
                            <a href="#"><img src="${path}/resources/images/product1.png" alt="product"></a>
                            <div class="product_text">
                                <p class="brand">브랜드</p>
                                <p class="product_name">상품이름상품이름</p>
                                <p class="product_price">50,000원</p>
                            </div>
                        </li> <li>
                            <a href="#"><img src="${path}/resources/images/product1.png" alt="product"></a>
                            <div class="product_text">
                                <p class="brand">브랜드</p>
                                <p class="product_name">상품이름상품이름</p>
                                <p class="product_price">50,000원</p>
                            </div>
                        </li> <li>
                            <a href="#"><img src="${path}/resources/images/product1.png" alt="product"></a>
                            <div class="product_text">
                                <p class="brand">브랜드</p>
                                <p class="product_name">상품이름상품이름</p>
                                <p class="product_price">50,000원</p>
                            </div>
                        </li> <li>
                            <a href="#"><img src="${path}/resources/images/product1.png" alt="product"></a>
                            <div class="product_text">
                                <p class="brand">브랜드</p>
                                <p class="product_name">상품이름상품이름</p>
                                <p class="product_price">50,000원</p>
                            </div>
                        </li>
                    </ul>
                </div>
            </section>
        </div>
    </div>
    <script>
    	/* 메인 배너 슬릭 슬라이더 */
        // jQuery를 $ 대신 사용할 수 있도록 설정
        var jq = $.noConflict();
        jq(document).ready(function(){
            jq('.banner_wrap').slick({
                infinite: true,
                slidesToShow: 3, // 한번에 보여줄 슬라이드 수
                slidesToScroll: 3, // 한번에 스크롤할 슬라이드 수
                autoplay: true,
                autoplaySpeed: 3000,
                dots: true,
                arrows : true
            });
        });
    </script>
</body>
</html>
