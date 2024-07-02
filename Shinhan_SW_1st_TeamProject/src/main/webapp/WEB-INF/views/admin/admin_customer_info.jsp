<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>고객 정보</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<jsp:include page="common.jsp" />
    <div class="content">
        <div class="container-fluid">
            <h1>고객 정보</h1>
            <form>
                <div class="form-group">
                    <label for="sellerId">고객 아이디</label>
                    <input type="text" class="form-control" id="customerId" value="${customer_info.MEMBER_ID}" readonly="readonly">
                </div>
                <div class="form-group">
                    <label for="sellerName">고객 성명</label>
                    <input type="text" class="form-control" id="customerName" value="${customer_info.MEMBER_NAME}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerEmail">고객 이메일</label>
                    <input type="text" class="form-control" id="customerEmail" value="${customer_info.EMAIL}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerPhone">고객 연락처</label>
                    <input type="text" class="form-control" id="customerPhone" value="${customer_info.PHONE}" readonly>
                </div>                
                <div class="form-group">
                    <label for="sellerBirthDate">고객 생년월일</label>
                    <input type="text" class="form-control" id="customerBirthDate" value="${customer_info.BIRTH_DATE}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerGender">고객 성별</label>
                    <input type="text" class="form-control" id="customerGender" value="${customer_info.GENDER}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerCreateDate">회원 등급</label>
                    <input type="text" class="form-control" id="customerMemberLevel" value="${customer_info.MEMBER_LEVEL}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerCreateDate">포인트</label>
                    <input type="text" class="form-control" id="customerPoint" value="${customer_info.POINT}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerCreateDate">누적 주문 금액</label>
                    <input type="text" class="form-control" id="customerAccum_amount" value="${customer_info.ACCUM_AMOUNT}" readonly>
                </div>
                <div class="form-group">
                    <label for="sellerCreateDate">가입일자</label>
                    <input type="text" class="form-control" id="CustomerCreateDate" value="${customer_info.CREATE_DATE}" readonly>
                </div>	                  
                <div class="form-group">
                    <label for="sellerCreateDate">마지막 접속일</label>
                    <input type="text" class="form-control" id="CustomerLastAccess" value="${customer_info.LAST_ACCESS}" readonly>
                </div>	                  
	            <button class="btn btn-sm btn-danger" onclick="location.href='admin_customer_delete?movePage=customerInfo&member_id=${customer_info.MEMBER_ID}'">삭제</button>
            </form>
        </div>
    </div>
</body>
</html>
