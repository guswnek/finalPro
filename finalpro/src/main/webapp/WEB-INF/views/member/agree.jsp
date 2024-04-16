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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>약관동의</title>
<link rel ="stylesheet" href="/finalpro/resources/css/agree.css">
</head>
<body>

<div class="container">
    <div class="header1">
        <h1>환영합니다!</h1>
        <p>가입하시려면 약관에 동의후 본인인증을 진행해주세요.</p>
    </div>

   <ul class="checklist">
    <li>
       <label class="agree-all-label">
            <input type="checkbox" class="agree-all-input" id="agree-all" onclick="checkAll(this)"> 
            약관 전체 동의하기 (선택 동의 포함)
        </label>
    </li>
    <li>
        <label>
            <input type="checkbox" class="required" required> 
            [필수] 만 14세 이상입니다.
        </label>
    </li>
    <li>
        <label>
            <input type="checkbox" class="required" required> 
            [필수] 서비스, 마케팅에 이용 및 처리
        </label>
    </li>
    
     <li>
        <label>
            <input type="checkbox" class="required" required> 
            [필수] 개인정보 수집 및 이용 동의
        </label>
    </li>
    
         <li>
        <label>
            <input type="checkbox" class="notrequired" required> 
            [선택] 광고성 정보 수신 동의
        </label>
    </li>
    
</ul>

<a href="${contextPath}/member/identity.do" class="agree-btn" onclick="return checkRequiredAndSubmit();">약관동의 및 본인인증</a>
 <p class="warning-message" id="warning-message">모든 필수 항목을 체크해주세요.</p>

    <div class="footer">
        <p></p>
    </div>
</div>
<script>
    function checkAll(master) {
        var checkboxes = document.querySelectorAll('.checklist input[type="checkbox"]');
        for (var i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = master.checked;
        }
    }
    
    function checkRequiredAndSubmit() {
        // 필수('.required') 체크박스들만 체크되었는지 확인
        var requiredCheckboxes = document.querySelectorAll('.required[required]');
        var allChecked = true;
        
        for (var i = 0; i < requiredCheckboxes.length; i++) {
            if (!requiredCheckboxes[i].checked) {
                allChecked = false;
                break;
            }
        }
        
        if (!allChecked) {
            // 필수 체크박스들이 모두 체크되지 않았으면 경고 메시지 표시
            document.getElementById('warning-message').style.display = 'block';
            return false; // 버튼 클릭 이벤트 중단
        } else {
            // 필수 체크박스들이 모두 체크되었으면 경고 메시지 숨김
            document.getElementById('warning-message').style.display = 'none';
            return true; // 버튼 클릭 이벤트 계속 (페이지 이동)
        }
    }
</script>
</body>
</html>
