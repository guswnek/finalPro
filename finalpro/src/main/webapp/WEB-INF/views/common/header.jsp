<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<body>
<header class="header">
    <div class="logo-container">
    	<a href="/finalpro/main.do">
        	<img src="/finalpro/resources/image/musinsa2.png">
        </a>	
    </div>
    <c:choose>
    <c:when test="${isLogin == true }">
    <nav class="user-nav">
    <form action="/finalpro/mypage/orderList.do" method="POST" style="display: inline;">
        <input type="hidden" name="id" value="${loginId}">
        <button type="submit" class="nn">${loginId}</button>
    </form>
    <a href="/finalpro/member/logout.do" class="logout">로그아웃</a>
    	</nav>
    	</c:when>
    	<c:otherwise>
    	  <nav class="user-nav-login">
    	<a href="/finalpro/member/loginForm.do" class="login">로그인</a>
    </nav>
    </c:otherwise>
    </c:choose>
    <div class="search-container">
    	<a href="/finalpro/member/searchForm.do">
            <img src="/finalpro/resources/image/search2.png">
        </a>    
    </div>
</header>
</body>
</html>
