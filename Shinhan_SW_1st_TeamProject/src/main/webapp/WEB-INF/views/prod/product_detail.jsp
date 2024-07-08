<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<%-- 로그인 여부를 확인하기 위한 세션 값 확인 --%>
<c:set var="isLoggedIn" value="${not empty sessionScope.member}"   />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세 페이지</title>
<%-- css --%>
<link rel="stylesheet" href="${path}/resources/css/product_detail.css">
<%-- 헤더,푸터 css --%>
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<%-- jquery 연결 --%>
<script src="${path}/resources/js/jquery-3.7.1.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<!-- bxSlider 플러그인 연결 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bxslider@4.2.17/dist/jquery.bxslider.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bxslider@4.2.17/dist/jquery.bxslider.min.js"></script>
<script>
	$(function() {
		//배송 안내 정보 토글
	    $(".toggle-button").click(function() {
	        var content = $(this).next(".toggle-content");
	        var arrow = $(this).find(".arrow");

	        content.slideToggle(300); // 내용의 표시/숨기기 
	        arrow.toggleClass("open"); // 화살표의 방향 변경
	    });
	    
	    
		//상품 상세 정보, 리뷰 버튼 조작  (동작 수정필요 - 리뷰버튼 클릭하고 상품정보버튼 클릭하면 상품정보내용이 안나타남)
		$('.detailbtn_wrap button').click(function(e) {
			e.preventDefault();
			
			// 버튼에 active 클래스 적용
			$('.detailbtn_wrap button').removeClass('this');
			$(this).addClass('this');

			// 관련된 컨텐츠 표시
			var tabId = $(this).data('tab');
			$('.container-detail, .container-review').removeClass('active');
			
			$('#' + tabId).addClass('active'); //container-detail에  다시 active가 안붙음
		});


		//상품 문의 모달창 열고 닫기 
		$('.qnaBtn').on('click', function() {
			$('#myModal').show();
		});

		$('.close').on('click', function() {
			$('#myModal').hide();
		});

		$(window).on('click', function(event) {
			if ($(event.target).is('#myModal')) {
				$('#myModal').hide();
			}
		});
		
		//대여버튼 팝업창 열고 닫기 
		$('.rent_btn').on('click', function() {
	        $('#rentPopup').show();
		});

		$('.rent-prod-close').on('click', function() {
			$('#rentPopup').hide();
		});

		$(window).on('click', function(event) {
			if ($(event.target).is('#rentPopup')) {
				$('#rentPopup').hide();
			}
		});
		
		//상품 문의 버튼 클릭 이벤트
        $('#prodQnaBtn').click(function() {
              var formData = $('#productQnaForm').serialize();
			  console.log(formData);
              $.ajax({
                  url: '${path}/prod/productQnaInsert.do',
                  type: 'POST',
                  data: formData,
                  success: function(response) {
                      alert(response);
                      location.reload(); 
                  },
                  error: function(xhr, status, error) {
                      console.error('Error:', error);
                      alert('오류가 발생했습니다. 다시 시도해주세요.');
                  }
              });
         });
		//메인 상품 사진 슬라이드
        $('.product-img-slide').bxSlider({
        	   auto: true,           // 자동 슬라이드		
               controls: true,      // 양옆 화살표 노출 여부
               pager: true,         // 슬라이드 밑 버튼 노출 여부
               minSlides: 1,
               maxSlides: 1
               //slideWidth: 500,
               //slideMargin: 10
    	});
      
	});
