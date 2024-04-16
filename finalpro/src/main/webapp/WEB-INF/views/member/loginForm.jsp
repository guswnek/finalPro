<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" 
	value="${pageContext.request.contextPath }" />
<c:set var="msg" value= '<%= request.getParameter("msg")%>' />
<c:set var="id" value= '<%= request.getParameter("id")%>' />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인창</title>
<link rel ="stylesheet" href="/finalpro/resources/css/mainEx.css">
<c:choose>
	<c:when test="${msg == 'addMember' }">
		<script>
			alert('${id}님 환영합니다. 로그인 페이지로 이동합니다.');
		</script>
	</c:when>
		<c:when test="${param.result == 'loginFailed' }">
		<script>
			alert('아이디나 비밀번호를 다시 확인해주세요.');
		</script>
	</c:when>

		<c:when test="${msg == 'newPwdSuccess' }">
		<script>
			alert('비밀번호가 변경되었습니다.');
		</script>
	</c:when>


</c:choose>
</head>
<body>
	<img src="/finalpro/resources/image/cat.png" id="catImage"> 
	<div id="wrap_search">
      <div id="login_area">
        <div id="login_box">
          <form method="post" action="${contextPath }/member/login.do">
          	<div class="id">아이디</div>
            <input class="input" type="text" placeholder="아이디를 입력해 주세요" name="id"/>
            <br>
           <div class="pwd">비밀번호</div>
            <input class="input" type="password" placeholder="비밀번호를 입력해 주세요" name="pwd"/>
            <br>
            
            <span class="submit"><input type="submit" value="로그인"></span>
          </form>
          <ul id="sub_menu">
            <li><a href="${contextPath}/member/agree.do">회원 가입</a></li>
            <li><a href="${contextPath}/member/FindId.do">아이디/비밀번호 찾기</a></li>
          </ul>
        </div>
        <!-- <div id="social">
          <a id="naver" href="https://nid.naver.com/nidlogin.login?mode=form&url=https://www.naver.com/">
            <img src="/shop/resources/image/naver3.png"><span>네이버로 로그인</span>
          </a>
          <a id="apple" href="https://appleid.apple.com/sign-in">
            <img src="/shop/resources/image/apple2.png"><span>Apple로 로그인</span>
          </a>
        </div> -->
       </div>
    </div> 
</body>
</html>