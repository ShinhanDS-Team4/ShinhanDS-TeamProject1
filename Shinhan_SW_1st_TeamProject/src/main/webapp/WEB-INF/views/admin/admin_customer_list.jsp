<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객 목록</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="common.jsp" />
    <div class="content">
        <div class="container-fluid">
            <h1>고객 목록</h1>
            
            <form id="searchForm" class="form-inline mb-3">
                <input type="text" name="searchCustomer" id="searchCustomer" placeholder="고객 아이디, 이름 또는 이메일" class="form-control mr-2">
                <input type="button" class="btn btn-primary" onclick="searchCustomers()" value="검색"/>
                <input type="button" class="btn btn-secondary ml-2" onclick="resetSearch()" value="초기화"/>                
            </form>

            <div class="table-container">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>아이디</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>연락처</th>
                            <th>생년월일</th>
                            <th>마지막 접속일</th>
                            <th>성별</th>
                            <th>누적 주문 금액</th>
                            <th>회원등급</th>
                            <th>포인트</th>
                        </tr>
                    </thead>
                    <tbody id="customerList">
                        <c:forEach var="customer" items="${customers}">
                        <tr>
                            <td><a href="admin_customer_info?member_id=${customer.member_id}">${customer.member_id}</a></td>
                            <td>${customer.member_name}</td>
                            <td>${customer.email}</td>
                            <td>${customer.phone}</td>
                            <td>${customer.birth_date}</td>
                            <td>${customer.last_access}</td>
                            <td>${customer.gender}</td>                           
                            <td>${customer.accum_amount}</td>                           
                            <td>${customer.member_level}</td>                           
                            <td>${customer.point}</td>                           
                        </tr>                
                        </c:forEach>
                        <c:if test="${empty customers}">
	                        <tr>
	                            <td colspan="10" class="text-center">고객 정보가 없습니다.</td>
	                        </tr>
                    	</c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
 
    <script>
        function searchCustomers() {
            var searchCustomer = $('#searchCustomer').val();
            alert("bbb:"+searchCustomer);
            $.ajax({
                url: 'search_customer',
                type: 'GET',
                data: { searchCustomer: searchCustomer },
                success: function(response) {
                	console.log(response);
                    $('#customerList').html(response);
                },
                error: function() {
                    alert('고객 검색에 실패했습니다.');
                }
            });
        }

        function resetSearch() {
            $('#searchCustomer').val('');
            searchCustomers();
        }        
    </script>
</body>
</html>
