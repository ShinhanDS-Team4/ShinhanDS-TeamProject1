<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자판매물품리스트</title>
<!-- 본문 css -->
<link rel="stylesheet" href="${path}/resources/css/style.css">
<!-- 헤더,푸터 css -->
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">

<!-- jquery 연결 -->
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/seller_prdList.css" />
<script>
	function deleteCheckedSellStock(){
		var selectedStatus='일괄삭제';
		var selectedSellStocks=[];
		$('.sellStock-checkbox:checked').each(function(){
			selectedSellStocks.push($(this).data('id'));
		});
		
		if(selectedSellStocks.length>0){
			$.ajax({
				url:'/shoppingmall/seller/deleteSellStocks',
				type:'POST',
				contentType:'application/json',
				data:JSON.stringify({sellStockIds:selectedSellStocks,status:selectedStatus}),
				success: function(response){
    				if(response==="Delete Success"){
    					alert('선택 항목 삭제 완료');
    					location.reload();
    				}else{
    					alert('삭제 중 오류 발생');
    				}
    			},
    			error:function(){
    				alert('서버 요청 중 오류가 발생했습니다.');
    			}
			});
		}else {
        	alert('선택한 재고가 없습니다.');
    	}
	}
	
	function deleteCheckedRentStock(){
		var selectedStatus='일괄삭제';
		var selectedRentStocks=[];
		$('.rentStock-checkbox:checked').each(function(){
			selectedRentStocks.push($(this).data('id'));
		});
		
		if(selectedSellStocks.length>0){
			$.ajax({
				url:'/shoppingmall/seller/deleteRentStocks',
				type:'POST',
				contentType:'application/json',
				data:JSON.stringify({rentStockIds:selectedRentStocks,status:selectedStatus}),
				success: function(response){
    				if(response==="Delete Success"){
    					alert('선택 항목 삭제 완료');
    					location.reload();
    				}else{
    					alert('삭제 중 오류 발생');
    				}
    			},
    			error:function(){
    				alert('서버 요청 중 오류가 발생했습니다.');
    			}
			});
		}else {
        	alert('선택한 재고가 없습니다.');
    	}
	}
</script>
</head>
<body>
	<%@ include file="../common/header.jsp"%>
	<main>
		<aside>
			<ul>
				<%-- <li><a onclick="location.href='${path}/seller/MainPage.do'">통계</a></li> --%>
				<li><a onclick="location.href='${path}/seller/PrdList.do'">판매/대여
						상품 목록</a></li>
				<li><a onclick="location.href='${path}/seller/DeliveryList.do'">주문/배송</a></li>
				<li><a onclick="location.href='${path}/seller/Q&AList.do'">문의
						목록</a></li>
			</ul>
		</aside>
		<section id="section">
			<h2>마이페이지</h2>
			<hr />
			<div class="user-info">
				<p>${sellerInfo.member_name}</p>
				<p>${sellerInfo.member_id}</p>
			</div>
			<!--판매 상품 목록 리스트-->
			<h3>판매 상품 목록</h3>
			<div class="product-list">
				<table class="sellPrdList">
					<thead>
						<tr>
							<th></th>
							<th>상품등록번호</th>
							<th>등록일자</th>
							<th>가격</th>
							<th>재고량</th>
							<th>조회/수정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="sStock" items="${stockSList}">
							<tr>
								<td><input type="checkbox" class="sellStock-checkbox" data-id="${sStock.s_stock_id }"/></td>
								<td>${sStock.s_stock_id}</td>
								<td>${sStock.prod_added_date}</td>
								<td>${sStock.prod_price}</td>
								<td>${sStock.stock}</td>
								<td><button type="button" onclick="location.href='${path}/seller/ModifyProduct.do?stock_id=${sStock.s_stock_id}'">조회/수정</button></td>
							</tr>
						</c:forEach>
						<!-- 여기는 예시 -->
					</tbody>
				</table>
				
			</div>
			<div class="actions">
				<button id="delete_selected_sStock" onclick="deleteCheckedSellStock()">선택 상품 삭제</button>
			</div>
			
			<!-- 대여 상품 리스트 -->
			<h3>대여 상품 목록</h3>
			<div class="product-list">
				
				<table class="sellPrdList">
					<thead>
						<tr>
							<th></th>
							<th>상품등록번호</th>
							<th>등록일자</th>
							<th>가격</th>
							<th>재고량</th>
							<th>조회/수정</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="rStock" items="${stockRList}">
							<tr>
								<td><input type="checkbox" class="rentStock-checkbox" data-id="${rStock.r_stock_id }"/></td>
								<td>${rStock.r_stock_id}</td>
								<td>${rStock.prod_added_date}</td>
								<td>${rStock.prod_price}</td>
								<td>${rStock.stock}</td>
								<td><button type="button" onclick="location.href='${path}/seller/ModifyProduct.do?stock_id=${rStock.r_stock_id}'">조회/수정</button></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="actions">
					<button id="delete_selected_rStock" onclick="deleteCheckedRentStock()">선택 상품 삭제</button>
	
			</div>
			
			<button onclick="location.href='${path}/seller/AddProduct.do'">상품 등록</button>
		</section>
		<%-- <aside class="notifications">
			<div class="notify_icon">
				<img src="${path}/resources/images/bell.png" alt="알림"
					class="bell_icon" />
				<div class="icon">
					<span>15</span>
				</div>
				<div class="popup">
					<p>결제 완료 주문 : 5건</p>
					<p>결제 대기 주문 : 23건</p>
				</div>
			</div>
		</aside> --%>
	</main>
	<%@ include file="../common/footer.jsp"%>
</body>
</html>