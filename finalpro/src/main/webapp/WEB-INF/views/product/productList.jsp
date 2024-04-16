<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
   request.setCharacterEncoding("utf-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="subCategory" value="${param.subCategory }" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<link rel="stylesheet" href="${contextPath }/resources/css/productList.css">

<style>
   .colorBox {
      border: 1px solid;
   }
   /* 선택된 컬러박스 설정 */
   .selected {
      border: 2px solid;
   }
   /* 선택된 페이지 번호 설정 */
   .pagination_button.active{
      background-color: lightgray;
      color: black;
   }
   /* 선택되지 않은 페이지 번호 설정 */ 
    .pagination_button{
   width: 50px;
    height: 50px;
    border-radius: 10px;
    background-color: white;
    color: #C8C8C8;
    border: 2px solid black;
   } 
   /* 페이지 번호틀 기본 설정 */
   #pagination{
   position: fixed;
   z-index: 12;
    bottom: 0;
    width: 68%;
    height: 50px;
    display: flex;
    justify-content: center;
    align-content: center;
    
    /* 페이지 번호들 끼리 간격 벌리기 */
    flex-wrap: nowrap;
    gap: 1px
   }
   
   /* 선택된 정렬 버튼 설정 */
   .selectedAlign{
   background-color: #e9e9e9;
   border: 1px solid #ccc;
   padding: 8px 16px;
   }
   
</style>


