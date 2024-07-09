<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객 주문 목록</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="common.jsp" />
    <div class="content">
        <div class="container-fluid">
            <h1>고객 주문 목록</h1>
            
            <form id="searchForm" class="form-inline mb-3">
                <input type="text" name="searchOrderList" id="searchOrderList" placeholder="고객 아이디 또는 이름 또는 이메일 입력" class="form-control mr-2">
                <input type="button" class="btn btn-primary" onclick="searchOrders()" value="검색"/>
                <input type="button" class="btn btn-secondary ml-2" onclick="resetSearch()" value="초기화"/>                
            </form>

            <div class="table-container">
                <table class="table table-striped">
                    <thead>
                        <tr>
                        	<th>아이디</th>
                        	<th>이름</th>
                        	<th>연락처</th>
                            <th>주문 ID</th>
                            <th>주문 날짜</th>
                            <th>주문 금액</th>
                            <th>상품 이름</th>
                            <th>수량</th>
                            <th>주문 상태</th>
                        </tr>
                    </thead>
                    <tbody id="orderList">
                    	
                    </tbody>
                </table>
            </div>
        </div>
    </div>
 
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        function searchOrders() {
            var searchOrderList = $('#searchOrderList').val();
            $.ajax({
                url: 'admin_customer_search_orderlist',
                type: 'GET',
                data: { searchKeyword: searchOrderList },
                success: function(response) {
                	//console.log(response);
                	var output = "";
                	$.each(response, function(index, item){
                		var customer = $(item)[0];                		
                		output += `
                    		<tr>
                    			<td>\${customer.PROD_PRICE}</td>
                    			<td>\${customer.MEMBER_NAME} </td>
                    			<td>\${customer.PHONE}</td>
                    			<td>\${customer.ORDER_ID} </td>
                    			<td>\${customer.ORDER_DATE}</td>
                    			<td>\${customer.TOTAL_PRICE}</td>
                    			<td>\${customer.PROD_NAME}</td>                    			
                    			<td>\${customer.ORDER_NUM}</td>
                    			<td>\${customer.ORDER_STATE}</td>
                    		</tr>
                    	`;
                	});
                	
                    $('#orderList').html(output);
                },
                error: function() {
                    alert('주문 검색에 실패했습니다.');
                }
            });
        }

        function resetSearch() {
            $('#searchOrderList').val('');
            $('#orderList').html('');
        }        
    </script>
</body>
</html>
