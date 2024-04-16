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
    <title>비밀번호 찾기 결과</title>
<link rel ="stylesheet" href="/finalpro/resources/css/serchPwd.css">
</head>
<body>
<form method="post" action="${contextPath }/member/searchPw.do">
<div class="container">
        <div class="content">
    <c:if test="${not empty userId}">
    <div class="logo">🐶</div><br>
        <p>비밀번호를 재설정 합니다.</p><br>
        <a href="${contextPath }/member/newPwd.do?id=${param.id}">새 비밀번호</a><br>
    </c:if>
    <c:if test="${empty userId}">
    <div class="logo">😭</div><br>
        <p>해당하는 비밀번호가 없습니다.</p><br>
        <a href="${contextPath }/member/FindPw.do">비밀번호 찾기</a><br>
    </c:if>
     </div>
    </div>
</form>
</body>

</html>