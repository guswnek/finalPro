<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.*" %>



<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<p>${fn:length(brandAllProduct.brand) > 8 ? fn:substring(brandAllProduct.brand, 0, 8) + "..." : brandAllProduct.brand}</p>
<h3>${fn:length(brandAllProduct.name) > 8 ? fn:substring(brandAllProduct.name, 0, 8) + "..." : brandAllProduct.name}</h3>


<link rel="stylesheet" href="/finalpro/resources/css/brand.css">


<c:set var="brandImage" value="${brandListMap.brandImage }" />
<c:set var="brandProduct" value="${brandListMap.allBrandProductDTO }" />
<c:set var="brandProductImage" value="${brandListMap.allBrandProductImageList }" />

<!-- 대분류에서 카테고리를 선택하면 해당 중분류 카테고리 나오게 하기 -->
<script>

let selectedCategory = null;
let selectedSubCategory = null;
let selectedColors = []; // 색상을 저장할 배열
let selectedMinPrice = null;
let selectedMaxPrice = null;
let selectedCategoryName = '';
let selectedSubCategoryName = '';
let selectedPriceRangeName = '';



//대분류 선택 시 중분류 선택 영역을 표시하고, 상품을 필터링하는 함수
function showCategory(category, categoryName) {
	if (category === 'all') {
        // "전체"를 클릭한 경우 모든 조건을 초기화합니다.
        selectedCategory = null;
        selectedSubCategory = null;
        selectedColors = []; // 색상 선택 배열을 초기화합니다.
        selectedCategoryName = ''; // 카테고리 이름 초기화
        selectedSubCategoryName = ''; // 중분류 이름 초기화 추가
        
        // 만약 선택 링크 또는 버튼을 사용하는 경우
        document.querySelectorAll('.color_tap_link').forEach(colorSelection => {
            colorSelection.classList.remove('selected'); // 'selected' 클래스 제거
        });

        // 모든 상품을 표시하고, 중분류 선택 영역을 숨깁니다.
        const allProducts = document.querySelectorAll('.allItemInfo');
        allProducts.forEach(product => {
            product.style.display = 'block';
            product.classList.add('filtered-visible'); // 이 부분을 추가
        });

        const categories = document.querySelectorAll('.sub_outer_category, .sub_top_category, .sub_pants_category, .sub_shoes_category');
        categories.forEach(cat => cat.style.display = 'none');

        updatePagination(); // 페이지네이션 업데이트 호출을 여기에 추가합니다.
    } else if (selectedCategory === category) {
        // 이미 선택된 대분류를 다시 클릭한 경우, 서브카테고리와 색상 필터를 초기화합니다.
        selectedSubCategory = null;
        selectedColor = null;
        // 대분류에 해당하는 상품만 다시 필터링하여 표시합니다.
        filterProducts();
    } else {
        // 다른 대분류를 선택한 경우
        selectedCategory = category;
        selectedSubCategory = null;
        selectedColor = null;
        selectedCategoryName = categoryName; // 카테고리의 실제 이름 저장
        // 중분류 선택 영역을 숨기고, 선택된 대분류에 따라 해당 중분류 영역을 표시합니다.
        const categories = document.querySelectorAll('.sub_outer_category, .sub_top_category, .sub_pants_category, .sub_shoes_category');
        categories.forEach(cat => cat.style.display = 'none');

        const subCategoryDivId = 'sub_' + category + '_category';
        const subCategoryDiv = document.getElementById(subCategoryDivId);
        if (subCategoryDiv) subCategoryDiv.style.display = 'block';
        
        filterProducts(); // 상품 필터링 함수 호출
    }
    updateUserSelectionDisplay(); // 사용자 선택 표시를 업데이트
}




