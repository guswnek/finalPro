<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%
    request.setCharacterEncoding("utf-8");
    %>
    <c:set var="contextPath" value="${pageContext.request.contextPath }"/>
    
<link rel ="stylesheet" href="${contextPath }/resources/css/myPage.css">
<link rel ="stylesheet" href="${contextPath }/resources/css/sizeRecommend.css">

<title>사이즈 추천 서비스</title>
<style>
    .hidden {
        display: none;
    }
    label, input {
        display: block;
        margin-bottom: 5px;
    }
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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
      
      <div class = "main-content2">
      <div class = "mbtn">
         <a href="${contextPath }/member/mySize.do"><input type="button" class="move-btn1"  value="나의 사이즈"></a>
          <input type="button" class="move-btn2"  value="사이즈 추천">
      </div>
      
   <div id="categoryButtons">
    <button class ="categoryButton" id="topsButton" data-category="tops">상의</button>
    <button class ="categoryButton" id="outerButton" data-category="outer">아우터</button>
    <button class ="categoryButton" id="bottomButton" data-category="bottoms">하의</button>
    <button class ="categoryButton" id="sneakersButton" data-category="sneakers">신발</button>
</div>

<div class="line"></div>

<!-- 상의 옵션들 -->
<div id="topsOptions" class="categoryOptions hidden">
    <button class="topsOption" data-option="shortT" id="shortT" name="shortSleevedTshirt" value="shortSleevedTshirt">반소매 티셔츠</button>
    <button class="topsOption" data-option="LongslT" id="LongslT" name="longSleevedTshirt" value="longSleevedTshirt">긴소매 티셔츠</button>
    <button class="topsOption" data-option="shirt" id="shirt"  name="shirt" value="shirt">셔츠</button>
    
   <div class="line"></div>
   
  
  <!-- 이미지 및 사이즈 입력 -->
  <div class="flex-container">
   <!-- 이미지 -->
   <div class="flex-item image-container">
     <img  id="shortT" data-option="shortT" src="/finalpro/resources/image/shortT.jpg" width="250px">
      <img id="LongslT" data-option="LongslT" src="/finalpro/resources/image/LongslT.jpg"width="250px">
    <img  id="shirt" data-option="shirt" src="/finalpro/resources/image/shirt.jpg"width="250px">
   </div>
   
      <!-- 사이즈 입력 -->
   <div class= "flex-item size-input-container">
   <div id="sizeInputForm" class="sizeInputForm hidden" data-category="tops">
     <h3>사이즈 입력</h3>
     <label for="topTotalLength">총장</label>
     <input class="toptl" type="text" id="topTotalLength" name="topTotalLength" placeholder="cm" value="${sizeDTO.topTotalLength }" maxlength="3" pattern="\d*"><br>
     
     <label for="shoulderLength">어깨 넓이</label>
     <input class="toptl" type="text" id="shoulderLength" name="shoulderLength" placeholder="cm" value="${sizeDTO.shoulderLength }" maxlength="3" pattern="\d*"><br>
     
     <label for="chestCrossLength">가슴단면</label>
     <input class="toptl" type="text" id="chestCrossLength" name="chestCrossLength" placeholder="cm" value="${sizeDTO.chestCrossLength }" maxlength="3" pattern="\d*"><br>
     
     <label for="sleeveLength">소매길이</label>
     <input class="toptl" type="text" id="sleevelength" name="sleevelength" placeholder="cm" value="${sizeDTO.sleevelength }" maxlength="3" pattern="\d*"><br>
     <button class="save-btn" type="submit" onclick="saveSizeInfo()">저장</button>
   </div>
</div>
</div>
</div>


