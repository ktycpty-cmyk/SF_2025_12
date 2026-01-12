<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html lang="ko">

        <head>
            <meta charset="UTF-8">
            <title>회원가입 - 오답노트</title>
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
                    <h3 class="notebook-title">JOIN PROJECT</h3>

                    <c:if test="${param.error == 'duplicate'}">
                        <div class="alert alert-warning py-2 small">
                            이미 사용 중인 아이디입니다. 다른 아이디를 입력해 주세요.
                        </div>
                    </c:if>

                    <form action="/account/join" method="post" class="notebook-form">
                        <div class="mb-4">
                            <label class="form-label">아이디 (ID)</label>
                            <input type="text" name="uid" class="form-control" placeholder="아이디를 입력하세요" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">비밀번호 (Password)</label>
                            <input type="password" name="upw" class="form-control" placeholder="비밀번호를 입력하세요" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">이름 (Name)</label>
                            <input type="text" name="uname" class="form-control" placeholder="이름을 입력하세요" required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">이메일 (Email)</label>
                            <input type="email" name="email" class="form-control" placeholder="example@email.com"
                                required>
                        </div>

                        <div class="mt-5">
                            <button type="submit" class="btn btn-primary w-100 py-3">신규 등록 완료</button>
                        </div>

                        <div class="text-center mt-4">
                            <a href="/account/login" class="text-secondary small">이미 계정이 있으신가요? 로그인하기</a>
                        </div>
                    </form>
                </div>
            </div>

        </body>

        </html>