<script>
   let currentPage = 1;
   let goodsCntPerPage = 4;
   let settingUrl = window.location.href;
   
   // pagination(페이지 넘기는 bar) 관련 함수들 해당 jsp 열 때 바로 실행
   document.addEventListener('DOMContentLoaded', function() {
    updateGoodsDisplay();
   });
   
   //페이지 화면 상품리스트 업데이트
   function updateGoodsDisplay(){
      let allGoods = document.querySelectorAll('.oneOfList');
      let startGoods = (currentPage - 1) * goodsCntPerPage;
      let endGoods = startGoods + goodsCntPerPage;
      
      allGoods.forEach(function(item,index){
         if(index >= startGoods && index < endGoods){
            item.style.display = 'block'; // 현재 페이지 상품리스트 보이기
         }else{
            item.style.display = 'none';  // 현재 페이지 상품리스트 제외한 다른 페이지 상품리스트 숨기기
         }
      });
      createPaginationBtn(); // 페이지 버튼 업데이트      
   }

   //페이지버튼 생성 설정
   function createPaginationBtn() {
      let pagination = document.querySelector('#pagination');
      let allGoods = document.querySelectorAll('.oneOfList').length;
      let totalPageCnt = Math.ceil(allGoods / goodsCntPerPage);
      
      pagination.innerHTML="";
      
      if(currentPage > 1){
         //제일 처음으로 이동하는 버튼
         let firstPageBtn = document.createElement('button');
         firstPageBtn.className = 'pagination_button';
         firstPageBtn.innerText = '<<';
         firstPageBtn.addEventListener('click',function(){
            currentPage  = 1;
            updateGoodsDisplay();
         });
         pagination.appendChild(firstPageBtn);
      }
      
         //바로 이전으로 이동하는 버튼
         if(currentPage > 1){
            let previousBtn = document.createElement('button');
            previousBtn.className = 'pagination_button';
            previousBtn.innerText = '<';
            previousBtn.addEventListener('click',function(){
               if(currentPage > 1){
                  currentPage--;
                  updateGoodsDisplay();
               }
            });
            pagination.appendChild(previousBtn);
         }
         
         // 상품의 총갯수에 따라 페이지 숫자 버튼 만들기 
         for(let i=1;  i <= totalPageCnt;  i++){
            let paginationNumBtn = document.createElement('button');
            paginationNumBtn.className = 'pagination_button';
            paginationNumBtn.innerText = i;
            if(i===currentPage){
               paginationNumBtn.classList.add('active');
            }
            paginationNumBtn.addEventListener('click',function(){
               currentPage = i;
               updateGoodsDisplay();
            });
            pagination.appendChild(paginationNumBtn);
         }
         
         // 바로 다음 페이지로 이동
         if(currentPage < totalPageCnt){
            let nextBtn = document.createElement('button');
            nextBtn.className = 'pagination_button';
            nextBtn.innerText = '>';
            nextBtn.addEventListener('click',function(){
               if(currentPage < totalPageCnt){
                  currentPage++;
                  updateGoodsDisplay();
               }
            });
            pagination.appendChild(nextBtn);
         }
         
         // 제일 끝으로 이동
         if(currentPage < totalPageCnt){
            let lastPageBtn = document.createElement('button');
            lastPageBtn.className = 'pagination_button';
            lastPageBtn.innerText = '>>';
            lastPageBtn.addEventListener('click', function(){
               currentPage = totalPageCnt;
               updateGoodsDisplay();
            });
            pagination.appendChild(lastPageBtn);
         }
}      
   
   //가격범위 고르기
   function fn_priceChoice(input) {
      let value = input.value;
      let priceMin, priceMax;

      switch (value) {
      case "~50,000원":
         priceMax = 50000;
         break;
      case "50,000원 ~ 100,000원":
         priceMin = 50000;
         priceMax = 100000;
         break;
      case "100,000원 ~ 200,000원":
         priceMin = 100000;
         priceMax = 200000;
         break;
      case "200,000원 ~ 300,000원":
         priceMin = 200000;
         priceMax = 300000;
         break;
      case "300,000원~":
         priceMin = 300000;
         break;
      }

      if (priceMin != undefined && priceMax != undefined) {
         fn_setOnPage('priceMin=' + priceMin + '&priceMax=' + priceMax);
      } else if (priceMin != undefined) {
         fn_setOnPage('priceMin=' + priceMin); 
      } else if (priceMax != undefined) {
         fn_setOnPage('priceMax=' + priceMax);
      }
      
   }

   //가격 검색
   function fn_priceSearch(form) {
      let priceMin = form.priceMin.value;
      let priceMax = form.priceMax.value;
      
      console.log(typeof priceMin);
      console.log(typeof priceMax);
      
      if (priceMin != "" && priceMax != "" && priceMax!=0) {
         fn_setOnPage('priceMin=' + priceMin + '&priceMax=' + priceMax);
      }
      else if(priceMin!="" || priceMin!=0 ){
         alert('최대 가격은 0이상의 숫자를 입력해주세요.');
      }
      else {
         alert("최소 가격과 최대 가격을 모두 입력해주세요.");
      }
      
   }
   
   //실측 검색
   //(작동 안되는 중 >> 실측 항목에 하나를 클릭해서 이 함수로 들어오면 해당 실측 함수의 변수 값은 정의 되는데 밑에 실측 변수들의 값은 정의 되지 않기 떄문)
   function fn_measure(form) {
      let idName = form.id;
      
      let topMin="";
      let topMax="";
      let shoulderMin = "";
      let shoulderMax = "";
      let chestMin = "";
      let chestMax = "";
      let sleeveMin = "";
      let sleeveMax = "";
      let waistMin = "";
      let waistMax = "";
      let hipMin = "";
      let hipMax = "";
      let thighMin = "";
      let thighMax = "";
      let riseMin = "";
      let riseMax = "";
      let hemCrossMin = "";
      let hemCrossMax = "";
      let footMin = "";
      let footMax = "";
      let ballMin = "";
      let ballMax = "";
      let ankleMin = "";
      let ankleMax = "";
      let instepMin = "";
      let instepMax = "";
      
   
      if (idName == 'topMinMax') {
         topMin = form.topMin.value;
         topMax = form.topMax.value;
         
         if (topMin != "" && topMax != "" && topMax!=0) {
            fn_setOnPage('topMin=' + topMin + '&topMax=' + topMax);
         }
         else if(topMin!="" || topMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         }
         else {
            alert('최소,최대값 둘다 입력하세요.');
         }
      } else if (idName == 'shoulderMinMax') {
         shoulderMin = form.shoulderMin.value;
         shoulderMax = form.shoulderMax.value;
         if (shoulderMin != "" && shoulderMax != "" && shoulderMax!=0) {
            fn_setOnPage('shoulderMin=' + shoulderMin + '&shoulderMax='+ shoulderMax);
         } 
         else if(shoulderMin!="" || shoulderMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         }
         else {
            alert('최소,최대값 둘다 입력하세요.');
         }
      } else if (idName == 'chestMinMax') {
         chestMin = form.chestMin.value;
         chestMax = form.chestMax.value;
         if (chestMin != "" && chestMax != ""&& chestMax!=0) {
            fn_setOnPage('chestMin=' + chestMin + '&chestMax=' + chestMax);
         }
         else if(chestMin!="" || chestMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         } 
         else {
            alert('최소,최대값 둘다 입력하세요.');
         }
      } else if (idName == 'sleeveMinMax') {
         sleeveMin = form.sleeveMin.value;
         sleeveMax = form.sleeveMax.value;
         if (sleeveMin != "" && sleeveMax != "" && sleeveMax!=0) {
            fn_setOnPage('sleeveMin=' + sleeveMin + '&sleeveMax='+ sleeveMax);
         } 
         else if(sleeveMin!="" || sleeveMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         } 
         else {
            alert('최소,최대값 둘다 입력하세요.');
         }
      } else if (idName == 'waistMinMax') {
         waistMin = form.waistMin.value;
         waistMax = form.waistMax.value;
         if (waistMin != "" && waistMax != "" && waistMax!=0 ) {
            fn_setOnPage('waistMin=' + waistMin + '&waistMax=' + waistMax);
         } 
         else if(waistMin!="" || waistMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         } 
         else {
            alert('최소,최대값 둘다 입력하세요.');
         }
      } else if (idName == 'hipMinMax') {
         hipMin = form.hipMin.value;
         hipMax = form.hipMax.value;
         if (hipMin != "" && hipMax != "" && hipMax!=0) {
            fn_setOnPage('hipMin=' + hipMin + '&hipMax=' + hipMax);
         } 
         else if(hipMin!="" || hipMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         } 
         else {
            alert('최소,최대값 둘다 입력하세요.');
         }
      } else if (idName == 'thighMinMax') {
         thighMin = form.thighMin.value;
         thighMax = form.thighMax.value;
         if (thighMin != "" && thighMax != "" && thighMax!=0) {
            fn_setOnPage('thighMin=' + thighMin + '&thighMax=' + thighMax);
         } 
         else if(thighMin!="" || thighMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         } 
         else {
            alert('최소,최대값 둘다 입력하세요.');
         }

      } else if (idName == 'riseMinMax') {
         riseMin = form.riseMin.value;
         riseMax = form.riseMax.value;
         if (riseMin != "" && riseMax != "" && riseMax !=0) {
            fn_setOnPage('riseMin=' + riseMin + '&riseMax=' + riseMax);
         } 
         else if(riseMin!="" || riseMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         }
         else {
            alert('최소,최대값 둘다 입력하세요.');
         }
      } else if (idName == 'hemCrossMinMax') {
         hemCrossMin = form.hemCrossMin.value;
         hemCrossMax = form.hemCrossMax.value;
         if (hemCrossMin != "" && hemCrossMax != "" && hemCrossMax !=0) {
            fn_setOnPage('hemCrossMin=' + hemCrossMin + '&hemCrossMax='+ hemCrossMax);
         } 
         else if(hemCrossMin!="" || hemCrossMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         }
         else {
            alert('최소,최대값 둘다 입력하세요.');
         }
      } else if (idName == 'footMinMax') {
         footMin = form.footMin.value;
         footMax = form.footMax.value;
         if (footMin != "" && footMax != "" && footMax !=0) {
            fn_setOnPage('footMin=' + footMin + '&footMax=' + footMax);
         } 
         else if(footMin!="" || footMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         }
         else {
            alert('최소,최대값 둘다 입력하세요.')
         }
      } else if (idName == 'ballMinMax') {
         ballMin = form.ballMin.value;
         ballMax = form.ballMax.value;
         if (ballMin != "" && ballMax != "" && ballMax != 0) {
            fn_setOnPage('ballMin=' + ballMin + '&ballMax=' + ballMax);
         } 
         else if(ballMin!="" || ballMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         }
         else {
            alert('최소,최대값 둘다 입력하세요.')
         }
      } else if (idName == 'ankleMinMax') {
         ankleMin = form.ankleMin.value;
         ankleMax = form.ankleMax.value;
         if (ankleMin != "" && ankleMax != "" && ankleMax !=0) {
            fn_setOnPage('ankleMin=' + ankleMin + '&ankleMax=' + ankleMax);
         } 
         else if(ankleMin!="" || ankleMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         }
         else {
            alert('최소,최대값 둘다 입력하세요.')
         }
      } else if (idName == 'instepMinMax') {
         instepMin = form.instepMin.value;
         instepMax = form.instepMax.value;
         if (instepMin != "" && instepMax != "" && instepMax !=0) {
            fn_setOnPage('instepMin=' + instepMin + '&instepMax=' + instepMax);
         } 
         else if(instepMin!="" || instepMin!=0 ){
            alert('최대값은 0이상의 숫자를 입력해주세요.');
         }
         else {
            alert('최소,최대값 둘다 입력하세요.')
         }
      }

   }
   
   
   //검색 버튼 클릭시 해당 값 처리 하는 함수
   function fn_search() {
      let searchVal = $('#search').val();
      console.log(searchVal);
      fn_setOnPage('search='+searchVal);
   }
   
   
   // 페이지 로드 시 실행
    $(document).ready(function() {
        fn_colorValues($(".colorBox"));
        fn_colorValues($(".selected"));
    });

   let colors=""; //url로 보낼 문자열 변수(url colors=에 set할 값을 가진 변수)
