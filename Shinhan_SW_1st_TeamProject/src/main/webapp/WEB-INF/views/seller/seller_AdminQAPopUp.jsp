<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>관리자 문의 작성</title>
    <style>
      body {
        font-family: Arial, sans-serif;
        margin: 40px;
      }
      h1 {
        font-size: 36px;
      }
      .container {
        width: 50%;
        margin: auto;
      }
      .info {
        margin-bottom: 20px;
      }
      .info div {
        margin: 10px 0;
      }
      .info label {
        font-weight: bold;
        display: inline-block;
        width: 100px;
      }
      .input-group {
        margin: 20px 0;
      }
      .input-group label {
        display: block;
        margin-bottom: 5px;
        font-weight: bold;
      }
      .input-group input,
      .input-group textarea {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        background-color: #f7f7f7;
      }
      .buttons {
        text-align: center;
      }
      .buttons button {
        padding: 10px 20px;
        margin: 0 10px;
        border: none;
        border-radius: 4px;
        background-color: black;
        color: white;
        font-size: 16px;
        cursor: pointer;
      }
    </style>
  </head>
  <body>
    <div class="container">
      <h1>관리자 문의 작성</h1>
      <div class="info">
        <div>
          <label>판매자ID</label>
          <span>abcd1234</span>
        </div>
        <div>
          <label>판매자명</label>
          <span>조윤재</span>
        </div>
        <div>
          <label>전화번호</label>
          <span>010-1234-5678</span>
        </div>
      </div>
      <div class="input-group">
        <label for="subject">제목</label>
        <input type="text" id="subject" />
      </div>
      <div class="input-group">
        <label for="content">내용작성</label>
        <textarea id="content" rows="10"></textarea>
      </div>
      <div class="buttons">
        <button type="button">등록</button>
        <button type="button">닫기</button>
      </div>
    </div>
  </body>
</html>