</script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<%-- prod폴더에서 작업중 --%>
	
	<%-- 대여 장바구니 팝업 창 --%>
	<div class="popup-background" id="popupBackground_rent">
	    <div class="popup-container">	       
	        <div class="popup-icon">!</div>	       
	         <p class="saveCartText">선택한 상품이 장바구니에 저장됩니다.</p> 
	        <p>장바구니로 이동하시겠습니까?</p>	        
	        <button id="yesRentCartBtn" class="popup-button yes-button">네</button>
	        <button id="noRentCartBtn" class="popup-button no-button">아니요</button>
	    </div>
	</div>
	<%-- 대여버튼 팝업 창 --%>
	<form id="rentPopupForm">
		<div id="rentPopup" class="rent-prod-overlay">
	        <div class="rent-prod-popup">
	            <div class="rent-prod-header">
	                <h2>상품 대여</h2>
	                <span class="rent-prod-close">&times;</span>
	            </div>
	            <%--상품 상세 정보 조회 --%>
	            <div class="rent-prod-content">
	                <p><strong>상품 명:</strong> (<strong class="blue-text">${prod_detail_info.BRAND}) ${prod_detail_info.PROD_NAME}</strong></p>
	                <div class="rent-prod-option">
	               		<strong>상품 옵션: </strong>
						<c:forEach items="${prod_Options}" var="prodOption" varStatus="status">
							<div>
								<p>${prodOption.OPT_NAME} :</p>
								<select id="rentOptions_${status.index}" name="${prodOption.OPT_NAME}">
								   <option disabled selected>선택</option>
							       <c:forTokens items="${prodOption.OPT_VALUE}" delims="," var="optValue" >
									     <c:set var="position" value="${fn:indexOf(optValue,'-')}"/>
									     <c:set var="optName" value="${fn:substring(optValue,0,position) }"/>
									     <c:set var="optLength" value="${fn:length(optValue)}"/>
									     <c:set var="optId" value="${fn:substring(optValue,position+1, optLength) }"/>
									     <option value="${optId}">${optName}</option>
									</c:forTokens>
							    </select> 
							</div>
				     	</c:forEach>
						<input type="hidden" name="prod_id" value="${prod_detail_info.prod_id}">
					</div>
	                <p>
	                <strong>대여량:</strong> 
	                	   <input type="number" id="rent_num" class="rent-prod-quantity" 
	                	   name="rent_num" value="0" min="0">개
	                </p>
	                <p><strong>대여 시작일 선택:</strong> <span>대여 기간은 7일입니다.</span></p>
	                
	                <div class="rent-prod-dates">
	                    <input type="date" id="rent_start_date" name="rent_start_date">
	                    <span> ~ </span>
	                    <input type="date" value="2024-07-01" id="rent_end_date" name="rent_end_date" readonly> <%-- 마감일 선택 불가 --%>
	                    <span class="small-text red-text">(제품도착일 - 반납처리일)</span>
	                </div>
	               
	                <div class="rent-prod-total">
	                    <p><strong>총 대여 금액</strong></p>
	                    <p class="total-amount"><strong>30,000원</strong></p> 
	                	
	                	<%-- 자바로 값을 넘겨주는 hidden타입 input --%>
	                	<input id="rent_product_price" name="rent_product_price" type="hidden" value="30000">
	                	<input id="total-price-hidden" name="total_rent_price" type="hidden" value=""> 
	                </div>
	                <p class="rent-prod-warning">! 선택한 상품의 옵션을 확인하신 후 대여를 진행해 주세요.</p>
		            <button type="button" class="rent-prod-button">대여하기</button> 
		            <button id="rentCartButton" type="button" class="rent-cart-button">장바구니</button> 
	            </div>
	        </div>
	    </div>
  	</form>
  
	<%-- 상품 장바구니 팝업 창 --%>
	<div class="popup-background" id="popupBackground">
	    <div class="popup-container">	       
	        <div class="popup-icon">!</div>	       
	        <p class="saveCartText">선택한 상품이 장바구니에 저장됩니다.</p> 
	        <p>장바구니로 이동하시겠습니까?</p>	        
	        <button id="yesCartBtn" class="popup-button yes-button">네</button>
	        <button id="noCartBtn" class="popup-button no-button">아니요</button>
	    </div>
	</div>
	<%-- 상품 문의 모달 창 --%>
	<form id="productQnaForm">
		
		<input type="hidden" name="prod_id" value="${prod_detail_info.prod_id}">
				
		<div id="myModal" class="modal">
			<div class="modal-content">
				<span class="close">&times;</span>
				<div class="modal-header">
					<h1>상품문의</h1>
				</div>
				<div class="modal-body">
					<label for="qnaTitle">문의 제목: </label>
					<input type="text" name="qnaTitle" placeholder="문의 제목" />
					<p>상품과 관련 없는 내용, 비방, 광고, 불건전한 내용의 글은 사전 동의 없이 삭제될 수 있습니다.</p>
					<textarea name="qnaTestarea"
						placeholder="문의 내용을 입력해주세요. 특수문자 &#87, &#47, &#60, &#62 는 사용할 수 없습니다.">
					</textarea>
					<br> 
				</div>
				<div class="modal-footer">
					<button id="prodQnaBtn" type="submit">등록</button> 
				</div>
			</div>
		</div>
	</form>
	<%-- 본문 --%>
	<div class="container">
		<div class="product_detail-inner">
				<p class="categoryName"><span class="homeText">home</span> > ${category.parentCategoryName} > ${category.currentCategoryName}</p>
				<div class="product-detail_wrap">
				
					<%-- 메인 상품 사진 :판매자가 등록한 이미지 중 첫번째 --%>
					<div class="product-image">
						<ul class="product-img-slide">
							<c:forEach var="imgNameMain" items="${mainImgIdList}">
								<li>
									<img src="/saren/ProdImgFile/main/${imgNameMain.IMG_ID}" alt="메인이미지">
								</li>
							</c:forEach>
						</ul>
					</div>
					
					<div class="product-details">
						<p class="free">무료배송</p>
						<h1>${prod_detail_info.BRAND}</h1>
						<h2>${prod_detail_info.PROD_NAME}</h2>
						<div class="price_wrap">
							<p class="productPrice">
								${String.format("%,d", Integer.parseInt(prod_detail_info.PROD_PRICE))}원
							</p>
						</div>
						<p class="rate">
							★${reviewInfo.AVG_RATE != nul ? reviewInfo.AVG_RATE : 0} <span>
							<a href="javascript:#void" class="review-rate-btn">
								리뷰 ${reviewInfo.REVIEW_COUNT != null ? reviewInfo.REVIEW_COUNT : 0 }건

							</a>
							</span>
						</p>
						<form id="prodOptionForm">
							<div class="choose_wrap">
								<p class="option_name">상품 옵션</p>
								<div class="select_choose">
									<div>
									    <c:forEach items="${prod_Options}" var="prodOption"  varStatus="status">
											<div>
												<p>${prodOption.OPT_NAME} :</p>
												<select id="options_${status.index}" name="${prodOption.OPT_NAME}">
												   <option disabled selected>선택</option>
											       <c:forTokens items="${prodOption.OPT_VALUE}" delims="," var="optValue" >
													     <c:set var="position" value="${fn:indexOf(optValue,'-')}"/>
													     <c:set var="optName" value="${fn:substring(optValue,0,position) }"/>
													     <c:set var="optLength" value="${fn:length(optValue)}"/>
													     <c:set var="optId" value="${fn:substring(optValue,position+1, optLength) }"/>
													     
													     <option value="${optId}">${optName}</option> 
													</c:forTokens>
											    </select> 
											</div>
								     	</c:forEach>
									</div>
								</div>
							</div>
							<div class="quantity-price">
								<div class="quantity_wrap">
									<p>수량 선택 :</p>
									<input type="number" id="order_num" class="quantity"
										name="order_num" value="0" min="0">
								</div>
								<p class="total"></p>  <%-- 총 상품 가격 --%>
							</div>
							
							<%-- 자바로 넘겨 줄 단가와 상품ID --%>
							<input type="hidden" name="productPrice" value="${prod_detail_info.PROD_PRICE}">  
							<input type="hidden" name="prod_id" value="${prod_detail_info.prod_id}">  
						</form>
						
						
						<div class="button-group">
							<button id="cartButton" type="button" class="white_button">장바구니</button> 
							<button id="orderButton" type="button" class="button">바로 구매</button>
						</div>
						
						<%-- 대여 재고에 있는 상품이면 대여하기 버튼 활성화 --%>
						<c:if test="${fn:length(rentProductStockCheck) > 0}">
						     <button type="button" class="rent_btn">대여하기</button>
						</c:if>
						<c:if test="${fn:length(rentProductStockCheck) == 0}">
						    <button type="button" class="noRent_btn">대여불가상품</button>
						</c:if>
					</div>
				</div>
			<script>
		        $(document).ready(function() {
		        	var currentStock = {}; ////선택한 옵션 상품의 재고id
					    
					var previousValues = {};//수량, 가격 처리
					

		            // 로그인 여부 확인 함수
		            function checkLoginStatus(callback) {
		                $.ajax({
		                    url: '${path}/prod/checkLoginStatus', // 서버에서 로그인 상태를 확인하는 엔드포인트
		                    type: 'GET',
		                    success: function(response) {
		                        if (response.isLoggedIn) {
		                             callback(); // 로그인 상태일 경우 콜백 함수 실행
		                        	 console.log("로그인 확인 성공");
		                        } else {
		                            alert('로그인이 필요합니다.');
		                        	// 로그인 페이지로 리다이렉트
		                            window.location.href = '${path}/member_test/login.do'; 
		                        }
		                    },
		                    error: function(error) {
		                        console.error('Error checking login status:', error);
		                    }
		                });
		            }
						
		    		/* 장바구니 버튼 클릭 시 나타나는 팝업창 */ 
		    		$('#cartButton').on('click', function(e) {
		    			e.preventDefault();
		    			//$('.popup-background').show();
		    			
		    		    checkLoginStatus(function() {
		    		    	console.log("로그인 체크 콜백함수 호출");
		    		    	//로그인 여부 체크 후 팝업창 열기
		    		    	$('.popup-background').show();
		    	        });
		    		});
		    		
		    		//네 선택 시 장바구니페이지로 이동
	        		$('.yes-button').on('click', function(e) {
	        			e.preventDefault();
	        			sendProdOption(); // 옵션 값을 컨트롤러로 넘겨주는 함수
	        			$('.popup-background').hide();
	        			
	        		});
	        		//아니요 선택 시 현재페이지 계속 쇼핑
	        		$('.no-button').on('click', function(e) {
	        			e.preventDefault();
	        			$('.popup-background').hide();
	        		});
	        		
		        });
				//버튼 클릭 -> 컨트롤러에 선택한 상품 옵션 값 넘김
				function sendProdOption(){
				
				   
					// 상품 원래 가격 (숫자만 추출)
				    var originalPrice = parseInt($('.productPrice').text().replace(/[^0-9]/g, ''));
				    $('.total').text(originalPrice.toLocaleString('ko-KR') + '원');

				    var previousValue = parseInt($('#order_num').val());

				    // 수량 입력 필드가 변경될 때마다 실행
				    $('#order_num').on('input', function() {
				       var currentValue = parseInt($(this).val()); // 수량

				       //확인용 (기능 구현 후 삭제)
				       if (currentValue < previousValue) {
				           console.log('수량이 감소 : ' + currentValue);
				       } else {
				           console.log('수량이 증가: ' + currentValue);
				       }
				       
				       if (currentValue <= currentStock.stock){
				       	// previousValue를 현재 값으로 업데이트
				        previousValue = currentValue;
				       	
				    	// 총 가격 업데이트 
				        var totalPrice = originalPrice * currentValue;
				        $('.total').text(totalPrice.toLocaleString('ko-KR') + '원');
				       } else {
				       		alert("수량 초과");
				       	//현재 재고까지만 수량 고르기 가능
				       	$('#order_num').val(currentStock.stock);
				       	return
				       }
				      
				   });
					
				    console.log(currentStock);
				    
					var allOptionsSelected = true;
			        $('#prodOptionForm select').each(function() {
			            if ($(this).val() === null || $(this).val() === "선택") {
			                allOptionsSelected = false;
			                return false; // each 루프 중지
			            }
			        });

			        if (!allOptionsSelected) {
			            alert("모든 옵션을 선택해 주세요.");
			            return;
		      		  }
				
			        // 컨트롤러에 상품 옵션 값 보내기
				    var formArray = $("#prodOptionForm").serializeArray();
					var param = { };

					// 배열을 JSON 객체로 변환
				    $.each(formArray, function(index, item) {
			            	param.s_stock_id =  currentStock.s_stock_id;
					    	param[item.name] = item.value;
				    });
					
					
					//모든 옵션이 선택된 경우 서버에 전송
					if (allOptionsSelected) {	
						
		        		$.ajax({
			                url: "${path}/prod/productCartInsert.do",
			                type: 'POST',
			                data:JSON.stringify(param),
			                contentType:"application/json;charset=utf-8",
			                success: function(response) {
			                    console.log("장바구니 response: " + response);
			                	if(response.status === 'success'){
			                   	  alert("장바구니에 저장 완료(현재 남은 재고" + currentStock.stock + "개)");
			                   	 location.href = "${path}/cart/cart.do?cart_id=" + response.cart_id;
			                      
			                    }else{
		                            alert('로그인이 필요합니다.');
		                        	// 로그인 페이지로 리다이렉트
		                            window.location.href = '${path}/member_test/login.do'; 
			                    }
			                },
			                error: function(error) {
			                    alert("Error: " + error);
			                }
			            });
			        } else {
			            alert("옵션을 선택해 주세요.");
			        }
				 	
				}
		    </script>
			
			<%-- 상품정보, 리뷰 버튼 --%>
			<div id="detailbtn_wrap" class="detailbtn_wrap">
				<button type="button" class="this" data-tab="container-detail">상품정보</button>
				<button type="button" data-tab="container-review">리뷰</button>
			</div>
			
			<%-- 상세 정보 (사진, 설명) --%>
			<div class="container-detail active">
				<div class="container-detail-img-wrap">
					<div class="container-detail-prod-img">  <%-- 스크롤처리 --%>
						<ul class="prod-img-scroll">
							<c:forEach var="imgName" items="${subImgIdList}">
								<li>
									<img src="/saren/ProdImgFile/desc/${imgName.IMG_ID}" alt="서브이미지">
								</li>
							</c:forEach>
							
						</ul>
					</div>
					<%-- 상품 설명 --%>
					<div class="container-detail-prod-subtext">  <%-- fixed --%>
						<h1>상품 상세 설명</h1>
						<h2>${prodDesc.prod_name}</h2>
						<p><span>상품번호: <span>${prodDesc.prod_id} , ${prodDesc.member_id}</p>
					    <c:forEach var="prod" items="${prod_Options}">
					        <p>Option: ${prod.OPT_NAME}, ${prod.OPT_VALUE}</p> 
					    </c:forEach> 
						<div class="prod-subtext-scroll">
							<p>${prodDesc.prod_desc}</p>
						</div>
					</div>				
				</div>
				<%-- 배송 정보 안내 --%>
				<div class="toggle-button inner">
					<h2>배송/교환/반품 안내</h2>
					<span class="arrow">▼</span>
				</div>
				<div class="toggle-content inner">
					<h3>배송안내</h3>
					<table>
						<tr>
							<td>일반 택배</td>
							<td>
								<p>전제품 국내산지에서 직접 배송하는 상품입니다.</p>
								<p>일반 택배: 전제품 국내산지에서 3일 이내 배송 (토,일,공휴일 제외)</p>
							</td>
						</tr>
						<tr>
							<td>교환/반품비용</td>
							<td>교환/반품 배송비: 2,500원 (CJ대한통운 교환/반품 수거 비용)</td>
						</tr>
						<tr>
							<td>교환/반품</td>
							<td>
								<p>1. 마이페이지에서 교환 신청 (단순 변심인 경우, 교환은 원하는 옵션 선택 후 교환신청)</p>
								<p>2. 교환 요청한 제품 회수하기 위해 반송비가 부과되는 경우 결제 완료 교환 선수</p>
								<p>3. 1~3일 내 반품 제품 수거 (택배 선택 검토 필요)</p>
								<p>4. 회수 제품 확인 후 상품 배송 (반품/교환 신청된 제품 외 교환/반품 배송)</p>
							</td>
						</tr>
						<tr>
							<td>안내사항</td>
							<td>
								<p>교환 기간: 교환은 제품을 받은 후 7일 내 가능합니다.</p>
								<p>반품 기간: 반품은 제품을 받은 후 7일 내 가능합니다.</p>
								<p>단순 변심일 경우 최초 배송한 상품의 상태와 다를 시 (세탁 또는 착용 후 외형 변형) 교환 및 반품이
									불가합니다.</p>
								<p>교환/반품 배송비: 2,500원 (CJ대한통운 교환/반품 수거 비용)</p>
							</td>
						</tr>
						<tr>
							<td>고객 A/S 안내</td>
							<td>이 상품은 입점사상품으로, 입점사의 A/S 정책에 따라 서비스가 제공됩니다. 상세한 문의사항은
								상품정보고객센터 및 A/S센터가 갖춘 정보를 확인해주세요.
							</td>
						</tr>
					</table>
				</div>
			</div>
			
			<%-- 리뷰 목록 --%>
			<div id="container-review" class="container-review inner">
			<h1>상품 리뷰</h1>
			<ul class="review_order">
				<li><a href="javascript:#void">최근 등록 순</a></li>
				<li><a href="javascript:#void">평점 높은 순</a></li>
				<li><a href="javascript:#void">평점 낮은 순</a></li>
			</ul>
			
			<c:if test="${empty productReviews}">
			    <p class="no-review">작성된 리뷰가 없습니다.</p>
			</c:if>
			<c:if test="${not empty productReviews}">
				<div class="review-list" id="review-list">
					<div class="review-scroll">	
						<c:forEach items="${productReviews}" var="review">
							<div class="review"> 
								<div class="left">
									<img src="${review.REVIEW_IMG}" width="150" height="150" alt="review image">   <%-- 리뷰 사진 (db작업 후 수정할 것) --%>
								</div>
								<div class="right">
									<div class="rating">
							            <c:set var="fullStars" value="${review.RATE - (review.RATE % 1)}" />
							            <c:set var="halfStar" value="${(review.RATE % 1) >= 0.5 ? 1 : 0}" />
							            <c:set var="emptyStars" value="${5 - fullStars - halfStar}" />
							
							            <c:forEach begin="1" end="${fullStars}" var="i">
							                <span>★</span>
							            </c:forEach>
							
							            <c:if test="${halfStar == 1}">
							                <span>☆</span>
							            </c:if>
							
							            <c:forEach begin="1" end="${emptyStars}" var="i">
							                <span>☆</span>
							            </c:forEach>
						        	</div>
						        	
						        	<%-- 리뷰상품 옵션값 불러오기 --%>
									<h3> 
										<c:forEach items="${prodOptions }" var="option">
										   <c:if test="${review.OPT_ID1==option.opt_id}">
										   ${option.opt_name } : ${option.opt_value }
										   </c:if> 
										   <c:if test="${review.OPT_ID2==option.opt_id}">
										   ${option.opt_name } : ${option.opt_value }
										   </c:if> 
										   <c:if test="${review.OPT_ID3==option.opt_id}">
										   ${option.opt_name } : ${option.opt_value }
										   </c:if> 
										   <c:if test="${review.OPT_ID4==option.opt_id}">
										   ${option.opt_name } : ${option.opt_value }
										   </c:if> 
										   <c:if test="${review.OPT_ID5==option.opt_id}">
										   ${option.opt_name } : ${option.opt_value }
										   </c:if> 
										</c:forEach>
									</h3>  
									<p>${review.REVIEW_CONTENT}</p>
									<p class="date">
										<fmt:formatDate value="${review.REVIEW_DATE}" pattern="yyyy-MM-dd"/>
									</p>
								</div>
							</div>
						</c:forEach>
					</div>
				</div>
			</c:if>
			<div class="review-write-btn">
				<button class="button-write">리뷰 작성하기</button>
			</div>
			<script type="text/javascript">
			    var path = "${path}";
			    var prodName = "${prod_detail_info.PROD_NAME}";
			</script>
			<script type="text/javascript">
			    //리뷰작성하기 버튼 클릭 
			    $('.review-write-btn > button').on('click', function(e) {
			        e.preventDefault();
			        location.href = path + "/review/write.do?prod_name=" + encodeURIComponent(prodName);
			    });
			</script>


				<div class="qa-section inner">
				<h2>상품 Q&A</h2>
				<div class="qa-section_txt">
				
					<%-- 상품 문의 있을 경우 테이블 생성 --%>
					<div class="qa-here">
						  <c:choose>
					        <c:when test="${not empty buyer_inqList}">
					            <table class="qa-table">
					                <thead>
					                    <tr>
					                        <th>문의 제목</th>
					                        <th>문의 내용</th>
					                        <th>작성자</th>
					                        <th>작성일</th>
					                    </tr>
					                </thead>
					                <tbody>
					                    <c:forEach var="inq" items="${buyer_inqList}">
					                        <tr>
					                            <td>${inq.buyer_inq_title}</td>
					                            <td>${inq.buyer_inq_content}</td>
					                            <td>${inq.member_id}</td>
					                            <td>${inq.buyer_inq_date}</td>
					                        </tr>
					                    </c:forEach>
					                </tbody>
					            </table>
					        </c:when>
					        <c:otherwise>
					            <p>등록된 상품 문의가 없습니다.</p>
					        </c:otherwise>
					    </c:choose>
					</div>
					<button id="qnaBtn" class="button-write qnaBtn">상품 문의하기</button>
				</div>
			</div>
			<script type="text/javascript">
				$('#qnaBtn').on('click',function(e){
					e.preventDefault();
				});
			</script>
			<%-- 배송 정보 안내 --%>
			<div class="toggle-button inner">
				<h2>배송/교환/반품 안내</h2>
				<span class="arrow">▼</span>
			</div>
			<div class="toggle-content inner">
				<h3>배송안내</h3>
				<table>
					<tr>
						<td>일반 택배</td>
						<td>
							<p>전제품 국내산지에서 직접 배송하는 상품입니다.</p>
							<p>일반 택배: 전제품 국내산지에서 3일 이내 배송 (토,일,공휴일 제외)</p>
						</td>
					</tr>
					<tr>
						<td>교환/반품비용</td>
						<td>교환/반품 배송비: 2,500원 (CJ대한통운 교환/반품 수거 비용)</td>
					</tr>
					<tr>
						<td>교환/반품</td>
						<td>
							<p>1. 마이페이지에서 교환 신청 (단순 변심인 경우, 교환은 원하는 옵션 선택 후 교환신청)</p>
							<p>2. 교환 요청한 제품 회수하기 위해 반송비가 부과되는 경우 결제 완료 교환 선수</p>
							<p>3. 1~3일 내 반품 제품 수거 (택배 선택 검토 필요)</p>
							<p>4. 회수 제품 확인 후 상품 배송 (반품/교환 신청된 제품 외 교환/반품 배송)</p>
						</td>
					</tr>
					<tr>
						<td>안내사항</td>
						<td>
							<p>교환 기간: 교환은 제품을 받은 후 7일 내 가능합니다.</p>
							<p>반품 기간: 반품은 제품을 받은 후 7일 내 가능합니다.</p>
							<p>단순 변심일 경우 최초 배송한 상품의 상태와 다를 시 (세탁 또는 착용 후 외형 변형) 교환 및 반품이
								불가합니다.</p>
							<p>교환/반품 배송비: 2,500원 (CJ대한통운 교환/반품 수거 비용)</p>
						</td>
					</tr>
					<tr>
						<td>고객 A/S 안내</td>
						<td>이 상품은 입점사상품으로, 입점사의 A/S 정책에 따라 서비스가 제공됩니다. 상세한 문의사항은
							상품정보고객센터 및 A/S센터가 갖춘 정보를 확인해주세요.
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
<%@ include file="../common/footer.jsp" %>
<script type="text/javascript">

	/* 판매상품 구매 기능 */
	
	//선택한 옵션 상품의 재고id 변수 선언
    var currentStock = {};
	//수량, 가격 처리
	var previousValues = {};
	
    // 로그인 여부 확인 함수
    function checkLoginStatus(callback) {
        $.ajax({
            url: '${path}/prod/checkLoginStatus', // 서버에서 로그인 상태를 확인하는 엔드포인트
            type: 'GET',
            success: function(response) {
                if (response.isLoggedIn) {
                     callback(); // 로그인 상태일 경우 콜백 함수 실행
                	 console.log("로그인 확인 성공");
                } else {
                    alert('로그인이 필요합니다.');
                	// 로그인 페이지로 리다이렉트
                    window.location.href = '${path}/member_test/login.do'; 
                }
            },
            error: function(error) {
                console.error('Error checking login status:', error);
            }
        });
    }

	// 상품 원래 가격 (숫자만 추출)
    var originalPrice = parseInt($('.productPrice').text().replace(/[^0-9]/g, ''));
    $('.total').text(originalPrice.toLocaleString('ko-KR') + '원');

    var previousValue = parseInt($('#order_num').val());

    // 수량 입력 필드가 변경될 때마다 실행
    $('#order_num').on('input', function() {
        var currentValue = parseInt($(this).val()); // 수량

        //확인용 (기능 구현 후 삭제)
        if (currentValue < previousValue) {
            console.log('수량이 감소 : ' + currentValue);
        } else {
            console.log('수량이 증가: ' + currentValue);
        }
        
        if (currentValue <= currentStock.stock){
        	// previousValue를 현재 값으로 업데이트
	        previousValue = currentValue;
        	
	    	 // 총 가격 업데이트 
	        var totalPrice = originalPrice * currentValue;
	        $('.total').text(totalPrice.toLocaleString('ko-KR') + '원');
        } else {
        	 //현재 재고까지만 수량 고르기 가능
        	 $('#order_num').val(currentStock.stock);
        	 alert("수량 초과");
        	 return
        }
    });

    // 모든 select 요소에 change 이벤트 리스너 추가
    $('#prodOptionForm select').on('change', function() {
    	 
        var allOptionsSelected = true;
        var isChanged = false;

        //select 요소의 현재 값과 이전 값을 비교
        $('#prodOptionForm select').each(function() {
            var currentValue = $(this).val();
            var name = $(this).attr('name');
            //// 현재 값이 null이거나 "선택"이면 모든 옵션이 선택되지 않은 것
            if (currentValue === null || currentValue === "선택") {
                allOptionsSelected = false;
                return false; // each 루프 중지
            }
            // 이전 값이 정의되어 있고 현재 값과 다르면 변경된 것으로 간주
            if (previousValues[name] !== undefined && previousValues[name] !== currentValue) {
                isChanged = true;
            }

            // 현재 값을 이전 값으로 저장
            previousValues[name] = currentValue;
        });

        if (isChanged) {
            $('#order_num').val(1); // 값이 변경된 경우 order_num(수량)를 1로 설정
            // 가격 초기화
            var totalPrice = originalPrice;
            $('.total').text(totalPrice.toLocaleString('ko-KR') + '원');
        } else if (allOptionsSelected) {
            var order_num = parseInt($('#order_num').val(), 10);
            $('#order_num').val(order_num + 1); // 모든 옵션이 선택된 경우 order_num 값을 1 증가
            // 총 가격 업데이트
            var totalPrice = originalPrice * (order_num + 1);
            $('.total').text(totalPrice.toLocaleString('ko-KR') + '원');
        }
        
        			
        if (allOptionsSelected) { //옵션 모두 선택 했을 경우
        	
	    	// 모든 옵션값에 해당하는 s_stock_id(재고ID) 찾아서 프론트에 저장하기
	    	var stockData = `${stockList}`;
	    	// var stockList = $.parseJSON('['+stockData+']')
	    	var stockList =JSON.parse(stockData);
			console.log(stockList);

	    	if(Array.isArray(stockList)){
	    		stockList.forEach((item, idx) => {
	    			

	    		 //현재선택한 옵션 상품의 재고id 업데이트 
	    		 //select id="options_0~5"
	    		 var selectOption1 = $('#options_0').val(); //예:'4'
    			 var selectOption2 = $('#options_1').val(); //예:'1'
    			 var selectOption3 = $('#options_2').val();
    			 var selectOption4 = $('#options_3').val();
    			 var selectOption5 = $('#options_4').val();
    			 
    			 if(selectOption1 !== undefined && parseInt(selectOption1) !== item.opt_id1){
    				 return;
    			 } 
    			 if(selectOption2 !== undefined && parseInt(selectOption2) !== item.opt_id2){
    				 return;
    			 } 
    			 if(selectOption3 !== undefined && parseInt(selectOption3) !== item.opt_id3){
    				 return;
    			 } 
    			 if(selectOption4 !== undefined && parseInt(selectOption4) !== item.opt_id4){
    				 return;
    			 } 
    			 if(selectOption5 !== undefined && parseInt(selectOption5) !== item.opt_id5){
    				 return;
    			 } 
    			 
    			 currentStock = item;

	    		 console.log(currentStock);
    			 
    			});
	    		
	    	}
	    	
        }
        
    });

	//구매하기 버튼 클릭 
	$('#orderButton').on('click', function(){
		

    	//checkLoginStatus(function() {
  		   
    	
			var allOptionsSelected = true;
	        $('#prodOptionForm select').each(function() {
	            if ($(this).val() === null || $(this).val() === "선택") {
	                allOptionsSelected = false;
	                return false; // each 루프 중지
	            }
	        });
	
	        if (!allOptionsSelected) {
	            alert("모든 옵션을 선택해 주세요.");
	            return;
	     	}
		
	        // 컨트롤러에 상품 옵션 값 보내기
		    var formArray = $("#prodOptionForm").serializeArray();
			var param = { };
	
		
			// 배열을 JSON 객체로 변환
		    $.each(formArray, function(index, item) {
	            	param.s_stock_id =  currentStock.s_stock_id;
			    	param[item.name] = item.value;
		    });
			console.log(formArray);
			console.log("param: " + param);
			
			//모든 옵션이 선택된 경우 서버에 전송
	  		if (allOptionsSelected) {	
	       		$.ajax({
	                url: "${path}/prod/productOrderInsert.do",
	                type: 'POST',
	                data:JSON.stringify(param),
	                contentType:"application/json;charset=utf-8",
	                success: function(response) {
	                    console.log(response);
	                    if(response.status === 'success'){
	                        alert("주문 저장 완료");
	                        //주문페이지로 이동
	                        location.href = "${path}/customer/orderPay.do?order_id=" + response.order_id;
	                    } else {
                            alert('로그인이 필요합니다.');
                        	// 로그인 페이지로 리다이렉트
                            window.location.href = '${path}/member_test/login.do'; 
	                    }
	                },
	                error: function(error) {
	                    alert("Error: " + error);
	                }
	            });
	        } else {
	            alert("옵션을 선택해 주세요.");
	        }
    	//});
	});
