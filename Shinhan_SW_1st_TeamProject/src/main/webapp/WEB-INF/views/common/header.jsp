<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />

<%-- 로그인 여부를 확인하기 위한 세션 값 확인 --%>
<c:set var="isLoggedIn" value="${not empty sessionScope.member}"   />

<%-- header !!!!!!!!! --%>

<header>
	<div class="header_top inner">
		<div class="leftGnb">
			<h1 class="logo">
				<a href="${path}/">
					<img src="${path}/resources/images/logo_main.png" alt="메인로고">
				</a>
			</h1>
			<%-- 상품 검색창 --%>
			<form action="${path}/" class="search_form">
				<label for="search_wrap"> 
					<input name="search_input" type="search" /> 
					<img src="${path}/resources/images/icon_serch.png" alt="돋보기 아이콘" class="search_img" />
				</label>
			</form>
		</div> 
		<div class="rightGnb">  
			<ul>
				<c:choose>
					<c:when test="${isLoggedIn}">
						<li>
							<a href="${path}/member_test/logout.do"> 
								<p>로그아웃</p>
								<img src="${path}/resources/images/icon-logout.png" alt="로그아웃">
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li>
							<a href="${path}/member_test/login.do" id="loginLink"> 
								<p>로그인</p>
								<img src="${path}/resources/images/icon-login.gif" alt="로그인">
							</a>
						</li>
						<li>
							<a href="${path}/member_test/signup">
								<p>회원가입</p>
								<img src="${path}/resources/images/icon-sign-in.png" alt="회원가입">
							</a>
						</li>
					</c:otherwise>
				</c:choose>
				<li>
					<a href="${path}/customer/myPage.do">
						<p>마이페이지</p>
						<img src="${path}/resources/images/icon-person2.png" alt="마이페이지" class="myPageIcon">
					</a>
					<%-- 문의 답변오면 나타나는 알림 --%>
					<%-- <span class="hidden">N</span> --%>
				</li>
				<li>
					<a href="${path}/cart/cart.do">
						<p>장바구니</p>
						<img src="${path}/resources/images/icon-cart.png" alt="장바구니">
					</a>
				</li>
			</ul>
	
		</div>
	</div>
	<div class="header_bottom">
		<div class="menu_wrap inner">
			<%-- 메인 메뉴 카테고리 --%>
			<ul class="left_menu">
				<li data-menu="0">
					<a href="${path}/prod/productlist?shwCtgNum=11000000"
					class="category_name">여성</a>
				</li>
				<li data-menu="1">
					<a href="${path}/prod/productlist?shwCtgNum=14000000"
					class="category_name">남성</a>
				</li>
				<li data-menu="2">
					<a href="${path}/prod/productlist?shwCtgNum=13000000"
					class="category_name">키즈</a>
				</li>
				<li data-menu="3">
					<a href="${path}/prod/productlist?shwCtgNum=15000000"
					class="category_name">럭셔리</a>
				</li>
				<li data-menu="4">
					<a href="${path}/prod/productlist?shwCtgNum=12000000"
					class="category_name">스포츠</a>
				</li>
				<li data-menu="5">
					<a href="${path}/prod/productlist?shwCtgNum=10000000"
					class="category_name">가방＆신발</a>
				</li>
			</ul>
			<%-- 오른쪽 메뉴 --%>
			<ul class="right_menu">
				<li><a href="${path}/customer/coordination.do" class="highlight">AI추천코디</a></li>
				<li><a href="${path}/customer/productlist" class="highlight">옷대여</a></li>
				<li><a href="${path}/adminqna/myqna.do">Q&A</a></li>
				<li><a href="${path}/notice/notices">공지사항</a></li>
			</ul>
		</div>
		<%-- 서브 메뉴 부분 --%>
		<div class="menu-backgorund"></div>
		<div class="menu_pan inner">
			<div class="dropdown_nav">

				<ul ctg="women">
				</ul>
				<ul ctg="men">
				</ul>
				<ul ctg="kids">
				</ul>
				<ul ctg="luxury">
				</ul>
				<ul ctg="sports">
				</ul>
				<ul ctg="bagAndShoes">
				</ul>

			</div>
		</div>
	</div>
</header>
<script>
	$(function() {
		//$.noConflict(); //제이쿼리 충돌방지
		//메뉴 드롭 다운
		var isFirstHover = true; // 처음 마우스를 올리는지 여부를 추적

		$(".left_menu > li").on("mouseenter", function() {
			var menuIndex = $(this).data("menu"); // data-menu 속성 값을 가져옴
			
	        $(".left_menu > li").css({
	            "color": "#ccc",
	            "font-weight": "normal"
	        }); // 모든 li를 #ccc 색상으로 변경하고 폰트 두께를 정상으로 설정
	        $(this).css({
	            "color": "black",
	            "font-weight": "bold"
	        }); // 호버한 li만 검정색으로 변경하고 폰트 두께를 두껍게 설정
			
			if (isFirstHover) {
				$(".dropdown_nav ul").stop().animate({
					height : "0"
				}, 500); // 모든 서브메뉴 높이 0으로 설정
				$(".dropdown_nav ul").eq(menuIndex).stop().animate({
					height : "400px"
				}, 500);
				$(".dropdown_nav").stop().animate({
					height : "400px"
				}, 500); // 서브메뉴 표시
	            $(".menu-backgorund").css("display","block");
				
				isFirstHover = false; // 이후 마우스 이동 시 애니메이션 제거
			} else {
				$(".dropdown_nav ul").css("height", "0"); // 모든 서브메뉴 높이 0으로 설정
				$(".dropdown_nav ul").eq(menuIndex).css("height", "400px");
				$(".dropdown_nav").css("height", "400px"); // 서브메뉴 표시
	            $(".menu-backgorund").css("display", "blcok"); // 배경 표시
	            
			}
		});

		$(".dropdown_nav").on("mouseleave", function() {
		   $(".left_menu > li").css({
	            "color": "black",
	            "font-weight": "normal"
	        }); // 모든 li 색상을 기본으로 변경하고 폰트 두께를 정상으로 설정
			// 마우스가 떠났을 때 서브메뉴 높이 초기화
			$(".dropdown_nav ul").css("height", "0");
			$(".dropdown_nav").css("height", "0");
	        $(".menu-backgorund").css("display","none"); // 배경 숨김	
			isFirstHover = true; // 마우스를 떠났을 때 다시 애니메이션 활성화
			
			
		});
	
		var h_ctg = {
				'women':11000000,
				'men':14000000,
				'kids':13000000,
				'luxury':15000000,
				'sports':12000000,
				'bagAndShoes':10000000
		}
		$.ajax({
			url:"${path}/prod/headerctg",
			type:'post',
			data:JSON.stringify(h_ctg),
			dataType: "json",
			contentType:"application/json",
			success: function(ctgMap) {
				for(var key in ctgMap) {
					$('.dropdown_nav').find(`ul[ctg='\${key}']`).append(`<li><a href='${path}/prod/productlist?shwCtgNum=\${ctgMap[key][0].parent_category_id}'>전체 상품</a></li>`);
					$(ctgMap[key]).each(function(index, ctgVO) {
						$('.dropdown_nav').find(`ul[ctg='\${key}']`).append(`<li><a href='${path}/prod/productlist?shwCtgNum=\${ctgVO.category_id}'>\${ctgVO.category_name}</a></li>`);
					});
				}
			},
			error: function() {
				
			}
		});
	});
</script>