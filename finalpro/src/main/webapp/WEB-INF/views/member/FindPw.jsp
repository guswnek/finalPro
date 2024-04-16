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
<link rel ="stylesheet" href="/finalpro/resources/css/findIdPw.css">
</head>
<body>
    <form  method="post" action='${contextPath }/member/searchPw.do'>
    <div class="member">
		<div class="password-reset-container">
        <h1>비밀번호 찾기</h1>
        <div class="password-reset-form">
            <div class="form-group">
                <input type="text" placeholder="아이디" name="id">
            </div>
            <div class="form-group">
                <input type="text" placeholder="이름" name="name">
            </div>
            <div class="form-group">
                <input type="email" placeholder="이메일" name="email">
            </div>
            <button type="submit">비밀번호 찾기</button>
        </div>
     
        <div class="links">
            <a href="${contextPath }/member/loginForm.do">로그인 &nbsp; / </a> 
            <a href="${contextPath }/member/FindId.do">아이디찾기 &nbsp; / </a> 
            <a href="${contextPath }/member/JoinMember.do">회원가입</a>
        </div>
        </div>
    </div>
    </form>

</body>
</html>