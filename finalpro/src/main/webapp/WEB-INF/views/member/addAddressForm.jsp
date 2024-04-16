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
    <title>신규 배송지</title>
</head>
<link rel ="stylesheet" href="/finalpro/resources/css/addAddress.css">
<body>
    <div class="form-container">
        <h2>신규 배송지</h2>
        <form id= "addressForm" name= "addAddress" method="post" action="${contextPath }/member/addAddress.do">
            <div class="form-group">
                <label for="addressName">배송지</label>
                <input type="text" id="addressName" name="addressName[]" placeholder="배송지" maxlength="3">
            </div>
            <div class="form-group">
                <label for="addressName">수령인</label>
            <input type="text" id="recipient" name="recipient[]" placeholder="수령인" maxlength="3">
            </div>
            <div class="form-group">
                <label for="addressName">수령인 번호</label>
                <input type="text" id="addressPhone" name="addressPhone[]" placeholder="수령인 번호(숫자만 입력) " maxlength="12" pattern="\d*">
            </div>
            <div class="form-group inline">
                <label for="postCode">우편번호</label>
                <input class="postcl" type="text" id="postCode" name="postCode[]" placeholder="우편번호" maxlength="5" pattern="\d*" readonly="readonly">
                <input class="postCode-btn" type="button" value="주소검색" onclick="SearchPostcode()">
            </div>
            <div class="form-group">
                <label for="addressName">주소</label>
                <input type="text" id="address" name="address[]" placeholder="주소"  maxlength="40" readonly="readonly">
            </div>
         <div class="form-group">
    <label for="detailAddress">상세주소</label>
    <textarea id="detailAddress" name="detailAddress[]" rows="4" cols="50" placeholder="상세주소"  maxlength="80"></textarea>
</div>
            <div class="form-group">
                <button type="submit" class="btn submit">주소입력</button>
            </div>
        </form>
    </div>
    
<script>
var contextPath = "<c:out value='${contextPath}'/>"; 
</script>
<script>
function submitForm() {
  
    var formData = new FormData(document.getElementById('addressForm'));


    fetch(contextPath + '/member/addAddress.do', { 
        method: 'POST',
        body: formData
    })
    .then(response => {
       if (response.ok) {
            console.log('Form successfully submitted');
            if (window.opener && !window.opener.closed) {
                window.opener.location.reload(); 

            }
            window.close(); 

        } else {
            console.error('Form submission failed');


        }
    })
    .catch(error => {


        console.error('There was a problem with the fetch operation: ', error);
    });
}



document.addEventListener('DOMContentLoaded', function () {
    document.getElementById('addressForm').addEventListener('submit', function(event) {
        
       event.preventDefault();

        submitForm();
    });
});
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function SearchPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
              
                var addr = '';
                var extraAddr = ''; 

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else { 
                    addr = data.jibunAddress;
                }

              
                if(data.userSelectedType === 'R'){
              
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                  
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                   
                   
                } 
               
                document.getElementById('postCode').value = data.zonecode;
                document.getElementById("address").value = addr;
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
</body>
</html>