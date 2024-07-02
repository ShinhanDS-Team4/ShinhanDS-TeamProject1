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
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="common.jsp" />
<div class="content">
    <div class="container-fluid">
        <h1>고객 목록</h1>
        <div class="mb-3">
            <input type="text" id="searchInput" class="form-control" placeholder="고객 이름 또는 이메일 검색">
        </div>
        <div class="table-responsive">
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
                        <th>삭제</th>
                    </tr>
                </thead>
                <tbody id="customerTableBody">
                    <c:forEach var="customer" items="${customers}">
                        <tr>
                            <td><a href="admin_customer_info?member_id=${customer.member_id}">${customer.member_id}</a></td>
                            <td>${customer.member_name}</td>
                            <td>${customer.email}</td>
                            <td>${customer.phone}</td>
                            <td>${customer.birth_date}</td>
                            <td>${customer.last_access}</td>
                            <td>${customer.gender}</td>
                            <td>
                                <button class="btn btn-sm btn-danger" onclick="location.href='admin_customer_delete?movePage=customerList&member_id=${customer.member_id}'">삭제</button>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty customers}">
                        <tr>
                            <td colspan="8" class="text-center">고객 정보가 없습니다.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
    $('#searchInput').on('input', function() {
        var searchQuery = $(this).val();
        $.ajax({
            url: 'search_customer',
            method: 'GET',
            data: { query: searchQuery },
            success: function(response) {
                $('#customerTableBody').html(response);
            },
            error: function() {
                alert('검색에 실패했습니다.');
            }
        });
    });
});
</script>
</body>
</html>
