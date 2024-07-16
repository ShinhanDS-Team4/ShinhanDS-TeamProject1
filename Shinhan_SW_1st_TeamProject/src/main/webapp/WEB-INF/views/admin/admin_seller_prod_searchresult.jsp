<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach var="product" items="${products}">
	<tr>
		<td>${product.prod_added_date}</td>
		<td><img src="${product.img_id}" alt="Product ${product.img_id}"
			style="width: 50px;"></td>
		<td>${product.prod_name}</td>
		<td>${product.prod_desc}</td>
		<td>${product.prod_price}</td>
		<td>${product.stock}</td>
		<td>${product.member_name}</td>
		<td>${product.brand}</td>
		<td>${product.phone}</td>
		<td><button class="btn btn-sm btn-danger"
				onclick="deleteProduct(${product.prod_id})">삭제</button></td>
	</tr>
</c:forEach>