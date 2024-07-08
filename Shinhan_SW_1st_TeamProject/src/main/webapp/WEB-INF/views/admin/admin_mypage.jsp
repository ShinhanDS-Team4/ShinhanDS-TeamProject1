<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="path" value="${pageContext.servletContext.contextPath}" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 마이 페이지</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<link href="${path}/resources/css/admin/admin_page.css" rel="stylesheet">
</head>
<body>
<jsp:include page="common.jsp" />
<div class="content">
    <div class="container-fluid">
        <h2 class="mb-4">관리자 정보</h2>
        <div class="form-group">
            <label for="adminId">아이디</label>
            <input type="text" class="form-control" id="adminId" name="adminId" value="${admin_id}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="adminName">이름</label>
            <input type="text" class="form-control" id="adminName" name="adminName" value="${admin_name}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="adminEmail">이메일</label>
            <input type="email" class="form-control" id="adminEmail" name="adminEmail" value="${admin_email}" readonly>
        </div>
        <div class="form-group">
            <label for="adminPhone">전화번호</label>
            <input type="text" class="form-control" id="adminPhone" name="adminPhone" value="${admin_phone}" readonly>
        </div>
        <div class="form-group">
            <label for="adminPassword">비밀번호</label>
            <input type="password" class="form-control" id="adminPassword" name="adminPassword" value="${admin_pw}" readonly>
        </div>
        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editAdminModal">수정</button>
    </div>
</div>

<!-- 수정 모달 -->
<div class="modal fade" id="editAdminModal" tabindex="-1" aria-labelledby="editAdminModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editAdminModalLabel">관리자 정보 수정</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editAdminForm" action="admin_mypage_edit" method="post">
                    <div class="form-group">
                        <label for="editAdminName">아이디</label>
                        <input type="text" class="form-control" id="editAdminId" name="admin_id" value="${admin_id}" readonly>
                    </div>
                    <div class="form-group">
                        <label for="editAdminName">이름</label>
                        <input type="text" class="form-control" id="editAdminName" name="admin_name" value="${admin_name}">
                    </div>
                    <div class="form-group">
                        <label for="editAdminEmail">이메일</label>
                        <input type="email" class="form-control" id="editAdminEmail" name="admin_email" value="${admin_email}">
                    </div>
                    <div class="form-group">
                        <label for="editAdminPhone">전화번호</label>
                        <input type="text" class="form-control" id="editAdminPhone" name="admin_phone" value="${admin_phone}">
                    </div>
                    <div class="form-group">
                        <label for="editAdminPassword">비밀번호</label>
                        <input type="password" class="form-control" id="editAdminPassword" name="admin_pw" value="${admin_pw}">
                    </div>
                    <button type="button" class="btn btn-secondary" onclick="resetForm()">리셋</button>
                    <button type="submit" class="btn btn-primary">수정</button>
                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="${path}/resources/js/admin/admin_page.js"></script>
<script>
    function resetForm() {
        document.getElementById('editAdminForm').reset();
    }
</script>
</body>
</html>
