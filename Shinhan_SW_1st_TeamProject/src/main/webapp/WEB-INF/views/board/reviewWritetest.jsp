<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<meta charset="UTF-8">
<title>Review Write</title>
</head>
<body>
<h2>Review Upload Page</h2>

<form:form method="POST" action="${path}/review/upload" enctype="multipart/form-data">
    <!-- 파일 업로드 폼 -->
    <table>
        <tr>
            <td><label for="files">File Upload:</label></td>
            <!-- 여러 파일을 선택할 수 있는 input 태그 -->
            <td><input type="file" id="files" name="files" multiple="multiple" /></td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit" value="Upload" /></td>
        </tr>
    </table>
</form:form>

</body>
</html>