function filterProducts() {
    const allProducts = document.querySelectorAll('.allItemInfo');
    allProducts.forEach(product => {
        const productCategory = product.getAttribute('data-category');
        const productSubCategory = product.getAttribute('data-subcategory');
        const productColorHex = product.getAttribute('data-color1');
        const productPrice = parseInt(product.getAttribute('data-price'), 10);
        const productColor = hexToRgb(productColorHex);

        // 가격 범위 필터
        const isPriceInRange = (!selectedMinPrice || productPrice >= selectedMinPrice) && (!selectedMaxPrice || productPrice <= selectedMaxPrice);
        
        // 색상 필터
        const isColorMatched = selectedColors.length === 0 || selectedColors.some(selectedHex => {
            const {r, g, b} = hexToRgb(selectedHex);
            const distance = Math.sqrt(Math.pow(r - productColor.r, 2) + Math.pow(g - productColor.g, 2) + Math.pow(b - productColor.b, 2));
            return distance <= 70;
        });

        if ((selectedCategory && productCategory !== selectedCategory) ||
            (selectedSubCategory && productSubCategory !== selectedSubCategory) ||
            !isColorMatched ||
            !isPriceInRange) {
            product.style.display = 'none';
            product.classList.remove('filtered-visible');
        } else {
            product.style.display = 'block';
            product.classList.add('filtered-visible');
        }
    });
    updatePagination();
}


// 중분류 상품 나오게 하기
function showSubCategory(subCategory, subCategoryName) {
    // 이미 선택된 서브카테고리를 한 번 더 클릭한 경우 조건을 삭제합니다.
    if (selectedSubCategory === subCategory) {
        selectedSubCategory = null; // 서브카테고리 선택 초기화
        selectedSubCategoryName = ''; // 중분류 이름 초기화
    } else {
        selectedSubCategory = subCategory; // 새로운 서브카테고리 선택 업데이트
        selectedSubCategoryName = subCategoryName; // 중분류 실제 이름 저장
    }

    filterProducts(); // 상품 필터링 함수 호출
    updateUserSelectionDisplay(); // 이 줄을 추가
}

// 색상 유클리디안 거리 30 이하인 값의 상품만 나오게 하기
function hexToRgb(hex) {
    let r = 0, g = 0, b = 0;
    // 3자리 hex 코드인 경우 (#RGB => #RRGGBB)
    if (hex.length === 4) {
        r = parseInt(hex[1] + hex[1], 16);
        g = parseInt(hex[2] + hex[2], 16);
        b = parseInt(hex[3] + hex[3], 16);
    }
    // 6자리 hex 코드인 경우
    else if (hex.length === 7) {
        r = parseInt(hex.substring(1, 3), 16);
        g = parseInt(hex.substring(3, 5), 16);
        b = parseInt(hex.substring(5, 7), 16);
    }
    return {r, g, b};
}


function filterByColor(hexColor, event) {
    const colorLink = event.currentTarget; // 클릭된 요소를 가져옵니다
    const colorIndex = selectedColors.indexOf(hexColor); // 선택된 색상이 배열에 이미 있는지 확인
    if (colorIndex > -1) {
        selectedColors.splice(colorIndex, 1);
        colorLink.classList.remove('selected'); // 'selected' 클래스를 제거
        if (hexColor === '#0e0e0e') { // 검정색의 경우 추가적으로 처리
            colorLink.classList.remove('selected-black'); // 'selected-black' 클래스를 제거
        }
    } else {
        selectedColors.push(hexColor);
        colorLink.classList.add('selected'); // 'selected' 클래스를 추가
        if (hexColor === '#0e0e0e') { // 검정색의 경우 추가적으로 처리
            colorLink.classList.add('selected-black'); // 'selected-black' 클래스를 추가
        }
    }

    filterProducts(); // 새로운 선택에 기반하여 상품 필터링
}




// 가격 설정
function showPriceRange(minPrice, maxPrice, priceRangeName) {
    // 이미 선택된 가격 범위를 다시 클릭한 경우 조건을 삭제합니다.
    if (selectedMinPrice === minPrice && selectedMaxPrice === maxPrice) {
        selectedMinPrice = null;
        selectedMaxPrice = null;
        selectedPriceRangeName = ''; // 가격 범위 이름 초기화
    } else {
        selectedMinPrice = minPrice;
        selectedMaxPrice = maxPrice;
        selectedPriceRangeName = priceRangeName; // 가격 범위 실제 이름 저장
    }
    
    filterProducts(); // 상품 목록을 업데이트합니다.
    updateUserSelectionDisplay(); // 이 줄을 추가
}