<!-- 아우터 옵션들 -->
<div id="outerOptions" class="categoryOptions hidden">
    <button class="outerOption" data-option="jumper" id="jumper"  name="jumper" value="jumper">점퍼</button>
    <button class="outerOption" data-option="heavyOuter" id="heavyOuter" name="heaveyOuter" value="heaveyOuter">헤비 아우터</button>
    <button class="outerOption" data-option="coat" id="coat" name="coat" value="coat">코트</button>
    
    <div class="line"></div>
   
    <div class="flex-container">
     <!-- 이미지 및 사이즈 입력 -->
    
    
    <div class="flex-item image-container">
     <img id="jumper" data-option="jumper" src="/finalpro/resources/image/jumper.jpg"width="250px">
     <img id="heavyOuter" data-option="heavyOuter" src="/finalpro/resources/image/heavyOuter.jpg"width="250px">
     <img id="coat" data-option="coat" src="/finalpro/resources/image/coat.jpg"width="230px">
    </div>
    
    
     
<div class= "flex-item size-input-container">
   <div id="sizeInputForm4" class="sizeInputForm hidden" data-category="outer">
     <h3>사이즈 입력</h3>
     <label for="outerTotalLength">총장</label>
     <input class="outerTl" type="text" id="outerTotalLength" name="topTotalLength" placeholder="cm" value="${sizeDTO.topTotalLength }"maxlength="3" pattern="\d*"><br>
     
     <label for="outershoulderLength">어깨 넓이</label>
     <input class="outerTl" type="text" id="outershoulderLength" name="shoulderLength" placeholder="cm" value="${sizeDTO.shoulderLength }"maxlength="3" pattern="\d*"><br>
     
     <label for="outerchestCrossLength">가슴단면</label>
     <input class="outerTl" type="text" id="outerchestCrossLength" name="chestCrossLength" placeholder="cm" value="${sizeDTO.chestCrossLength }"maxlength="3" pattern="\d*"><br>
     
     <label for="outersleeveLength">소매길이</label>
     <input class="outerTl" type="text" id="outersleevelength" name="sleevelength" placeholder="cm" value="${sizeDTO.sleevelength }"maxlength="3" pattern="\d*"><br>
     
     <button class="save-btn" type="submit" onclick="saveSizeInfo()">저장</button>
   </div>
</div>
</div>
</div>


<!-- 바지 옵션들 -->
<div id="bottomsOptions" class="categoryOptions hidden">
    <button class="bottomOption" data-option="pants" id="pants" name="pants" value="pants">바지</button>
    <button class="bottomOption" data-option="shorts" id="shorts" name="shortsPants" value="shortsPants">반바지</button>
    <button class="bottomOption" data-option="skirt" id="skirt"  name="skirt" value="skirt">스커트</button>

    <div class="line"></div>
  <div class="flex-container">
    <div class="flex-item image-container">  
     <img id="pants" data-option="pants" src="/finalpro/resources/image/pants.jpg"width="300px" height="300px"> 
     <img id="shorts" data-option="shorts" src="/finalpro/resources/image/shorts.jpg"width="300px"> 
     <img id="skirt" data-option="skirt" src="/finalpro/resources/image/skirt.jpg"width="300px"> 
    </div>
    
    <div class="flex-item size-input-container">
   <div id="sizeInputForm2" class="sizeInputForm hidden" data-category="bottoms">
     <h3>사이즈 입력</h3>
     <label for="pantsTotalLength">총장</label>
     <input class="bottomTl" type="text" id="pantsTotalLength" name="pantsTotalLength" placeholder="cm" value="${sizeDTO.pantsTotalLength }"maxlength="3" pattern="\d*"><br>
     
     <label for="waistCrossLength">허리단면</label>
     <input class="bottomTl" type="text" id="waistCrossLength" name="waistCrossLength" placeholder="cm" value="${sizeDTO.waistCrossLength }"maxlength="3" pattern="\d*"><br>
     
     <label for="hipCrossLength">엉덩이 단면</label>
     <input class="bottomTl" type="text" id="hipCrossLength" name="hipCrossLength" placeholder="cm" value="${sizeDTO.hipCrossLength }"maxlength="3" pattern="\d*"><br>
     
     <label for="thighCrossLength">허벅지 단면</label>
     <input class="bottomTl" type="text" id="thighCrossLength" name="thighCrossLength" placeholder="cm" value="${sizeDTO.thighCrossLength }"maxlength="3" pattern="\d*"><br>
      
      <label for="riseLength">밑위</label>
     <input class="bottomTl" type="text" id="riseLength" name="riseLength" placeholder="cm" value="${sizeDTO.riseLength }"maxlength="3" pattern="\d*"><br>
     
     <label for="hemCrossLength">밑단 단면:</label>
     <input class="bottomTl" type="text" class="hemcl" id="hemCrossLength" name="hemCrossLength" placeholder="cm" value="${sizeDTO.hemCrossLength }"maxlength="3" pattern="\d*"><br>
   
     
     <button class="save-btn" type="submit" onclick="saveSizeInfo()">저장</button>
   </div>