</script>
<script type="text/javascript">
  $(document).ready(function() {
  	
  	/*  대여하기 기능  */
  	
  	//대여가격 기본 3만원으로 설정
     const basePrice = 30000;
  	 
     function formatDate(date) {
         var day = String(date.getDate()).padStart(2, '0');
         var month = String(date.getMonth() + 1).padStart(2, '0');
         var year = date.getFullYear();

         return year + '-' + month + '-' + day;
     }
 	 //7일 후의 날짜 설정
     function setReturnDate(startDate) {
         var returnDate = new Date(startDate);
         returnDate.setDate(returnDate.getDate() + 7);
         return formatDate(returnDate);
     }
 	 //대여 가격
     function updateTotalPrice() {
         var rent_num = $('#rent_num').val();
         var totalPrice = basePrice * rent_num;
         $('.total-amount>strong').text(totalPrice.toLocaleString('ko-KR') + '원');
         
         $('#rent_product_price').val(basePrice);
         
         //$('#basePrice').val(basePrice);  //기본 대여 가격
         $('#total-price-hidden').val(totalPrice); //총 수량별 대여가격 
         
     }
     var today = new Date();
     var formattedToday = formatDate(today);
     $('#rent_start_date').val(formattedToday);

   	//초기 종료일 설정
     var initialReturnDate = setReturnDate(today);
     $('#rent_end_date').val(initialReturnDate);

     //시작일 이벤트 
     $('#rent_start_date').on('input', function() {
         var selectedStartDate = new Date($(this).val());
         var newReturnDate = setReturnDate(selectedStartDate);
         $('#rent_end_date').val(newReturnDate);
     });
     // 종료일을 사용자가 직접 변경할 수 없음
     $('#rent_end_date').on('input', function() {
         var startDate = new Date($('#rent_start_date').val());
         $(this).val(setReturnDate(startDate));
     });
     
     $('#rent_num').on('input', function() {
         updateTotalPrice();
     });
     
     updateTotalPrice(); // 초기 총 대여 금액 설정
     
  	//선택한 옵션 상품의 재고id 변수 선언
    var currentStock = {};

	//수량, 가격 처리
	var previousValues = {};
	// 상품 원래 가격 (숫자만 추출)
    var originalPrice = parseInt($('.productPrice').text().replace(/[^0-9]/g, ''));
    $('.total').text(originalPrice.toLocaleString('ko-KR') + '원');

    var previousValue = parseInt($('#order_num').val());

    // 수량 입력 필드가 변경될 때마다 실행
    $('#rent_num').on('input', function() {
       var currentValue = parseInt($(this).val()); // 수량

       //확인용 (기능 구현 후 삭제)
       if (currentValue < previousValue) {
           console.log('수량이 감소 : ' + currentValue);
       } else {
           console.log('수량이 증가: ' + currentValue);
       }
       
       if (currentValue <= currentStock.stock){
       	// previousValue를 현재 값으로 업데이트
        previousValue = currentValue;
       	
    	// 총 가격 업데이트 
        var totalPrice = originalPrice * currentValue;
        $('.total').text(totalPrice.toLocaleString('ko-KR') + '원');
       } else {
       	alert("수량 초과");
       	//현재 재고까지만 수량 고르기 가능
       	$('#rent_num').val(currentStock.stock);
       	return
       }
   });

   // 모든 select 요소에 change 이벤트 리스너 추가
   $('#rentPopupForm select').on('change', function() {
       var allOptionsSelected = true;
       var isChanged = false;

       //select 요소의 현재 값과 이전 값을 비교
       $('#rentPopupForm select').each(function() {
           var currentValue = $(this).val();
           var name = $(this).attr('name');
           //// 현재 값이 null이거나 "선택"이면 모든 옵션이 선택되지 않은 것
           if (currentValue === null || currentValue === "선택") {
               allOptionsSelected = false;
               return false; // each 루프 중지
           }
           // 이전 값이 정의되어 있고 현재 값과 다르면 변경된 것으로 간주
           if (previousValues[name] !== undefined && previousValues[name] !== currentValue) {
               isChanged = true;
           }

           // 현재 값을 이전 값으로 저장
           previousValues[name] = currentValue;
       });

       if (isChanged) {
           $('#rent_num').val(1); // 값이 변경된 경우 rent_num(수량)를 1로 설정
           // 가격 초기화
           var totalPrice = originalPrice;
           $('.total').text(totalPrice.toLocaleString('ko-KR') + '원');
       } else if (allOptionsSelected) {
           var rent_num = parseInt($('#rent_num').val(), 10);
           $('#rent_num').val(order_num + 1); // 모든 옵션이 선택된 경우 rent_num 값을 1 증가
           // 총 가격 업데이트
           var totalPrice = originalPrice * (rent_num + 1);
           $('.total').text(totalPrice.toLocaleString('ko-KR') + '원');
       }
       
       // 현재 대여재고아이디 저장				
       if (allOptionsSelected) { //옵션 모두 선택 했을 경우
       	
    	// 모든 옵션값에 해당하는 r_stock_id(대여재고ID) 찾아서 프론트에 저장
    	var rStockData = `${rentStockList}`;
    	var rStockList =JSON.parse(rStockData);
    	if(Array.isArray(rStockList)){
    		rStockList.forEach((item, idx) => {
    			
    		 //현재 옵션의 대여상품 재고id 업데이트 
    		 //select id="rentOptions_0~5"
    		 var selectOption1 = $('#rentOptions_0').val(); //예:'4'
   			 var selectOption2 = $('#rentOptions_1').val(); //예:'1'
   			 var selectOption3 = $('#rentOptions_2').val();
   			 var selectOption4 = $('#rentOptions_3').val();
   			 var selectOption5 = $('#rentOptions_4').val();
   			 
   			 if(selectOption1 !== undefined && parseInt(selectOption1) !== item.opt_id1){
   				 return;
   			 } 
   			 if(selectOption2 !== undefined && parseInt(selectOption2) !== item.opt_id2){
   				 return;
   			 } 
   			 if(selectOption3 !== undefined && parseInt(selectOption3) !== item.opt_id3){
   				 return;
   			 } 
   			 if(selectOption4 !== undefined && parseInt(selectOption4) !== item.opt_id4){
   				 return;
   			 } 
   			 if(selectOption5 !== undefined && parseInt(selectOption5) !== item.opt_id5){
   				 return;
   			 } 
   			 
   			 currentStock = item;
   		
    		 console.log(currentStock);
   			 
   			});
    		
    	 }
    	
       }
       
   });
  	
   //[대여 팝업창] 대여하기 버튼 클릭 이벤트
  	$('.rent-prod-button').on('click',function(){
  		
  		var allOptionsSelected = true;
       $('#rentPopupForm select').each(function() {
           if ($(this).val() === null || $(this).val() === "선택") {
               allOptionsSelected = false;
               return false; // each 루프 중지
           }
       });

       if (!allOptionsSelected) {
           alert("모든 옵션을 선택해 주세요.");
           return;
    	}

	    // 컨트롤러에 상품 옵션 값 보내기
	    var rentFormArray = $("#rentPopupForm").serializeArray();
		var rentFormParam = { };
	
		// 배열을 JSON 객체로 변환
	    $.each(rentFormArray, function(index, item) {
	    		rentFormParam.r_stock_id =  currentStock.r_stock_id;
		    	rentFormParam[item.name] = item.value;
	    });
			 
  		 //옵션 값이 null일 때 경고 띄우기
		 var allOptionsSelected = true;
  		 $('#rentPopupForm select').each(function() {
            if ($(this).val() === null) {
                allOptionsSelected = false;
                return false; 
            }
    	 });
	  		 
        if (!allOptionsSelected) {
           alert("모든 옵션을 선택해 주세요.");
           return;
    		 }
        
  		 $.ajax({
               url: "${path}/prod/rentProductOrderInsert.do",
               type: 'POST',
               data:JSON.stringify(rentFormParam),
               contentType:"application/json;charset=utf-8",
               success: function(response) {
              	if(response.status === 'success'){
              		alert("대여 저장 완료 (현재 남은 재고" + currentStock.stock + "개)");
                    //대여 결제페이지로 이동
                    location.href = "${path}/customer/rentPay.do?rental_code=" + response.rental_code;
                } else {
                    alert('로그인이 필요합니다.');
                	// 로그인 페이지로 리다이렉트
                    window.location.href = '${path}/member_test/login.do'; 
                }
              	 
              	 
               },
               error: function(error) {
              	 	 alert("Error: "+error);
               }
           });
  	});
   
   //[대여 팝업창] 장바구니 버튼 클릭 이벤트
   $('#rentCartButton').on('click',function(){
   	
   	var allOptionsSelected = true;
       $('#rentPopupForm select').each(function() {
           if ($(this).val() === null || $(this).val() === "선택") {
               allOptionsSelected = false;
               return false; // each 루프 중지
           }
       });

       if (!allOptionsSelected) {
           alert("모든 옵션을 선택해 주세요.");
           return;
    		  }

     // 컨트롤러에 상품 옵션 값 보내기
    var formArray = $("#rentPopupForm").serializeArray();
	var param = { };

	// 배열을 JSON 객체로 변환
    $.each(formArray, function(index, item) {
	       	param.r_stock_id =  currentStock.r_stock_id;   
           	param[item.name] = item.value;
    });
	
	 console.log(param);
	 
	//모든 옵션이 선택된 경우 서버에 전송
	if (allOptionsSelected) {	
		
      		$.ajax({
               url: "${path}/prod/rentProductCartInsert.do",
               type: 'POST',
               data:JSON.stringify(param),
               contentType:"application/json;charset=utf-8",
               success: function(response) {
                   console.log(response);
               	  if(response.status === 'success'){
	                   alert("대여상품 장바구니 저장 완료(현재 남은 재고" + currentStock.stock + "개)");
	                   location.href = "${path}/cart/cart.do?cart_id=" + response.rentCartId;
                   }else{
                       alert('로그인이 필요합니다.');
                   	// 로그인 페이지로 리다이렉트
                       window.location.href = '${path}/member_test/login.do'; 
                   }
               },
               error: function(error) {
                   alert("Error: " + error);
               }
           });
       } else {
           alert("옵션을 선택해 주세요.");
       }
   	
   });
     
  });
  </script>						
</body>
</html>