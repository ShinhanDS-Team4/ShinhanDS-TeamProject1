<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객 대여 목록</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="common.jsp" />
    <div class="content">
        <div class="container-fluid">
            <h1>고객 대여 목록</h1>
            
            <form id="searchForm" class="form-inline mb-3">
                <input type="text" name="searchRentList" id="searchRentList" placeholder="고객 아이디 또는 이름 또는 이메일 입력" class="form-control mr-2">
                <input type="button" class="btn btn-primary" onclick="searchRents()" value="검색"/>
                <input type="button" class="btn btn-secondary ml-2" onclick="resetSearch()" value="초기화"/>                
            </form>

            <div class="table-container">
                <table class="table table-striped">
                    <thead>
                        <tr>
                        	<th>아이디</th>
                        	<th>이름</th>
                        	<th>연락처</th>
                        	<th>상품 이미지</th>
                        	<th>상품 명</th>
                            <th>대여 ID</th>
                            <th>대여 시작 일</th>
                            <th>대여 마감 일</th>
                            <th>대여 가격</th>
                            <th>수량</th>
                            <th>대여 총 가격</th>
                            <th>대여 상태</th>
                        </tr>
                    </thead>
                    <tbody id="rentList">
                    	
                    </tbody>
                </table>
            </div>
        </div>
    </div>
 
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
        function searchRents() {
            var searchRentList = $('#searchRentList').val();
            $.ajax({
                url: 'admin_customer_search_rentlist',
                type: 'GET',
                data: { searchRentKeyword: searchRentList },
                success: function(response) {
                	console.log(response);
                	var output = "";
                	$.each(response, function(index, item){
                		var rent = $(item)[0];                		
                		output += `
                    		<tr>
                    			<td>\${rent.member_id}</td>
                    			<td>\${rent.member_name}</td>
                    			<td>\${rent.phone}</td>
                    			<td>\${rent.img_id}</td>
                    			<td>\${rent.prod_name}</td>
                    			<td>\${rent.rental_code}</td>
                    			<td>\${rent.rent_start_date}</td>
                    			<td>\${rent.rent_end_date}</td>
                    			<td>\${rent.rent_product_price}</td>
                    			<td>\${rent.rent_num}</td>
                    			<td>\${rent.total_rent_price}</td>
                    			<td>\${rent.rent_state}</td>
                    		</tr>
                    	`;
                	});
                	
                    $('#rentList').html(output);
                },
                error: function() {
                    alert('대여 검색에 실패했습니다.');
                }
            });
        }

        function resetSearch() {
            $('#searchRentList').val('');
            $('#rentList').html('');
        }        
    </script>
</body>
</html>