</div>
</div>
</div>


<!-- 신발 옵션들 -->
<div id="sneakersOptions" class="categoryOptions hidden">
    <button class="sneakersOption" data-option="sneakers" id="sneakers" name="sneakers" value="sneakers">스니커즈</button>
    <button class="shoesOption" data-option="shoes" id="shoes"  name="shoes" value="shoes">신발</button>
    
     <div class="line"></div>
    
  <div class="flex-container">    
     <div class="flex-item image-container">
     <img  id="sneakers" data-option="sneakers" src="/finalpro/resources/image/sneakers.jpg"width="250px">
     <img id="shoes" data-option="shoes" src="/finalpro/resources/image/shoes.jpg"width="300px">
     </div>
     
     <div class="flex-item size-input-container">
   <div id="sizeInputForm3" class="sizeInputForm hidden"  data-category="foot" >
     <h3>사이즈 입력</h3>
     <label for="footLength">발길이</label>
     <input class="shoesTl" type="text" id="footLength" name="footLength" placeholder="cm" value="${sizeDTO.footLength }"maxlength="3" pattern="\d*"><br>
     
     <label for="ballOfFoot">발볼</label>
     <input class="shoesTl" type="text" id="ballOfFoot" name="ballOfFoot" placeholder="cm" value="${sizeDTO.ballOfFoot }"maxlength="3" pattern="\d*"><br>
     
     <label for="ankleHeight">발목높이</label>
     <input class="shoesTl" type="text" id="ankleHeight" name="ankleHeight" placeholder="cm" value="${sizeDTO.ankleHeight }"maxlength="3" pattern="\d*"><br>
     
     <label for="instepHeight">굽높이</label>
     <input class="shoesTl" type="text" id="instepHeight" name="instepHeight" placeholder="cm" value="${sizeDTO.instepHeight }"maxlength="3" pattern="\d*"><br>
     
    <button class="save-btn" type="submit" onclick="saveSizeInfo()">저장</button>
   </div>
</div>
</div> 
</div
>
</div>

<!-- 스크립트 -->
<script>
$('.categoryOptions button').click(function() {
    selectedOption = $(this).data('option'); 
    var contextPath = "${pageContext.request.contextPath}"; 
    var loginId = "${sessionScope.loginId}"; 

   // 사이즈 저장정보 불러오기
    $.ajax({
        url: contextPath + "/member/infoSizeRecommend.do", 
        type: "GET",
        data: {
           memberId: "${sessionScope.loginId}",
           sizeCategory: selectedOption
           }, 
        success: function(response) {
          
            fillFormWithSizeData(response, selectedOption);
        },
        error: function(xhr, status, error) {
            
            if(xhr.status == 404) {
                console.log("No data found for the selected category, showing empty fields.");
               
                fillFormWithSizeData({}, selectedOption);
            } else {
                console.log("Error fetching size data: " + error);
            }
        }
    });
});


function fillFormWithSizeData(sizeData, selectedOption) {
    $('.sizeInputForm input, .sizeInputForm2 input, .sizeInputForm3 input, .sizeInputForm4 input').parent().hide();

   

    var fieldsToShow = determineFieldsToShow(selectedOption);

    fieldsToShow.forEach(function(fieldName) {
        
        var fieldValue = sizeData[fieldName] || '';

      
        $('input[name="' + fieldName + '"]').val(fieldValue).parent().show();
    });
}


