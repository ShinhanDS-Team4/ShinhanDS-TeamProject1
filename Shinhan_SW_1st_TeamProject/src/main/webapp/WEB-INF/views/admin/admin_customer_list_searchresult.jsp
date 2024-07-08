<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach var="customer" items="${customers}">
	<tr>
		<td><a href="admin_customer_info?member_id=${customer.member_id}">${customer.member_id}</a></td>
		<td>${customer.member_name}</td>
		<td>${customer.email}</td>
		<td>${customer.phone}</td>
		<td>${customer.birth_date}</td>
		<td>${customer.last_access}</td>
		<td>${customer.gender}</td>
	</tr>
</c:forEach>