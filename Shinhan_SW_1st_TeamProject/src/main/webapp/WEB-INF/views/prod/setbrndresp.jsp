<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<p>브랜드 검색</p>
           
<ul>
	<c:forEach var="brnd" items="${brndsList}">		
		<li>
			<i></i>
			<p>${brnd}</p>
		</li>
	</c:forEach>
</ul>

<input id="totalBrnds" type="hidden" value="${totalBrnds}">
<div class="paginationBrnd" id="paginationBrnd"></div>