function determineFieldsToShow(selectedOption) {

    var fieldsMapping = {
        // 상의
       'shortT': ['topTotalLength', 'shoulderLength', 'chestCrossLength', 'sleevelength'],
        'LongslT': ['topTotalLength', 'shoulderLength', 'chestCrossLength', 'sleevelength'],
        'shirt': ['topTotalLength', 'shoulderLength', 'chestCrossLength', 'sleevelength'],
        
        // 아우터
        'jumper': ['topTotalLength', 'shoulderLength', 'chestCrossLength', 'sleevelength'],
        'heavyOuter': ['topTotalLength', 'shoulderLength', 'chestCrossLength', 'sleevelength'],
        'coat': ['topTotalLength', 'shoulderLength', 'chestCrossLength', 'sleevelength'],
        
        // 바지
        'pants': ['pantsTotalLength', 'waistCrossLength', 'hipCrossLength', 'thighCrossLength', 'riseLength', 'hemCrossLength'],
        'shorts': ['pantsTotalLength', 'waistCrossLength', 'hipCrossLength', 'thighCrossLength', 'riseLength', 'hemCrossLength'],
        'skirt': ['pantsTotalLength', 'waistCrossLength', 'hipCrossLength', 'hemCrossLength'],
        
        //스니커즈
        'sneakers': ['footLength', 'ballOfFoot', 'ankleHeight', 'instepHeight'],
        //신발
        'shoes': ['footLength', 'ballOfFoot', 'ankleHeight', 'instepHeight'],
        
        
        
    };

    return fieldsMapping[selectedOption] || [];
}
</script>
<script>
var selectedOption = ''; 

$(document).ready(function() {
   
    $('#categoryButtons button').click(function() {
      
        $('.categoryOptions, .sizeInputForm').addClass('hidden');
        
        
        $('.sizeInputForm').find('input').val('');

        
        var category = $(this).data('category');
        $('#' + category + 'Options').removeClass('hidden');
    });

   
    $('.categoryOptions button').click(function() {
        selectedOption = $(this).data('option');

        
        $('.sizeInputForm').addClass('hidden').find('input').val('');

        
        var selectedForm = determineFormToShow(selectedOption);
        $(selectedForm).removeClass('hidden').data('option', selectedOption); 
        
      
        if (selectedForm === '#sizeInputForm') {
            showFieldsForTops(selectedOption);
        } else if (selectedForm === '#sizeInputForm2') {
            showFieldsForBottoms(selectedOption);
        } else if (selectedForm === '#sizeInputForm3') {
            showFieldsForShoes(selectedOption);
        } else if (selectedForm === '#sizeInputForm4'){
           showFieldsForOuter(selectedOption);
        }
    });
});



function determineFormToShow(option) {
    switch(option) {
        case 'shortT':
        case 'LongslT':
        case 'shirt':
           return '#sizeInputForm';
        case 'jumper':
        case 'heavyOuter':
        case 'coat':
            return '#sizeInputForm4';
        case 'pants':
        case 'shorts':
        case 'skirt':
            return '#sizeInputForm2';
        case 'sneakers':
        case 'shoes':
            return '#sizeInputForm3';
        default:
            return null; 
    }
}


function showFieldsForTops(option) {

        
  $('#sizeInputForm label, #sizeInputForm input').removeClass('hidden');
   
}

function showFieldsForOuter(option) {

    
     $('#sizeInputForm4 label, #sizeInputForm4 input').removeClass('hidden');
      
   }

