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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<title>회원가입</title>
<link rel ="stylesheet" href="/finalpro/resources/css/joinMember.css">
</head>
<script>
var isEmailChecked = false;
var contextPath = "${contextPath}";
function DupEmail() {
    var email = $('input[name="email"]').val();
    $.ajax({
        url: '${contextPath}/member/dupEmail.do',
        type: 'GET',
        data: {email: email},
        success: function(data) {
            if(data.dup) {
                alert('이미 사용 중인 이메일입니다.');
                isEmailChecked = false;
            } else {
                alert('사용 가능한 이메일입니다.');
                isEmailChecked = true;
            }
        },
        error: function() {
            alert('이메일 중복체크 실패');
        }
    });
   
}



var isIdChecked = false;
var contextPath = "${contextPath}";
function DupId() {
    var id = $('input[name="id"]').val();
    $.ajax({
        url: '${contextPath}/member/dupId.do',
        type: 'GET',
        data: {id: id},
        success: function(data) {
            if(data.dup) {
                alert('이미 사용 중인 아이디입니다.');
                isIdChecked = false;
            } else {
                alert('사용 가능한 아이디입니다.');
                isIdChecked = true;
            }
        },
        error: function() {
            alert('아이디 중복체크 실패');
        }
    });
   
}
function validateForm() {
    var id = $('input[name="id"]').val();
    var pwd = $('input[name="pwd"]').val();
    var name = $('input[name="name"]').val();
    var birthdate = $('input[name="birthdate"]').val();
    var email = $('input[name="email"]').val();
    var phone = $('input[name="phone"]').val();
    var idck = $('button[name="idck"]').val();
    var emailck = $('button[name="emailck"]').val();
    var genderChecked = $('input[name="gender"]:checked').length > 0;

    // 아이디 검사
    if(id.length < 1 || id.length > 20) {
        alert("아이디는 1자 이상, 20자 이하로 입력해야 합니다.");
        $('input[name="id"]').focus();
        return false;
    }
    if(!isIdChecked) {
        alert("아이디 중복체크를 해주십시오");
        $('input[name="id"]').focus();
        return false;
    }

    // 비밀번호 검사
    if(pwd.length < 8) {
        alert("비밀번호는 8자 이상으로 설정해야 합니다.");
        $('input[name="pwd"]').focus();
        return false;
    }

    // 이름 검사
    if(name === "") {
        alert("이름을 입력해주세요.");
        $('input[name="name"]').focus();
        return false;
    }

    // 생년월일 검사
    var birthdatePattern = /^\d{4}(\d{2})(\d{2})$/;
    if(!birthdatePattern.test(birthdate)) {
        alert("생년월일은 YYYYMMDD 형식으로 입력해야 합니다.");
        $('input[name="birthdate"]').focus();
        return false;
    }

    // 이메일 검사
   
    if(email === "") {
        alert("이메일 주소 형식으로 입력해주세요.");
        $('input[name="email"]').focus();
        return false;
    }
    
    if(!isEmailChecked) {
        alert("이메일 중복체크를 해주십시오");
        $('input[name="email"]').focus();
        return false;
    }

    // 휴대전화 검사
    var phonePattern = /^01([0|1|6|7|8|9])(\d{3,4})(\d{4})$/;
    if(!phonePattern.test(phone)) {
        alert("유효한 휴대전화 번호를 입력해주세요.");
        $('input[name="phone"]').focus();
        return false;
    }
    if(!genderChecked) {
        alert("성별을 선택해주세요.");
        return false;
    }

    
    return true;
}
</script>

<body>
    <form method="post" action='${contextPath }/member/addMember.do'
   onsubmit="return validateForm()"  accept-charset="UTF-8">
    <div class="member">
        <!-- 목록 -->
       <div class="layout go-id">
            <label for="id">아이디</label>
            <input class= "id" type="text" name="id"  placeholder="아이디 입력">
            <input class= "idck" type="button" name="idck" onclick="DupId()" value="중복체크" class="check-btn">
        </div>
        <div class="layout">
            <label for="pwd">비밀번호</label>
            <input class="pw" type="password" name="pwd" placeholder="비밀번호 입력">
        </div>
        <div class="layout">
            <label for="name">이름</label>
            <input type="text" name="name"  placeholder="이름 입력">
        </div>

     		<!-- 생년월일 -->
         <div class="layout birth">
            <label for="birth">생년월일</label>
            <div>
                <input type="text" placeholder="ex)19980627" name="birthdate">                
            </div>
        </div> 


        <!-- 이메일 -->
      <div class="layout email">
           <label for="email">이메일</label>
            <input type="email" name="email"  placeholder="이메일 입력">
            <input class= "idck" type="button" name="emailck" onclick="DupEmail()" value="중복체크" class="check-btn">
        </div>
        
        <!-- 번호 -->
        <div class="layout tel-number">
            <label for="phone">전화번호</label>
            <div>
                <input type="tel" placeholder="전화번호 입력" name="phone">
            </div>
        </div>
        
       <div class="layout gender">
            <label for="gender">성별</label>
            <label>
                <input type="radio" name="gender" value="남성" checked> 남자
            </label>
            <label>
                <input type="radio" name="gender" value="여성"> 여자
            </label>
        </div>

        <input type="submit" value="가입하기">

    </div>
</form>
</body>
</html>