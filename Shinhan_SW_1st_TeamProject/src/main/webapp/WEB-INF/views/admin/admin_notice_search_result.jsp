<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach var="notice" items="${notices}">
	<tr>
		<td>${notice.not_id}</td>
		<td><a href="#" onclick="openDetailPopup(${notice.not_id})">${notice.not_title}</a></td>
		<td>${notice.not_content}</td>
		<td>${notice.not_date}</td>
	</tr>
</c:forEach>