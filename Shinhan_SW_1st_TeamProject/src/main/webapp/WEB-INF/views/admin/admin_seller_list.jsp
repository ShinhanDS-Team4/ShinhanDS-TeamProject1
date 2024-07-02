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
    <link href="${pageContext.request.contextPath}/resources/css/admin/admin_page.css" rel="stylesheet">
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
                            <th>수정/삭제</th>
                        </tr>
                    </thead>
                    <tbody>
                    	<c:forEach var="seller" items="${sellers}">
	                        <tr>
	                            <td><a href="admin_seller_prod?sellerid=${seller.member_id}">${seller.member_id}</a></td>
	                            <td>${seller.member_name}</td>
	                            <td>${seller.member_email}</td>
	                            <td>${seller.member_phone}</td>
	                            <td>${seller.member_brand}</td>
	                            <td>${seller.member_birth_date}</td>
	                            <td>${seller.member_last_access}</td>
	                            <td>${seller.member_gender}</td>
	                            <td>${seller.member_seller_authority}</td>                          
	                            <td>
	                            	<button class="btn btn-sm btn-primary" onclick="window.location.href='admin_seller_info?member_id=${seller.member_id}'">수정</button>
	                                <button class="btn btn-sm btn-danger">삭제</button>
	                            </td>
	                        </tr>
	                    </c:forEach>
                    	<c:if test="${empty sellers}">
	                        <tr>
	                            <td colspan="9" class="text-center">판매자 정보가 없습니다.</td>
	                        </tr>
                    	</c:if>              
                    </tbody>
                </table>
            </div>
        </div>
    </div>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<%-- <script src="${pageContext.request.contextPath}/resources/css/admin/admin_page.js"></script> --%>
</body>
</html>

