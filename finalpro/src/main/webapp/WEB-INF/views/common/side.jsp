<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>


<script>
	document.addEventListener('DOMContentLoaded', function() {
	  // 카테고리 이름을 클릭하면 실행될 함수를 모든 카테고리 이름에 할당합니다.
	  document.querySelectorAll('.category-item > span').forEach(function(categoryName) {
	    categoryName.addEventListener('click', function() {
	      // 클릭된 카테고리 이름 바로 다음 요소를 찾습니다 (subcategory 리스트).
	      var subcategory = this.nextElementSibling;
	      
	      // 'visible' 클래스를 토글합니다. 클래스가 있으면 제거하고 없으면 추가합니다.
	      if (subcategory.classList.contains('hidden')) {
	        subcategory.classList.remove('hidden');
	        subcategory.classList.add('visible');
	      } else {
	        subcategory.classList.remove('visible');
	        subcategory.classList.add('hidden');
	      }
	    });
	  });
	});
 </script>
 
 <!-- 사이드 바 숨김/나타내기 -->
 <script>
 document.addEventListener('DOMContentLoaded', function() {
	  var brandInput = document.getElementById('brandInput');
	  var btn = document.querySelector('.btn_show');
	  var sidebar = document.querySelector('.sidebar');

	  btn.addEventListener('click', function() {
	    
	    if (sidebar.style.display === 'none' || sidebar.style.display === '') {
	      sidebar.style.display = 'block'; 
	    } else {
	      sidebar.style.display = 'none'; 
	    }
	  });
	// 브랜드명 입력 필드 이벤트 리스너 추가
      brandInput.addEventListener('input', function() {
          var searchText = brandInput.value; // 입력 필드의 값
          listBrand(searchText); // 입력 값에 기반한 브랜드 리스트 조회
      });

      // 페이지 로드 시 브랜드 리스트 초기 조회
      listBrand('');
	});
</script>


<!-- 품목/브랜드 선택시 해당 항목 나오게 하기 -->
<script>
document.addEventListener('DOMContentLoaded', function() {
  // Product List and Brand List elements
  var productList = document.querySelector('.product_List');
  var brandList = document.querySelector('.brand_list');

  // Buttons
  var productButton = document.querySelector('.product_button');
  var brandButton = document.querySelector('.brand_button');

  // Event listener for the Product button
  productButton.addEventListener('click', function() {
    productList.style.display = 'block'; // Show product list
    brandList.style.display = 'none'; // Hide brand list
    productButton.style.backgroundColor = '#e9e9e9'; // Highlight product button
    brandButton.style.backgroundColor = 'white'; // Reset brand button
  });

  // Event listener for the Brand button
  brandButton.addEventListener('click', function() {
    productList.style.display = 'none'; // Hide product list
    brandList.style.display = 'block'; // Show brand list
    brandButton.style.backgroundColor = '#e9e9e9'; // Highlight brand button
    productButton.style.backgroundColor = 'white'; // Reset product button
  });

  // Initialize with the Product List shown
  productButton.click();
});
</script>

<script type="text/javascript">
		window.onload = function() {
			listBrand();
	    };
		
	    // 입력 값에 따라 브랜드 리스트를 조회하고 화면에 표시하는 함수
	    function listBrand(searchText) {
	        $.ajax({
	            url: "/finalpro/common/listBrand2.do",
	            method: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({ firstLetter: searchText }), // 검색 텍스트를 기반으로 요청 데이터 구성
	            success: function(data) {
	                var brandList = data.brandList.slice(0, 20); // 처음 20개의 항목만 선택
	                var brandListUl = document.getElementById('brandlistslide');
	                brandListUl.innerHTML = ''; // 기존 리스트 초기화

	                brandList.forEach(function(brand) {
	                    var listItem = document.createElement('li');
	                    listItem.className = 'listItem';

	                    var brandLink = document.createElement('a');
	                    // 클릭 시 지정된 URL로 이동하도록 href 속성 설정
	                    brandLink.href = '/finalpro/brand/brandList.do?brand=' + (brand.brand);
	                    brandLink.className = 'command-brand-link';

	                    var titleSpan = document.createElement('span');
	                    titleSpan.className = 'title';

	                    var engSpan = document.createElement('span');
	                    engSpan.className = 'eng';
	                    engSpan.textContent = brand.brandEng; // 영어 브랜드명 설정

	                    var korSpan = document.createElement('span');
	                    korSpan.className = 'kor';
	                    korSpan.textContent = brand.brand; // 한글 브랜드명 설정
	                    
	                 	// engSpan과 korSpan을 감싸는 div 생성
	                    var engDiv = document.createElement('div');
	                    engDiv.className = 'eng-wrap';
	                    engDiv.appendChild(engSpan); // 영어 브랜드명을 engDiv에 추가

	                    var korDiv = document.createElement('div');
	                    korDiv.className = 'kor-wrap';
	                    korDiv.appendChild(korSpan); // 한글 브랜드명을 korDiv에 추가


	                    var replyCntSpan = document.createElement('span');
	                    replyCntSpan.className = 'replyCnt parentheses';
	                    replyCntSpan.textContent = '(' + brand.productCount + ')'; 

	                    // 수정된 부분: engDiv와 korDiv를 titleSpan에 추가
	                    titleSpan.appendChild(engDiv);
	                    titleSpan.appendChild(korDiv);
	                    korDiv.appendChild(replyCntSpan); // 상품 수
	                    brandLink.appendChild(titleSpan);
	                    listItem.appendChild(brandLink);
	                    brandListUl.appendChild(listItem);
	                });
	            },
	            error: function(error) {
	                console.error('Error:', error);
	            }
	        });
	    }
	</script>


 
