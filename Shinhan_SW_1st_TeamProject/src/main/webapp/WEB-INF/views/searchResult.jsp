<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>주소 검색 결과</title>
</head>
<body>
    <h1>주소 검색</h1>
    <form action="${pageContext.request.contextPath}/search" method="get">
        <label for="query">검색어:</label>
        <input type="text" id="query" name="query">
        <button type="submit">검색</button>
    </form>
</body>
</html>