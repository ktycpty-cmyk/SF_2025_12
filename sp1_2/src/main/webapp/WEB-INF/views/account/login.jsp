<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <title>로그인</title>

            <!-- Bootstrap 5 CDN -->
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
            <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/style.css">

            <style>
                body {
                    background-color: var(--bg-color);
                }
            </style>
        </head>

        <body>

            <div class="container">
                <div class="notebook-container animate-fade-in">
                    <div class="notebook-tape"></div>
                    <h3 class="notebook-title">LOGIN PROJECT</h3>

                    <!-- 로그인 실패 메시지 -->
                    <c:if test="${param.error != null}">
                        <div class="alert alert-danger py-2 small">
                            아이디 또는 비밀번호가 올바르지 않습니다.
                        </div>
                    </c:if>

                    <!-- 로그아웃 메시지 -->
                    <c:if test="${param.logout != null}">
                        <div class="alert alert-success py-2 small">
                            정상적으로 로그아웃되었습니다.
                        </div>
                    </c:if>

                    <!-- Spring Security 로그인 처리 -->
                    <form method="post" action="/account/login" class="notebook-form">

                        <div class="mb-4">
                            <label class="form-label">아이디</label>
                            <input type="text" name="username" class="form-control" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">비밀번호</label>
                            <input type="password" name="password" class="form-control" required>
                        </div>

                        <div class="form-check mb-4">
                            <input class="form-check-input" type="checkbox" name="remember-me" id="rememberMe">
                            <label class="form-check-label small text-secondary" for="rememberMe">
                                로그인 상태 유지
                            </label>
                        </div>

                        <div class="mt-5">
                            <button type="submit" class="btn btn-primary w-100 py-3">
                                로그인
                            </button>
                        </div>

                    </form>

                    <div class="text-center mt-4">
                        <a href="/account/join" class="text-secondary small">회원가입</a>
                    </div>

                </div>
            </div>

        </body>

        </html>