//컬러 여러개 선택하여 url에 보낼 수 있고 url에서 값을 지우기도 하는 함수
   function fn_colorValues(color) {
      let clickedColor = ""; // 클릭한 컬러명들을 저장한 변수
      let subCategory = $("#subCategory").val();
      
      color.click(function() {
         if (!settingUrl.includes('align=')) {
            settingUrl = "listProducts.do?subCategory="
                  + subCategory
                  + "&align=&colors=&topMin=&topMax=&shoulderMin=&shoulderMax=&chestMin=&chestMax=&sleeveMin=&sleeveMax=&waistMin=&waistMax=&hipMin=&hipMax=&thighMin=&thighMax=&riseMin=&riseMax=&hemCrossMin=&hemCrossMax=&footMin=&footMax=&ballMin=&ballMax=&ankleMin=&ankleMax=&instepMin=&instepMax=&search=&priceMin=&priceMax=";
         }
         
          let UrlParameters = settingUrl.split('&');
         let listColor = UrlParameters[2];
         
         // url에 올라간 모든 컬러 리스트
         let listC = listColor.split(',');
         clickedColor = this.value;
         console.log(clickedColor);
         //컬러배열 길이가 5이하 일떄 url에 컬러값 추가
         if(!settingUrl.includes(clickedColor) && listC.length <= 5){
               colors += clickedColor + ","
               console.log(colors);
               settingUrl = settingUrl.replace('colors=', 'colors=' + colors);
               location.href = settingUrl;
         }
         // url의 색상 컬러값 지우기
         else if (settingUrl.includes(clickedColor)) {
            settingUrl = settingUrl.replace(clickedColor + ",", "");
            location.href = settingUrl;
         } else {
            alert('색상조건은 5가지 까지만 설정 가능합니다.');
         }
         
            });
      
      
   }

   // 해당 name에 기존 값을 초기화하는(지우는) 메서드 생성 >> 이 메서드 처리 안하면 해당 name 기존 값에 새로운 값 계속적으로 붙음
   function parameterInit(url, pName) {
      /* let reg = new RegExp(pName + `[a-zA-Z0-9]+`, 'g'); 검색 시 url에 한글인코딩된 것 %불라불라와 색깔 # 인식 시키기 위해서 아래와 같이 변경*/
      let reg = new RegExp(pName + `[%a-zA-Z0-9#]+`, 'g');
      url = url.replace(reg, pName);
      return url;
   }

   
   function fn_setOnPage(option) {
      let subCategory = $("#subCategory").val();
      let optionSub = option.split('&');

      /* priceMin, priceMax는 값 넣기 전에 controller에서 int로 형변환 시 오류가 나므로 나중에 값 들어올 떄 전체 url 뒤에 추가하기 >> 컨트롤러에서 오류 나던거 해결*/
      // 조건 선택 시 settingUrl set하기
      if (!settingUrl.includes('align=')) {
         settingUrl = "listProducts.do?subCategory="
               + subCategory
               + "&align=&colors=&topMin=&topMax=&shoulderMin=&shoulderMax=&chestMin=&chestMax=&sleeveMin=&sleeveMax=&waistMin=&waistMax=&hipMin=&hipMax=&thighMin=&thighMax=&riseMin=&riseMax=&hemCrossMin=&hemCrossMax=&footMin=&footMax=&ballMin=&ballMax=&ankleMin=&ankleMax=&instepMin=&instepMax=&search=&priceMin=&priceMax=";
      }

      //정렬 관련
      if (option == 'highPrice' || option == 'lowPrice'
            || option == 'highStarScore' || option == 'highReview') {
         settingUrl = parameterInit(settingUrl, "align=");
         settingUrl = settingUrl.replace('align=', 'align=' + option);
      }

      //가격범위 관련
      if (option.includes('priceMin') || option.includes('priceMax')) {
         settingUrl = parameterInit(settingUrl, "priceMin=");
         settingUrl = parameterInit(settingUrl, "priceMax=");
         optionSub = option.split('&');

         if (option.includes('priceMin') && option.includes('priceMax')) {
            settingUrl = settingUrl.replace('priceMin=', 'priceMin='
                  + optionSub[0].substring(9));
            settingUrl = settingUrl.replace('priceMax=', 'priceMax='
                  + optionSub[1].substring(9));
         } else if (optionSub[0].includes('priceMin')) {
            settingUrl = settingUrl.replace('priceMin=', 'priceMin='
                  + optionSub[0].substring(9));
         } else if (optionSub[0].includes('priceMax')) {
            settingUrl = settingUrl.replace('priceMax=', 'priceMax='
                  + optionSub[0].substring(9));
         }
      }

      //실측범위 관련
      if (option.includes('topMin') && option.includes('topMax')) {
         optionSub = option.split('&');
         settingUrl = parameterInit(settingUrl, "topMin=");
         settingUrl = parameterInit(settingUrl, "topMax=");
         settingUrl = settingUrl.replace('topMin=', 'topMin='
               + optionSub[0].substring(7));
         settingUrl = settingUrl.replace('topMax=', 'topMax='
               + optionSub[1].substring(7));
      }
      if (option.includes('shoulderMin') && option.includes('shoulderMax')) {
         settingUrl = parameterInit(settingUrl, "shoulderMin=");
         settingUrl = parameterInit(settingUrl, "shoulderMax=");
         settingUrl = settingUrl.replace('shoulderMin=', 'shoulderMin='
               + optionSub[0].substring(12));
         settingUrl = settingUrl.replace('shoulderMax=', 'shoulderMax='
               + optionSub[1].substring(12));
      }
      if (option.includes('chestMin') && option.includes('chestMax')) {
         settingUrl = parameterInit(settingUrl, "chestMin=");
         settingUrl = parameterInit(settingUrl, "chestMax=");
         settingUrl = settingUrl.replace('chestMin=', 'chestMin='
               + optionSub[0].substring(9));
         settingUrl = settingUrl.replace('chestMax=', 'chestMax='
               + optionSub[1].substring(9));
      }
      if (option.includes('sleeveMin') && option.includes('sleeveMax')) {
         console.log(optionSub[0].substring(10));
         settingUrl = parameterInit(settingUrl, "sleeveMin=");
         settingUrl = parameterInit(settingUrl, "sleeveMax=");
         settingUrl = settingUrl.replace('sleeveMin=', 'sleeveMin='
               + optionSub[0].substring(10));
         settingUrl = settingUrl.replace('sleeveMax=', 'sleeveMax='
               + optionSub[1].substring(10));

      }
      if (option.includes('waistMin') && option.includes('waistMax')) {
         settingUrl = parameterInit(settingUrl, "waistMin=");
         settingUrl = parameterInit(settingUrl, "waistMax=");
         settingUrl = settingUrl.replace('waistMin=', 'waistMin='
               + optionSub[0].substring(9));
         settingUrl = settingUrl.replace('waistMax=', 'waistMax='
               + optionSub[1].substring(9));
      }
      if (option.includes('hipMin') && option.includes('hipMax')) {
         settingUrl = parameterInit(settingUrl, "hipMin=");
         settingUrl = parameterInit(settingUrl, "hipMax=");
         settingUrl = settingUrl.replace('hipMin=', 'hipMin='
               + optionSub[0].substring(7));
         settingUrl = settingUrl.replace('hipMax=', 'hipMax='
               + optionSub[1].substring(7));
      }
      if (option.includes('thighMin') && option.includes('thighMax')) {
         settingUrl = parameterInit(settingUrl, "thighMin=");
         settingUrl = parameterInit(settingUrl, "thighMax=");
         settingUrl = settingUrl.replace('thighMin=', 'thighMin='
               + optionSub[0].substring(9));
         settingUrl = settingUrl.replace('thighMax=', 'thighMax='
               + optionSub[1].substring(9));
      }
      if (option.includes('riseMin') && option.includes('riseMax')) {
         settingUrl = parameterInit(settingUrl, "riseMin=");
         settingUrl = parameterInit(settingUrl, "riseMax=");
         settingUrl = settingUrl.replace('riseMin=', 'riseMin='
               + optionSub[0].substring(8));
         settingUrl = settingUrl.replace('riseMax=', 'riseMax='
               + optionSub[1].substring(8));
      }
      if (option.includes('hemCrossMin') && option.includes('hemCrossMax')) {
         settingUrl = parameterInit(settingUrl, "hemCrossMin=");
         settingUrl = parameterInit(settingUrl, "hemCrossMax=");
         settingUrl = settingUrl.replace('hemCrossMin=', 'hemCrossMin='
               + optionSub[0].substring(12));
         settingUrl = settingUrl.replace('hemCrossMax=', 'hemCrossMax='
               + optionSub[1].substring(12));
      }
      if (option.includes('footMin') && option.includes('footMax')) {
         settingUrl = parameterInit(settingUrl, "footMin=");
         settingUrl = parameterInit(settingUrl, "footMax=");
         settingUrl = settingUrl.replace('footMin=', 'footMin='
               + optionSub[0].substring(8));
         settingUrl = settingUrl.replace('footMax=', 'footMax='
               + optionSub[1].substring(8));
      }
      if (option.includes('ballMin') && option.includes('ballMax')) {
         settingUrl = parameterInit(settingUrl, "ballMin=");
         settingUrl = parameterInit(settingUrl, "ballMax=");
         settingUrl = settingUrl.replace('ballMin=', 'ballMin='
               + optionSub[0].substring(8));
         settingUrl = settingUrl.replace('ballMax=', 'ballMax='
               + optionSub[1].substring(8));
      }
      if (option.includes('ankleMin') && option.includes('ankleMax')) {
         settingUrl = parameterInit(settingUrl, "ankleMin=");
         settingUrl = parameterInit(settingUrl, "ankleMax=");
         settingUrl = settingUrl.replace('ankleMin=', 'ankleMin='
               + optionSub[0].substring(9));
         settingUrl = settingUrl.replace('ankleMax=', 'ankleMax='
               + optionSub[1].substring(9));
      }
      if (option.includes('instepMin') && option.includes('instepMax')) {
         settingUrl = parameterInit(settingUrl, "instepMin=");
         settingUrl = parameterInit(settingUrl, "instepMax=");
         settingUrl = settingUrl.replace('instepMin=', 'instepMin='
               + optionSub[0].substring(10));
         settingUrl = settingUrl.replace('instepMax=', 'instepMax='
               + optionSub[1].substring(10));
      }

      // 검색 관련
      if (option.includes('search=')) {
         settingUrl = parameterInit(settingUrl, 'search=');
         settingUrl = settingUrl.replace('search=', option);
      }

      // 컬러 관련  >> 컬러 클릭 설정을 위해 따로 처리하기로 함
      /* if (option.includes('colors=')) {
         settingUrl = settingUrl.replace('colors=', option);
      }  */

      // x 처리 관련(option_bar)
      //가격 범위x
      if (option.includes('priceRangeX')) {
         settingUrl = parameterInit(settingUrl, 'priceMin=');
         settingUrl = parameterInit(settingUrl, 'priceMax=');
      }
      //실측 범위x
      if (option.includes('topX')) {
         settingUrl = parameterInit(settingUrl, 'topMin=');
         settingUrl = parameterInit(settingUrl, 'topMax=');
      }
      if (option.includes('shoulderX')) {
         settingUrl = parameterInit(settingUrl, 'shoulderMin=');
         settingUrl = parameterInit(settingUrl, 'shoulderMax=');
      }
      if (option.includes('chestX')) {
         settingUrl = parameterInit(settingUrl, 'chestMin=');
         settingUrl = parameterInit(settingUrl, 'chestMax=');
      }
      if (option.includes('sleeveX')) {
         settingUrl = parameterInit(settingUrl, 'sleeveMin=');
         settingUrl = parameterInit(settingUrl, 'sleeveMax=');
      }
      if (option.includes('waistX')) {
         settingUrl = parameterInit(settingUrl, 'waistMin=');
         settingUrl = parameterInit(settingUrl, 'waistMax=');
      }
      if (option.includes('hipX')) {
         settingUrl = parameterInit(settingUrl, 'hipMin=');
         settingUrl = parameterInit(settingUrl, 'hipMax=');
      }
      if (option.includes('thighX')) {
         settingUrl = parameterInit(settingUrl, 'thighMin=');
         settingUrl = parameterInit(settingUrl, 'thighMax=');
      }
      if (option.includes('riseX')) {
         settingUrl = parameterInit(settingUrl, 'riseMin=');
         settingUrl = parameterInit(settingUrl, 'riseMax=');
      }
      if (option.includes('hemCrossX')) {
         settingUrl = parameterInit(settingUrl, 'hemCrossMin=');
         settingUrl = parameterInit(settingUrl, 'hemCrossMax=');
      }
      if (option.includes('footX')) {
         settingUrl = parameterInit(settingUrl, 'footMin=');
         settingUrl = parameterInit(settingUrl, 'footMax=');
      }
      if (option.includes('ballX')) {
         settingUrl = parameterInit(settingUrl, 'ballMin=');
         settingUrl = parameterInit(settingUrl, 'ballMax=');
      }
      if (option.includes('ankleX')) {
         settingUrl = parameterInit(settingUrl, 'ankleMin=');
         settingUrl = parameterInit(settingUrl, 'ankleMax=');
      }
      if (option.includes('instepX')) {
         settingUrl = parameterInit(settingUrl, 'instepMin=');
         settingUrl = parameterInit(settingUrl, 'instepMax=');
      }
      //검색 x처리
      if (option.includes('searchX')) {
         settingUrl = parameterInit(settingUrl, 'search=');
      }

      location.href = settingUrl;

   }
