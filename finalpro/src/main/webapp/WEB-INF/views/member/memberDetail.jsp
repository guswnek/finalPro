<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    request.setCharacterEncoding("utf-8");
    %>
<c:set var="contextPath" value="#{pageContext.request.contextPath }"/>
<c:set var="msg" value= '<%= request.getParameter("msg")%>' />
<c:set var="id" value= '<%= request.getParameter("id")%>' />

<c:choose>
   <c:when test="${msg == 'updateSuccess' }">
      <script>
         alert('회원정보가 수정되었습니다.');
      </script>
   </c:when>
</c:choose>
</head>
<link rel ="stylesheet" href="${contextPath }/resources/css/memberDetail.css">
<link rel ="stylesheet" href="${contextPath }/resources/css/myPage.css">
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
                <h1 class = "pro_file">프로필</h1>
                <form class="profile-form" name="modMember" method="post" action="${contextPath }/member/memberDetailForm.do"
                onsubmit="return validateForm()"  accept-charset="UTF-8">
               
                    <div class="form-group">
                        <label for="id">아이디</label>
                        <input type="text" name="id" id="id" value="${memberDetails.id}" readonly="readonly">
                    </div>
              <div class="form-row">
              <label for="password">비밀번호</label>
              <div class="password-container">
                <input type="password" name="password" id="password" value="${memberDetails.pwd}"  readonly="readonly">
                <button type="button" onclick="togglePasswordVisibility()" class="password-toggle">비밀번호 확인</button>
              </div>
            </div>
            
                    <div class="form-group">
                        <label for="name">이름</label>
                        <input type="text" name="name" id="name" value="${memberDetails.name}" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label for="birthdate">생년월일</label>
                        <input type="text" name="birthdate" id="birthdate" value="${memberDetails.birthdate}" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label for="email">이메일</label>
                        <input type="text" name="email" id="email" value="${memberDetails.email}" readonly="readonly">
                    </div>
                    <div class="form-group">
                        <label for="phone">연락처</label>
                        <input type="text" id="phone" id=phone value="${memberDetails.phone}" readonly="readonly">
                    </div>
                      <div class="form-group">
                        <label for="gender">성별</label>
                        <input type="text" id="gender" id=gender value="${memberDetails.gender}" readonly="readonly">
                    </div>
                    <div class="form-actions">
                        <button type="submit" class="edit-button">회원수정창</button>
                        <button type="button" class="delete-button" onclick="confirmAndDelete()">회원탈퇴</button>
                    </div>
                </form>
                </div>
             </div>
<script>
function togglePasswordVisibility() {
     var passwordInput = document.getElementById("password");
     if (passwordInput.type === "password") {
       passwordInput.type = "text";
     } else {
       passwordInput.type = "password";
     }
   }

    
    function confirmAndDelete() {
        var result = confirm("회원 탈퇴를 진행하시겠습니까?");
        if (result) {
         
            sendDelMember();
        } else {
          
            postToMemberDetail();
        }
    }
     
    
    function sendDelMember() {
  
            var form = document.createElement("form");
            form.setAttribute("method", "post");
            form.setAttribute("action", "${contextPath}/member/delMember.do");


            var idField = document.createElement("input");
            idField.setAttribute("type", "hidden");
            idField.setAttribute("name", "id");
            idField.setAttribute("value", "${memberDetails.id}");
            form.appendChild(idField);

   
            document.body.appendChild(form);

   
            form.submit();
    }
        
        function postToMemberDetail() {
            var form = document.createElement("form");
            form.setAttribute("method", "post");
            form.setAttribute("action", "${contextPath}/member/memberDetail.do");

            
            var idField = document.createElement("input");
            idField.setAttribute("type", "hidden");
            idField.setAttribute("name", "id");
            idField.setAttribute("value", "${memberDetails.id}"); 
            form.appendChild(idField);

           
            document.body.appendChild(form);

        
            form.submit();
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
            idField.setAttribute("value", "${loginId}"); // 여기서 member.id는 서버 사이드 코드에서 제공되어야 합니다.
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
            idField.setAttribute("value", "${loginId}"); // 여기서 member.id는 서버 사이드 코드에서 제공되어야 합니다.
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