// 사용자 가격 검색
function applyCustomPriceRange() {
    // 사용자 입력을 기반으로 최소 및 최대 가격을 가져옵니다.
    const minPrice = document.getElementById('minPrice').value;
    const maxPrice = document.getElementById('maxPrice').value;
    
    // 입력 값이 없는 경우 undefined를 전달합니다.
    const minPriceValue = minPrice ? parseInt(minPrice, 10) : undefined;
    const maxPriceValue = maxPrice ? parseInt(maxPrice, 10) : undefined;
    
    // 가격 범위를 적용합니다.
    showPriceRange(minPriceValue, maxPriceValue);
    updateUserSelectionDisplay(); // 이 줄을 추가
}


//사용자 선택 표시를 업데이트하는 함수
// 사용자 선택 표시를 업데이트하는 함수
function updateUserSelectionDisplay() {
    const display = document.getElementById('userSelectionDisplay');
    display.innerHTML = ''; // 기존에 표시된 모든 선택 항목을 초기화

    // 선택된 대분류, 중분류, 가격 범위에 대한 버튼 생성 및 추가
    if (selectedCategoryName) {
        display.appendChild(createSelectionButton(selectedCategoryName, 'category'));
    }
    if (selectedSubCategoryName) {
        display.appendChild(createSelectionButton(selectedSubCategoryName, 'subCategory'));
    }
    if (selectedPriceRangeName) {
        display.appendChild(createSelectionButton(selectedPriceRangeName, 'price'));
    }
    // 나머지 로직 유지
}

//선택한 항목에 대한 버튼을 생성하는 함수
function createSelectionButton(text, type) {
    const button = document.createElement('button');
    button.textContent = text + " (x)";
    
    // 버튼에 스타일 추가
    //button.style.backgroundColor = '#007bff'; // 배경색
    button.style.color = 'black'; // 텍스트 색상
    button.style.backgroundColor = '#ffffff';
    button.style.padding = '5px 10px'; // 안쪽 여백
    // button.style.border = 'none'; // 테두리 없음
    button.style.borderRadius = '5px'; // 모서리 둥글게
    button.style.marginRight = '5px'; // 오른쪽 마진
    
    button.onclick = function() {
        if (type === 'category') {
            selectedCategory = null;
            selectedCategoryName = '';
        } else if (type === 'subCategory') {
            selectedSubCategory = null;
            selectedSubCategoryName = '';
        } else if (type === 'price') {
            selectedMinPrice = null;
            selectedMaxPrice = null;
            selectedPriceRangeName = '';
        }
        filterProducts();
        updateUserSelectionDisplay();
    };
    return button;
}


// 상품 정렬 버튼
function sortItems(sortBy, button) {
  var items = document.querySelectorAll('.allItemInfo');
  var itemsArr = Array.from(items);

  var sortFunctions = {
    'highToLow': function(a, b) { return parseInt(b.dataset.price) - parseInt(a.dataset.price); },
    'lowToHigh': function(a, b) { return parseInt(a.dataset.price) - parseInt(b.dataset.price); },
    'reviews': function(a, b) { return parseInt(b.dataset.reviewcount) - parseInt(a.dataset.reviewcount); },
    'starScore': function(a, b) { return parseInt(b.dataset.starscore) - parseInt(a.dataset.starscore); } // 새로운 정렬 함수 추가
  };

  var sortedItems = itemsArr.sort(sortFunctions[sortBy]);

  var parent = document.querySelector('.productsGrid');
  parent.innerHTML = ""; // 컨테이너 비우기

  sortedItems.forEach(function(item) {
    parent.appendChild(item); // 정렬된 항목을 다시 컨테이너에 추가
  });

  //updateItemsDisplay();

  // 버튼 외관 업데이트를 위한 새 코드:
  var buttons = document.querySelectorAll('.sorter_button');
  buttons.forEach(function(btn) {
    btn.classList.remove('active_sort_button'); // 모든 버튼에서 활성 클래스 제거
  });
  button.classList.add('active_sort_button'); // 클릭된 버튼에 활성 클래스 추가
}



