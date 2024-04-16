<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <%
    request.setCharacterEncoding("utf-8");
    %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<c:set var="msg" value= '<%= request.getParameter("msg")%>' />
<c:set var="id" value= '<%= request.getParameter("id")%>' />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송지 관리</title>
</head>
<link rel ="stylesheet" href="${contextPath }/resources/css/addressDetail.css">
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
		<div class = "main-content2">
        <h1 class = "address_info">배송지 관리</h1>
     <div class="address-book">
        <div class="address-header">
            <div class="a">배송지</div>
            <div class="b">주소</div>
            <div class="c">연락처</div>
        </div>
     <c:forEach items="${addressList}" var="address" varStatus="status">
     <form name="modAddress" method="post" action="${contextPath }/member/delAddress.do">
        <div class="address-entry">
            <div>
                <input type ="hidden" name="no" value="${address.no}">
    			<input type ="hidden" name="memberId" value="${address.memberId}">
                <strong>${address.addressName}</strong><br>
                <span class="gray-text">수령인: ${address.recipient}</span>
            </div>
           <div>
                <span class="gray-text">${address.postCode}</span>
                <span >${address.address}</span>
                <span >${address.detailAddress}</span>
            </div>
            <div >
                <span class="cp">${address.addressPhone}</span>
            </div>
            <div>
           <span> <button type="submit" class="delete-button">삭제</button></span>
            </div>
        </div>
    
     </form>
		</c:forEach>
		</div>
		<c:if test="${fn:length(addressList) < 3}">
		 	 <div>
		        <button type="button" class="add-button" onclick="sendPostRequest()">+새 배송지 추가</button>
		     </div>
		</c:if>
</div>
</div>
     
     <script>
var contextPath = "${contextPath}";
</script>
     <script>
function sendPostRequest() {
    var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "${contextPath}/member/addAddressForm.do");
    form.setAttribute("target", "popupWindow"); 

   
    var idField = document.createElement("input");
    idField.setAttribute("type", "hidden");
    idField.setAttribute("name", "id");
    idField.setAttribute("value", "${param.id }");
    form.appendChild(idField);

    document.body.appendChild(form);


    var popupWindow = window.open('', 'popupWindow', 'width=700,height=600,scrollbars=yes');
    form.submit();


    document.body.removeChild(form);
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