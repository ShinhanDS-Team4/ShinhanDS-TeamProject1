<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매자 목록</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="common.jsp" />
    <div class="content">
        <div class="container-fluid">
            <h1>판매자 목록</h1>
            <div class="table-responsive">
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>아이디</th>
                            <th>이름</th>
                            <th>이메일</th>
                            <th>연락처</th>
                            <th>브랜드</th>
                            <th>생년월일</th>
                            <th>마지막 접속일</th>
                            <th>성별</th>
                            <th>판매가능여부</th>
                            <th>삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="seller" items="${sellers}">
	                        <tr>
	                            <td><a href="admin_seller_info?member_id=${seller.member_id}">${seller.member_id}</a></td>
	                            <td>${seller.member_name}</td>
	                            <td>${seller.email}</td>
	                            <td>${seller.phone}</td>
	                            <td>${seller.brand}</td>
	                            <td>${seller.birth_date}</td>
	                            <td>${seller.last_access}</td>
	                            <td>${seller.gender}</td>
	                            <td>${seller.seller_authority}</td>                          
	                            <td>	                            	
	                                <button class="btn btn-sm btn-danger" onclick="location.href='admin_seller_delete?member_id=${seller.member_id}'">삭제</button>
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
</body>
</html>
