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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>본인 인증 화면</title>
<link rel ="stylesheet" href="/finalpro/resources/css/identity.css">
</head>
<body>

<div class="modal">
    <div class="modal-header">
        본인인증
        <span class="close">&times;</span>
    </div>

    <div class="input-group">
        <label for="name">이름</label>
        <input type="text" id="name" placeholder="이름을 입력해주세요.">
    </div>

    <div class="input-group">
        <label for="u_phone">휴대폰 번호</label>
        <input type="text" id="u_phone" name="u_phone" placeholder="전화번호를 입력하세요">
        <input class="sendbtn" type="button" value="인증번호 발송" onclick="sendSMS();">
    </div>
    
        <div class="input-group">
       	<label for="phone"></label>
        <input type="text" id="inputCertNum" placeholder="인증번호">
    </div>

    <div class="button-group">
        <button class="active">SKT</button>
        <button>KT</button>
        <button>LG U+</button>
        <button>알뜰폰</button>
    </div>
    <div class="footer">
        <button class="ckbtn" onclick="verifyCertNum();">인증번호 확인</button>
    </div>
</div>
<c:if test="${!empty message}">
 <p>${message}</p>
</c:if>

<script>

    document.querySelector('.modal-header .close').onclick = function() {
      
    };

    
    var carrierButtons = document.querySelectorAll('.button-group button');
    carrierButtons.forEach(function(button) {
        button.onclick = function() {
            carrierButtons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
        };
    });
</script>


<script>
function sendSMS() {
   
    var u_phone = $("#u_phone").val();
    var contextPath = "${pageContext.request.contextPath}"; 

  
    $.ajax({
        url: contextPath + "/member/sendTest2.do", 
        type: 'POST', 
        data: {
            'u_phone': u_phone 
        },
        success: function(response) {
            
            console.log("성공: ", response);
            alert("인증번호가 발송되었습니다.");
        },
        error: function(xhr, status, error) {
            
            console.error("실패: ", error);
            alert("인증번호 발송에 실패했습니다.");
        }
    });
}
</script>

<script>
function verifyCertNum() {

    var inputCertNum = $("#inputCertNum").val();
    var contextPath = "${pageContext.request.contextPath}"; 

 
    $.ajax({
        url: contextPath+ "/member/verifyCertNum.do", 
        type: 'POST',
        dataType: 'json',
        data: {
            'inputCertNum': inputCertNum 
        },
        success: function(response) {
            
            alert(response.message); 
            if(response.success) {
                window.location.href = contextPath+ "/member/JoinMember.do"; 
            }
        },
        error: function(xhr, status, error) {
            
            alert("인증 실패: " + error);
        }
    });
}
</script>

</body>
</html>
