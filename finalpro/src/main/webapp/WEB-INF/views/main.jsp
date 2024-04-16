<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<c:choose>  
   <c:when test="${param.msg == 'delMember' }">
   <script>
      alert('회원탈퇴 되었습니다.')
   </script>
   </c:when>
   <c:when test="${param.result == 'logout'}">
      <script>
       alert("로그아웃 되었습니다.")
      </script>
   </c:when>
   <c:when test="${msg == 'delMember' }">
      <c:if test="${empty id }">
         <script >
         alert('삭제에 실패 했습니다.)
         </script>
      </c:if>
   </c:when>
   
</c:choose>







 <script>
 document.addEventListener("DOMContentLoaded", function() {
	    const pictorialItems = document.querySelectorAll('.carousel-item.pictorial');
	    const lookbookItems = document.querySelectorAll('.carousel-item.lookbook');
	    const allItems = document.querySelectorAll('.carousel-item');
	    const prevBtn = document.querySelector('.prev-btn');
	    const nextBtn = document.querySelector('.next-btn');
	    const tabLinks = document.querySelectorAll('.tab-link-magazine'); // 탭 링크 선택

	    let currentList = 'pictorialList'; // 기본적으로 화보 리스트를 표시
	    let counter = 0;

	    function updateCarousel(items) {
	        allItems.forEach(item => item.style.display = 'none'); // 모든 아이템을 숨김
	        items.forEach((item, index) => {
	            if(index >= counter && index < counter + 3) { // 현재 counter 기준으로 3개의 아이템만 표시
	                item.style.display = 'block';
	            }
	        });
	    }

	    function switchTab(listName) {
	        counter = 0; // 탭을 변경할 때마다 counter를 초기화
	        currentList = listName;
	        const itemsToShow = currentList === 'pictorialList' ? pictorialItems : lookbookItems;
	        updateCarousel(itemsToShow);

	        // 모든 탭 링크에서 active 클래스 제거
	        tabLinks.forEach(link => {
	            link.classList.remove('active');
	        });

	        // 현재 클릭된 탭에 active 클래스 추가
	        const activeTab = Array.from(tabLinks).find(link => link.getAttribute('data-value') === listName);
	        if (activeTab) {
	            activeTab.classList.add('active');
	        }
	    }

	    nextBtn.addEventListener('click', () => {
	        const items = currentList === 'pictorialList' ? pictorialItems : lookbookItems;
	        if (counter < items.length - 3) counter++;
	        updateCarousel(items);
	    });

	    prevBtn.addEventListener('click', () => {
	        if (counter > 0) counter--;
	        const items = currentList === 'pictorialList' ? pictorialItems : lookbookItems;
	        updateCarousel(items);
	    });

	    tabLinks.forEach(link => {
	        link.addEventListener('click', function() {
	            switchTab(this.getAttribute('data-value'));
	        });
	    });

	    // 초기 화보 리스트 표시
	    switchTab('pictorialList');
	});

 </script>
 

<script>


document.addEventListener("DOMContentLoaded", function() {
    var contextPath = '${pageContext.request.contextPath}';
    var tabLinks = document.querySelectorAll('.tab-link-product');
    var allViewLink = document.getElementById('product_all_view');

    var allItems = [];
    var outerItems = [];
    var topItems = [];
    var pantsItems = [];
    var shoesItems = [];

    // 항목들을 배열에 채워 넣기
    for (var i = 1; i <= 10; i++) {
        allItems.push(document.querySelector('#allProduct' + i));
        outerItems.push(document.querySelector('#outerProduct' + i));
        topItems.push(document.querySelector('#topProduct' + i));
        pantsItems.push(document.querySelector('#pantsProduct' + i));
        shoesItems.push(document.querySelector('#shoesProduct' + i));
    }

    function hideAllItems() {
        var allCategories = [allItems, outerItems, topItems, pantsItems, shoesItems];
        allCategories.forEach(function(category) {
            category.forEach(function(item) {
                if (item !== null) {
                    item.style.display = 'none';
                }
            });
        });
    }

    function showItems(itemsToShow) {
        hideAllItems();
        itemsToShow.forEach(function(item) {
            if (item !== null) {
                item.style.display = 'block';
            }
        });
    }

    showItems(allItems); // 페이지 로드 시 모든 항목을 보여줌
    
    
 	// '전체' 탭을 찾아 초기에 active 클래스 추가
    var initialActiveTab = document.querySelector('.tab-link-product[data-value="productAll"]');
    if(initialActiveTab) {
        initialActiveTab.classList.add('active');
    }

    tabLinks.forEach(function(link) {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            var value = this.getAttribute('data-value');

            tabLinks.forEach(function(innerLink) {
                innerLink.classList.remove('active');
            });
            this.classList.add('active');

            switch (value) {
                case 'outer':
                    showItems(outerItems);
                    break;
                case 'top':
                    showItems(topItems);
                    break;
                case 'pants':
                    showItems(pantsItems);
                    break;
                case 'shoes':
                    showItems(shoesItems);
                    break;
                default:
                    showItems(allItems);
                    break;
            }
        });
    });
});

</script>
 
 


