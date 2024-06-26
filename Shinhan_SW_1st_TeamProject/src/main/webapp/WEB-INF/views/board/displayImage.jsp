<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Display Uploaded Image</title>
</head>
<body>
<h2>Uploaded Image</h2>

<!-- 업로드된 이미지 URL 리스트가 있는 경우 -->
<c:if test="${not empty uploadedImageUrls}">
    <!-- 각 URL에 대해 이미지를 표시 -->
    <c:forEach var="imageUrl" items="${uploadedImageUrls}">
        <img src="${imageUrl}" alt="Uploaded Image" style="width: auto; height: 200px;" />
    </c:forEach>
</c:if>
<!-- 업로드된 이미지 URL 리스트가 없는 경우 -->
<c:if test="${empty uploadedImageUrls}">
    <p>No images uploaded yet. Please upload some images.</p>
</c:if>

</body>
</html>