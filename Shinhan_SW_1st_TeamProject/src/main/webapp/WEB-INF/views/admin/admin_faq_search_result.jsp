<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:forEach var="inquiry" items="${inquiries}">
    <tr>
        <td>${inquiry.admin_inq_id}</td>
        <td><a href="#" onclick="openDetailPopup(${inquiry.admin_inq_id})">${inquiry.admin_inq_title}</a></td>
        <td>${inquiry.admin_inq_content}</td>
        <td>${inquiry.admin_inq_date}</td>
        <td>
            <c:choose>
                <c:when test="${inquiry.admin_reply != null}">
                    답변 완료
                </c:when>
                <c:otherwise>
                    미답변
                </c:otherwise>
            </c:choose>
        </td>
        <td>${inquiry.member_id}</td>
        <td>${inquiry.member_type}</td>
    </tr>
</c:forEach>
