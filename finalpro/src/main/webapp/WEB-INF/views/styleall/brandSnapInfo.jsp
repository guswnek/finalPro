<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>스냅샷 상세 페이지</title>
</head>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var="brandSnap2" value="${brandSnapMap.brandSnap2 }" />
<c:set var="imageFileList4" value="${brandSnapMap.imageFileList4 }" />
<c:set var="brandSnapTag" value="${brandSnapMap.tagDTO }" />
<c:set var="brandImage" value="${brandSnapMap.brandImage }" />

<c:set var="brandSnapProduct" value="${brandSnapMap.brandSnapDTO3 }" />
<c:set var="brandSnapProductImageList" value="${brandSnapMap.brandSnapProductImageList }" />


<c:set var="brand" value="${brandSnapMap.brandSnapDTO4 }" />
<c:set var="brandImageList" value="${brandSnapMap.brandImageList }" />

<link rel="stylesheet" href="/finalpro/resources/css/brandSnapInfo.css">

<script>
function changeImage(element) {
  // 이전에 선택된 요소의 테두리 스타일 제거
  var previouslySelected = document.querySelector('.product_second_image .image-hover');
  if (previouslySelected) {
    previouslySelected.classList.remove('image-hover');
  }

  // 현재 요소에 테두리 스타일 추가
  element.classList.add('image-hover');

  // 메인 이미지 변경
  var mainImage = document.getElementById('mainImage');
  var newSrc = element.children[0].src; // element의 첫 번째 자식 요소인 img 태그의 src를 가져옵니다.
  mainImage.src = newSrc;
}

function resetImage() {
  var mainImage = document.getElementById('mainImage');
  mainImage.src = "${contextPath}/download.do?imageFileName=1.jpg&productNo=${dto.productNo}&path=";
}
</script>	

<script>
document.addEventListener('DOMContentLoaded', function () {
    // 서버로부터 받은 데이터를 JavaScript 변수에 할당
    // 예: var brandSnapTagString = "태그1,태그2,태그3";
    var brandSnapTagString = "${brandSnapTag[0].tag}"; // 서버 측 데이터

    // 쉼표로 구분된 문자열을 배열로 변환
    var brandSnapTags = brandSnapTagString.split(',');

    // 태그 컨테이너 선택
    var tagContainer = document.getElementById('tagContainer');

    // 배열의 각 요소(태그)에 대해 버튼 생성
    brandSnapTags.forEach(function(tag) {
        var button = document.createElement('button');
        button.className = 'tag-button';
        button.textContent = tag.trim(); // 공백 제거
        button.onclick = function() { tagClicked(tag.trim()); };
        tagContainer.appendChild(button);
    });
});

</script>



<script type="text/javascript">
function tagClicked(tag) {
    // 키워드 값을 쿼리 파라미터로 포함하여 URL을 구성합니다.
    var searchUrl = '/finalpro/product/searchList.do?keyword=' + (tag);
    // 해당 URL로 페이지를 리다이렉트합니다.
    window.location.href = searchUrl;
}
</script>






