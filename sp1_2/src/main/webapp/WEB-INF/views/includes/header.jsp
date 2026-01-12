<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

    <!DOCTYPE html>
    <html lang="en">

    <head>
      <meta charset="UTF-8" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <title>Project Management</title>

      <!-- Fonts -->
      <link rel="preconnect" href="https://fonts.googleapis.com">
      <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
      <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap"
        rel="stylesheet">

      <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
      <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
      <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>

    <body>

      <!-- Top Navbar -->
      <nav class="navbar navbar-expand-lg navbar-custom px-4 sticky-top">
        <a class="navbar-brand" href="/project/dashboard"><i
            class="bi bi-journal-check me-2"></i>My<span>오답노트</span></a>

        <div class="ms-3 d-none d-md-block">
          <c:if test="${not empty category or not empty dto.category}">
            <span class="badge bg-white text-indigo border px-3 py-2 rounded-pill shadow-sm">
              <i class="bi bi-bookmark-fill me-1"></i>
              <c:choose>
                <c:when test="${(category != null ? category : dto.category) == 'CODING'}">💻 코딩노트</c:when>
                <c:when test="${(category != null ? category : dto.category) == 'JAPANESE'}">🇯🇵 일본어노트</c:when>
                <c:otherwise>오답노트</c:otherwise>
              </c:choose>
            </span>
          </c:if>
        </div>
        <div class="collapse navbar-collapse">
          <ul class="navbar-nav me-auto">
            <!-- Links can go here -->
          </ul>
          <div class="d-flex align-items-center gap-3">
            <sec:authorize access="isAnonymous()">
              <a href="/account/login" class="btn btn-login btn-sm rounded-pill px-4">Login</a>
            </sec:authorize>
            <div class="dropdown me-3">
              <button class="btn btn-outline-light btn-sm dropdown-toggle rounded-pill px-3" type="button"
                data-bs-toggle="dropdown">
                노트 전환
              </button>
              <ul class="dropdown-menu dropdown-menu-end shadow-sm border-0 rounded-3">
                <li><a class="dropdown-item py-2" href="/project/list?category=CODING"><i
                      class="bi bi-code-slash me-2"></i>코딩노트</a></li>
                <li><a class="dropdown-item py-2" href="/project/list?category=JAPANESE"><i
                      class="bi bi-translate me-2"></i>일본어노트</a></li>
                <li>
                  <hr class="dropdown-divider">
                </li>
                <li><a class="dropdown-item py-2" href="/project/dashboard"><i class="bi bi-grid-fill me-2"></i>대시보드</a>
                </li>
              </ul>
            </div>
            <sec:authorize access="isAuthenticated()">
              <span class="text-secondary small">수강생: <strong class="text-dark">
                  <sec:authentication property="principal.username" />
                </strong></span>
              <form action="/account/logout" method="post" style="display: inline;">
                <button type="submit" class="btn btn-logout btn-sm rounded-pill px-4">Logout</button>
              </form>
            </sec:authorize>
          </div>
        </div>
      </nav>

      <!-- Sidebar + Content -->
      <div class="main-wrapper">
        <!-- Sidebar -->
        <div class="sidebar">
          <div class="list-group list-group-flush w-100">
            <c:set var="currentCategory" value="${category != null ? category : dto.category}" />
            <a href="/project/list?category=${not empty currentCategory ? currentCategory : 'CODING'}"
              class="list-group-item active">
              <i class="bi bi-card-checklist me-2"></i> 오답 리스트
            </a>
          </div>
        </div>

        <!-- Main Content -->
        <div class="content">