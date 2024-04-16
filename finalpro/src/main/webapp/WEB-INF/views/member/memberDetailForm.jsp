<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    request.setCharacterEncoding("utf-8");
    %>
<c:set var="contextPath" value="#{pageContext.request.contextPath }"/>
<c:set var="msg" value= '<%= request.getParameter("msg")%>' />
<c:set var="id" value= '<%= request.getParameter("id")%>' />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 찾기</title>
    <link rel ="stylesheet" href="${contextPath }/resources/css/memberDetailForm.css">
    <link rel ="stylesheet" href="${contextPath }/resources/css/myPage.css">
</head>
<body>
   
   <div class="main">
      <div class="sidebar">
         <h1>마이페이지</h1>
         <h3>쇼핑 정보</h3>
            <a href="${contextPath }/mypage/orderList.do">구매 내역</a>
            <a href="${contextPath }/mypage/like.do">좋아요 누른 상품</a>
            <a href="${contextPath }/mypage/recentProduct.do">최근 본 상품</a>
         <h3>내 정보</h3>
            <button type="button" onclick="sendMemberDetail()">내정보 관리</button>
            <br>
            <button type="button" onclick="sendPostAddress()">주소록</button>
            <br>
            <button type="button" onclick="sendMySize()">나의 사이즈</button>
      </div>

   <div class="profile-container">
       <h1 class = "profileTitle">프로필</h1>
       <form name="modMember" method="post" action="${contextPath }/member/modMember.do"
       onsubmit="return validateForm()"  accept-charset="UTF-8">
           <div class="form-group">
               <label for="id">아이디</label>
               <input type="text" name="id" id="id" value="${mdf.id}" readonly="readonly">
           </div>
           <div class="form-row">
     <label for="password">비밀번호</label>
     <div class="password-container">
       <input type="password" name="pwd" id="pwd" value="${mdf.pwd}">
       <button type="button" onclick="togglePasswordVisibility()" class="password-toggle">비밀번호 확인</button>
     </div>
   </div>
                   <div class="form-group">
               <label for="name">이름</label>
                <input type="text" name="name" id=name value="${mdf.name}">
           </div>
                   <div class="form-group">
               <label for="birthdate">생년월일</label>
                <input type="text" name="birthdate" id=birthdate value="${mdf.birthdate}"readonly="readonly">
           </div>
                  <div class="form-group">
               <label for="email">이메일</label>
               <input type="text" name="email" id=eamil value="${mdf.email}">
           </div>
                <div class="form-group">
               <label for="phone">연락처</label>
               <input type="text" name="phone" id=phone value="${mdf.phone}">
           </div>
               <div class="form-group">
               <label for="gender">성별</label>
               <input type="text" name="gender" id=gender value="${mdf.gender}">
           </div>
           
           <div class="form-actions">
               <input type="submit" class="edit-button" value="회원수정">
           </div>
       </form>
   </div>
   </div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
function togglePasswordVisibility() {
     var passwordInput = document.getElementById("pwd");
     if (passwordInput.type === "password") {
       passwordInput.type = "text";
     } else {
       passwordInput.type = "password";
     }
   }

    
    
    function validateForm() {
        var pwd = document.querySelector('input[name="pwd"]').value;
        var name = document.querySelector('input[name="name"]').value;
        var email = document.querySelector('input[name="email"]').value;
        var phone = document.querySelector('input[name="phone"]').value;

        // 비밀번호 검사
        if(pwd.length < 8) {
            alert("비밀번호는 8자 이상으로 설정해야 합니다.");
            document.querySelector('input[name="pwd"]').focus();
            return false;
        }

        // 이름 검사
        if(name === "") {
            alert("이름을 입력해주세요.");
            document.querySelector('input[name="name"]').focus();
            return false;
        }

        // 이메일 검사
        var emailPattern = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
        if (!emailPattern.test(email)) {
            alert("이메일 주소 형식으로 입력해주세요.");
            document.querySelector('input[name="email"]').focus();
            return false;
        }

        // 휴대전화 검사
        var phonePattern = /^01([0|1|6|7|8|9])(\d{3,4})(\d{4})$/;
        if(!phonePattern.test(콜)) {
            alert("유효한 휴대전화 번호를 입력해주세요.");
            document.querySelector('input[name="phone"]').focus();
            return false;
        }

        return true;
    }
    
    function sendMemberDetail() {
        // 폼 생성
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "${contextPath}/member/memberDetail.do");

        // memberId를 위한 input 요소 생성
        var idField = document.createElement("input");
        idField.setAttribute("type", "hidden");
        idField.setAttribute("name", "id");
        idField.setAttribute("value", "${myPage.id}"); // 여기서 member.id는 서버 사이드 코드에서 제공되어야 합니다.
        form.appendChild(idField);

        // 생성된 폼을 문서에 추가
        document.body.appendChild(form);

        // 폼 제출
        form.submit();
    }
    
    function sendPostAddress() {
        // 폼 생성
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "${contextPath}/member/addressDetailForm.do");

        // memberId를 위한 input 요소 생성
        var idField = document.createElement("input");
        idField.setAttribute("type", "hidden");
        idField.setAttribute("name", "id");
        idField.setAttribute("value", "${myPage.id}"); // 여기서 member.id는 서버 사이드 코드에서 제공되어야 합니다.
        form.appendChild(idField);

        // 생성된 폼을 문서에 추가
        document.body.appendChild(form);

        // 폼 제출
        form.submit();
    }
    
    function sendMySize() {
        // 폼 생성
        var form = document.createElement("form");
        form.setAttribute("method", "post");
        form.setAttribute("action", "${contextPath}/member/mySize.do");

        // memberId를 위한 input 요소 생성
        var idField = document.createElement("input");
        idField.setAttribute("type", "hidden");
        idField.setAttribute("name", "id");
        idField.setAttribute("value", "${myPage.id}"); // 여기서 member.id는 서버 사이드 코드에서 제공되어야 합니다.
        form.appendChild(idField);

        // 생성된 폼을 문서에 추가
        document.body.appendChild(form);

        // 폼 제출
        form.submit();
    }
  
    </script>

</body>
</html>