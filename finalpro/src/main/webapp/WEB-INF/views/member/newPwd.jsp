<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="javax.servlet.http.HttpSession" %>
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
    <form  method="post" action='${contextPath }/member/modNewPwd.do'>
    <div class="member">
    <div class="password-reset-container">
    <h1>새로운 비밀번호</h1>
     <div class="password-reset-form">
       <div class="form-group">  
             <input type="hidden" name="id" value="${param.id}"> 
        </div> 
       <div class="form-group">
             <input type="password" name="pwd" placeholder="새로운 비밀번호 입력" required>
        </div>

        <button type="submit" value="새로웁 비밀번호 수정">새로웁 비밀번호 수정</button>
        </div>
        </div>

    </div>
    </form>

</body>
</html>