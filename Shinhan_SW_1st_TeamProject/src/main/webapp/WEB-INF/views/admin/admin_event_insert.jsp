<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이벤트 ${event.event_id != null ? '수정' : '등록'}</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <h1>이벤트 ${event.event_id != null ? '수정' : '등록'}</h1>
        <form action="${pageContext.request.contextPath}/event/${event.event_id != null ? 'edit' : 'create'}" method="post">
            <input type="hidden" name="event_id" value="${event.event_id}">
            <div class="form-group">
                <label for="event_title">제목</label>
                <input type="text" class="form-control" id="event_title" name="event_title" value="${event.event_title}" required>
            </div>
            <div class="form-group">
                <label for="event_content">내용</label>
                <textarea class="form-control" id="event_content" name="event_content" rows="5" required>${event.event_content}</textarea>
            </div>
            <div class="form-group">
                <label for="event_date">작성 일자</label>
                <input type="date" class="form-control" id="event_date" name="event_date" value="${event.event_date}" required>
            </div>
            <button type="submit" class="btn btn-success">저장</button>
            <a href="${pageContext.request.contextPath}/event/list" class="btn btn-secondary">목록으로</a>
        </form>
    </div>
</body>
</html>
l>