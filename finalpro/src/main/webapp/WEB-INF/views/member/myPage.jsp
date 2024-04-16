<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    request.setCharacterEncoding("utf-8");
    %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel ="stylesheet" href="/finalpro/resources/css/myPage.css">
</head>
<body>

<div class="main">
    <div class="sidebar">
        <h1>마이페이지</h1>
        <h2>쇼핑 정보</h2>
        <button type="button">?</button><br>
        <button type="button">?</button><br>
        <button type="button">?</button><br>
        <h2>내 정보</h2>
        <button type="button" onclick="sendMemberDetail()">내정보 관리</button><br>
        <button type="button" onclick="sendPostAddress()">주소록</button><br>
        <button type="button" onclick="sendMySize()">나의 사이즈</button>
    </div>
    <div class="main-content">
        <div class="member">
            <div>
                <h2>개인정보</h2>
                <div class="user">
                    <div>
                    <p>이름 : 
                    <input type="text" id="name" value="${myPage.name }" readonly="readonly">
                    <p>
                    </div>
                    <div class="user-email">
                    <p>이메일 : 
                    <input type="text" id="email" value="${myPage.email }" readonly="readonly">
                    <p>
                    
                    </div>
                </div>
            </div>
        </div>
       <div class="main-content1">
    <ul class="sub">
        <li class="active">전체/최신</li>
        <li>관심 상품</li>
        <li>구매 상품</li>
        <li>구매 완료</li>
        <li>취소/교환/반품</li>
    </ul>
    <div class="no-order">
        <i class="icon">!</i>
        <span>주문 내역이 없습니다.</span>
    </div>
</div>
       <div class="main-content2">
    <div class="add-content">
        <i class="icon">???</i>
        <span>추가할 것 넣어도 됨.</span>
    </div>
</div>
    </div>
</div>
<script>
        function sendMemberDetail() {
       
            var form = document.createElement("form");
            form.setAttribute("method", "post");
            form.setAttribute("action", "${contextPath}/member/memberDetail.do");

      
            var idField = document.createElement("input");
            idField.setAttribute("type", "hidden");
            idField.setAttribute("name", "id");
            idField.setAttribute("value", "${myPage.id}"); 
            form.appendChild(idField);

            
            document.body.appendChild(form);

           
            form.submit();
        }
        
        function sendPostAddress() {
      
            var form = document.createElement("form");
            form.setAttribute("method", "post");
            form.setAttribute("action", "${contextPath}/member/addressDetailForm.do");

            var idField = document.createElement("input");
            idField.setAttribute("type", "hidden");
            idField.setAttribute("name", "id");
            idField.setAttribute("value", "${myPage.id}"); 
            form.appendChild(idField);

         
            document.body.appendChild(form);

           
            form.submit();
        }
        
        function sendMySize() {
         
            var form = document.createElement("form");
            form.setAttribute("method", "post");
            form.setAttribute("action", "${contextPath}/member/mySize.do");

      
            var idField = document.createElement("input");
            idField.setAttribute("type", "hidden");
            idField.setAttribute("name", "id");
            idField.setAttribute("value", "${myPage.id}"); 
            form.appendChild(idField);


            document.body.appendChild(form);

     
            form.submit();
        }
    </script>
</body>
</html>