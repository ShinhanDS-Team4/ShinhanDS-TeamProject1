<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 목록</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <h1>공지사항 목록</h1>
        <form class="form-inline mb-3">
            <input type="text" name="searchTerm" class="form-control mr-2" placeholder="공지사항 제목 검색">
            <button type="submit" class="btn btn-primary">검색</button>
            <button type="button" class="btn btn-success ml-auto" onclick="openCreatePopup()">등록</button>
        </form>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>공지사항 ID</th>
                    <th>제목</th>
                    <th>내용</th>
                    <th>작성 일자</th>
                    <th>작업</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="notice" items="${notices}">
                    <tr>
                        <td>${notice.notice_id}</td>
                        <td><a href="#" onclick="openEditPopup(${notice.notice_id})">${notice.notice_title}</a></td>
                        <td>${notice.notice_content}</td>
                        <td>${notice.notice_date}</td>
                        <td>
                            <button class="btn btn-primary btn-sm" onclick="openEditPopup(${notice.notice_id})">수정</button>
                            <button class="btn btn-danger btn-sm" onclick="deleteNotice(${notice.notice_id})">삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Notice Popup Modal -->
    <div class="modal fade" id="noticeModal" tabindex="-1" role="dialog" aria-labelledby="noticeModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="noticeModalLabel">공지사항</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="noticeForm">
                        <input type="hidden" id="notice_id" name="notice_id">
                        <div class="form-group">
                            <label for="notice_title">제목</label>
                            <input type="text" class="form-control" id="notice_title" name="notice_title" required>
                        </div>
                        <div class="form-group">
                            <label for="notice_content">내용</label>
                            <textarea class="form-control" id="notice_content" name="notice_content" rows="5" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="notice_date">작성 일자</label>
                            <input type="date" class="form-control" id="notice_date" name="notice_date" required>
                        </div>
                        <button type="submit" class="btn btn-success" id="saveButton">저장</button>
                        <button type="button" class="btn btn-danger" id="deleteButton" onclick="deleteNotice()">삭제</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openCreatePopup() {
            $('#noticeModalLabel').text('공지사항 등록');
            $('#noticeForm').attr('action', '${pageContext.request.contextPath}/notice/create');
            $('#notice_id').val('');
            $('#notice_title').val('');
            $('#notice_content').val('');
            $('#notice_date').val('');
            $('#deleteButton').hide();
            $('#noticeModal').modal('show');
        }

        function openEditPopup(noticeId) {
            $.ajax({
                url: '${pageContext.request.contextPath}/notice/get/' + noticeId,
                method: 'GET',
                success: function(data) {
                    $('#noticeModalLabel').text('공지사항 수정');
                    $('#noticeForm').attr('action', '${pageContext.request.contextPath}/notice/edit');
                    $('#notice_id').val(data.notice_id);
                    $('#notice_title').val(data.notice_title);
                    $('#notice_content').val(data.notice_content);
                    $('#notice_date').val(data.notice_date);
                    $('#deleteButton').show();
                    $('#noticeModal').modal('show');
                }
            });
        }

        function deleteNotice(noticeId) {
            if (confirm('공지사항을 삭제하시겠습니까?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/notice/delete/' + noticeId,
                    method: 'POST',
                    success: function() {
                        alert('공지사항이 삭제되었습니다.');
                        location.reload();
                    }
                });
            }
        }

        $('#noticeForm').submit(function(event) {
            event.preventDefault();
            var formData = $(this).serialize();
            $.ajax({
                url: $(this).attr('action'),
                method: 'POST',
                data: formData,
                success: function() {
                    alert('공지사항이 저장되었습니다.');
                    $('#noticeModal').modal('hide');
                    location.reload();
                }
            });
        });
    </script>
</body>
</html>