<body>
	
	<div class="title">
	    <c:choose>
	        <c:when test="${ empty brandSnap2.street}">
	            <h1>BrandSnap</h1>
	        </c:when>
	        <c:when test="${not empty brandSnap2.street}">
	            <h1>StreetSnap</h1>
	        </c:when>
	    </c:choose>
	</div>

	
    	<div class="title_box">
    		<div class="tool-tabBtn">
    			<a href="${contextPath }/styleall/brandSnap.do" class="plain-btn btn">브랜드 스냅</a>
    			<a href="${contextPath }/styleall/streetSnap.do" class="plain-btn btn">스트릿 스냅</a>
    		</div>
    	</div>
	    	
	 <c:if test="${ empty brandSnap2.street}">	
	    <div class="snap-detail-container">
		   
		        <div class="image-wrapper"> 
			      <div class="snap-detail-image">
			        <img id="mainImage" src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${brandSnap2.snapNo}&path=snap" alt="${brandSnap2.name}">
			      </div>
			      <div class="product_second_image">
					  <ul class="product_second_image" style="list-style: none;">
					    <c:forEach var="image" items="${imageFileList4}">
					      <li onmouseover="changeImage(this)">
					        <img src="${contextPath}/download.do?imageFileName=${image.imageFileName}&productNo=${brandSnap2.snapNo}&path=snap" alt="상품 썸네일">
					      </li>
					    </c:forEach>
					  </ul>
					</div>
			    </div>
		        <div class="snap-detail-info">
		        	<h3 class="info-title">
				        Information
				        <span class="style-info">스타일 정보</span>
				    </h3>
				    <div class="info-brand">
				        <span class="info-label">브랜드:</span>
				        <p class="snap-brand">${brandSnap2.brand}</p>
				    </div>
				    <div class="info-name">
				        <span class="info-label">이름:</span>
				        <p class="snap-name">${brandSnap2.name}</p>
				    </div>
				    <div class="info-job">
				        <span class="info-label">직업:</span>
				        <p class="snap-job">${brandSnap2.job}</p>
				    </div>
				    <div class="info-height">
				        <span class="info-label">키:</span>
				        <p class="snap-height">${brandSnap2.height}</p>
				    </div>
				    <div class="info-weight">
				        <span class="info-label">몸무게:</span>
				        <p class="snap-weight">${brandSnap2.weight}</p>
				    </div>
				    <div class="info-viewcount">
				        <span class="info-label">조회수:</span>
				        <p class="snap-count">${brandSnap2.viewCount}</p>
				    </div>
				    <!-- 나중에 클릭되면 해당 태그가 검색될 수 있게 자바스크립트 만들어야 됨 -->
				    <div class="info-tag">
					    <span class="info-label-tag">태그:</span>
					    <div id="tagContainer"></div>
					</div>
					
					
					<div class="brand-introduce">
					    <div class="brand-header">
					        <h3>Brand</h3>
					        <span class="info-label">브랜드</span>
					    </div>
					    <img src="${contextPath}/download.do?imageFileName=2.jpg&productNo=${brandImage[0].brand}&path=brand" id="preview">
					    <span>${brandImage[0].introduce}</span>
					</div>

		        </div>
		        
		</div>
		
		
		<!-- 관련 상품 구역 -->
		
		<h3>관련상품</h3>
		<div class="productList">
		    <c:forEach var="product" items="${brandSnapProduct}" varStatus="status">
		        <div id="brandSnapProduct${status.index + 1}">
		            <a href="${contextPath}/product/detailProduct.do?productNo=${product.productNo}">
		                <img src="${contextPath}/download.do?imageFileName=${brandSnapProductImageList[status.index].imageFileName}&productNo=${product.productNo}&path=product" alt="인스타 ${status.index + 1}번">
		                <h3>${product.name}</h3>
		                <p>${product.brand}</p>
		                <div class="stars-background">
						    <div class="star-rating">
						        <div class="filled-stars" style="width: ${product.averageStarScore / 5 * 100}%;">★★★★★</div>
						        <div class="empty-stars">★★★★★</div>
						    </div>
						    <span class="review-count">${product.reviewCount}</span>
						</div>
		                <%-- <p>${product.likeCount}</p> --%>
		                <fmt:formatNumber value="${product.price}" pattern="#,##0" var="formattedPrice"/>
	            		<span class="product-price">${formattedPrice}원</span>
		            </a>
		        </div>
		    </c:forEach>
		</div>

		<!-- 해당 브랜드 다른 브랜드 스냅샷 구역 -->
		
		<h3>${brandSnap2.brand } 스타일</h3>
		<div id="brandStyle">
		    <c:forEach var="brandItem" items="${brand}" varStatus="status">
		        <c:if test="${brandItem.snapNo ne brandSnap2.snapNo}">
		            <div id="brandSnapStyle${status.index}">
		                <a href="${contextPath}/styleall/brandSnapInfo.do?snapNo=${brandItem.snapNo}&productNo=${brandItem.productNo}&brand=${brandItem.brand}">  
		                    <img src="${contextPath}/download.do?imageFileName=${brandImageList[status.index].imageFileName}&productNo=${brandItem.snapNo}&path=snap">
		                    <p>${brandItem.brand}</p>
		                    <h3>${brandItem.name}</h3>
		                    <p>${brandItem.viewCount}</p>
		                </a>    
		            </div>
		        </c:if>
		    </c:forEach>
		</div>

	</c:if>
	
	
	<!-- 스트릿 스냅샷 상세페이지 street 값이 있을 때만 나옴 -->

    <c:if test="${not empty brandSnap2.street}">

       <div class="snap-detail-container">
		   
		        <div class="image-wrapper"> 
			      <div class="snap-detail-image">
			        <img id="mainImage" src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${brandSnap2.snapNo}&path=snap" alt="${brandSnap2.name}">
			      </div>
			       <div class="product_second_image">
					  <ul>
					    <c:forEach var="image" items="${imageFileList4}">
					      <li onmouseover="changeImage(this)">
					        <img src="${contextPath}/download.do?imageFileName=${image.imageFileName}&productNo=${brandSnap2.snapNo}&path=snap" alt="상품 썸네일">
					      </li>
					    </c:forEach>
					  </ul>
					</div> 
			    </div>
		        <div class="snap-detail-info">
		        	<h3 class="info-title">
				        Information
				        <span class="style-info">스타일 정보</span>
				    </h3>
				    <div class="info-name">
				        <span class="info-label">이름:</span>
				        <p class="snap-name">${brandSnap2.name}</p>
				    </div>
				    <div class="info-street">
				        <span class="info-label">촬영지역:</span>
				        <p class="snap-street">${brandSnap2.street}</p>
				    </div>
				    <div class="info-job">
				        <span class="info-label">직업:</span>
				        <p class="snap-job">${brandSnap2.job}</p>
				    </div>
				   <div class="info-height">
					    <span class="info-label">키:</span>
					    <p class="snap-height">
					        <c:choose>
					            <c:when test="${brandSnap2.height == null || brandSnap2.height == 0}">
					                비공개
					            </c:when>
					            <c:otherwise>
					                ${brandSnap2.height}
					            </c:otherwise>
					        </c:choose>
					    </p>
					</div>
					<div class="info-weight">
					    <span class="info-label">몸무게:</span>
					    <p class="snap-weight">
					        <c:choose>
					            <c:when test="${brandSnap2.weight == null || brandSnap2.weight == 0}">
					                비공개
					            </c:when>
					            <c:otherwise>
					                ${brandSnap2.weight}
					            </c:otherwise>
					        </c:choose>
					    </p>
					</div>

				    <div class="info-viewcount">
				        <span class="info-label">조회수:</span>
				        <p class="snap-count">${brandSnap2.viewCount}</p>
				    </div>
				    <!-- 나중에 클릭되면 해당 태그가 검색될 수 있게 자바스크립트 만들어야 됨 -->
				     <div class="info-tag">
					    <span class="info-label-tag">태그:</span>
					    <div id="tagContainer"></div>
					</div>
					
					
					<div class="street-introduce">
					    <div class="brand-header">
					        <h3>Reporter</h3>
					    </div>
					    <div class="street-introduce2">
					        <img src="/finalpro/resources/image/repoter.png" id="repoterImage"> 
					        <div class="text-container"> <!-- 여기에 새로운 div를 추가 -->
					            <p>김재현</p>
					            <span>스타일이란 무엇일까요?</span>
					        </div>
					    </div>
					</div>
					
		        </div>
		</div>
		
		
		<div class="paginationSnap"></div>
		
		<h3>비슷한 스타일 상품</h3>
		<div class="productList">
		    <c:forEach var="product" items="${brandSnapProduct}" varStatus="status">
		        <div id="brandSnapProduct${status.index + 1}"> 
		            <a href="${contextPath}/product/detailProduct.do?productNo=${product.productNo}">
		                <img src="${contextPath}/download.do?imageFileName=${brandSnapProductImageList[status.index].imageFileName}&productNo=${product.productNo}&path=product" alt="인스타 ${status.index + 1}번">
		                <h3>${product.name}</h3>
		                <p>${product.brand}</p>
		                <div class="stars-background">
						    <div class="star-rating">
						        <div class="filled-stars" style="width: ${product.averageStarScore / 5 * 100}%;">★★★★★</div>
						        <div class="empty-stars">★★★★★</div>
						    </div>
						    <span class="review-count">${product.reviewCount}</span>
						</div>
		                <%-- <p>${product.likeCount}</p> --%>
		                <fmt:formatNumber value="${product.price}" pattern="#,##0" var="formattedPrice"/>
	            		<span class="product-price">${formattedPrice}원</span>
		            </a>
		        </div>
		    </c:forEach>
		</div>
    </c:if>
    
    
    
    

    
</body>
</html>
