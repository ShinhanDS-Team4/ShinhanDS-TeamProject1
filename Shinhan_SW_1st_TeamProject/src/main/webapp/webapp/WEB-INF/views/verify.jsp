<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Verify</title>
</head>
<body>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
    <form action="${path}/member_test/verify" method="post">
        Name: <input type="text" name="name"><br>
        Email: <input type="email" name="email"><br>
        <input type="submit" value="Send Verification Code">
    </form>
</body>
</html>
