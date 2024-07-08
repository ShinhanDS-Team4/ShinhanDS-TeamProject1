<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

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
			<button class="btn btn-sm btn-danger"
				onclick="location.href='admin_seller_delete?returnUrl=sellerList&member_id=${seller.member_id}'">삭제</button>
		</td>
	</tr>
</c:forEach>
<c:if test="${empty sellers}">
	<tr>
		<td colspan="10" class="text-center">판매자 정보가 없습니다.</td>
	</tr>
</c:if>
