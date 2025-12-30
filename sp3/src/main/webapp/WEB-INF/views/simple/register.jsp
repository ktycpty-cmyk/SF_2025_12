<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>

<div class="container mt-3">
  <h2>Simple Register</h2>
  <form action="/simple/register" method="post">
    <div class="mb-3 mt-3">
      <label for="title">title:</label>
      <input type="text" class="form-control" id="name" placeholder="Enter name" name="title">
    </div>
    <div class="mb-3 mt-3">
      <label for="description">description:</label>
      <input type="text" class="form-control" id="description" placeholder="Enter description" name="description">
    </div>
    
    
    <button type="submit" class="btn btn-primary">등록</button>
    <button type="reset" class="btn btn-info">취소</button>
  </form>
</div>

</body>
</html>
