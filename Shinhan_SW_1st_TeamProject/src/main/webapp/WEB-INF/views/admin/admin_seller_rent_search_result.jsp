<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:forEach var="rent" items="${rents}">
	<tr>
		<td>${rent.prod_added_date}</td>
		<td><img src="${rent.img_id}" alt="Product ${rent.img_id}"
			style="width: 50px;"></td>
		<td>${rent.prod_name}</td>
		<td>${rent.prod_desc}</td>
		<td>${rent.rent_product_price}</td>
		<td>${rent.stock}</td>
		<td>${rent.member_name}</td>
		<td>${rent.brand}</td>
		<td>${rent.phone}</td>
		<td><button class="btn btn-sm btn-danger"
				onclick="deleteProduct(${rent.prod_id})">삭제</button></td>
	</tr>
</c:forEach>
