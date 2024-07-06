<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>판매자 정보</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">   
</head>
<body>
<jsp:include page="common.jsp" />
    <div class="content">
        <div class="container-fluid">
            <h1>판매자 정보</h1>
            <form>
                <div class="form-group">
                    <label for="sellerId">판매자 아이디</label>
                    <input type="text" class="form-control" id="sellerId" value="${member_info.member_id}" readonly="readonly">
                </div>
                <div class="form-group">
                    <label for="sellerName">판매자 명</label>
                    <input type="text" class="form-control" id="sellerName" value="${member_info.member_name}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerEmail">판매자 이메일</label>
                    <input type="text" class="form-control" id="sellerEmail" value="${member_info.email}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerPhone">판매자 연락처</label>
                    <input type="text" class="form-control" id="sellerPhone" value="${member_info.phone}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerBrand">판매자 브랜드</label>
                    <input type="text" class="form-control" id="sellerBrand" value="${member_info.brand}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerBirthDate">판매자 생년월일</label>
                    <input type="text" class="form-control" id="sellerBirthDate" value="${member_info.birth_date}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerGender">판매자 성별</label>
                    <input type="text" class="form-control" id="sellerGender" value="${member_info.gender}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerCreateDate">판매 가능 여부</label>
                    <input type="text" class="form-control" id="sellerMember_seller_authority" value="${member_info.seller_authority}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerCreateDate">판매자 등록 신청일</label>
                    <input type="text" class="form-control" id="sellerCreateDate" value="${member_info.create_date}" readonly>
                </div>	                  
	                  <button class="btn btn-sm btn-danger" onclick="location.href='admin_seller_delete?returnUrl=sellerInfo&member_id=${seller.member_id}'">삭제</button>
            </form>
        </div>
    </div>
</body>
</html>