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
<jsp:include page="common.jsp" />
    <div class="content">
        <div class="container-fluid">
            <h1>공지사항 목록</h1>
            <form id="searchForm" class="form-inline mb-3" method="get" action="admin_notice_search">
                <input type="text" name="search_title" id="searchTerm" placeholder="공지사항 제목 검색" class="form-control mr-2">
                <button type="submit" class="btn btn-primary">검색</button>
                <input type="button" class="btn btn-secondary ml-2" onclick="resetSearch()" value="초기화"/>
                <button type="button" class="btn btn-success ml-auto" onclick="openCreatePopup()">등록</button>
            </form>

            <div class="table-container">
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
                    <tbody id="noticeList">
                        <c:forEach var="notice" items="${notices}">
                        <tr>
                            <td>${notice.not_id}</td>
                            <td><a href="#" onclick="openViewPopup(${notice.not_id})">${notice.not_title}</a></td>
                            <td>${notice.not_content}</td>
                            <td>${notice.not_date}</td>
                            <td>
                                <button class="btn btn-primary btn-sm" onclick="openEditPopup(${notice.not_id})">수정</button>
                                <button class="btn btn-danger btn-sm" onclick="deleteNotice(${notice.not_id})">삭제</button>
                            </td>
                        </tr>                
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
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
                        <input type="hidden" id="not_id" name="not_id">
                        <div class="form-group">
                            <label for="not_title">제목</label>
                            <input type="text" class="form-control" id="not_title" name="not_title" required>
                        </div>
                        <div class="form-group">
                            <label for="not_content">내용</label>
                            <textarea class="form-control" id="not_content" name="not_content" rows="5" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="not_date">작성 일자</label>
                            <input type="date" class="form-control" id="not_date" name="not_date" required>
                        </div>
                        <button type="submit" class="btn btn-success" id="saveButton">저장</button>
                        <button type="button" class="btn btn-danger" id="deleteButton" onclick="deleteNotice()">삭제</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function resetSearch() {
            $('#searchTerm').val('');
        }

        function openCreatePopup() {
            $('#noticeModalLabel').text('공지사항 등록');
            $('#noticeForm').attr('action', 'admin_notice_insert');
            $('#not_id').val('');
            $('#not_title').val('');
            $('#not_content').val('');
            $('#not_date').val('');
            $('#saveButton').show();
            $('#deleteButton').hide();
            $('#noticeModal').modal('show');
        }

        function openViewPopup(noticeId) {
            $.ajax({
                url: 'admin_notice_select',
                type: 'GET',
                data: { not_id: noticeId },
                success: function(data) {
                    $('#noticeModalLabel').text('공지사항 조회');
                    $('#noticeForm').attr('action', '');
                    $('#not_id').val(data.not_id);
                    $('#not_title').val(data.not_title);
                    $('#not_content').val(data.not_content);
                    $('#not_date').val(data.not_date);
                    $('#saveButton').hide();
                    $('#deleteButton').hide();
                    $('#noticeModal').modal('show');
                }
            });
        }

        function openEditPopup(noticeId) {
            $.ajax({
                url: 'admin_notice_select',
                type: 'GET',
                data: { not_id: noticeId },
                success: function(data) {
                    $('#noticeModalLabel').text('공지사항 수정');
                    $('#noticeForm').attr('action', 'admin_notice_update');
                    $('#not_id').val(data.not_id);
                    $('#not_title').val(data.not_title);
                    $('#not_content').val(data.not_content);
                    $('#not_date').val(data.not_date);
                    $('#saveButton').show();
                    $('#deleteButton').show().attr('onclick', `deleteNotice(${noticeId})`);
                    $('#noticeModal').modal('show');
                }
            });
        }

        function deleteNotice(noticeId) {
            if (confirm('정말로 이 공지사항을 삭제하시겠습니까?')) {
                $.ajax({
                    url: 'admin_notice_delete',
                    type: 'POST',
                    data: { not_id: noticeId },
                    success: function() {
                        alert('공지사항이 삭제되었습니다.');
                        location.reload();
                    },
                    error: function() {
                        alert('공지사항 삭제에 실패했습니다.');
                    }
                });
            }
        }

        $('#noticeForm').submit(function(event) {
            event.preventDefault();
            var formData = $(this).serialize();
            $.ajax({
                url: $(this).attr('action'),
                method: 'GET',
                data: formData,
                success: function() {
                    alert('공지사항이 저장되었습니다.');
                    $('#noticeModal').modal('hide');
                    location.reload();
                },
                error: function() {
                    alert('공지사항 저장에 실패했습니다.');
                }
            });
        });
    </script>
</body>
</html>