// 페이지 버튼 스타일링
function applyButtonStyle(button) {
    button.style.backgroundColor = '#ffffff'; // 배경색을 옅은 회색으로 설정
    button.style.padding = '10px 15px'; // 패딩을 적용하여 버튼 크기 조정
    button.style.margin = '5px'; // 버튼 사이의 간격 조정
    button.style.borderRadius = '5px'; // 버튼 모서리 둥글게
    button.style.cursor = 'pointer'; // 마우스 오버 시 커서 변경
}


//페이지네이션 생성 및 업데이트 함수
function updatePagination() {
    const itemsPerPage = 20;
    const allVisibleItems = document.querySelectorAll('.allItemInfo:not([style*="display: none"])');
    const pageCount = Math.ceil(allVisibleItems.length / itemsPerPage);

    const paginationDiv = document.querySelector('.pagination');
    paginationDiv.innerHTML = '';

    const firstPageButton = document.createElement('button');
    firstPageButton.innerText = "<<";
    firstPageButton.onclick = function() { showPage(1); };
    applyButtonStyle(firstPageButton); // 버튼 스타일 적용
    paginationDiv.appendChild(firstPageButton);

    for (let i = 1; i <= pageCount; i++) {
        const pageButton = document.createElement('button');
        pageButton.innerText = i;
        pageButton.onclick = function() { showPage(i); };
        applyButtonStyle(pageButton); // 버튼 스타일 적용
        paginationDiv.appendChild(pageButton);
    }

    const lastPageButton = document.createElement('button');
    lastPageButton.innerText = ">>";
    lastPageButton.onclick = function() { showPage(pageCount); };
    applyButtonStyle(lastPageButton); // 버튼 스타일 적용
    paginationDiv.appendChild(lastPageButton);

    if (pageCount > 0) {
        showPage(1);
    }
}

let currentPage = 1; // 현재 페이지 번호를 추적하는 글로벌 변수

//지정된 페이지의 상품만 보이도록 하는 함수
function showPage(pageNumber) {
    currentPage = pageNumber; // 현재 페이지 번호 업데이트
    const itemsPerPage = 20;
    const filteredVisibleItems = document.querySelectorAll('.allItemInfo.filtered-visible');

    document.querySelectorAll('.allItemInfo').forEach(item => {
        item.style.display = 'none';
    });

    const start = (pageNumber - 1) * itemsPerPage;
    const end = start + itemsPerPage;
    for (let i = start; i < end && i < filteredVisibleItems.length; i++) {
        filteredVisibleItems[i].style.display = 'block';
    }

    // 페이지 버튼의 스타일을 업데이트합니다.
    updatePaginationStyles();
}

function updatePaginationStyles() {
    const paginationDiv = document.querySelector('.pagination');
    const buttons = paginationDiv.querySelectorAll('button');
    buttons.forEach(button => {
        applyButtonStyle(button); // 모든 버튼에 기본 스타일 적용
        if (parseInt(button.innerText) === currentPage) {
            button.style.backgroundColor = '#d3d3d3'; // 현재 페이지 버튼에만 회색 배경 적용
        }
    });
}

document.addEventListener('DOMContentLoaded', function() {
    // 페이지 로딩 시 모든 상품에 filtered-visible 클래스를 추가하여 초기화합니다.
    const allProducts = document.querySelectorAll('.allItemInfo');
    allProducts.forEach(product => {
        product.classList.add('filtered-visible'); // 초기 상태에서 모든 상품에 클래스 추가
        product.style.display = 'block'; // 모든 상품을 보이게 합니다.
    });
    
    updatePagination(); // 초기 페이지네이션 업데이트
});


</script>




