<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" 
	value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>

</head>
<link rel ="stylesheet" href="/finalpro/resources/css/serchId.css">
<body>
<form method="post" action="${contextPath }/member/searchId.do">
<div class="container">
        <div class="content">
            <h1>아이디 찾기 결과</h1>
           <c:if test="${not empty userId}">
            <div class="logo">😺</div>
            <p class="email-intro">회원님의 아이디는</p>
            <p class="email">"${userId}"</p>
            <p>입니다.</p><br>
            <a href="${contextPath }/member/loginForm.do">로그인</a>
           </c:if>
            <c:if test="${empty userId}">
            <div class="logo">😿</div><br>
            <p class="email-intro">아이디가 존재하지 않습니다</p><br>
            <a href="${contextPath }/member/FindId.do">아이디 찾기</a><br>
            </c:if>
        </div>
    </div>
</form>
</body>