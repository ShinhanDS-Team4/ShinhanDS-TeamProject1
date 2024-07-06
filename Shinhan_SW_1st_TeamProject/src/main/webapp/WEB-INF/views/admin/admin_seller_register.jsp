<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매자 등록 신청</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="common.jsp" />
<div class="content">
        <div class="container-fluid">
            <h1>판매자 등록 신청 관리</h1>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                    	<tr>
                    		<th>아이디</th>
                    		<th>신청자명</th>
                    		<th>브랜드</th>                    		                            
                            <th>이메일</th>
                            <th>연락처</th>                            
                            <th>생년월일</th>                           
                            <th>성별</th>                            
                            <th>신청 날짜</th>
                            <th>판매 상태</th>
                            <th colspan="2">허용 / 거부</th>
                    	</tr>                        
                    </thead>
                    <tbody>
                        <c:forEach var="seller" items="${sellers}">
	                        <tr>
                            	<td id="seller-${seller.member_id}"><a href="admin_seller_info?member_id=${seller.member_id}">${seller.member_id}</a></td>
	                            <td>${seller.member_name}</td>
	                            <td>${seller.brand}</td>
	                            <td>${seller.email}</td>
	                            <td>${seller.phone}</td>
	                            <td>${seller.birth_date}</td>
	                            <td>${seller.gender}</td>
	                            <td>${seller.create_date}</td>
	                            <td id="status-${seller.member_id}">${seller.seller_authority}</td>
	                            <td colspan="2">
	                                <button class="btn btn-sm btn-primary" onclick="updateSellerStatus('${seller.member_id}', 'Y')">허용</button>
	                                <button class="btn btn-sm btn-danger" onclick="updateSellerStatus('${seller.member_id}', 'N')">거부</button>
	                            </td>
                        </tr>                      
	                    </c:forEach>
                    	<c:if test="${empty sellers}">
	                        <tr>
	                            <td colspan="10" class="text-center">판매자 정보가 없습니다.</td>
	                        </tr>
                    	</c:if>                                             
                    </tbody>
                </table>
            </div>
        </div>
    </div>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script>
    function updateSellerStatus(member_id, seller_authority) {
        $.ajax({
            url: 'update_seller_register',
            type: 'POST',
            data: {
                member_id: member_id,
                seller_authority: seller_authority
            },
            success: function(response) {
            	if (response === 'success') {
            		console.log(response);
            		$("#status-"+member_id).text(seller_authority);
                    alert('판매자 등록 수정되었습니다.');     
                    
                } else {
                    alert('상태 업데이트에 실패했습니다.');
                }
            },
            error: function() {
                alert('서버와의 통신에 문제가 발생했습니다.');
            }
        });
    }
    </script>
</body>
</html>