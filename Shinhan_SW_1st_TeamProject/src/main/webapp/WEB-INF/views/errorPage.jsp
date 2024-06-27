<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Error</title>
</head>
<body>
<h2>Error: <%= request.getAttribute("message") %></h2>
<p>Please go back and upload an image.</p>
</body>
</html>