function showFieldsForBottoms(option) {
    $('#sizeInputForm2 label, #sizeInputForm2 input').addClass('hidden');
    
    
    if (option === 'skirt') {
        
        $('#sizeInputForm2 label[for="pantsTotalLength"], #sizeInputForm2 input#pantsTotalLength').removeClass('hidden');
        $('#sizeInputForm2 label[for="waistCrossLength"], #sizeInputForm2 input#waistCrossLength').removeClass('hidden');
        $('#sizeInputForm2 label[for="hipCrossLength"], #sizeInputForm2 input#hipCrossLength').removeClass('hidden');
        $('#sizeInputForm2 label[for="hemCrossLength"], #sizeInputForm2 input#hemCrossLength').removeClass('hidden');
    } else {
      
        $('#sizeInputForm2 label, #sizeInputForm2 input').removeClass('hidden');
    }
}

function showFieldsForShoes(option) {
    
    $('#sizeInputForm3 label, #sizeInputForm3 input').removeClass('hidden');
}



// 저장기능
function saveSizeInfo() {
    var loginId = "${sessionScope.loginId}"; 
    var contextPath = "${pageContext.request.contextPath}"; 
    
    var selectedForm = determineFormToShow(selectedOption);

    var formData = collectFormData(); 

    formData.loginId = loginId;

    console.log("formData:", formData);

   
    $.ajax({
        url: contextPath + "/member/updateRecommend.do", 
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(formData),
        success: function(response) {
            alert("정보가 저장되었습니다.");
        },
        error: function(xhr, status, error) {
            alert("숫자3자리 이하만 입력해주세요: " + error);
            console.log(xhr.responseText);
        }
    });
}

function collectFormDataFromVisibleForm(selectedForm) {
    var data = {};

    
    $(selectedForm + ":not(.hidden) input").each(function() {
        var inputName = $(this).attr("name");
        var inputValue = $(this).val();
        data[inputName] = inputValue;
    });

    return data;
}

function collectFormData() {
    var data = {
        memberId: "${sessionScope.loginId}", 
        sizeCategory: selectedOption 
    };

    $(".sizeInputForm:not(.hidden) input").each(function() {
        var inputName = $(this).attr("name");
        var inputValue = $(this).val();
        data[inputName] = inputValue;
    });

    if (selectedOption === "shortT") {
        data.topTotalLength = $('#topTotalLength').val();
        data.shoulderLength = $('#shoulderLength').val();
        data.chestCrossLength = $('#chestCrossLength').val();
        data.sleevelength = $('#sleevelength').val();
    
    }
    
    else if (selectedOption === "LongslT") {
        data.topTotalLength = $('#topTotalLength').val();
        data.shoulderLength = $('#shoulderLength').val();
        data.chestCrossLength = $('#chestCrossLength').val();
        data.sleevelength = $('#sleevelength').val();
    
    } 
    
    else if (selectedOption === "shirt") {
        data.topTotalLength = $('#topTotalLength').val();
        data.shoulderLength = $('#shoulderLength').val();
        data.chestCrossLength = $('#chestCrossLength').val();
        data.sleevelength = $('#sleevelength').val();
    
    } 

    else if (selectedOption === "jumper") {
        data.outerTotalLength = $('#outerTotalLength').val();
        data.outershoulderLength = $('#outershoulderLength').val();
        data.outerCrossLength = $('#outerchestCrossLength').val();
        data.outersleevelength = $('#outersleevelength').val();
      
    } 

    else if (selectedOption === "heavyOuter") {
        data.outerTotalLength = $('#outerTotalLength').val();
        data.outershoulderLength = $('#outershoulderLength').val();
        data.outerchestCrossLength = $('#outerchestCrossLength').val();
        data.outersleevelength = $('#outersleevelength').val();
  
    } 

    else if (selectedOption === "coat") {
        data.outerTotalLength = $('#outerTotalLength').val();
        data.outershoulderLength = $('#outershoulderLength').val();
        data.outerchestCrossLength = $('#outerchestCrossLength').val();
        data.outersleevelength = $('#outersleevelength').val();
      
    } 

    else if (selectedOption === "pants") {
        data.pantsTotalLength = $('#pantsTotalLength').val();
        data.waistCrossLength = $('#waistCrossLength').val();
      data.hipCrossLength = $('#hipCrossLength').val();
        data.thighCrossLength = $('#thighCrossLength').val();
        data.riseLength = $('#riseLength').val();
        data.hemCrossLength = $('#hemCrossLength').val();
    
    }
    else if (selectedOption === "shorts") {
        data.pantsTotalLength = $('#pantsTotalLength').val();
        data.waistCrossLength = $('#waistCrossLength').val();
      data.hipCrossLength = $('#hipCrossLength').val();
        data.thighCrossLength = $('#thighCrossLength').val();
        data.riseLength = $('#riseLength').val();
        data.hemCrossLength = $('#hemCrossLength').val();
       
    }

    else if (selectedOption === "skirt") {
        data.pantsTotalLength = $('#pantsTotalLength').val();
        data.waistCrossLength = $('#waistCrossLength').val();
        data.hipCrossLength = $('#hipCrossLength').val();
        data.hemCrossLength = $('#hemCrossLength').val();

    }

     else if (selectedOption === "sneakers") {
        data.footLength = $('#footLength').val();
        data.ballOfFoot = $('#ballOfFoot').val();
        data.ankleHeight = $('#ankleHeight').val();
        data.instepHeight = $('#instepHeight').val();
        
    }
    
    else if (selectedOption === "shoes") {
        data.footLength = $('#footLength').val();
        data.ballOfFoot = $('#ballOfFoot').val();
        data.ankleHeight = $('#ankleHeight').val();
        data.instepHeight = $('#instepHeight').val();
       
    }

    return data;
}
</script>
<script>
fetch('/finalpro/member/updateRecommend.do', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify(memberSizeData),
})
.then(response => {
    if (response.status === 401) {
  
        alert('로그인이 필요합니다.');
        window.location.href = '/finalpro/member/loginForm.do'; 
    } else if (response.ok) {
        return response.text();
    } else {
        throw new Error('서버에서 문제가 발생했습니다.');
    }
})
.then(message => {
    console.log(message); 
})
.catch(error => {
    console.error(error);
});

