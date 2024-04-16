<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var = "contextPath" value="${pageContext.request.contextPath }"/>

<body>
	<div class="sidebar">
        <h1>마이페이지</h1>
        <h2>쇼핑 정보</h2>
        <a href="${contextPath }/mypage/orderList.do">구매 내역</a>
        <a href="${contextPath }/mypage/like.do">좋아요 누른 상품</a>
        <a href="${contextPath }/mypage/recentProduct.do">최근 본 상품</a>
        <h2>내 정보</h2>
        <a href="${contextPath }/member/memberDetail.do?id=${loginId}">프로필 관리</a>
        <a href="${contextPath }/member/mySize.do?">사이즈/퍼스널컬러</a>
    </div>
</body>