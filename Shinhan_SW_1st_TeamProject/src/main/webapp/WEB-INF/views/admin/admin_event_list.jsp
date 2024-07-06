<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이벤트 목록</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <div class="container">
        <h1>이벤트 목록</h1>
        <form class="form-inline mb-3">
            <input type="text" name="searchTerm" class="form-control mr-2" placeholder="이벤트 제목 검색">
            <button type="submit" class="btn btn-primary">검색</button>
            <button type="button" class="btn btn-success ml-auto" onclick="openCreatePopup()">등록</button>
        </form>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>이벤트 ID</th>
                    <th>제목</th>
                    <th>내용</th>
                    <th>작성 일자</th>
                    <th>작업</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="event" items="${events}">
                    <tr>
                        <td>${event.event_id}</td>
                        <td><a href="#" onclick="openEditPopup(${event.event_id})">${event.event_title}</a></td>
                        <td>${event.event_content}</td>
                        <td>${event.event_date}</td>
                        <td>
                            <button class="btn btn-primary btn-sm" onclick="openEditPopup(${event.event_id})">수정</button>
                            <button class="btn btn-danger btn-sm" onclick="deleteEvent(${event.event_id})">삭제</button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <!-- Event Popup Modal -->
    <div class="modal fade" id="eventModal" tabindex="-1" role="dialog" aria-labelledby="eventModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="eventModalLabel">이벤트</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form id="eventForm">
                        <input type="hidden" id="event_id" name="event_id">
                        <div class="form-group">
                            <label for="event_title">제목</label>
                            <input type="text" class="form-control" id="event_title" name="event_title" required>
                        </div>
                        <div class="form-group">
                            <label for="event_content">내용</label>
                            <textarea class="form-control" id="event_content" name="event_content" rows="5" required></textarea>
                        </div>
                        <div class="form-group">
                            <label for="event_date">작성 일자</label>
                            <input type="date" class="form-control" id="event_date" name="event_date" required>
                        </div>
                        <button type="submit" class="btn btn-success" id="saveButton">저장</button>
                        <button type="button" class="btn btn-danger" id="deleteButton" onclick="deleteEvent()">삭제</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        function openCreatePopup() {
            $('#eventModalLabel').text('이벤트 등록');
            $('#eventForm').attr('action', '${pageContext.request.contextPath}/event/create');
            $('#event_id').val('');
            $('#event_title').val('');
            $('#event_content').val('');
            $('#event_date').val('');
            $('#deleteButton').hide();
            $('#eventModal').modal('show');
        }

        function openEditPopup(eventId) {
            $.ajax({
                url: '${pageContext.request.contextPath}/event/get/' + eventId,
                method: 'GET',
                success: function(data) {
                    $('#eventModalLabel').text('이벤트 수정');
                    $('#eventForm').attr('action', '${pageContext.request.contextPath}/event/edit');
                    $('#event_id').val(data.event_id);
                    $('#event_title').val(data.event_title);
                    $('#event_content').val(data.event_content);
                    $('#event_date').val(data.event_date);
                    $('#deleteButton').show();
                    $('#eventModal').modal('show');
                }
            });
        }

        function deleteEvent(eventId) {
            if (confirm('이벤트를 삭제하시겠습니까?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/event/delete/' + eventId,
                    method: 'POST',
                    success: function() {
                        alert('이벤트가 삭제되었습니다.');
                        location.reload();
                    }
                });
            }
        }

        $('#eventForm').submit(function(event) {
            event.preventDefault();
            var formData = $(this).serialize();
            $.ajax({
                url: $(this).attr('action'),
                method: 'POST',
                data: formData,
                success: function() {
                    alert('이벤트가 저장되었습니다.');
                    $('#eventModal').modal('hide');
                    location.reload();
                }
            });
        });
    </script>
</body>
</html>
