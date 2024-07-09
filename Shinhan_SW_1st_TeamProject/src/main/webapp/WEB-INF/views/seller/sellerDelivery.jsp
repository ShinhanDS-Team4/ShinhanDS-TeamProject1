<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>판매자_판매&배송</title>
<!-- 본문 css -->
<link rel="stylesheet" href="${path}/resources/css/style.css">
<!-- 헤더,푸터 css -->
<link rel="stylesheet" href="${path}/resources/css/header_footer.css">
<!-- jquery 연결 -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<!-- 페이지용 css -->
<link rel="stylesheet" href="${path}/resources/css/seller_Delivery.css" />
<script>

	//선택 판매 주문 항목 주문상태 일괄처리
	function updateOrderStatus(){
		
		var selectedStatus = $('#order_status_select').val();//일괄처리할 상태(select-option)
		
		var selectedOrderDetails =[];
		
		$('.order-checkbox:checked').each(function() {
			selectedOrderDetails.push($(this).data('id'));
		});
		
		if(selectedOrderDetails.length>0){
    		$.ajax({
    			url:"/shoppingmall/seller/updateOrderStatus",
    			type:'POST',
    			contentType: 'application/json',
    			data: JSON.stringify({orderDetailIds:selectedOrderDetails, status:selectedStatus}),
    			success: function(response){
    				if(response==="Update Success"){
    					alert('갱신 완료');
    					location.reload();
    				}else{
    					alert('갱신 중 오류 발생');
    				}
    			},
    			error:function(){
    				alert('서버 요청 중 오류가 발생했습니다.');
    			}
    		});
    	}else {
        	alert('선택된 주문이 없습니다.');
    	}
	}
	
	//선택 판매 주문 항목 삭제
	function deleteCheckedOrder(){
		var selectedStatus = '일괄삭제'
		var selectedOrderDetails =[];
		$('.order-checkbox:checked').each(function() {
			selectedOrderDetails.push($(this).data('id'));
		});
		
		if(selectedOrderDetails.length>0){
			$.ajax({
    			url:'/shoppingmall/seller/deleteOrderDetails',
    			type:'POST',
    			contentType: 'application/json',
    			data: JSON.stringify({orderDetailIds:selectedOrderDetails, status:selectedStatus}),
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
        	alert('선택된 주문이 없습니다.');
    	}
	}
	
	//선택 대여 주문 항목 주문상태 일괄처리
	function updateRentStatus(){
		
		var selectedStatus = $('#rent_status_select').val();//일괄처리할 상태(select-option)
		
		var selectedRentDetails =[];
		
		$('.rent-checkbox:checked').each(function() {
			selectedRentDetails.push($(this).data('id'));
		});
		
		if(selectedRentDetails.length>0){
    		$.ajax({
    			url:"/shoppingmall/seller/updateRentStatus",
    			type:'POST',
    			contentType: 'application/json',
    			data: JSON.stringify({orderDetailIds:selectedRentDetails, status:selectedStatus}),
    			success: function(response){
    				if(response==="Update Success"){
    					alert('갱신 완료');
    					location.reload();
    				}else{
    					alert('갱신 중 오류 발생');
    				}
    			},
    			error:function(){
    				alert('서버 요청 중 오류가 발생했습니다.');
    			}
    		});
    	}else {
        	alert('선택된 주문이 없습니다.');
    	}
	}
	
	//선택 대여 주문 항목 일괄삭제
	function deleteCheckedRent(){
		var selectedStatus = '일괄삭제'
		var selectedRentDetails =[];
		$('.rent-checkbox:checked').each(function() {
			selectedRentDetails.push($(this).data('id'));
		});
		
		if(selectedRentDetails.length>0){
			$.ajax({
    			url:'/shoppingmall/seller/deleteRentDetails',
    			type:'POST',
    			contentType: 'application/json',
    			data: JSON.stringify({orderDetailIds:selectedRentDetails, status:selectedStatus}),
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
        	alert('선택된 주문이 없습니다.');
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
		<section>
			<h2>마이페이지</h2>
			<hr />
			<div class="user-info">
				<p>${sellerInfo.member_name}</p>
				<p>${sellerInfo.member_id}</p>
			</div>
			<!-- 주문/배송 -->
			<h3>판매 상품 주문 리스트</h3>
			<div class="product-list">
				
				<table class="sellPrdList">
					<thead>
						<tr>
							<th></th>
							<th>주문상세ID</th>
							<th>상품재고ID</th>
							<th>가격</th>
							<th>주문 수량</th>
							<th>주문상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="order_detail" items="${orderDetailList}">
							<tr>
								<td><input type="checkbox" class="order-checkbox"
									data-id="${order_detail.orderdetail_id}" /></td>
								<td>${order_detail.orderdetail_id}</td>
								<td>${order_detail.s_stock_id}</td>
								<td>${order_detail.order_product_price}</td>
								<td>${order_detail.order_num}</td>
								<td>${order_detail.order_state}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
			</div>
			<div class="actions">
					<select id="order_status_select" class="orderStatus">
						<option>결제대기</option>
						<option>결제완료</option>
						<option>배송준비중</option>
						<option>배송중</option>
						<option>배송완료</option>
						<option>교환요청</option>
						<option>교환완료</option>
						<option>환불요청</option>
						<option>환불완료</option>
					</select>
					<button id="batch_process_button" onclick="updateOrderStatus()">일괄처리</button>
					<button id="delete_selected_button" onclick="deleteCheckedOrder()">선택 내역 삭제</button>
				</div>
			
			

			<!-- 대여 -->
			<h3>대여 상품 주문 리스트</h3>
			<div class="product-list">
				<table class="sellPrdList">
					<thead>
						<tr>
							<th></th>
							<th>주문상세ID</th>
							<th>상품재고ID</th>
							<th>가격</th>
							<th>주문 수량</th>
							<th>주문상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="rent_detail" items="${rentDetailList}">
							<tr>
								<td><input type="checkbox" class="rent-checkbox"
									data-id="${rent_detail.rentdetail_id}"/></td>
								<td>${rent_detail.rentdetail_id}</td>
								<td>${rent_detail.r_stock_id}</td>
								<td>${rent_detail.rent_product_price}</td>
								<td>${rent_detail.rent_num}</td>
								<td>${rent_detail.rent_state}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				
			</div>
			
		<div class="actions">
					<select id="rent_status_select" class="orderStatus">
						<option>대여신청완료</option>
						<option>결제완료</option>
						<option>대여취소</option>
						<option>대여중</option>
						<option>반납중</option>
						<option>반납완료</option>
					</select>
					<button class="button" id="batch_process_button" onclick="updateRentStatus()">일괄처리</button>
					<button class="button" id="delete_selected_button" onclick="deleteCheckedRent()">선택 내역 삭제</button>
				</div>
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
</style>
</body>
</html>