<body>
	
	<div class="sidebar">
                <div class="select_Box">
                	<button class="product_button">품목</button>
                	<button class="brand_button">브랜드</button>
                </div>
                <ul class="product_List">
				    <li class="category-item">
				      <span>아우터</span>
				      <ul class="subcategory hidden">
				       <li><a href="${contextPath }/product/listProducts.do?subCategory=coat">코트</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=heavyOuter">패딩</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=cardigan">가디건</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=fleece">후리스</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=jumper">재킷</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=outerOthers">기타</a></li>
				      </ul>
				    </li>
				    <li class="category-item">
				      <span>상의</span>
				      <ul class="subcategory hidden">
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=mtom">맨투맨</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=hood">후드</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=t-shirt">티셔츠</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=knit">니트</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=shirt">셔츠</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=topOhters">기타</a></li>
				      </ul>
				    </li>
				    <li class="category-item">
				      <span>하의</span>
				      <ul class="subcategory hidden">
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=jeans">청바지</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=slacks">슬렉스</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=trackPants">츄리닝</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=skirt">치마</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=shorts">반바지</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=pantsOthers">기타</a></li>
				      </ul>
				    </li>
				    <li class="category-item">
				      <span>신발</span>
				      <ul class="subcategory hidden">
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=dressShoes">구두</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=slippers">슬리퍼</a></li>
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=sneakers">스니커즈</a></li>
				        
				        <li><a href="${contextPath }/product/listProducts.do?subCategory=shoeOthers">기타</a></li>
				      </ul>
				    </li>
				 </ul>
				 
				 
				 <!-- 브랜드 항목 -->
				 
				 
		<div class="brand_list">		 
		 	<div class="searchTab tabBox" br-data-name="magazine_left_tab">
			   <ul class="brand-option-list list">
			      <li class="listItem">
			         <label class="spell">브랜드명 입력 
					    <input type="text" class="ui-brand-kwd" id="brandInput" >
					</label>
			         <ul class="letter-list">
			            <li class="listItem btn ui-brand-btn tyA" ktype="A">A</li>
			            <li class="listItem btn ui-brand-btn tyB" ktype="B">B</li>
			            <li class="listItem btn ui-brand-btn tyC" ktype="C">C</li>
			            <li class="listItem btn ui-brand-btn tyD" ktype="D">D</li>
			            <li class="listItem btn ui-brand-btn tyE" ktype="E">E</li>
			            <li class="listItem btn ui-brand-btn tyF" ktype="F">F</li>
			            <li class="listItem btn ui-brand-btn tyG" ktype="G">G</li>
			            <li class="listItem btn ui-brand-btn tyH" ktype="H">H</li>
			            <li class="listItem btn ui-brand-btn tyI" ktype="I">I</li>
			            <li class="listItem btn ui-brand-btn tyJ" ktype="J">J</li>
			            <li class="listItem btn ui-brand-btn tyK" ktype="K">K</li>
			            <li class="listItem btn ui-brand-btn tyL" ktype="L">L</li>
			            <li class="listItem btn ui-brand-btn tyM" ktype="M">M</li>
			            <li class="listItem btn ui-brand-btn tyN" ktype="N">N</li>
			            <li class="listItem btn ui-brand-btn tyO" ktype="O">O</li>
			            <li class="listItem btn ui-brand-btn tyP" ktype="P">P</li>
			            <li class="listItem btn ui-brand-btn tyQ" ktype="Q">Q</li>
			            <li class="listItem btn ui-brand-btn tyR" ktype="R">R</li>
			            <li class="listItem btn ui-brand-btn tyS" ktype="S">S</li>
			            <li class="listItem btn ui-brand-btn tyT" ktype="T">T</li>
			            <li class="listItem btn ui-brand-btn tyU" ktype="U">U</li>
			            <li class="listItem btn ui-brand-btn tyV" ktype="V">V</li>
			            <li class="listItem btn ui-brand-btn tyW" ktype="W">W</li>
			            <li class="listItem btn ui-brand-btn tyX" ktype="X">X</li>
			            <li class="listItem btn ui-brand-btn tyY" ktype="Y">Y</li>
			            <li class="listItem btn ui-brand-btn tyZ" ktype="Z">Z</li>
			         </ul>
			      </li>
			      <li class="listItem">
			         <ul class="brand-list list area-list-brand" id="brandlistslide">
			         </ul>
			      </li>
			   </ul>
			</div>
		</div>		
    </div>
            <button type="button" class="btn_show">
				<svg width="30" height="30" viewBox="0 0 30 30 file="none" xmlns="http://www.w3.org/2000/svg">
					<path fill-rule="evenodd" clip-rule="evenodd" d="M5 9.5H25V8.5H5V9.5ZM25 15.5H5V14.5H25V15.5ZM25 21.5H5V20.5H25V21.5Z" fill="black"></path>	 
				</svg>
			</button>
</body>
<script type="text/javascript">
	let letterListItems = document.querySelectorAll('.letter-list > li'); // CSS 선택자 수정
	
	letterListItems.forEach(function(item) {
	    item.addEventListener('click', function(event) {
	        var alphabet = event.target.getAttribute('ktype'); // 커스텀 데이터 속성 사용 권장
	        listBrand(alphabet);
	    });
	});
</script>	