<!-- 스타일 구역에서 각각의 항목을 클릭하면 해당 항목의 상품들이 보이게 하는 것 -->
<script>
 document.addEventListener("DOMContentLoaded", function() {
    // contextPath 변수 선언
    var contextPath = '${pageContext.request.contextPath}';

    // 탭 링크와 기본 아이템, 스트릿 아이템 선택
    var tabLinks = document.querySelectorAll('.tab-link');
    var allViewLink = document.getElementById('snap_all_view');
    var defaultItem1 = document.querySelector('#default_product1'); // 기본 아이템 선택
    var defaultItem2 = document.querySelector('#default_product2'); // 기본 아이템 선택
    var defaultItem3 = document.querySelector('#default_product3'); // 기본 아이템 선택
    var defaultItem4 = document.querySelector('#default_product4'); // 기본 아이템 선택
    var streetItem1 = document.querySelector('#street1'); // 스트릿 아이템 선택
    var streetItem2 = document.querySelector('#street2'); // 스트릿 아이템 선택
    var streetItem3 = document.querySelector('#street3'); // 스트릿 아이템 선택
    var streetItem4 = document.querySelector('#street4'); // 스트릿 아이템 선택
    var colorItem = document.querySelector('#color'); // 퍼스널컬러 아이템 선택
    var initialItem = document.querySelector('.product-item2 > a'); // 초기에 보여질 아이템

    // 초기 상태 설정
    streetItem1.style.display = 'none'; // 스트릿 아이템 숨김
    streetItem2.style.display = 'none'; // 스트릿 아이템 숨김
    streetItem3.style.display = 'none'; // 스트릿 아이템 숨김
    streetItem4.style.display = 'none'; // 스트릿 아이템 숨김
    colorItem.style.display = 'none'; // 퍼스널 컬러 아이템을 숨김
	
    
    
    // '브랜드 스냅샷' 탭을 찾아 초기에 active 클래스 추가
    var initialActiveTab = document.querySelector('.tab-link[data-value="brandSnap"]');
    if(initialActiveTab) {
        initialActiveTab.classList.add('active');
    }
    
  	// 초기 링크 설정
    allViewLink.href = contextPath + '/styleall/brandSnap.do';
    
    
    // 각 탭 링크에 대한 클릭 이벤트 리스너 등록
    tabLinks.forEach(function(link) {
        link.addEventListener('click', function() {
            // 모든 링크에서 'active' 클래스 제거
            tabLinks.forEach(function(innerLink) {
                innerLink.classList.remove('active');
            });

            // 클릭된 링크에 'active' 클래스 추가
            this.classList.add('active');

            // allViewLink의 href 속성 변경
            var value = this.getAttribute('data-value');
            allViewLink.href = contextPath + '/styleall/' + value + '.do';
            

            // 탭에 따른 아이템 표시 변경
            if(value === 'streetSnap') {
                // '스트릿 스냅샷' 탭 클릭 시
                defaultItem1.style.display = 'none'; // 기본 아이템 숨김
                defaultItem2.style.display = 'none'; // 기본 아이템 숨김
                defaultItem3.style.display = 'none'; // 기본 아이템 숨김
                defaultItem4.style.display = 'none'; // 기본 아이템 숨김
                streetItem1.style.display = 'block'; // 스트릿 아이템 표시
                streetItem2.style.display = 'block'; // 스트릿 아이템 표시
                streetItem3.style.display = 'block'; // 스트릿 아이템 표시
                streetItem4.style.display = 'block'; // 스트릿 아이템 표시
                colorItem.style.display = 'none'; // 퍼스널 컬러 아이디템 숨김
            } else if(value === 'brandSnap') {
                defaultItem1.style.display = 'block';
                defaultItem2.style.display = 'block';
                defaultItem3.style.display = 'block';
                defaultItem4.style.display = 'block';
                streetItem1.style.display = 'none';
                streetItem2.style.display = 'none';
                streetItem3.style.display = 'none';
                streetItem4.style.display = 'none';
                colorItem.style.display = 'none';
            } else if(value === 'personalColor') {
                defaultItem1.style.display = 'none';
                defaultItem2.style.display = 'none';
                defaultItem3.style.display = 'none';
                defaultItem4.style.display = 'none';
                streetItem1.style.display = 'none';
                streetItem2.style.display = 'none';
                streetItem3.style.display = 'none';
                streetItem4.style.display = 'none';
                colorItem.style.display = 'block';
            }
        });
    });
}); 

</script>

<script>
window.onload = function() {
    var contextPath = '${pageContext.request.contextPath}'; // 실제 경로에 맞게 조정하세요.

    var tabLinks = document.querySelectorAll('.tab-link-magazine');
    var magazineViewLink = document.getElementById('magazine_all_view');
	
    
    
	 // 초기 링크 설정
    magazineViewLink.href = contextPath + '/magazine/pictorialList.do';
    
    tabLinks.forEach(function(link) {
        link.addEventListener('click', function() {
            // 모든 탭 링크의 색상과 폰트 굵기를 초기화
            tabLinks.forEach(function(otherLink) {
                otherLink.style.color = '#777'; // 기본 색상으로 설정
                otherLink.style.fontWeight = 'normal'; // 기본 폰트 굵기로 설정
            });

            // 클릭된 링크의 색상을 검정색으로, 폰트 굵기를 굵게(bold) 변경
            this.style.color = 'black';
            this.style.fontWeight = 'bold';

            var value = this.getAttribute('data-value');
            magazineViewLink.href = contextPath + '/magazine/' + value + '.do';
            console.log('New href: ', magazineViewLink.href);
        });
    });
};
</script>







<!-- 전체 상위 10개 -->
<c:set var="product" value="${productMap.product }" />
<c:set var="imageFileList" value="${productMap.imageFileList }" />
<!-- 아우터 상위 10개 -->
<c:set var="outerProduct" value="${productMap.productOuter }" />
<c:set var="outerImageFileList" value="${productMap.imageFileListOuter }" />
<!-- 상의 상위 10개 -->
<c:set var="topProduct" value="${productMap.productTop }" />
<c:set var="topImageFileList" value="${productMap.imageFileListTop }" />
<!-- 하의 상위 10개 -->
<c:set var="pantsProduct" value="${productMap.productPants }" />
<c:set var="pantsImageFileList" value="${productMap.imageFileListPants }" />
<!-- 신발 상위 10개 -->
<c:set var="shoesProduct" value="${productMap.productShoes }" />
<c:set var="shoesImageFileList" value="${productMap.imageFileListShoes }" />

<!-- 스타일 탭 -->
<c:set var="brandSnap" value="${brandSnapMap.brandSnap }" />
<c:set var="imageFileList3" value="${brandSnapMap.imageFileList3 }" />
<c:set var="streetSnap" value="${streetSnapMap.streetSnap }" />
<c:set var="imageFileList5" value="${streetSnapMap.imageFileList5 }" />

<!-- 매거진 탭 -->
<c:set var="pictorialImage" value="${pictorialMap.pictorialMainImage }" />
<c:set var="lookbookImage" value="${lookbookMap.lookbookMainImage }" />



