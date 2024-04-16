<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var = "contextPath" value="${pageContext.request.contextPath }"/>

<body>
    <div class="member">
        <div>
            <h2>개인정보</h2>
            <div class="user">
                <div>이름: ${memberInfo.name }</div>
                <div class="user-email">이메일: ${memberInfo.email }</div>
            </div>
            <div class="user-mod">
                <a href = "${contextPath }/member/memberDetail.do?id=${loginId}">내정보 변경</a>
            </div>
        </div>
        
        <div>
   			<ul>
   				<li><a href="${contextPath }/main.do">홈</a></li>
   				<li><a href="${contextPath }/mypage/shoppingBasket.do">장바구니</a></li>
   				<li><a href="${contextPath }/member/logout.do">로그아웃</a></li>
   			</ul>     
        </div>
    </div>
    
</body>