<body>
   <div class="brand_banner">
   	<a href="${contextPath}/brand/brandList.do?brand=${brandProduct[0].brand}">
   		<img src="${contextPath}/download.do?imageFileName=2.jpg&productNo=${brandImage[0].brand}&path=brand" id="preview">
   	</a>
   </div>
   <div class="brand_banner_detail">
   		<img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${brandImage[0].brand}&path=brand" id="preview">
   		<span>${brandImage[0].introduce}</span>
   </div>
   
   <!-- 조건 선택 창 -->
   <div class="category_select_box">
	   <div class="major_category">
	   		<p class="major_title">대분류</p>
	   		<dl class="list_division_brand">
	   			<dt>
	   				<div>
	   					<a href="javascript:void(0)" onclick="showCategory('all')">전체</a>
	   				</div>
	   			</dt>
	   			<dd>
	   				<ul class = "division_reset">
	   					<li><a href="javascript:void(0)" class="major_tap_link" data-value="outer" onclick="showCategory('outer', '아우터')">아우터<span style="display:none;">(x)</span></a></li>
	   					<li><a href="javascript:void(0)" class="major_tap_link" data-value="top" onclick="showCategory('top', '상의')">상의<span style="display:none;">(x)</span></a></li>
	   					<li><a href="javascript:void(0)" class="major_tap_link" data-value="pants" onclick="showCategory('pants', '하의')">하의<span style="display:none;">(x)</span></a></li>
	   					<li><a href="javascript:void(0)" class="major_tap_link" data-value="shoes" onclick="showCategory('shoes', '신발')">신발<span style="display:none;">(x)</span></a></li>
	   				</ul>
	   			</dd>
	   			
	   		</dl>
	   </div>
	   
	   
	   <div class="sub_outer_category" id="sub_outer_category" style="display:none;">
	   		<p class="sub_title">중분류</p>
	   		
	   		<dl class="list_division_brand">
	   			<dt>
	   				<div>
	   					<a href="javascript:void(0)" onclick="showSubCategory(null, '전체')">전체</a>
	   				</div>
	   			</dt>
	   			<dd>
	   				<ul class = "sub_outer">
	   					<li><a href="javascript:void(0)" class="sub_outer_tap_link" data-value="jumper" onclick="showSubCategory('jumper', '자켓')">자켓<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_outer_tap_link" data-value="coat" onclick="showSubCategory('coat', '코트')">코트<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_outer_tap_link" data-value="heavyOuter" onclick="showSubCategory('heavyOuter', '패딩')">패딩<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_outer_tap_link" data-value="cardigan" onclick="showSubCategory('cardigan', '가디건')">가디건<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_outer_tap_link" data-value="fleece" onclick="showSubCategory('fleece', '후리스')">후리스<span style="display:none;">(x)</span></a></li>
	   				</ul>
	   			</dd>
	   			
	   			
	   			
	   		</dl>
	   </div>
	   
	   <div class="sub_top_category" id="sub_top_category" style="display:none;">
	   		<p class="sub_title">중분류</p>
	   		
	   		<dl class="list_division_brand">
	   			<dt>
	   				<div>
	   					<a href="javascript:void(0)">전체</a>
	   				</div>
	   			</dt>
	   			 <dd>
	   				<ul class = "sub_top">
	   					<li><a href="javascript:void(0)" class="sub_outer_tap_link" data-value="mtom" onclick="showSubCategory('mtom', '맨투맨')">맨투맨<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_outer_tap_link" data-value="hood" onclick="showSubCategory('hood', '후드티')">후드티<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_outer_tap_link" data-value="t-shirt" onclick="showSubCategory('t-shirt', '티셔츠')">티셔츠<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_outer_tap_link" data-value="knit" onclick="showSubCategory('knit', '니트')">니트<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_outer_tap_link" data-value="shirt" onclick="showSubCategory('shirt', '셔츠')">셔츠<span style="display:none;">(x)</span></a></li>
	   				</ul>
	   			</dd>
	   		</dl>
	   </div>
	   
	   <div class="sub_pants_category" id="sub_pants_category" style="display:none;">
	   		<p class="sub_title">중분류</p>
	   		
	   		<dl class="list_division_brand">
	   			<dt>
	   				<div>
	   					<a href="javascript:void(0)">전체</a>
	   				</div>
	   			</dt>
	   			 <dd>
	   				<ul class = "sub_pants">
	   					<li><a href="javascript:void(0)" class="sub_pants_tap_link" data-value="jeans" onclick="showSubCategory('jeans', '청바지')">청바지<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_pants_tap_link" data-value="slacks" onclick="showSubCategory('slacks', '슬렉스')">슬렉스<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_pants_tap_link" data-value="skirt" onclick="showSubCategory('skirt', '치마')">치마<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_pants_tap_link" data-value="trackPants" onclick="showSubCategory('trackPants', '츄리닝')">츄리닝<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_pants_tap_link" data-value="shorts" onclick="showSubCategory('shorts', '반바지')">반바지<span style="display:none;">(x)</span></a></li>
	   				</ul>
	   			</dd>
	   		</dl>
	   </div>
	   
	   <div class="sub_shoes_category" id="sub_shoes_category" style="display:none;">
	   		<p class="sub_title">중분류</p>
	   		
	   		<dl class="list_division_brand">
	   			<dt>
	   				<div>
	   					<a href="javascript:void(0)">전체</a>
	   				</div>
	   			</dt>
	   			 <dd>
	   				<ul class = "sub_shoes">
	   					<li><a href="javascript:void(0)" class="sub_pants_tap_link" data-value="dressShoes" onclick="showSubCategory('dressShoes', '구두')">구두<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_pants_tap_link" data-value="slippers" onclick="showSubCategory('slippers', '슬리퍼')">슬리퍼<span style="display:none;">(x)</span></a></li>
						<li><a href="javascript:void(0)" class="sub_pants_tap_link" data-value="sneakers" onclick="showSubCategory('sneakers', '스니커즈')">스니커즈<span style="display:none;">(x)</span></a></li>
	
	   				</ul>
	   			</dd>
	   		</dl>
	   </div>
	   
	   <div class="selectColor" id="selectColor">
	   		<p class="sub_title">색상</p>
	   		
	   		<dl class="list_division_color">
	   			 <dd>
	   				<ul class = "color_tab">
	   					<li><a href="javascript:void(0)" class="color_tap_link" data-value="#0e0e0e" onclick="filterByColor('#0e0e0e', event)" style="background-color: #0e0e0e;" title="블랙"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#d9d9d7" onclick="filterByColor('#d9d9d7', event)" style="background-color: #d9d9d7;" title="라이트 그레이"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#9c9c9b" onclick="filterByColor('#9c9c9b', event)" style="background-color: #9c9c9b;" title="그레이"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#001e66" onclick="filterByColor('#001e66', event)" style="background-color: #001e66;" title="네이비"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#FF0000" onclick="filterByColor('#FF0000', event)" style="background-color: #FF0000;" title="레드"></a></li>
					
					
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#feffed" onclick="filterByColor('#feffed', event)" style="background-color: #feffed;" title="아이보리"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#ffffff" onclick="filterByColor('#ffffff', event)" style="background-color: #ffffff;" title="화이트"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#52565b" onclick="filterByColor('#52565b', event)" style="background-color: #52565b;" title="다크 그레이"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#2508ff" onclick="filterByColor('#2508ff', event)" style="background-color: #2508ff;" title="블루"></a></li>
						
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#00b000" onclick="filterByColor('#00b000', event)" style="background-color: #00b000;" title="라이트 그린"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#f1c276" onclick="filterByColor('#f1c276', event)" style="background-color: #f1c276;" title="베이지"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#00c3eb" onclick="filterByColor('#00c3eb', event)" style="background-color: #00c3eb;" title="스카이 블루"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#5b5a35" onclick="filterByColor('#5b5a35', event)" style="background-color: #5b5a35;" title="카키"></a></li>
						
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#03431d" onclick="filterByColor('#03431d', event)" style="background-color: #03431d;" title="다크 그린"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#7f290c" onclick="filterByColor('#7f290c', event)" style="background-color: #7f290c;" title="브라운"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#00c4ab" onclick="filterByColor('#00c4ab', event)" style="background-color: #00c4ab;" title="민트"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#ff00a1" onclick="filterByColor('#ff00a1', event)" style="background-color: #ff00a1;" title="핑크"></a></li>
						
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#ceb390" onclick="filterByColor('#ceb390', event)" style="background-color: #ceb390;" title="샌드"></a></li>
						
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#ff9db5" onclick="filterByColor('#ff9db5', event)" style="background-color: #ff9db5;" title="라이트 핑크"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#b077cf" onclick="filterByColor('#b077cf', event)" style="background-color: #b077cf;" title="라벤더"></a></li>
						
						
						
						
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#77872e" onclick="filterByColor('#77872e', event)" style="background-color: #77872e;" title="올리브 그린"></a></li>
						
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#feea00" onclick="filterByColor('#feea00', event)" style="background-color: #feea00;" title="옐로우"></a></li>
						
						
						
						
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#e8a399" onclick="filterByColor('#e8a399', event)" style="background-color: #e8a399;" title="페일 핑크"></a></li>
						
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#e49700" onclick="filterByColor('#e49700', event)" style="background-color: #e49700;" title="오렌지"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#ad0a32" onclick="filterByColor('#ad0a32', event)" style="background-color: #ad0a32;" title="버건디"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#aa7200" onclick="filterByColor('#aa7200', event)" style="background-color: #aa7200;" title="카키 베이지"></a></li>
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#204784" onclick="filterByColor('#204784', event)" style="background-color: #204784;" title="데님"></a></li>
						
						
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#b9cee0" onclick="filterByColor('#b9cee0', event)" style="background-color: #b9cee0;" title="라이트 블루"></a></li>
						
						
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#570070" onclick="filterByColor('#570070', event)" style="background-color: #570070;" title="퍼플"></a></li>
						
						
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#b9b018" onclick="filterByColor('#b9b018', event)" style="background-color: #b9b018;" title="머스타드"></a></li>
						
						<li><a href="javascript:void(0)" class="color_tap_link" data-value="#8b9fbb" onclick="filterByColor('#8b9fbb', event)" style="background-color: #8b9fbb;" title="미디엄 블루"></a></li>
	   				</ul>
	   			</dd>
	   		</dl>
	   
	   
	   
	   </div>	
	   
	   
	   
	   <!-- 가격 -->
	   <div class="selectPrice" id="selectPrice" >
	   		<p class="sub_title">가격</p>
	   		
	   		<dl class="list_division_brand">
	   			<dt>
	   				<div>
	   					<a href="javascript:void(0)" class="sub_pants_tap_link" onclick="showPriceRange(undefined, undefined, '전체')">전체</a>
	   				</div>
	   			</dt>
	   			 <dd>
	   				<ul class = "sub_price">
	   					<li class="price_selection"><a href="javascript:void(0)" class="sub_pants_tap_link" onclick="showPriceRange(undefined, 50000, '5만원 이하')">5만원 이하<span style="display:none;">(x)</span></a></li>
	   					<li class="price_selection"><a href="javascript:void(0)" class="sub_pants_tap_link" onclick="showPriceRange(50000, 100000, '5만원~10만원')">5만원~10만원<span style="display:none;">(x)</span></a></li>
	   					<li class="price_selection"><a href="javascript:void(0)" class="sub_pants_tap_link" onclick="showPriceRange(100000, 200000, '10만원~20만원')">10만원~20만원<span style="display:none;">(x)</span></a></li>
	   					<li class="price_selection"><a href="javascript:void(0)" class="sub_pants_tap_link" onclick="showPriceRange(200000, 300000, '20만원~30만원')">20만원~30만원<span style="display:none;">(x)</span></a></li>
	   					<li class="price_selection"><a href="javascript:void(0)" class="sub_pants_tap_link" onclick="showPriceRange(300000, undefined, '30만원 이상')">30만원이상<span style="display:none;">(x)</span></a></li>
	   					<li>
	   						<div class="custom_price_range">
							    <input type="text" id="minPrice" placeholder="최소">
							    ~
							    <input type="text" id="maxPrice" placeholder="최대">
							    <button onclick="applyCustomPriceRange()">검색</button>
							</div>
	   					</li>
	   				</ul>
	   			</dd>
	   		</dl>
	   </div>
	   
	   <!-- 클릭한 값 표시 -->
	   
	   <div id="userSelectionDisplay" style="padding: 20px; margin-top: 40px;">
		    선택한 항목이 여기에 표시됩니다.
		</div>
	</div>	
	
	
	
	<!-- 상품 리스트 위의 선택 버튼 -->
   
   <div class="sorter_box">
	  <ul class="sorter_list">
	    <li><button class="sorter_button" onclick="sortItems('highToLow', this)">높은 가격순</button></li>
	    <li><button class="sorter_button" onclick="sortItems('lowToHigh', this)">낮은 가격순</button></li>
	    <li><button class="sorter_button" onclick="sortItems('reviews', this)">리뷰 순</button></li>
	    <li><button class="sorter_button" onclick="sortItems('starScore', this)">별점 순</button></li>
	  </ul>
	  
    <!-- 페이지 버튼 -->	  
	  <!-- 페이지 버튼 -->
		<div class="pagination">
		
		</div>
	</div>
   
   <!-- 브랜드 상품 리스트 구역 -->
  
	 <div class="productsGrid">
	  <c:forEach var="brandAllProduct" items="${brandProduct}" varStatus="status">
	    <div class="allItemInfo" data-category="${brandAllProduct.category}" data-subcategory="${brandAllProduct.subCategory}"
	     data-color1="${brandAllProduct.color1}" data-color2="${brandAllProduct.color2}" data-color3="${brandAllProduct.color3}" data-price="${brandAllProduct.price }"
	     data-viewCount="${brandAllProduct.viewCount }" data-reviewCount="${brandAllProduct.reviewCount }" data-starScore="${brandAllProduct.averageStarScore }" id="brandAllProduct${status.index + 1}">
	        <a href="${contextPath }/product/detailProduct.do?productNo=${brandAllProduct.productNo}">
	            <img src="${contextPath}/download.do?imageFileName=${brandProductImage[status.index].imageFileName}&productNo=${brandAllProduct.productNo}&path=product" id="preview${status.index + 1}">
	            <h4>${brandAllProduct.brand}</h4>
	            <p>${brandAllProduct.name}</p>
	            <fmt:formatNumber value="${brandAllProduct.price}" pattern="#,##0" var="formattedPrice"/>
	            <span class="product-price">${formattedPrice}원</span>
	            <div class="stars-background">
				    <div class="star-rating">
				        <div class="filled-stars" style="width: ${brandAllProduct.averageStarScore / 5 * 100}%;">★★★★★</div>
				        <div class="empty-stars">★★★★★</div>
				    </div>
				    <span class="review-count">${brandAllProduct.reviewCount}</span>
				</div>
	            <%-- <p><img src="/finalpro/resources/image/like.png" class="like_image"><span class="like_count">${brandAllProduct.likeCount}</span></p> --%>
	        </a>
	    </div>
	  </c:forEach>
	</div>



<script type="text/javascript">
    window.onload = function() {
        // 브랜드 이름 처리
        var brandNames = document.querySelectorAll('.allItemInfo p');
        brandNames.forEach(function(brandName) {
            if (brandName.innerText.length > 15) {
                brandName.innerText = brandName.innerText.substring(0, 15) + "...";
            }
        });

        // 제품 이름 처리
        var productNames = document.querySelectorAll('.allItemInfo h3');
        productNames.forEach(function(productName) {
            if (productName.innerText.length > 15) {
                productName.innerText = productName.innerText.substring(0, 15) + "...";
            }
        });
    };
</script>

	
	
</body>