</script>




<body>
<!-- script 값처리를 위한 input tag -->
   <input type="hidden" id="subCategory" value="${subCategory }"> 
   
   
   <!-- option 메뉴바 -->
   <table id="option_menu" border="1">
      <tr>
         <td>색상</td>
         <td>
            <button value="0e0e0e" class="colorBox" 
            style="background-color:#0e0e0e;  width:20px; height:20px; display:inline-block;" title="블랙"></button>
            
            <button value="d9d9d7" class="colorBox" 
            style="background-color:#d9d9d7;  width:20px; height:20px; display:inline-block;" title="라이트 그레이"></button>
            
            <button value="9c9c9b" class="colorBox" 
            style="background-color:#9c9c9b;  width:20px; height:20px; display:inline-block;" title="그레이"></button>
            
            <button value="001e66" class="colorBox" 
            style="background-color:#001e66;  width:20px; height:20px; display:inline-block;" title="네이비"></button>
            
            <button value="FF0000" class="colorBox" 
            style="background-color:#FF0000;  width:20px; height:20px; display:inline-block;" title="레드"></button>
            
            <button value="feffed" class="colorBox" 
            style="background-color:#feffed;  width:20px; height:20px; display:inline-block;" title="아이보리"></button>
            
            <button value="ffffff" class="colorBox" 
            style="background-color:#ffffff;  width:20px; height:20px; display:inline-block;" title="화이트"></button>
            
            <button value="52565b" class="colorBox" 
            style="background-color:#52565b;  width:20px; height:20px; display:inline-block;" title="다크 그레이"></button>
            
            <button value="2508ff" class="colorBox" 
            style="background-color:#2508ff;  width:20px; height:20px; display:inline-block;" title="블루"></button>
            
            <button value="00b000" class="colorBox" 
            style="background-color:#00b000;  width:20px; height:20px; display:inline-block;" title="라이트 그린"></button>
            
            <button value="f1c276" class="colorBox" 
            style="background-color:#f1c276;  width:20px; height:20px; display:inline-block;" title="베이지"></button>
            
            <button value="00c3eb" class="colorBox" 
            style="background-color:#00c3eb;  width:20px; height:20px; display:inline-block;" title="스카이블루"></button>
            
            <button value="5b5a35" class="colorBox" 
            style="background-color:#5b5a35;  width:20px; height:20px; display:inline-block;" title="카키"></button>
            
            <button value="03431d" class="colorBox" 
            style="background-color:#03431d;  width:20px; height:20px; display:inline-block;" title="다크 그린"></button>
            
            <button value="7f290c" class="colorBox" 
            style="background-color:#7f290c;  width:20px; height:20px; display:inline-block;" title="브라운"></button>
            
            <button value="00c4ab" class="colorBox" 
            style="background-color:#00c4ab;  width:20px; height:20px; display:inline-block;" title="민트"></button>
            
            <button value="ff00a1" class="colorBox" 
            style="background-color:#ff00a1;  width:20px; height:20px; display:inline-block;" title="핑크"></button>
            
            <button value="ceb390" class="colorBox" 
            style="background-color:#ceb390;  width:20px; height:20px; display:inline-block;" title="샌드"></button>
            
            <button value="ff9db5" class="colorBox" 
            style="background-color:#ff9db5;  width:20px; height:20px; display:inline-block;" title="라이트 핑크"></button>
            
            <button value="b077cf" class="colorBox" 
            style="background-color:#b077cf;  width:20px; height:20px; display:inline-block;" title="라벤더"></button>
            
            <button value="77872e" class="colorBox" 
            style="background-color:#77872e;  width:20px; height:20px; display:inline-block;" title="올리브 그린"></button>
            
            <button value="feea00" class="colorBox" 
            style="background-color:#feea00;  width:20px; height:20px; display:inline-block;" title="옐로우"></button>
            
            <button value="e8a399" class="colorBox" 
            style="background-color:#e8a399;  width:20px; height:20px; display:inline-block;" title="페일 핑크"></button>
            
            <button value="e49700" class="colorBox"  
            style="background-color:#e49700;  width:20px; height:20px; display:inline-block;" title="오렌지"></button>
            
            <button value="ad0a32" class="colorBox" 
            style="background-color:#ad0a32;  width:20px; height:20px; display:inline-block;" title="버건디"></button>
            
            <button value="aa7200" class="colorBox" 
            style="background-color:#aa7200;  width:20px; height:20px; display:inline-block;" title="카키 베이지"></button>
            
            <button value="204784" class="colorBox" 
            style="background-color:#204784;  width:20px; height:20px; display:inline-block;" title="데님"></button>
            
            <button value="b9cee0" class="colorBox" 
            style="background-color:#b9cee0;  width:20px; height:20px; display:inline-block;" title="라이트 블루"></button>
            
            <button value="570070" class="colorBox" 
            style="background-color:#570070;  width:20px; height:20px; display:inline-block;" title="퍼플"></button>
            
            <button value="b9b018" class="colorBox" 
            style="background-color:#b9b018; width:20px; height:20px; display:inline-block;" title="머스타드"></button>
            
            <button value="8b9fbb" class="colorBox" 
            style="background-color:#8b9fbb; width:20px; height:20px; display:inline-block;" title="미디엄 블루"></button>
            
         </td>
      </tr>

      <tr>
         <td>가격</td>
         <td class="price_td">
            <input class="range_price" type="button" value="~50,000원" onclick="fn_priceChoice(this)">
            <input class="range_price" type="button" value="50,000원 ~ 100,000원" onclick="fn_priceChoice(this)"> 
            <input class="range_price" type="button" value="100,000원 ~ 200,000원" onclick="fn_priceChoice(this)"> 
            <input class="range_price" type="button" value="200,000원 ~ 300,000원" onclick="fn_priceChoice(this)"> 
            <input class="range_price" type="button" value="300,000원~" onclick="fn_priceChoice(this)">
            <form id="frm">
               <input class="btnInput" name="priceMin" type="number" placeholder="최소가격 검색" title="최소가격 검색">
               <span>-</span> 
               <input class="btnInput" name="priceMax" type="number" placeholder="최대가격 검색" title="최대가격 검색"> 
               <input class="setting" type="button" value="적용" onclick="fn_priceSearch(frm)">
            </form>
         </td>
      </tr>

      <tr>
         <td>실측</td>
         <td>
            <c:if test="${not empty totalList }">
               <c:if test="${totalList[0].topTotalLength!=0 }">
                  <form id="topMinMax" >
                     총장
                     <input name="topMin" class="measureBtnInput"  type="number" value="44"  title="총장최소">
                     <span>-</span>
                     <input name="topMax" class="measureBtnInput" type="number" value="71"  title="총장최대">
                     <input class="setting" type="button" value="적용" onclick="fn_measure(topMinMax)">
                  </form>
               </c:if>
               
               <c:if test="${totalList[0].shoulderLength!=0 }">
                  <form id="shoulderMinMax">
                     어깨너비
                     <input name="shoulderMin" class="measureBtnInput" type="number" value="35" title="어깨너비 최소"> 
                     <span>-</span> 
                     <input name="shoulderMax" class="measureBtnInput" type="number" value="59" title="어깨너비 최대">
                     <input class="setting" type="button" value="적용" onclick="fn_measure(shoulderMinMax)">
                  </form>
               </c:if>
               
               <c:if test="${totalList[0].chestCrossLength!=0 }">
                  <form id="chestMinMax">
                     가슴단면
                        <input name="chestMin" class="measureBtnInput" type="number" value="40"  title="가슴단면 최소"> 
                        <span>-</span> 
                        <input name="chestMax" class="measureBtnInput" type="number" value="63"  title="가슴단면 최대"> 
                        <input class="setting" type="button" value="적용" onclick="fn_measure(chestMinMax)">
                  </form>
               </c:if>
               
               <c:if test="${totalList[0].sleevelength!=0  }">
                  <form id="sleeveMinMax">
                     소매길이
                     <input name="sleeveMin" class="measureBtnInput" value="53"  type="number" title="소매길이 최소">
                     <span>-</span> 
                     <input name="sleeveMax" class="measureBtnInput" type="number" value="65" title="소매길이 최대"> 
                     <input class="setting" type="button" value="적용" onclick="fn_measure(sleeveMinMax)">
                  </form>
               </c:if>
               
               <c:if test="${totalList[0].waistCrossLength!=0  }">
                  <form id="waistMinMax">
                     허리단면
                     <input name="waistMin" class="measureBtnInput" type="number" value="34" title="허리단면 최소"> 
                     <span>-</span> 
                     <input name="waistMax" class="measureBtnInput" type="number" value="47" title="허리단면 최대"> 
                     <input class="setting" type="button" value="적용"onclick="fn_measure(waistMinMax)">
                  </form>
               </c:if>
               <c:if test="${totalList[0].hipCrossLength!=0  }">
                  <form id="hipMinMax">
                     엉덩이단면
                     <input name="hipMin" class="measureBtnInput" type="number" value="46" title="엉덩이단면 최소"> 
                     <span>-</span> 
                     <input name="hipMax" class="measureBtnInput" type="number" value="61" title="엉덩이단면 최대"> 
                     <input class="setting" type="button" value="적용" onclick="fn_measure(hipMinMax)">
                  </form>
               </c:if>
               <c:if test="${totalList[0].thighCrossLength!=0  }">
                  <form id="thighMinMax">
                     허벅지단면
                     <input id="thighMin" class="measureBtnInput" type="number" value="29" title="허벅지단면 최소"> 
                     <span>-</span>
                     <input name="thighMax" class="measureBtnInput" type="number" value="38" title="허벅지단면 최대"> 
                     <input class="setting" type="button" value="적용" onclick="fn_measure(thighMinMax)">
                  </form>
               </c:if>
               <c:if test="${totalList[0].riseLength!=0  }">
                  <form id="riseMinMax">
                     밑위
                     <input name="riseMin" class="measureBtnInput" type="number" value="25" title="밑위 최소">
                     <span>-</span>
                     <input name="riseMax" class="measureBtnInput" type="number" value="35" title="밑위 최대"> 
                     <input class="setting" type="button" value="적용" onclick="fn_measure(riseMinMax)">
                  </form>
               </c:if>
               <c:if test="${totalList[0].hemCrossLength!=0  }">
                  <form id="hemCrossMinMax">
                     밑단
                     <input name="hemCrossMin" class="measureBtnInput" type="number" value="17" title="밑단 최소"> 
                     <span>-</span> 
                     <input name="hemCrossMax" class="measureBtnInput" type="number" value="28" title="밑단 최대"> 
                     <input class="setting" type="button" value="적용" onclick="fn_measure(hemCrossMinMax)">
                  </form>
               </c:if>
               <c:if test="${totalList[0].footLength!=0  }">
                  <form id="footMinMax">
                     발길이
                     <input name="footMin" class="measureBtnInput" type="number" value="235"  title="발길이 최소"> 
                     <span>-</span> 
                     <input name="footMax" class="measureBtnInput" type="number" value="270" title="발길이 최대"> 
                     <input class="setting" type="button" value="적용" onclick="fn_measure(footMinMax)">
                  </form>
               </c:if>
               <c:if test="${totalList[0].ballOfFoot!=0  }">
                  <form id="ballMinMax">
                     발볼
                     <input name="ballMin" class="measureBtnInput" type="number" value="21.5" title="발볼 최소">
                     <span>-</span> 
                     <input name="ballMax" class="measureBtnInput" type="number" value="25" title="발볼 최대"> 
                     <input class="setting" type="button" value="적용" onclick="fn_measure(ballMinMax)">
                  </form>
               </c:if>
               <c:if test="${totalList[0].ankleHeight!=0  }">
                  <form id="ankleMinMax">
                     발목
                     <input name="ankleMin" class="measureBtnInput" type="number" value="23" title="발목 최소"> 
                     <span>-</span>
                     <input name="ankleMax" class="measureBtnInput" type="number" value="25" title="발목 최대"> 
                     <input class="setting" type="button" value="적용" onclick="fn_measure(ankleMinMax)">
                  </form>
               </c:if>
               <c:if test="${totalList[0].instepHeight!=0  }">
                  <form id="instepMinMax">
                     궆높이
                     <input name="instepMin" class="measureBtnInput" type="number" value="3" title="궆높이 최소"> 
                     <span>-</span> 
                     <input name="instepMax" class="measureBtnInput" type="number"  value="6" title="궆높이 최대"> 
                     <input class="setting" type="button" value="적용"onclick="fn_measure(instepMinMax)">
                  </form>
               </c:if>
            </c:if>
            </td>
      </tr>
      <tr>
         <td>검색</td>
         <td>
            <input id="search" type="text" placeholder="  상품명/브랜드명/상품번호 검색"> 
            <input class="setting" type="button" onclick="fn_search()" value="검색">
         </td>
      </tr>
   </table>
   
   
   
   <!-- option_bar: 설정되는 조건 올라가는 곳 -->
   <div id="option_bar">
      <!-- option_bar: 상품종류 설정 -->
      <c:if test="${not empty subCategory }">
         <div class="option">
            <c:if test="${subCategory=='mtom' }">
               <a href="main.do">종류:맨투맨 x</a>
            </c:if>
            <c:if test="${subCategory=='hood' }">
               <a href="main.do">종류:후드 x</a>
            </c:if>
            <c:if test="${subCategory=='t-shirt' }">
               <a href="/finalpro/main.do">종류:티셔츠 x</a>
            </c:if>
            <c:if test="${subCategory=='knit' }">
               <a href="/finalpro/main.do">종류:니트 x</a>
            </c:if>
            <c:if test="${subCategory=='shirt' }">
               <a href="/finalpro/main.do">종류:셔츠 x</a>
            </c:if>
            <c:if test="${subCategory=='topOthers' }">
               <a href="/finalpro/main.do">종류:기타 상의 x</a>
            </c:if>
            <c:if test="${subCategory=='coat' }">
               <a href="/finalpro/main.do">종류:코트 x</a>
            </c:if>
            <c:if test="${subCategory=='heavyOuter' }">
               <a href="/finalpro/main.do">종류:패딩 x</a>
            </c:if>
            <c:if test="${subCategory=='cardigan' }">
               <a href="/finalpro/main.do">종류:가디건 x</a>
            </c:if>
            <c:if test="${subCategory=='fleece' }">
               <a href="/finalpro/main.do">종류:후리스 x</a>
            </c:if>
            <c:if test="${subCategory=='jumper' }">
               <a href="/finalpro/main.do">종류:자켓 x</a>
            </c:if>
            <c:if test="${subCategory=='outerOthers' }">
               <a href="/finalpro/main.do">종류:기타 아우터 x</a>
            </c:if>
            <c:if test="${subCategory=='jeans' }">
               <a href="/finalpro/main.do">종류:청바지 x</a>
            </c:if>
            <c:if test="${subCategory=='slacks' }">
               <a href="/finalpro/main.do">종류:슬랙스 x</a>
            </c:if>
            <c:if test="${subCategory=='skirt' }">
               <a href="/finalpro/main.do">종류:스커트 x</a>
            </c:if>
            <c:if test="${subCategory=='trackPants' }">
               <a href="/finalpro/main.do">종류:츄리닝 x</a>
            </c:if>
            <c:if test="${subCategory=='shorts' }">
               <a href="/finalpro/main.do">종류:반바지 x</a>
            </c:if>
            <c:if test="${subCategory=='pantOthers' }">
               <a href="/finalpro/main.do">종류:기타 바지 x</a>
            </c:if>
            <c:if test="${subCategory=='dressShoes' }">
               <a href="/finalpro/main.do">종류:구두 x</a>
            </c:if>
            <c:if test="${subCategory=='slippers' }">
               <a href="/finalpro/main.do">종류:슬리퍼 x</a>
            </c:if>
            <c:if test="${subCategory=='sneakers' }">
               <a href="/finalpro/main.do">종류:스니커즈 x</a>
            </c:if>
            <c:if test="${subCategory=='athleticShoes' }">
               <a href="/finalpro/main.do">종류:운동화 x</a>
            </c:if>
            <c:if test="${subCategory=='shoeOthers' }">
               <a href="/finalpro/main.do">종류:기타 신발 x</a>
            </c:if>
            
         </div>
      </c:if>
      <!-- option_bar: 실측 설정  -->
      <c:if test="${not empty param.topMin && not empty param.topMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('topX')">총장: ${param.topMin }~${param.topMax } x</button>
         </div>
      </c:if>
      <c:if test="${not empty param.shoulderMin && not empty param.shoulderMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('shoulderX')">어깨 너비: ${param.shoulderMin }~${param.shoulderMax } x</button>
         </div>
      </c:if>
      <c:if test="${not empty param.chestMin && not empty param.chestMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('chestX')">가슴 단면: ${param.chestMin }~${param.chestMax } x</button>
         </div>
      </c:if>
      <c:if test="${not empty param.sleeveMin && not empty param.sleeveMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('sleeveX')">소매길이: ${param.sleeveMin }~${param.sleeveMax } x</button>
         </div>
      </c:if>
      <c:if test="${not empty param.waistMin && not empty param.waistMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('waistX')">허리 단면: ${param.waistMin }~${param.waistMax } x</button>
         </div>
      </c:if>
      <c:if test="${not empty param.hipMin && not empty param.hipMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('hipX')">엉덩이 단면: ${param.hipMin }~${param.hipMax } x</button>
         </div>
      </c:if>
      <c:if test="${not empty param.thighMin && not empty param.thighMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('thighX')">허벅지 단면: ${param.thighMin }~${param.thighMax } x</button>
         </div>
      </c:if>
      <c:if test="${not empty param.riseMin && not empty param.riseMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('riseX')">밑위: ${param.riseMin }~${param.riseMax } x</button>
         </div>
      </c:if>
      <c:if test="${not empty param.hemCrossMin && not empty param.hemCrossMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('hemCrossX')">밑단: ${param.hemCrossMin }~${param.hemCrossMax } x</button>
         </div>
      </c:if>
      <c:if test="${not empty param.footMin && not empty param.footMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('footX')">발 길이: ${param.footMin }~${param.footMax } x</button>
         </div>
      </c:if>
      <c:if test="${not empty param.ballMin && not empty param.ballMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('ballX')">발볼: ${param.ballMin }~${param.ballMax } x</button>
         </div>
      </c:if>
      <c:if test="${not empty param.ankleMin && not empty param.ankleMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('ankleX')">발목: ${param.ankleMin }~${param.ankleMax } x</button>
         </div>
      </c:if>
      <c:if test="${not empty param.instepMin && not empty param.instepMax }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('instepX')">궆 높이: ${param.instepMin }~${param.instepMax } x</button>
         </div>
      </c:if>
      
      
      <!-- option_bar: 가격대 설정 -->
      <c:if test="${not empty param.priceMax && empty param.priceMin }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('priceRangeX')">50,000원 이하 x</button>
         </div>
      </c:if>

      <c:if test="${not empty param.priceMin && not empty param.priceMax }">
         <c:choose>
            <c:when test="${param.priceMin==50000 && param.priceMax==100000 }">
               <div class="option">
                  <button class="x" value="x"
                     onclick="fn_setOnPage('priceRangeX')">50,000원~100,000원 x</button>
               </div>
            </c:when>
            <c:when test="${param.priceMin==100000 && param.priceMax==200000 }">
               <div class="option">
                  <button class="x" value="x"
                     onclick="fn_setOnPage('priceRangeX')">100,000원~200,000원 x</button>
               </div>
            </c:when>
            <c:when test="${param.priceMin==200000 && param.priceMax==300000 }">
               <div class="option">
                  <button class="x" value="x"
                     onclick="fn_setOnPage('priceRangeX')">200,000원~300,000원 x</button>
               </div>
            </c:when>
            <c:otherwise>
               <div class="option">
                  <button class="x" value="x"
                     onclick="fn_setOnPage('priceRangeX')">${param.priceMin }원~${param.priceMax }원 x</button>
               </div>
            </c:otherwise>
         </c:choose>
      </c:if>
      <c:if test="${not empty param.priceMin && empty param.priceMax }">
         <c:if test="${param.priceMin>=300000 }">
            <div class="option">
               <span></span>
               <button class="x" value="x" onclick="fn_setOnPage('priceRangeX')">300,000원 이상 x</button>
            </div>
         </c:if>
      </c:if>
      
      <!-- option_bar: 검색(브랜드) 설정 -->
      <c:if test="${not empty param.search }">
         <div class="option">
            <button class="x" onclick="fn_setOnPage('searchX')">${param.search } x</button>
         </div>
      </c:if>   
   </div>

   <!-- align bar -->
   <header id="align_bar">
      <button class="align" value="highPrice" onclick="fn_setOnPage('highPrice')">높은가격순</button>
      <button class="align" value="lowPrice" onclick="fn_setOnPage('lowPrice')">낮은가격순</button>
      <button class="align" value="highStarScore" onclick="fn_setOnPage('highStarScore')">별점순</button>
      <button class="align" value="highReview" onclick="fn_setOnPage('highReview')">후기순</button>
   </header>

   <!-- 상품리스트 출력(조건에 따른)-->
   <div id="product_container">
      <!-- 상품 -->
      <div id="listProducts">
         <%-- 상품리스트 갯수: ${totalList.size()} --%>
         <!-- 조건에 맞는 상품 없을 때 -->
         <c:if test="${empty totalList }">
            <h1>현재 설정하신 조건에 맞는 상품이 없습니다. 조건을 다시 설정해보세요.</h1>
         </c:if>
         <!-- 상품리스트 출력 -->
         <c:forEach var="goods" items="${totalList }" varStatus="status">
            <div class="oneOfList" id="goods${status.index+1 }">
               <a href=detailProduct.do?productNo=${goods.productNo}>
                  <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${goods.productNo }&path=product">
               </a>
               <br><a href="/finalpro/brand/brandList.do?brand=${goods.brand }">${goods.brand }</a> 
               <p>${goods.name }</p>
               <b>${goods.price }원</b>
               <div class="stars-background">
                   <div class="star-rating">
                       <div class="filled-stars" style="width: ${goods.avg_starScore / 5 * 100}%;">★★★★★</div>
                       <div class="empty-stars">★★★★★</div>
                   </div>
                   <span class="review-count">${goods.review_count}</span>
               </div>
            </div>
         </c:forEach>
      </div>
   </div>
   
   <!-- 페이지 넘기는 bar -->
   <div id="pagination">
   </div>

