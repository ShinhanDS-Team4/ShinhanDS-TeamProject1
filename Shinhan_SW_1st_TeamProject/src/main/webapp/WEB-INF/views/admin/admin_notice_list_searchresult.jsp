<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach var="notice" items="${notices}">
	<tr>
		<td>${notice.not_id}</td>
		<td><a href="#" onclick="openEditPopup(${notice.not_id})">${notice.not_title}</a></td>
		<td>${notice.not_content}</td>
		<td>${notice.not_date}</td>
		<td>
			<button class="btn btn-primary btn-sm"
				onclick="openEditPopup(${notice.not_id})">수정</button>
			<button class="btn btn-danger btn-sm"
				onclick="deleteNotice(${notice.not_id})">삭제</button>
		</td>
	</tr>
</c:forEach>