<body>
	<div class="body1">
		<div class="main_ranking_box">
				<h2 class="txt_tit_main">실시간랭킹</h2>
				<input type="hidden" name="product_kind" id="product_kind" value="staff">
				<!-- <span class="txt_detail_link">
					<a href="#" id="product_all_view">전체</a>
				</span> -->
				<div class="tool-tabBtn renew-menu-list" id="snap_tab">
					<a href="javascript:void(0)" class="tab-link-product" data-value="productAll">전체</a>
				    <a href="javascript:void(0)" class="tab-link-product " data-value="outer">아우터</a>
				    <a href="javascript:void(0)" class="tab-link-product" data-value="top">상의</a>
				    <a href="javascript:void(0)" class="tab-link-product" data-value="pants">하의</a>
				    <a href="javascript:void(0)" class="tab-link-product" data-value="shoes">신발</a>
				</div>
			</div>
		
		<div class="content-area">
		<div class="product-ranking">
			<!-- 1위 상품 -->
		    <div class="product-item" id="allProduct1">
			  <div class="rank">1위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${product[0].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${product[0].productNo}&path=product" alt="1위 상품" id="preview">
			    <h3>${product[0].name}</h3>
			    <p>${product[0].brand}</p>
			    <fmt:formatNumber value="${product[0].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="outerProduct1">
			  <div class="rank">1위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${outerProduct[0].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${outerImageFileList[0].imageFileName}&productNo=${outerProduct[0].productNo}&path=product"" alt="1위 상품" id="preview">
			    <h3>${outerProduct[0].name}</h3>
			    <p>${outerProduct[0].brand}</p>
			    <fmt:formatNumber value="${outerProduct[0].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="topProduct1">
			  <div class="rank">1위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${topProduct[0].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${topImageFileList[0].imageFileName}&productNo=${topProduct[0].productNo}&path=product"" alt="1위 상품" id="preview">
			    <h3>${topProduct[0].name}</h3>
			    <p>${topProduct[0].brand}</p>
			    <fmt:formatNumber value="${topProduct[0].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="pantsProduct1">
			  <div class="rank">1위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${pantsProduct[0].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${pantsImageFileList[0].imageFileName}&productNo=${pantsProduct[0].productNo}&path=product"" alt="1위 상품" id="preview">
			    <h3>${pantsProduct[0].name}</h3>
			    <p>${pantsProduct[0].brand}</p>
			    <fmt:formatNumber value="${pantsProduct[0].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="shoesProduct1">
			  <div class="rank">1위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${shoesProduct[0].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${shoesImageFileList[0].imageFileName}&productNo=${shoesProduct[0].productNo}&path=product"" alt="1위 상품" id="preview">
			    <h3>${shoesProduct[0].name}</h3>
			    <p>${shoesProduct[0].brand}</p>
			    <fmt:formatNumber value="${shoesProduct[0].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<!-- 2위 상품 -->
			<div class="product-item" id="allProduct2">
			  <div class="rank">2위</div>
			   <a href="${contextPath }/product/detailProduct.do?productNo=${product[1].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${imageFileList[1].imageFileName}&productNo=${product[1].productNo}&path=product"" alt="2위 상품" id="preview">
			      <h3>${product[1].name}</h3>
			      <p>${product[1].brand}</p>
			      <fmt:formatNumber value="${product[1].price}" pattern="#,##0" var="formattedPrice0"/>
				  <span class="product-price">${formattedPrice0}원</span>
		      </a>
		    </div>
		    
		    <div class="product-item" id="outerProduct2">
			  <div class="rank">2위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${outerProduct[1].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${outerImageFileList[1].imageFileName}&productNo=${outerProduct[1].productNo}&path=product"" alt="2위 상품" id="preview">
			    <h3>${outerProduct[1].name}</h3>
			    <p>${outerProduct[1].brand}</p>
			    <fmt:formatNumber value="${outerProduct[1].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="topProduct2">
			  <div class="rank">2위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${topProduct[1].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${topImageFileList[1].imageFileName}&productNo=${topProduct[1].productNo}&path=product"" alt="2위 상품" id="preview">
			    <h3>${topProduct[1].name}</h3>
			    <p>${topProduct[1].brand}</p>
			    <fmt:formatNumber value="${topProduct[1].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="pantsProduct2">
			  <div class="rank">2위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${pantsProduct[1].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${pantsImageFileList[1].imageFileName}&productNo=${pantsProduct[1].productNo}&path=product"" alt="2위 상품" id="preview">
			    <h3>${pantsProduct[1].name}</h3>
			    <p>${pantsProduct[1].brand}</p>
			    <fmt:formatNumber value="${pantsProduct[1].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="shoesProduct2">
			  <div class="rank">2위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${shoesProduct[1].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${shoesImageFileList[1].imageFileName}&productNo=${shoesProduct[1].productNo}&path=product"" alt="2위 상품" id="preview">
			    <h3>${shoesProduct[1].name}</h3>
			    <p>${shoesProduct[1].brand}</p>
			    <fmt:formatNumber value="${shoesProduct[1].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<!-- 3위 상품 -->
		    <div class="product-item" id="allProduct3">
		      <div class="rank">3위</div>
			      <a href="${contextPath }/product/detailProduct.do?productNo=${product[2].productNo}">
				    <img src="${contextPath}/download.do?imageFileName=${imageFileList[2].imageFileName}&productNo=${product[2].productNo}&path=product"" alt="3위 상품" id="preview">
				      <h3>${product[2].name}</h3>
				      <p>${product[2].brand}</p>
				      <fmt:formatNumber value="${product[2].price}" pattern="#,##0" var="formattedPrice0"/>
					  <span class="product-price">${formattedPrice0}원</span>
			      </a>
		    </div>
		    
		    <div class="product-item" id="outerProduct3">
			  <div class="rank">3위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${outerProduct[2].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${outerImageFileList[2].imageFileName}&productNo=${outerProduct[2].productNo}&path=product"" alt="3위 상품" id="preview">
			    <h3>${outerProduct[2].name}</h3>
			    <p>${outerProduct[2].brand}</p>
			    <fmt:formatNumber value="${outerProduct[2].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="topProduct3">
			  <div class="rank">3위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${topProduct[2].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${topImageFileList[2].imageFileName}&productNo=${topProduct[2].productNo}&path=product"" alt="3위 상품" id="preview">
			    <h3>${topProduct[2].name}</h3>
			    <p>${topProduct[2].brand}</p>
			    <fmt:formatNumber value="${topProduct[2].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="pantsProduct3">
			  <div class="rank">3위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${pantsProduct[2].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${pantsImageFileList[2].imageFileName}&productNo=${pantsProduct[2].productNo}&path=product"" alt="3위 상품" id="preview">
			    <h3>${pantsProduct[2].name}</h3>
			    <p>${pantsProduct[2].brand}</p>
			    <fmt:formatNumber value="${pantsProduct[2].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="shoesProduct3">
			  <div class="rank">3위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${shoesProduct[2].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${shoesImageFileList[2].imageFileName}&productNo=${shoesProduct[2].productNo}&path=product"" alt="3위 상품" id="preview">
			    <h3>${shoesProduct[2].name}</h3>
			    <p>${shoesProduct[2].brand}</p>
			    <fmt:formatNumber value="${shoesProduct[2].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<!-- 4위 상품 -->
		    <div class="product-item" id="allProduct4">
		      <div class="rank">4위</div>
			      <a href="${contextPath }/product/detailProduct.do?productNo=${product[3].productNo}">
					    <img src="${contextPath}/download.do?imageFileName=${imageFileList[3].imageFileName}&productNo=${product[3].productNo}&path=product"" alt="4위 상품" id="preview">
					      <h3>${product[3].name}</h3>
					      <p>${product[3].brand}</p>
					      <fmt:formatNumber value="${product[3].price}" pattern="#,##0" var="formattedPrice0"/>
					      <span class="product-price">${formattedPrice0}원</span>
				  </a>
		    </div>
		    
		    <div class="product-item" id="outerProduct4">
			  <div class="rank">4위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${outerProduct[3].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${outerImageFileList[3].imageFileName}&productNo=${outerProduct[3].productNo}&path=product"" alt="4위 상품" id="preview">
			    <h3>${outerProduct[3].name}</h3>
			    <p>${outerProduct[3].brand}</p>
			    <fmt:formatNumber value="${outerProduct[3].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="topProduct4">
			  <div class="rank">4위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${topProduct[3].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${topImageFileList[3].imageFileName}&productNo=${topProduct[3].productNo}&path=product"" alt="4위 상품" id="preview">
			    <h3>${topProduct[3].name}</h3>
			    <p>${topProduct[3].brand}</p>
			    <fmt:formatNumber value="${topProduct[3].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="pantsProduct4">
			  <div class="rank">4위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${pantsProduct[3].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${pantsImageFileList[3].imageFileName}&productNo=${pantsProduct[3].productNo}&path=product"" alt="4위 상품" id="preview">
			    <h3>${pantsProduct[3].name}</h3>
			    <p>${pantsProduct[3].brand}</p>
			    <fmt:formatNumber value="${pantsProduct[3].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="shoesProduct4">
			  <div class="rank">4위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${shoesProduct[3].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${shoesImageFileList[3].imageFileName}&productNo=${shoesProduct[3].productNo}&path=product"" alt="4위 상품" id="preview">
			    <h3>${shoesProduct[3].name}</h3>
			    <p>${shoesProduct[3].brand}</p>
			    <fmt:formatNumber value="${shoesProduct[3].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<!-- 5위 상품 -->
		    <div class="product-item" id="allProduct5">
		      <div class="rank">5위</div>
		      <a href="${contextPath }/product/detailProduct.do?productNo=${product[4].productNo}">
				    <img src="${contextPath}/download.do?imageFileName=${imageFileList[4].imageFileName}&productNo=${product[4].productNo}&path=product"" alt="5위 상품" id="preview">
				      <h3>${product[4].name}</h3>
				      <p>${product[4].brand}</p>
				      <fmt:formatNumber value="${product[4].price}" pattern="#,##0" var="formattedPrice0"/>
				      <span class="product-price">${formattedPrice0}원</span>

			  </a>
		    </div>
		    
		    <div class="product-item" id="outerProduct5">
			  <div class="rank">5위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${outerProduct[4].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${outerImageFileList[4].imageFileName}&productNo=${outerProduct[4].productNo}&path=product"" alt="5위 상품" id="preview">
			    <h3>${outerProduct[4].name}</h3>
			    <p>${outerProduct[4].brand}</p>
			    <fmt:formatNumber value="${outerProduct[4].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="topProduct5">
			  <div class="rank">5위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${topProduct[4].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${topImageFileList[4].imageFileName}&productNo=${topProduct[4].productNo}&path=product"" alt="5위 상품" id="preview">
			    <h3>${topProduct[4].name}</h3>
			    <p>${topProduct[4].brand}</p>
			    <fmt:formatNumber value="${topProduct[4].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="pantsProduct5">
			  <div class="rank">5위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${pantsProduct[4].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${pantsImageFileList[4].imageFileName}&productNo=${pantsProduct[4].productNo}&path=product"" alt="5위 상품" id="preview">
			    <h3>${pantsProduct[4].name}</h3>
			    <p>${pantsProduct[4].brand}</p>
			    <fmt:formatNumber value="${pantsProduct[4].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="shoesProduct5">
			  <div class="rank">5위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${shoesProduct[4].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${shoesImageFileList[4].imageFileName}&productNo=${shoesProduct[4].productNo}&path=product"" alt="5위 상품" id="preview">
			    <h3>${shoesProduct[4].name}</h3>
			    <p>${shoesProduct[4].brand}</p>
			    <fmt:formatNumber value="${shoesProduct[4].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
		    
		    <!-- 6위 상품 -->
		    <div class="product-item" id="allProduct6">
		      <div class="rank">6위</div>
		      <a href="${contextPath }/product/detailProduct.do?productNo=${product[5].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${imageFileList[5].imageFileName}&productNo=${product[5].productNo}&path=product"" alt="6위 상품" id="preview">
			      <h3>${product[5].name}</h3>
			      <p>${product[5].brand}</p>
			      <fmt:formatNumber value="${product[5].price}" pattern="#,##0" var="formattedPrice0"/>
				  <span class="product-price">${formattedPrice0}원</span>
			  </a>
		    </div>
		    
		    <div class="product-item" id="outerProduct6">
			  <div class="rank">6위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${outerProduct[5].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${outerImageFileList[5].imageFileName}&productNo=${outerProduct[5].productNo}&path=product"" alt="6위 상품" id="preview">
			    <h3>${outerProduct[5].name}</h3>
			    <p>${outerProduct[5].brand}</p>
			    <fmt:formatNumber value="${outerProduct[5].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="topProduct6">
			  <div class="rank">6위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${topProduct[5].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${topImageFileList[5].imageFileName}&productNo=${topProduct[5].productNo}&path=product"" alt="6위 상품" id="preview">
			    <h3>${topProduct[5].name}</h3>
			    <p>${topProduct[5].brand}</p>
			    <fmt:formatNumber value="${topProduct[5].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="pantsProduct6">
			  <div class="rank">6위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${pantsProduct[5].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${pantsImageFileList[5].imageFileName}&productNo=${pantsProduct[5].productNo}&path=product"" alt="6위 상품" id="preview">
			    <h3>${pantsProduct[5].name}</h3>
			    <p>${pantsProduct[5].brand}</p>
			    <fmt:formatNumber value="${pantsProduct[5].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="shoesProduct6">
			  <div class="rank">6위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${shoesProduct[5].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${shoesImageFileList[5].imageFileName}&productNo=${shoesProduct[5].productNo}&path=product"" alt="6위 상품" id="preview">
			    <h3>${shoesProduct[5].name}</h3>
			    <p>${shoesProduct[5].brand}</p>
			    <fmt:formatNumber value="${shoesProduct[5].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<!-- 7위 상품 -->
		    <div class="product-item" id="allProduct7">
		      <div class="rank">7위</div>
		      <a href="${contextPath }/product/detailProduct.do?productNo=${product[6].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${imageFileList[6].imageFileName}&productNo=${product[6].productNo}&path=product"" alt="7위 상품" id="preview">
			      <h3>${product[6].name}</h3>
			      <p>${product[6].brand}</p>
			      <fmt:formatNumber value="${product[6].price}" pattern="#,##0" var="formattedPrice0"/>
				  <span class="product-price">${formattedPrice0}원</span>
			  </a>
		    </div>
		    
		    <div class="product-item" id="outerProduct7">
			  <div class="rank">7위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${outerProduct[6].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${outerImageFileList[6].imageFileName}&productNo=${outerProduct[6].productNo}&path=product"" alt="7위 상품" id="preview">
			    <h3>${outerProduct[6].name}</h3>
			    <p>${outerProduct[6].brand}</p>
			    <fmt:formatNumber value="${outerProduct[6].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="topProduct7">
			  <div class="rank">7위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${topProduct[6].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${topImageFileList[6].imageFileName}&productNo=${topProduct[6].productNo}&path=product"" alt="7위 상품" id="preview">
			    <h3>${topProduct[6].name}</h3>
			    <p>${topProduct[6].brand}</p>
			    <fmt:formatNumber value="${topProduct[6].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="pantsProduct7">
			  <div class="rank">7위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${pantsProduct[6].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${pantsImageFileList[6].imageFileName}&productNo=${pantsProduct[6].productNo}&path=product"" alt="7위 상품" id="preview">
			    <h3>${pantsProduct[6].name}</h3>
			    <p>${pantsProduct[6].brand}</p>
			    <fmt:formatNumber value="${pantsProduct[6].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="shoesProduct7">
			  <div class="rank">7위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${shoesProduct[6].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${shoesImageFileList[6].imageFileName}&productNo=${shoesProduct[6].productNo}&path=product"" alt="7위 상품" id="preview">
			    <h3>${shoesProduct[6].name}</h3>
			    <p>${shoesProduct[6].brand}</p>
			    <fmt:formatNumber value="${shoesProduct[6].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
		    
		    <!-- 8위 상품 -->
		    <div class="product-item" id="allProduct8">
		      <div class="rank">8위</div>
		      <a href="${contextPath }/product/detailProduct.do?productNo=${product[7].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${imageFileList[7].imageFileName}&productNo=${product[7].productNo}&path=product"" alt="8위 상품" id="preview">
			      <h3>${product[7].name}</h3>
			      <p>${product[7].brand}</p>
			      <fmt:formatNumber value="${product[7].price}" pattern="#,##0" var="formattedPrice0"/>
				  <span class="product-price">${formattedPrice0}원</span>
			  </a>
		    </div>
		    
		    <div class="product-item" id="outerProduct8">
			  <div class="rank">8위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${outerProduct[7].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${outerImageFileList[7].imageFileName}&productNo=${outerProduct[7].productNo}&path=product"" alt="8위 상품" id="preview">
			    <h3>${outerProduct[7].name}</h3>
			    <p>${outerProduct[7].brand}</p>
			    <fmt:formatNumber value="${outerProduct[7].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="topProduct8">
			  <div class="rank">8위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${topProduct[7].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${topImageFileList[7].imageFileName}&productNo=${topProduct[7].productNo}&path=product"" alt="8위 상품" id="preview">
			    <h3>${topProduct[7].name}</h3>
			    <p>${topProduct[7].brand}</p>
			    <fmt:formatNumber value="${topProduct[7].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="pantsProduct8">
			  <div class="rank">8위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${pantsProduct[7].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${pantsImageFileList[7].imageFileName}&productNo=${pantsProduct[7].productNo}&path=product"" alt="8위 상품" id="preview">
			    <h3>${pantsProduct[7].name}</h3>
			    <p>${pantsProduct[7].brand}</p>
			    <fmt:formatNumber value="${pantsProduct[7].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="shoesProduct8">
			  <div class="rank">8위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${shoesProduct[7].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${shoesImageFileList[7].imageFileName}&productNo=${shoesProduct[7].productNo}&path=product"" alt="8위 상품" id="preview">
			    <h3>${shoesProduct[7].name}</h3>
			    <p>${shoesProduct[7].brand}</p>
			    <fmt:formatNumber value="${shoesProduct[7].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<!-- 9위 상품 -->
		   <div class="product-item" id="allProduct9">
		      <div class="rank">9위</div>
		      <a href="${contextPath }/product/detailProduct.do?productNo=${product[8].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${imageFileList[8].imageFileName}&productNo=${product[8].productNo}&path=product"" alt="9위 상품" id="preview">
			      <h3>${product[8].name}</h3>
			      <p>${product[8].brand}</p>
			      <fmt:formatNumber value="${product[8].price}" pattern="#,##0" var="formattedPrice0"/>
				  <span class="product-price">${formattedPrice0}원</span>
			  </a>
		    </div>
		    
		    <div class="product-item" id="outerProduct9">
			  <div class="rank">9위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${outerProduct[8].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${outerImageFileList[8].imageFileName}&productNo=${outerProduct[8].productNo}&path=product"" alt="9위 상품" id="preview">
			    <h3>${outerProduct[8].name}</h3>
			    <p>${outerProduct[8].brand}</p>
			    <fmt:formatNumber value="${outerProduct[8].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="topProduct9">
			  <div class="rank">9위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${topProduct[8].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${topImageFileList[8].imageFileName}&productNo=${topProduct[8].productNo}&path=product"" alt="9위 상품" id="preview">
			    <h3>${topProduct[8].name}</h3>
			    <p>${topProduct[8].brand}</p>
			    <fmt:formatNumber value="${topProduct[8].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="pantsProduct9">
			  <div class="rank">9위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${pantsProduct[8].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${pantsImageFileList[8].imageFileName}&productNo=${pantsProduct[8].productNo}&path=product"" alt="9위 상품" id="preview">
			    <h3>${pantsProduct[8].name}</h3>
			    <p>${pantsProduct[8].brand}</p>
			    <fmt:formatNumber value="${pantsProduct[8].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="shoesProduct9">
			  <div class="rank">9위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${shoesProduct[8].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${shoesImageFileList[8].imageFileName}&productNo=${shoesProduct[8].productNo}&path=product"" alt="9위 상품" id="preview">
			    <h3>${shoesProduct[8].name}</h3>
			    <p>${shoesProduct[8].brand}</p>
			    <fmt:formatNumber value="${shoesProduct[8].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<!-- 10위 상품 -->
		    <div class="product-item" id="allProduct10">
		      <div class="rank">10위</div>
		      <a href="${contextPath }/product/detailProduct.do?productNo=${product[9].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${imageFileList[9].imageFileName}&productNo=${product[9].productNo}&path=product"" alt="10위 상품" id="preview">
			      <h3>${product[9].name}</h3>
			      <p>${product[9].brand}</p>
			      <fmt:formatNumber value="${product[9].price}" pattern="#,##0" var="formattedPrice0"/>
				  <span class="product-price">${formattedPrice0}원</span>
			  </a>
		    </div>
		    
		    <div class="product-item" id="outerProduct10">
			  <div class="rank">10위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${outerProduct[9].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${outerImageFileList[9].imageFileName}&productNo=${outerProduct[9].productNo}&path=product"" alt="10위 상품" id="preview">
			    <h3>${outerProduct[9].name}</h3>
			    <p>${outerProduct[9].brand}</p>
			    <fmt:formatNumber value="${outerProduct[9].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="topProduct10">
			  <div class="rank">10위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${topProduct[9].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${topImageFileList[9].imageFileName}&productNo=${topProduct[9].productNo}&path=product"" alt="10위 상품" id="preview">
			    <h3>${topProduct[9].name}</h3>
			    <p>${topProduct[9].brand}</p>
			    <fmt:formatNumber value="${topProduct[9].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="pantsProduct10">
			  <div class="rank">10위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${pantsProduct[9].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${pantsImageFileList[9].imageFileName}&productNo=${pantsProduct[9].productNo}&path=product"" alt="10위 상품" id="preview">
			    <h3>${pantsProduct[9].name}</h3>
			    <p>${pantsProduct[9].brand}</p>
			    <fmt:formatNumber value="${pantsProduct[9].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
			<div class="product-item" id="shoesProduct10">
			  <div class="rank">10위</div>
			  <a href="${contextPath }/product/detailProduct.do?productNo=${shoesProduct[9].productNo}">
			    <img src="${contextPath}/download.do?imageFileName=${shoesImageFileList[9].imageFileName}&productNo=${shoesProduct[9].productNo}&path=product"" alt="10위 상품" id="preview">
			    <h3>${shoesProduct[9].name}</h3>
			    <p>${shoesProduct[9].brand}</p>
			    <fmt:formatNumber value="${shoesProduct[9].price}" pattern="#,##0" var="formattedPrice0"/>
				<span class="product-price">${formattedPrice0}원</span>
			  </a>
			</div>
			
		    </div>
		 </div>    
	  </div>
	 <div>
	 <div class="body2">
	 	<div class="content-area">
		<div class="product-ranking2">
			<div class="main_category_box">
				<h2 class="txt_tit_main">스타일</h2>
				<input type="hidden" name="snap_kind" id="snap_kind" value="staff">
				<span class="txt_detail_link">
					<a href="#" id="snap_all_view">전체</a>
				</span>
				<div class="tool-tabBtn renew-menu-list" id="snap_tab">
				    <a href="javascript:void(0)" class="tab-link" data-value="brandSnap">브랜드 스냅샷</a>
				    <a href="javascript:void(0)" class="tab-link" data-value="streetSnap">스트릿 스냅샷</a>
				</div>
			</div>
			
		    <div class="product-item2" id="product1">
		      <a href="#">
		      	<div id="default_product1">	
			      <a href="${contextPath}/styleall/brandSnapInfo.do?snapNo=${brandSnap[0].snapNo}&brand=${brandSnap[0].brand}">
				    <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${brandSnap[0].snapNo}&path=snap" alt="브랜드 스냅샷 1번" class="brandSmallImage">
				      <div class="snap_info_list">	
					      <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${brandSnap[0].productNo}&path=product" alt="브랜드 스냅샷 1번" class="style_subImage">
					      <div class="snap_info_list2">
						      <h3>${brandSnap[0].productName}</h3>
						      <p>${brandSnap[0].brand}</p>
						      <span class="product-price">${brandSnap[0].price}원</span>
						  </div>    
				      </div>
			     </a>
			    </div>    
		        <div class="street-item" id="street1">
	        	 <a href="${contextPath }/styleall/brandSnapInfo.do?snapNo=${streetSnap[0].snapNo}">
				    <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${streetSnap[0].snapNo}&path=snap" alt="스트릿 스냅샷 1번">
				      <div class="snap_info_list">
				      	  <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${streetSnap[0].productNo}&path=product" alt="스트릿 스냅샷 1번" class="style_subImage">	
						  <div class="snap_info_list2">    
						      <h3>${streetSnap[0].productName}</h3>
						      <p>${streetSnap[0].street}</p>
						      <span class="product-price">${streetSnap[0].price}원</span>
						  </div>    
					  </div>    
				  </a>     
		        </div>
		        <div class="color-item" id="color">
		        	<img src="/shop/resources/image/insta3.png" alt="인스타 3번">
				     <img src="/shop/resources/image/mini3.png" alt=" 3번 작은 상품 이미지">
				     <h3>아웃스텐딩 PCU</h3>
				     <p>HOOD</p>
				     <span class="product-price">125,100원</span>
		        </div>    
		      </a>
		    </div>
		        
		    <div class="product-item2" id="product2">
			    <div id="default_product2">	
			      <a href="${contextPath }/styleall/brandSnapInfo.do?snapNo=${brandSnap[1].snapNo}&brand=${brandSnap[1].brand}">
					    <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${brandSnap[1].snapNo}&path=snap"" alt="브랜드 스냅샷 2번">
					    <div class="snap_info_list">	
					      <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${brandSnap[1].productNo}&path=product" alt="브랜드 스냅샷 2번" class="style_subImage">
					      <div class="snap_info_list2">
						      <h3>${brandSnap[1].productName}</h3>
						      <p>${brandSnap[1].brand}</p>
						      <span class="product-price">${brandSnap[1].price}원</span>
						  </div>    
				      </div>
				   </a>   
				 </div>
				 <div class="street-item" id="street2">
		        	 <a href="${contextPath }/styleall/brandSnapInfo.do?snapNo=${streetSnap[1].snapNo}">
					    <img src="${contextPath}/download.do?imageFileName=${imageFileList5[1].imageFileName}&productNo=${streetSnap[1].snapNo}&path=snap" alt="스트릿 스냅샷 2번">
					      <div class="snap_info_list">
					      	  <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${streetSnap[1].productNo}&path=product" alt="스트릿 스냅샷 2번" class="style_subImage">	
							  <div class="snap_info_list2">    
							      <h3>${streetSnap[1].productName}</h3>
							      <p>${streetSnap[1].street}</p>
							      <span class="product-price">${streetSnap[1].price}원</span>
							  </div>    
						  </div>    
					 </a>     
		        </div>     
		    </div>
		    <div class="product-item2" id="product3">
			    <div id="default_product3">		
			      <a href="${contextPath }/styleall/brandSnapInfo.do?snapNo=${brandSnap[2].snapNo}&brand=${brandSnap[2].brand}">
					    <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${brandSnap[2].snapNo}&path=snap"" alt="브랜드 스냅샷 3번">
					      <div class="snap_info_list">	
						      <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${brandSnap[2].productNo}&path=product" alt="브랜드 스냅샷 3번" class="style_subImage">
						      <div class="snap_info_list2">
							      <h3>${brandSnap[2].productName}</h3>
							      <p>${brandSnap[2].brand}</p>
							      <span class="product-price">${brandSnap[2].price}원</span>
							  </div>    
					      </div>
				      </a>
				</div>
				<div class="street-item" id="street3">
	        	 <a href="${contextPath }/styleall/brandSnapInfo.do?snapNo=${streetSnap[2].snapNo}">
				    <img src="${contextPath}/download.do?imageFileName=${imageFileList5[2].imageFileName}&productNo=${streetSnap[2].snapNo}&path=snap" alt="스트릿 스냅샷 3번">
				      <div class="snap_info_list">
				      	  <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${streetSnap[2].productNo}&path=product" alt="스트릿 스냅샷 3번" class="style_subImage">	
						  <div class="snap_info_list2">    
						      <h3>${streetSnap[2].productName}</h3>
						      <p>${streetSnap[2].street}</p>
						      <span class="product-price">${streetSnap[2].price}원</span>
						  </div>    
					  </div>    
				 </a>     
		        </div>      
		    </div>
		    <div class="product-item2" id="product4">		      
		      <div id="default_product4">		
			      <a href="${contextPath }/styleall/brandSnapInfo.do?snapNo=${brandSnap[3].snapNo}&brand=${brandSnap[3].brand}">
					    <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${brandSnap[3].snapNo}&path=snap" alt="브랜드 스냅샷 4번">
					      
					      <div class="snap_info_list">	
						      <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${brandSnap[3].productNo}&path=product" alt="브랜드 스냅샷 4번" class="style_subImage">
						      <div class="snap_info_list2">
							      <h3>${brandSnap[3].productName}</h3>
							      <p>${brandSnap[3].brand}</p>
							      <span class="product-price">${brandSnap[3].price}원</span>
							  </div>    
					      </div>
				      </a>
				</div>
				<div class="street-item" id="street4">
	        	 <a href="${contextPath }/styleall/brandSnapInfo.do?snapNo=${streetSnap[3].snapNo}">
				    <img src="${contextPath}/download.do?imageFileName=${imageFileList5[3].imageFileName}&productNo=${streetSnap[3].snapNo}&path=snap"" alt="스트릿 스냅샷 4번">
				      <div class="snap_info_list">
				      	  <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${streetSnap[3].productNo}&path=product" alt="스트릿 스냅샷 4번" class="style_subImage">	
						  <div class="snap_info_list2">    
						      <h3>${streetSnap[3].productName}</h3>
						      <p>${streetSnap[3].street}</p>
						      <span class="product-price">${streetSnap[3].price}원</span>
						  </div>    
					  </div>    
				 </a>     
		        </div>  
		    </div>
		    </div>
		 </div> 
	 </div>
	</div>
	
		<div class="body3">
			<div class="main_category_box">
				<h2 class="txt_tit_main">매거진</h2>
				<input type="hidden" name="magazine_kind" id="magazine_kind" value="staff">
				<span class="txt_detail_link">
					<a href="#" id="magazine_all_view">전체</a>
				</span>
				<div class="tool-tabBtn renew-menu-list" id="snap_tab">
				    <a href="javascript:void(0)" class="tab-link-magazine" data-value="pictorialList">화보</a>
				    <a href="javascript:void(0)" class="tab-link-magazine" data-value="lookbookList">룩북</a>
				</div>
			</div>
		
		
			<div class="content-area">
				<div class="carousel-container">
					<div class="carousel-slide">
						<!-- 슬라이드 -->
						<div class="carousel-item pictorial">
							<a href ="${contextPath }/magazine/pictorialInfo.do?magazineNo=${pictorialImage[0].magazineNo}">
								<img src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${pictorialImage[0].magazineNo}&path=pictorial" alt="화보 1">
								<div class="carousel-caption">${pictorialImage[0].title}</div>
							</a>
						</div>
						<div class="carousel-item pictorial">
							<a href ="${contextPath }/magazine/pictorialInfo.do?magazineNo=${pictorialImage[1].magazineNo}">
								<img src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${pictorialImage[1].magazineNo}&path=pictorial" alt="화보 2">
								<div class="carousel-caption">${pictorialImage[1].title}</div>
							</a>	
						</div>
						<div class="carousel-item pictorial">
							<a href ="${contextPath }/magazine/pictorialInfo.do?magazineNo=${pictorialImage[2].magazineNo}">
								<img src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${pictorialImage[2].magazineNo}&path=pictorial" alt="화보 3">
								<div class="carousel-caption">${pictorialImage[2].title}</div>
							</a>
						</div>
						<div class="carousel-item pictorial">
							<a href ="${contextPath }/magazine/pictorialInfo.do?magazineNo=${pictorialImage[3].magazineNo}">
								<img src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${pictorialImage[3].magazineNo}&path=pictorial" alt="화보 4">
								<div class="carousel-caption">${pictorialImage[3].title}</div>
							</a>	
						</div>
						<div class="carousel-item pictorial">
							<a href ="${contextPath }/magazine/pictorialInfo.do?magazineNo=${pictorialImage[4].magazineNo}">
								<img src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${pictorialImage[4].magazineNo}&path=pictorial" alt="화보 1">
								<div class="carousel-caption">${pictorialImage[4].title}</div>
							</a>	
						</div>
						
						
						
						<div class="carousel-item lookbook">
							<a href ="${contextPath }/magazine/lookbookInfo.do?magazineNo=${lookbookImage[0].magazineNo}">
								<img src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${lookbookImage[0].magazineNo}&path=lookbook" alt="룩북 1">
								<div class="carousel-caption">${lookbookImage[0].title}</div>
							</a>	
						</div>
						<div class="carousel-item lookbook">
							<a href ="${contextPath }/magazine/lookbookInfo.do?magazineNo=${lookbookImage[1].magazineNo}">
								<img src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${lookbookImage[1].magazineNo}&path=lookbook" alt="룩북 2">
								<div class="carousel-caption">${lookbookImage[1].title}</div>
							</a>	
						</div>
						<div class="carousel-item lookbook">
							<a href ="${contextPath }/magazine/lookbookInfo.do?magazineNo=${lookbookImage[2].magazineNo}">
								<img src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${lookbookImage[2].magazineNo}&path=lookbook" alt="룩북 3">
								<div class="carousel-caption">${lookbookImage[2].title}</div>
							</a>	
						</div>
						<div class="carousel-item lookbook">
							<a href ="${contextPath }/magazine/lookbookInfo.do?magazineNo=${lookbookImage[3].magazineNo}">
								<img src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${lookbookImage[3].magazineNo}&path=lookbook" alt="룩북 4">
								<div class="carousel-caption">${lookbookImage[3].title}</div>
							</a>	
						</div>
						<div class="carousel-item lookbook">
							<a href ="${contextPath }/magazine/lookbookInfo.do?magazineNo=${lookbookImage[4].magazineNo}">
								<img src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${lookbookImage[4].magazineNo}&path=lookbook" alt="룩북 5">
								<div class="carousel-caption">${lookbookImage[4].title}</div>
							</a>	
						</div>
					</div>
					<button class="prev-btn"><span class="arrow">❮</span></button>
					<button class="next-btn"><span class="arrow">❯</span></button>
				</div>
			</div>
		</div>
	
<script>
	// 글자수 제한 함수
	function truncateString(str, num) {
	  if (str.length > num) {
	    return str.slice(0, num) + "...";
	  } else {
	    return str;
	  }
	}
	
	// 상품, 화보, 룩북 및 기타 요소의 name, brand, street 등을 수정하는 함수
	function truncateDetails() {
	  // 상품 정보 수정
	  var productItems = document.querySelectorAll('.product-item, .product-item2, .street-item');
	  productItems.forEach(function(item) {
	    var brand = item.querySelector('p'); // brand 또는 street 위치
	    var name = item.querySelector('h3'); // name 위치
	     
	    
	    // 글자수 제한 적용
	    if(brand) brand.innerText = truncateString(brand.innerText, 8);
	    if(name) name.innerText = truncateString(name.innerText, 5);
	    
	  });
	  
	  // 화보 및 룩북 타이틀 수정 (이전 단계에서 추가된 코드)
	  var carouselItems = document.querySelectorAll('.carousel-caption');
	  carouselItems.forEach(function(item) {
	    // 글자수 제한 적용
	    item.innerText = truncateString(item.innerText, 24);
	  });
	}
	
	// 페이지 로드 시 함수 호출
	document.addEventListener('DOMContentLoaded', truncateDetails);
</script>
	 
	  
</body>
