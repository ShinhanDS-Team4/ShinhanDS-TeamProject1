<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<c:forEach var="event" items="${events}">
	<tr>
		<td>${event.event_id}</td>
		<td><a href="#" onclick="openDetailPopup(${event.event_id})">${event.event_title}</a></td>
		<td>${event.event_content}</td>
		<td>${event.event_date}</td>
		<td>			
			<button class="btn btn-danger btn-sm" onclick="deleteEvent(${event.event_id})">삭제</button>
		</td>
	</tr>
</c:forEach>