</body>
<script>
   let allParameter = settingUrl.split('&');
   // colorBox 클래스 변경
   if(settingUrl.includes("colors")) {
      let colorList = allParameter[2];
      let alignParameter = allParameter[1];
      
      // url에 올라간 모든 컬러 리스트
      let cList = colorList.split(',');
      // colors=010101,202020,303030
      // 컬러 버튼 객체를 모두 가진 버튼 리스트
      let buttonList = document.getElementsByClassName('colorBox');

      for(var j=0;j<cList.length;j++){
         for(var i=0;i<buttonList.length;i++){
            let c = '';
            if(j == 0) {
               c = cList[0].substring(7);
            }
            if(buttonList[i].value == c) {
               buttonList[i].setAttribute('class', 'selected');
            } else    if(buttonList[i].value == cList[j]) {
               buttonList[i].setAttribute('class', 'selected');
            } else {
               buttonList[i].setAttribute('class', 'colorBox');
            }
         }
      }
      let alignSplit = alignParameter.split('=');
      let alignList = document.getElementsByClassName('align');
      if(alignSplit[1] == 'highPrice'){
         alignList[0].setAttribute('class', 'selectedAlign');
      }
      else if(alignSplit[1] == 'lowPrice'){
         alignList[1].setAttribute('class', 'selectedAlign');
      }
      else if(alignSplit[1] == 'highStarScore'){
         alignList[2].setAttribute('class', 'selectedAlign');
      }
      else if(alignSplit[1] == 'highReview'){
         alignList[3].setAttribute('class', 'selectedAlign');
      }
   }
</script>
</html>