</script> 
<script>
$(document).ready(function() {
   
    $('#categoryButtons button').click(function() {
       
   
        $('.categoryOptions, .categoryOptions img').addClass('hidden');

 
        var category = $(this).attr('data-category');
        console.log(category);
        $('#' + category + 'Options').removeClass('hidden');

  
    });

   
    $('.categoryOptions button').click(function() {
     
        var selectedOption = $(this).data('option');

       
        $('.categoryOptions img').addClass('hidden');

 
        $('img[data-option="' + selectedOption + '"]').removeClass('hidden');
    });
});



</script>
<script>
fetch('/finalpro/member/updateRecommend.do', {
    method: 'POST',
    headers: {
        'Content-Type': 'application/json',
    },
    body: JSON.stringify(memberSizeData),
})
.then(response => {
    if (response.status === 401) {
        // 로그인 필요 상태 코드를 받았을 때 처리
        alert('로그인이 필요합니다.');
        window.location.href = '/finalpro/member/loginForm.do'; // 로그인 페이지로 리다이렉션
    } else if (response.ok) {
        return response.text();
    } else {
        throw new Error('서버에서 문제가 발생했습니다.');
    }
})
.then(message => {
    console.log(message); // 성공 메시지 처리
})
.catch(error => {
    console.error(error);
});

function sendMemberDetail() {
    // 폼 생성
    var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "${contextPath}/member/memberDetail.do");

    // memberId를 위한 input 요소 생성
    var idField = document.createElement("input");
    idField.setAttribute("type", "hidden");
    idField.setAttribute("name", "id");
    idField.setAttribute("value", "${loginId}"); 
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
    idField.setAttribute("value", "${loginId}"); 
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
    idField.setAttribute("value", "${loginId}"); 
    form.appendChild(idField);

    // 생성된 폼을 문서에 추가
    document.body.appendChild(form);

    // 폼 제출
    form.submit();
}
</script>

 
 </body>
 </html>