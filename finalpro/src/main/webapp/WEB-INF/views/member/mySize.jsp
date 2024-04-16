<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    request.setCharacterEncoding("utf-8");
    %>
<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<link rel ="stylesheet" href="${contextPath }/resources/css/myPage.css">
<link rel ="stylesheet" href="${contextPath }/resources/css/mySize.css">

<title>사이즈 및 피부톤 설정</title>
<style>
  .focus { border: 2px solid #555; }
</style>
<c:choose>
<c:when test="${param.msg == 'updateSuccess' }">
<script>
alert('저장 및 수정 완료')
</script>
</c:when>

<c:when test="${param.msg == 'updatFailure' }">
<script>
alert('저장 및 수정 실패 (키 몸무게는 숫자 3자리 미만으로 입력해주세요)')
</script>
</c:when>
</c:choose>
<style>

.line{
border-bottom: 3px solid #918d8d;
margin-bottom: 40px;
margin-top: -22px;
}

.line2{
border-bottom: 3px solid #918d8d;;
margin-bottom: 40px;
margin-top: -22px;
}
.skin{
margin-bottom: 20px;
}

.physical{
margin-bottom: 20px;
}
</style>
</head>

<link rel ="stylesheet" href="/finalpro/resources/css/mySize.css">
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
			
		    <div class="main-content1">
		        <h2 class="title">내 사이즈 / 뷰티 정보</h2>
		        <form method="post" action="${contextPath }/member/updateMySize.do">
		        <div class="btn-container">
		            <button type="button" class="btn1">체형 피부정보</button>
		            <button type="button" class="btn2" onclick="sendPostRequest()">사이즈 추천</button>
		        </div>
		        <div class = "line"> </div>
		         <div>
		    		<input type="hidden" name="id" value="${member.id }"> 
				</div>
		        
		        <div class="section1">
		        	<label class="physical"><h3>신체 사이즈</h3></label>
		            <div class="unit-input">
		                <label for="height" class="label-inline">키</label>
		                <input class="height" type="number" id="height" name="height" value="${member.height }" placeholder="cm">
		                <span class="unit-label">cm</span>
		            </div>
		        </div>
		        
		
		        
		        <div class="section2">
		            <div class="unit-input">
		                <label for="weight" class="label-inline">몸무게</label>
		                <input class="weight" type="number" id="weight" name="weight" value="${member.weight }" placeholder="kg">
		                <span class="unit-label">kg</span>
		            </div>
		        </div>
		        
		        <div class = "line2"> </div>
		
		        <div class="section3">
		            <label class="skin"><h3>피부톤</h3></label>
		            <div class="radio-group">
		                <input type="radio" id="warmSpring" name="personalColor" value="warmSpring">
		                <label for="warmSpring">봄웜톤</label>
		                <input type="radio" id="coolSummer" name="personalColor" value="coolSummer">
		                <label for="coolSummer">여름쿨톤</label>
		                <input type="radio" id="warmAutumn" name="personalColor" value="warmAutumn">
		                <label for="warmAutumn">가을웜톤</label>
		                <input type="radio" id="coolWinter" name="personalColor" value="coolWinter">
		                <label for="coolWinter">겨울쿨톤</label>
		            </div>
		        </div>
		
		        <div class="btn-container">
		            <button type="submit" class="btn">저장</button>
		        </div>
		        </form>
		    </div>
	</div>
    <script>
    
    document.addEventListener('DOMContentLoaded', function() {
        
        var savedPersonalColor = "${member.personalColor}"; 
        
        if(savedPersonalColor) {
            var personalColorInput = document.getElementById(savedPersonalColor);
            if (personalColorInput) {
                personalColorInput.checked = true;
             
            }
        }
        
      
        var skinToneButtons = document.querySelectorAll('.radio-group input[type="radio"]');
        skinToneButtons.forEach(function(button) {
            button.addEventListener('change', function() {
               
                skinToneButtons.forEach(function(btn) {
                    btn.nextSibling.classList.remove('focused');
                });
                
                this.nextSibling.classList.add('focused');
            });
        });
    });
        
        function sendPostRequest() {
           
            var form = document.createElement("form");
            form.setAttribute("method", "post");
            form.setAttribute("action", "${contextPath}/member/sizeRecommend.do");

        
            var idField = document.createElement("input");
            idField.setAttribute("type", "hidden");
            idField.setAttribute("name", "id");
            idField.setAttribute("value", "${member.id}"); 
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