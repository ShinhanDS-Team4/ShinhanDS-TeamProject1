<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
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
<script>
	$(function() {
		//배송 안내 정보 토글
		$('.toggle-button').click(function() {
			$('.toggle-content').slideToggle();
			$('.arrow').toggleClass('open');
		});

		//상품 상세 정보, 리뷰 버튼 조작  (수정필요! 리뷰버튼 클릭하고 상품정보버튼 클릭하면 상품정보내용이 안나타남)
		//첫번째 button이 this클래스를 갖고있으면 컨테이너-디테일이 active클래스 붙음
		//두번째 button이 this클래스를 갖고있으면 컨테이너-리뷰에 active클래스 붙음
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
	});

</script>
</head>
<body>
	<%@ include file="../common/header.jsp" %>
	<%-- prod폴더에서 작업중 --%>
	
	<%-- 대여버튼 팝업 창 --%>
	<form id="rentPopupForm">
		<div id="rentPopup" class="rent-prod-overlay">
	        <div class="rent-prod-popup">
	            <div class="rent-prod-header">
	                <h2>상품 대여</h2>
	                <span class="rent-prod-close">&times;</span>
	            </div>
	            <div class="rent-prod-content">
	           		<c:forEach items="${prod_detail_info}" var="prod"> <%--상품 상세 정보 조회 --%>
		                <p><strong>상품 명:</strong> (<strong class="blue-text">${prod.BRAND}) ${prod.PROD_NAME}</strong></p>
		                <div class="rent-prod-option">
		               		<strong>상품 옵션: </strong>
							<c:forEach items="${prod_Options}" var="prodOption">
								<div>
									<p>${prodOption.OPT_NAME} :</p>
									<select id="product-option" name="${prodOption.OPT_NAME}">
									   <option disabled selected>선택</option>
								       <c:forTokens items="${prodOption.OPT_VALUE}" delims="," var="optValue">
										     <option value="${optValue}">${optValue}</option>
										</c:forTokens>
								    </select> 
								</div>
					     	</c:forEach>
						</div>
		                <p>
		                <strong>대여량:</strong> 
		                <input type="number" id="rent-prod-quantity" class="rent-prod-quantity" 
		                	   name="rent-prod-quantity" value="1" min="1">개
		                </p>
		                <p><strong>대여 시작일 선택:</strong> <span>대여 기간은 7일입니다.</span></p>
		                
		                <div class="rent-prod-dates">
		                    <input type="date" id="rent_start_date" name="rent_start_date">
		                    <span> ~ </span>
		                    <input type="date" value="2024-07-01" id="rent_end_date" name="rent_end_date" readonly> <%-- 마감일 선택 불가 --%>
		                    <span class="small-text red-text">(제품도착일 - 반납처리일)</span>
		                </div>
	                </c:forEach>
	                <div class="rent-prod-total">
	                    <p><strong>총 대여 금액</strong></p>
	                    <p class="total-amount"><strong>30,000원</strong></p> <%-- js: 기간확인 후 가격붙이기 --%>
	                	<input type="hidden" value="30000"> <%-- 자바로 넘길 대여가격 --%>
	                </div>
	                <p class="rent-prod-warning">! 선택한 상품의 옵션을 확인하신 후 대여를 진행해 주세요.</p>
		            <button type="button" class="rent-prod-button">대여하기</button> 
	            </div>
	        </div>
	    </div>
  	</form>
    <script type="text/javascript">
    $(document).ready(function() {
    	
    	
      $('.rent-prod-button').on('click',function(){
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
           var quantity = $('#rent-prod-quantity').val();
           var totalPrice = basePrice * quantity;
           $('.total-amount>strong').text(totalPrice.toLocaleString() + '원');
           $('#total-price-hidden').val(totalPrice);
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
       
       $('#rent-prod-quantity').on('input', function() {
           updateTotalPrice();
       });
       
       updateTotalPrice(); // 초기 총 대여 금액 설정
       
       
    	//대여 팝업창 대여하기 버튼 클릭 이벤트
    	//$('.rent-prod-button').on('click',function(){
    		 var rentFormData = $('#rentPopupForm').serialize();
    		 
    		 console.log("rentFormData: " + rentFormData);
    		 /*
    		 $.ajax({
                 url: "${path}/prod/isProductRentable",
                 type: 'POST',
                 data: rentFormData,
                 success: function(response) {
                 	 alert(response);
                 },
                 error: function(error) {
                	 	alert("Error: "+error);
                 }
             });*/
    		 $.ajax({
                 url: "${path}/prod/isProductRentable?"+rentFormData,
                 type: 'POST',
                 //data: rentFormData,
                 success: function(response) {
                 	 alert(response);
                 },
                 error: function(error) {
                	 	alert("Error: "+error);
                 }
             });
    	});
    });
    </script>
	<%-- 장바구니 팝업 창 --%>
	<div class="popup-background" id="popupBackground">
	    <%-- 팝업 컨테이너 --%>
	    <div class="popup-container">
	        <%-- 팝업 아이콘 --%>
	        <div class="popup-icon">!</div>
	        <%-- 팝업 메시지 --%>
	        <p>장바구니로 이동하시겠습니까?</p>
	        <!-- 팝업 버튼 -->
	        <button class="popup-button yes-button">네</button>
	        <button class="popup-button no-button">아니요</button>
	    </div>
	</div>
	<%-- 상품 문의 모달 창 action="${path}/prod/productQnaInsert.do"  method="post" --%>
	<form id="productQnaForm">
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
					<%-- <input type="text" name="qnaWriterName" placeholder="이름" /> --%>
				</div>
				<div class="modal-footer">
					<button id="prodQnaBtn" type="submit">등록</button> 
				</div>
			</div>
		</div>
	</form>
	  <script>
        $(document).ready(function() {
        	//상품 문의 버튼 클릭 이벤트
        	$(document).ready(function() {
                $('#prodQnaBtn').click(function() {
                    var formData = $('#productQnaForm').serialize();

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
            });
        });
    </script>
	<%-- 본문 --%>
	<div class="container">
		<div class="product_detail-inner">
			<c:forEach items="${prod_detail_info}" var="prod">
				<p>home > ${prod.PARENT_CATEGORY_NAME} > ${prod.SUB_CATEGORY_NAME}</p>
				<div class="product-detail_wrap">
				
					<%-- 메인 상품 사진 :판매자가 등록한 이미지 중 첫번째 --%>
					<div class="product-image">
						<img src="${path}/resources/images/product1.png" alt="상품">  
					</div>
					<div class="product-details">
						<p class="free">무료배송</p>
						<h1>${prod.BRAND}</h1>
						<h2>${prod.PROD_NAME}</h2>
						<div class="price_wrap">
							<p class="productPrice">
								${prod.PROD_PRICE}원
							</p>
						</div>
						<p class="rate">
							★${prod.AVERAGE_RATE} <span><a href="javascript:#void" class="review-rate-btn">리뷰 ${prod.REVIEW_COUNT}건</a></span>
						</p>
						<form id="prodOptionFrom" >
							<div class="choose_wrap">
								<p class="option_name">상품 옵션</p>
								<div class="select_choose">
									<%-- 현재 판매 상품의 옵션들 --%>
									<div>
										<c:forEach items="${prod_Options}" var="prodOption">
											<p>${prodOption.OPT_NAME} :</p>
											<select id="product-option" name="${prodOption.OPT_NAME}">
											   <option disabled selected>선택</option>
										       <c:forTokens items="${prodOption.OPT_VALUE}" delims="," var="optValue">
												     <option value="${optValue}">${optValue}</option>
												</c:forTokens>
										    </select> 
								     	</c:forEach>
									</div>
								</div>
							</div>
							<div class="quantity-price">
								<div class="quantity_wrap">
									<p>수량 선택 :</p>
									<input type="number" id="quantity" class="quantity"
										name="quantity" value="1" min="1">
								</div>
								<p class="total"></p>  <%-- 총 상품 가격 --%>
							</div>
							
							<%-- !!!!!!!!!! 자바로 넘겨 줄 단가와 상품ID !!!!!!!!!! --%>
							<input type="hidden" name="productPrice" value="100000">  <%--value="${prod.prod_price}" --%>
							<input type="hidden" name="prod_id" value='나이키 반팔_1234-1234'> <%-- value="${prod.prod_id}"> --%>
						</form>
						<div class="button-group">
							<button id="cartButton" type="button" class="white_button">장바구니</button> 
							<%-- <input id="cartButton" type="button" class="white_button" value="장바구니" /> --%>
							<button type="button" class="button">바로 구매</button>
						</div>
						
						<%-- 
							대여 재고에 있는 상품이면 대여하기 버튼 활성화 시키기 (상품의 대여재고id를 찾기)
						--%>
						<%-- <button type="button" class="noRent_btn">대여불가상품</button> --%>
						<button type="button" class="rent_btn">대여하기</button>
					</div>
				</div>
			</c:forEach>
			<script>
		        $(document).ready(function() {
		    		/* "장바구니 버튼" 선택 시 나타나는 팝업창 */ 
		    		$('#cartButton').on('click', function(e) {
		    			
		    			e.preventDefault();
		    			
		    			$('.popup-background').show();
		    			
		    			console.log("장바구니 버튼 클릭");
		    			
		    		});
		    		
		    		//네 선택 시 장바구니페이지로 이동
	        		$('.yes-button').on('click', function(e) {
	        			e.preventDefault();
	        			
	        			prodOption(); // 옵션 값을 컨트롤러로 넘겨주는 함수
	        			
	        			console.log("네 버튼");
	        			
	        			$('.popup-background').hide();
	        			
	        		});
	        		//아니요 선택 시 현재페이지 계속 쇼핑
	        		$('.no-button').on('click', function(e) {
	        			e.preventDefault();
	        			prodOption();
	        			
	        			console.log("아니요 버튼");
	        			
	        			location.reload(); 
	        		});
	        		
		        });
				//버튼 클릭 -> 컨트롤러에 선택한 상품 옵션 값 넘김 (수정중)
				function prodOption(){
					//컨트롤러에 상품 옵션 값 보내기
			   		var param =  $("#prodOptionFrom").serialize();
		
				 	//선택한 옵션이 null인 경우 페이지 이동 X
					if(param != null){
						
						 $.ajax({
			                    url: "${path}/prod/productCartInsert.do?" + param ,
			                    type: 'GET',
			                    success: function(response) {
			                    	 console.log(response);
			                    	 alert(response);
			                    	 alert("장바구니에 저장 완료");
			                    },
			                    error: function(error) {
			                   	 	alert("Error: "+error);
			                    }
			                });
					}else{
						alert("옵션을 선택해 주세요.");
					}
					//location.href : Get요청
					//location.href= "${path}/prod/productOption?" + param;
				}
		    </script>
			
			<%-- 상품정보, 리뷰 버튼 --%>
			<div id="detailbtn_wrap" class="detailbtn_wrap">
				<button type="button" class="this" data-tab="container-detail">상품정보</button>
				<button type="button" data-tab="container-review">리뷰</button>
			</div>
			<%-- 상세 정보 --%>
			<div class="container-detail active">
				<h1 style="text-align: center;">상품 정보 이미지 등록할 부분</h1>
				<div class="container-detail-here"></div>
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
					<%-- 리뷰가 3개 이상일 때 스크롤 아이콘 ( 수정필요 )
						<div class="scroll-icon-wrap">
							<img alt="스크롤아이콘" src="${path}/resources/images/icon-scroll.png"> 
						</div>
					--%>
						<c:forEach items="${productReviews}" var="review">
							<div class="review"> 
								<div class="left">
									<img src="" alt="review image">   <%-- 리뷰 사진 (db작업 후 수정할 것) --%>
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
										   ${option.opt_name } ${option.opt_value }
										   </c:if> 
										   <c:if test="${review.OPT_ID2==option.opt_id}">
										   ${option.opt_name } ${option.opt_value }
										   </c:if> 
										   <c:if test="${review.OPT_ID3==option.opt_id}">
										   ${option.opt_name } ${option.opt_value }
										   </c:if> 
										   <c:if test="${review.OPT_ID4==option.opt_id}">
										   ${option.opt_name } ${option.opt_value }
										   </c:if> 
										   <c:if test="${review.OPT_ID5==option.opt_id}">
										   ${option.opt_name } ${option.opt_value }
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
				//리뷰작성하기 버튼 클릭 : ${path}/review/write.do 로 이동
				$('.review-write-btn>button').on('click',function(e){
					e.preventDefault();
					location.href = "${path}/review/write.do";
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
	<script>
        $(document).ready(function() {
            // 원래 가격 (숫자만 추출)
            var originalPrice = parseInt($('.productPrice').text().replace(/[^0-9]/g, ''));

            $('.total').text(originalPrice + '원');

            var previousValue = parseInt($('.quantity').val());

            // 수량 입력 필드가 변경될 때마다 실행
            $('.quantity').on('input', function() {
                var currentValue = parseInt($(this).val()); // 수량

                if (currentValue < previousValue) {
                    console.log('수량이 감소 : ' + currentValue);
                } else {
                    console.log('수량이 증가: ' + currentValue);
                }

                // previousValue를 현재 값으로 업데이트
                previousValue = currentValue;

                // 할인된 가격과 총 가격 업데이트 
                var totalPrice = originalPrice * currentValue;
                $('.total').text(totalPrice.toLocaleString() + '원');
            });
    		
        });
    </script>
</body>
</html>