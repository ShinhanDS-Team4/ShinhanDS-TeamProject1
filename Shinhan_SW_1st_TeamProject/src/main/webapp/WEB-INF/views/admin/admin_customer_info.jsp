<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>고객 정보</title>
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet">
</head>
<body>
	<jsp:include page="common.jsp" />
	<div class="content">
		<div class="container-fluid">
			<h1>고객 정보</h1>
			<form>
				<div class="form-group">
					<label for="sellerid">고객 아이디</label> <input type="text"
						class="form-control" id="customerid"
						value="${customer_info.member_id}" readonly="readonly">
				</div>
				<div class="form-group">
					<label for="sellername">고객 성명</label> <input type="text"
						class="form-control" id="customername"
						value="${customer_info.member_name}" readonly>
				</div>
				<div class="form-group">
					<label for="selleremail">고객 이메일</label> <input type="text"
						class="form-control" id="customeremail"
						value="${customer_info.email}" readonly>
				</div>
				<div class="form-group">
					<label for="sellerphone">고객 연락처</label> <input type="text"
						class="form-control" id="customerphone"
						value="${customer_info.phone}" readonly>
				</div>
				<div class="form-group">
					<label for="sellerbirthdate">고객 생년월일</label> <input type="text"
						class="form-control" id="customerbirthdate"
						value="${customer_info.birth_date}" readonly>
				</div>
				<div class="form-group">
					<label for="sellergender">고객 성별</label> <input type="text"
						class="form-control" id="customergender"
						value="${customer_info.gender}" readonly>
				</div>
				<div class="form-group">
					<label for="sellercreatedate">회원 등급</label> <input type="text"
						class="form-control" id="customermemberlevel"
						value="${customer_info.member_level}" readonly>
				</div>
				<div class="form-group">
					<label for="sellercreatedate">포인트</label> <input type="text"
						class="form-control" id="customerpoint"
						value="${customer_info.point}" readonly>
				</div>
				<div class="form-group">
					<label for="sellercreatedate">누적 주문 금액</label> <input type="text"
						class="form-control" id="customeraccum_amount"
						value="${customer_info.accum_amount}" readonly>
				</div>
				<div class="form-group">
					<label for="sellercreatedate">가입일자</label> <input type="text"
						class="form-control" id="customercreatedate"
						value="${customer_info.create_date}" readonly>
				</div>
				<div class="form-group">
					<label for="sellercreatedate">마지막 접속일</label> <input type="text"
						class="form-control" id="customerlastaccess"
						value="${customer_info.last_access}" readonly>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
