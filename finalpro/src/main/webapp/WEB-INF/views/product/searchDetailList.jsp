<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var = "contextPath" value="${pageContext.request.contextPath}" />

<link rel="stylesheet" href="/finalpro/resources/css/brand.css">

<script>

	var currentPage = 1;
	var itemsPerPage = 20;   
	
	function goToPage(pageNum) {
	    currentPage = pageNum;
	    updateItemsDisplay();
	}
	
	function nextPage() {
	    var allItems = document.querySelectorAll('.li_box');
	    var totalPages = Math.ceil(allItems.length / itemsPerPage);
	    if (currentPage < totalPages) {
	        currentPage++;
	        updateItemsDisplay();
	    }
	}
	
	function previousPage() {
	    if (currentPage > 1) {
	        currentPage--;
	        updateItemsDisplay();
	    }
	}
	
	document.addEventListener('DOMContentLoaded', function() {
	    updateItemsDisplay();
	});
</script>

<script>

//페이지네이션 버튼을 동적으로 생성하는 함수
function createPaginationButtons() {
    var paginationContainer = document.querySelector('.paginationSnap');
    var totalItems = document.querySelectorAll('.li_box').length;
    var totalPages = Math.ceil(totalItems / itemsPerPage);

    // 기존 페이지네이션 버튼을 모두 제거합니다.
    paginationContainer.innerHTML = '';

 // 맨 처음 페이지로 이동하는 버튼 추가
    if (currentPage > 1) {
        let firstPageButton = document.createElement('button');
        firstPageButton.className = 'pagination_button';
        firstPageButton.innerText = '<<';
        firstPageButton.addEventListener('click', firstPage);
        paginationContainer.appendChild(firstPageButton);
    }

    if (currentPage > 1) {
        let prevButton = document.createElement('button');
        prevButton.className = 'pagination_button';
        prevButton.innerText = '<';
        prevButton.addEventListener('click', previousPage);
        paginationContainer.appendChild(prevButton);
    }

    for (let i = 1; i <= totalPages; i++) {
        let button = document.createElement('button');
        button.className = 'pagination_button';
        button.innerText = i;
        if (i == currentPage) {
            button.classList.add('active');
        }
        button.addEventListener('click', function() {
            goToPage(i);
        });
        paginationContainer.appendChild(button);
    }

    if (currentPage < totalPages) {
        let nextButton = document.createElement('button');
        nextButton.className = 'pagination_button';
        nextButton.innerText = '>';
        nextButton.addEventListener('click', nextPage);
        paginationContainer.appendChild(nextButton);
    }

    // 맨 끝 페이지로 이동하는 버튼 추가
    if (currentPage < totalPages) {
        let lastPageButton = document.createElement('button');
        lastPageButton.className = 'pagination_button';
        lastPageButton.innerText = '>>';
        lastPageButton.addEventListener('click', function() {
            lastPage(totalPages);
        });
        paginationContainer.appendChild(lastPageButton);
    }
}

	function firstPage() {
	    currentPage = 1;
	    updateItemsDisplay();
	}
	
	function lastPage(totalPages) {
	    currentPage = totalPages;
	    updateItemsDisplay();
	}

	document.addEventListener('DOMContentLoaded', function() {
	    updateItemsDisplay(); // 아이템을 업데이트하는 함수
	    createPaginationButtons(); // 페이지네이션 버튼을 생성하는 함수
	});
	
	function updateItemsDisplay() {
	    var allItems = document.querySelectorAll('.li_box');
	    var startItem = (currentPage - 1) * itemsPerPage;
	    var endItem = startItem + itemsPerPage;
	
	    allItems.forEach(function(item, index) {
	        if (index >= startItem && index < endItem) {
	            item.style.display = ''; // 현재 페이지 아이템만 보여주기
	        } else {
	            item.style.display = 'none'; // 다른 페이지 아이템 숨기기
	        }
	    });
	
	    createPaginationButtons(); // 페이지네이션 버튼 업데이트
}
</script>

<style>

	.nav_sub a, .nav_sub span{
		font-size: 14px;
		color: gray;
	}
	
	.nav_sub {
		margin: 20px 0;
	}
	
	.n-search-result {
		margin: 20px 0;
	}
	
	.n-search-result span {
		color: #CD0000;
	}
	
	h3.subTitle {
		margin: 20px 40px;
	}
	
	.n-search-nav {
    	margin: 30px 0 15px 18px;
    }
    
    .menu {
    	font-size: 16px;
    	margin: 0 0 10px 25px;
    	font-weight: bold;
    	color: #aaaaaa;
    }
    
    .menu:hover, .menu1 {
    	color: black;
    	font-size: 16px;
    	margin: 0 0 10px 25px;
    	font-weight: bold;
    }
    
    hr {
    	width: 90%;
    	margin: 0 0 0 20px;
    	
    }
    
    #searchList {
        display: flex;
        flex-wrap: wrap;
        list-style: none;
        padding: 0;
        margin: 0 0 0 15px;
    }
    
    .li_box {
        width: calc(20% - 50px);
        border: 1px solid #aaaaaa;
        margin: 0 0 25px 25px;
        padding: 20px;
        font-size: 14px;
    }
    
    .listBox {
    	overflow: hidden;
    }
    
    img {
    	text-align: center;
    }
    
    /* 별점 */
	.star-rating {
	    position: relative;
	    display: inline-block;
	    font-size: 12px; /* 별의 크기를 조절 */
	    color: transparent;
	}
	
	.filled-stars {
	    position: absolute;
	    top: 0;
	    left: 0;
	    white-space: nowrap;
	    overflow: hidden;
	    color: #f5a623; /* 색칠된 별의 색상 */
	}
	
	.empty-stars {
	    display: block;
	    white-space: nowrap;
	    color: #ccc; /* 빈 별의 색상 */
	}
	
	.stars-background {
	    display: flex;
	    align-items: center;
	}
	
	.review-count {
	    color: #f5a623; 
	    margin-left: 8px;
	    margin-top: 5px;
	    font-size: 12px; 
	}
	
	.subMenuItems {
		display: flex;
		margin: 10px;
		padding: 5px 5px 5px 29px;
	}
	
	.subMenu {
		font-size: 13px;
		background-color: white;
	    border: 1px solid #ccc;
	    padding: 5px 13px;
	    margin-right: 7px;
	}
	
    .subMenu:hover, .subMenu1 {
    	font-size: 13px;
		background-color: #e9e9e9;
	    border: 1px solid #ccc;
	    padding: 5px 13px;
	    margin-right: 7px;
    }
    
    .snapItems, .magazineItems {
		margin: 0 0 0 12px;
		display: flex;
        flex-wrap: wrap;
        list-style: none;
        padding: 0;
        margin: 20px 0 0 25px;
	}
	
	.snapItem, .magazineItem {
		width: calc(25% - 45px);
        border: 1px solid #aaaaaa;
        margin: 0 0 25px 15px;
        padding: 10px;
        font-size: 14px;
        overflow: hidden;
	}
	
	p.noItem {
   		display: flex;
        justify-content: center;
        align-items: center;
        height: 200px; /* 필요에 따라 높이 조정 */
        font-size: 18px;
        font-weight: bold;
        width: 100%;
   }
   
   .paginationSnap {
   		display: flex;
        justify-content: center;
        margin-top: 20px; /* 필요에 따라 여백 조정 */
   }
   
   /* 별점 */
	.star-rating {
	    position: relative;
	    display: inline-block;
	    font-size: 12px; /* 별의 크기를 조절 */
	    color: transparent;
	}
	
	.filled-stars {
	    position: absolute;
	    top: 0;
	    left: 0;
	    white-space: nowrap;
	    overflow: hidden;
	    color: #f5a623; /* 색칠된 별의 색상 */
	}
	
	.empty-stars {
	    display: block;
	    white-space: nowrap;
	    color: #ccc; /* 빈 별의 색상 */
	}
	
	.stars-background {
	    display: flex;
	    align-items: center;
	}
	
	.review-count {
	    color: #f5a623; 
	    margin-left: 8px;
	    margin-top: 5px;
	    font-size: 12px; 
	}
	
</style>

<body>
	
	<div class="pagenation">
	    <div class="nav_sub">
	        <a href="${contextPath }/main.do">STORE</a>
	        
	        <c:if test="${category == 'product'}">
	        	<span class="icon_entity">&gt;</span><span> 상품</span>
	        </c:if>
	        <c:if test="${category == 'snap'}">
	        	<span class="icon_entity">&gt;</span><span> 스냅</span>
	        </c:if>
	        <c:if test="${category == 'magazine'}">
	        	<span class="icon_entity">&gt;</span><span> 매거진</span>
	        </c:if>
	        
	    </div>
	</div>
        
	<h2 class="n-search-result">
            	<span>'${keyword }'</span>에 대한 검색결과
    </h2>

	<nav class="n-search-nav">
		<c:choose>
			<c:when test = "${fn:contains(keyword, '#') }">
				<a class = "menu" href="${contextPath}/product/searchList.do?keyword=${fn:replace(keyword, '#', '%23')}">통합</a>
			</c:when>
			<c:otherwise>
				<a class = "menu"  href="${contextPath }/product/searchList.do?keyword=${keyword}">통합</a>				
			</c:otherwise>
		</c:choose>
		
		<c:choose>
            <c:when test = "${fn:contains(keyword, '#') }">
				<a class = "menu"  href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=product">상품</a>
			</c:when>
			<c:otherwise>
				<a class = "menu"  href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=product">상품</a>				
			</c:otherwise>
		</c:choose>
		
		<c:choose>	
               <c:when test = "${fn:contains(keyword, '#') }">
				<a class = "menu"  href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=snap">스냅</a>
			</c:when>
			<c:otherwise>
				<a class = "menu"  href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=snap">스냅</a>				
			</c:otherwise>
		</c:choose>
		
		<c:choose>
               <c:when test = "${fn:contains(keyword, '#') }">
				<a class = "menu" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=magazine">매거진</a>
			</c:when>
			<c:otherwise>
				<a class = "menu" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=magazine">매거진</a>				
			</c:otherwise>
		</c:choose>				
    </nav>
	<hr>

	<!-- 상품 이동  -->
	<c:if test="${category == 'product'}">
		<div>
			<ul class = "subMenuItems">
				<li><!-- 상품 정렬 : 추천순 -->
					<c:choose>
						<c:when test="${fn:contains(keyword, '#') }">
							<a class = "subMenu" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=product">추천순 </a>
						</c:when>
						<c:otherwise>
							<a class = "subMenu" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=product">추천순 </a>
						</c:otherwise>
					</c:choose>
				</li>
				<li><!-- 상품 정렬 : 높은 가격순 -->
					<c:choose>
						<c:when test="${fn:contains(keyword, '#') }">
							<a class = "subMenu" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=product&orderBy=highPrice">높은 가격순</a>
						</c:when>
						<c:otherwise>
							<a class = "subMenu" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=product&orderBy=highPrice">높은 가격순</a>
						</c:otherwise>
					</c:choose>
				</li>
				<li><!-- 상품 정렬 : 낮은 가격순 -->
					<c:choose>
						<c:when test="${fn:contains(keyword, '#') }">
							<a class = "subMenu" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=product&orderBy=lowPrice">낮은 가격순</a>
						</c:when>
						<c:otherwise>
							<a class = "subMenu" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=product&orderBy=lowPrice">낮은 가격순</a>
						</c:otherwise>
					</c:choose>
				</li>
				<li><!-- 상품 정렬 : 별점순 -->
					<c:choose>
						<c:when test="${fn:contains(keyword, '#') }">
							<a class = "subMenu" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=product&orderBy=starscore">별점순</a>
						</c:when>
						<c:otherwise>
							<a class = "subMenu" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=product&orderBy=starscore">별점순</a>
						</c:otherwise>
					</c:choose>
				</li>
				<li><!-- 상품 정렬 : 후기순 -->
					<c:choose>
						<c:when test="${fn:contains(keyword, '#') }">
							<a class = "subMenu" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=product&orderBy=reviewCount">후기순</a>
						</c:when>
						<c:otherwise>
							<a class = "subMenu" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=product&orderBy=reviewCount">후기순</a>
						</c:otherwise>
					</c:choose>
				</li>
			</ul>
		</div>
	
		<!-- 상품 출력 -->
		<div class="list-box">
			<ul id="searchList">
				<c:choose>
					<c:when test = "${searchProductList != null && searchProductList.size() != 0 }">
						<c:forEach var="product" items="${searchProductList}">
							<c:if test="${product.productNo != null}">
								<li class="li_box">
									<a href="${contextPath }/product/detailProduct.do?productNo=${product.productNo}"> 
										<img width="145" height="160" src="${contextPath }/download.do?imageFileName=${product.imageFileName}&productNo=${product.productNo}&path=product"
											alt="${product.name }">
										<div class="article_info">
											<p class="item_title">
												<a href="${contextPath }/brand/brandList.do?brand=${product.brand}"><b>${product.brand }</b></a>
											</p>
											<p class="list_info">
												<a href="${contextPath }/product/detailProduct.do?productNo=${product.productNo}"><b>${product.name }</b></a>
											</p>
											<p class="price"><fmt:formatNumber type="number" maxFractionDigits="3" value="${product.price }" />원</p>
											 <div class="stars-background">
							                   <div class="star-rating">
							                       <div class="filled-stars" style="width: ${product.starScore / 5 * 100}%;">★★★★★</div>
							                       <div class="empty-stars">★★★★★</div>
							                   </div>
							                   <span class="review-count">${product.reviewCount}</span>
							               </div>
										</div>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<p class = "noItem">검색한 상품이 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</ul>
			<div class = "paginationSnap"></div>
		</div>
	</c:if>
	
	<!-- 스냅 -->
	<c:if test = "${category == 'snap' }" >
		<div>
			<ul class = "subMenuItems">
				<li class = "subMenuItem"><!-- 스냅 정렬 : 추천순 -->
					<c:choose>
						<c:when test="${fn:contains(keyword, '#') }">
							<a class = "subMenu" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=snap">추천순</a>
						</c:when>
						<c:otherwise>
							<a class = "subMenu" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=snap">추천순</a>
						</c:otherwise>
					</c:choose>
				</li>
				<li><!-- 스냅 정렬 : 최신순 -->
					<c:choose>
						<c:when test="${fn:contains(keyword, '#') }">
							<a class = "subMenu" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=snap&orderBy=newest">최신순</a>
						</c:when>
						<c:otherwise>
							<a class = "subMenu" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=snap&orderBy=newest">최신순</a>
						</c:otherwise>
					</c:choose>
				</li>
				<li><!-- 스냅 정렬 : 오래된순 -->
					<c:choose>
						<c:when test="${fn:contains(keyword, '#') }">
							<a class = "subMenu" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=snap&orderBy=oldest">오래된순</a>
						</c:when>
						<c:otherwise>
							<a class = "subMenu" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=snap&orderBy=oldest">오래된순</a>
						</c:otherwise>
					</c:choose>
				</li>
			</ul>
		</div>
		
		<!-- 스냅 출력 -->
		<div>
			<ul class = "snapItems">
				<c:choose>
					<c:when test = "${searchSnapList != null && searchSnapList.size() != 0 }">
						<c:forEach var="snap" items="${searchSnapList }">
								<c:if test = "${snap.snapNo != null }" >
			                       <li class = "snapItem li_box">
			                           <a href="${contextPath }/styleall/brandSnapInfo.do?snapNo=${snap.snapNo }&brand=${snap.brand}">
			                               <div class="result-img">
			                                   <img width="228px" height = "280px" src="${contextPath }/download.do?imageFileName=${snap.snapImageFileName}&productNo=${snap.snapNo}&path=snap" alt = "${snap.brand }">
			                               </div>
			                               <c:if test = "${fn:contains(snap.snapNo, 'b')}">
				                               <span>브랜드스냅</span><br>
				                           </c:if>
				                           <c:if test = "${fn:contains(snap.snapNo, 's')}">
				                               <span>스트릿스냅</span><br>
				                           </c:if>
				                           <strong>${snap.modelName }</strong>
				                           <p class="result-date">${snap.snapRegDate }</p>
			                           </a>
			                       </li>
			                    </c:if>
		                </c:forEach>
		        	</c:when>
		        	<c:otherwise>
		        		<p class = "noItem">검색한 스냅이 없습니다.</p>
		        	</c:otherwise>
                </c:choose>	
			</ul>
			<div class = "paginationSnap"></div>
		</div>
	</c:if>

	<!-- 매거진 출력 -->
	<c:if test="${category == 'magazine' }">
		<div>
			<ul class = "subMenuItems">
				<li class = "subMenuItem"><!-- 매거진 정렬 : 추천순 -->
					<c:choose>
						<c:when test="${fn:contains(keyword, '#') }">
							<a class = "subMenu" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=magazine">추천순</a>
						</c:when>
						<c:otherwise>
							<a class = "subMenu" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=magazine">추천순</a>
						</c:otherwise>
					</c:choose>
				</li>
				<li><!-- 매거진 정렬 : 최신순 -->
					<c:choose>
						<c:when test="${fn:contains(keyword, '#') }">
							<a class = "subMenu" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=magazine&orderBy=newest">최신순</a>
						</c:when>
						<c:otherwise>
							<a class = "subMenu" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=magazine&orderBy=newest">최신순</a>
						</c:otherwise>
					</c:choose>
				</li>
				<li><!-- 매거진 정렬 : 오래된순 -->
					<c:choose>
						<c:when test="${fn:contains(keyword, '#') }">
							<a class = "subMenu" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=magazine&orderBy=oldest">오래된순</a>
						</c:when>
						<c:otherwise>
							<a class = "subMenu" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=magazine&orderBy=oldest">오래된순</a>
						</c:otherwise>
					</c:choose>
				</li>
			</ul>
		</div>
	
		<!-- 매거진 출력 -->
		<div>
			<ul class = "magazineItems">
				<c:choose>
					<c:when test = "${searchMagazineList != null && searchMagazineList.size() != 0 }">
						<c:forEach var="magazine" items="${searchMagazineList }">
							<c:if test="${magazine.magazineNo != null }">
								<li class = "magazineItem li_box">
										<div class="result-img">
											<c:if test="${magazine.category == 'pictorial'}">
												<a href="${contextPath }/magazine/pictorialInfo.do?magazineNo=${magazine.magazineNo}">
												<img width="228" height="280" src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${magazine.magazineNo}&path=pictorial" alt="${magazine.title}">
												<span>화보</span>
												<br>
												</a>
											</c:if>
											<c:if test="${magazine.category == 'lookbook'}">
												<a href="${contextPath }/magazine/lookbookInfo.do?magazineNo=${magazine.magazineNo}">
												<img width="228" height="280" src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${magazine.magazineNo}&path=lookbook" alt="${magazine.title}">
												<span>룩북</span>
												<br>
												</a>
											</c:if>
										</div>
										<strong>${magazine.title }</strong>
										<p>${magazine.magRegdate }</p>
									</a>
								</li>
							</c:if>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<p class = "noItem">검색한 매거진이 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</ul>
				<div class = "paginationSnap"></div>
		</div>
	</c:if>

</body>

	<script>
		let page = window.location.href;
		let pageSplit = page.split("&");
		
		
		let alignList = document.getElementsByClassName("subMenu");
		let menuList = document.getElementsByClassName("menu");
		 
		if(pageSplit.length < 3) {
			alignList[0].setAttribute('class', 'subMenu1')
			
		}else{
			/* 상품 */
			let pageSplit2 = pageSplit[2];
			let pageSplit2_split = pageSplit2.split("=");
			
			if (pageSplit2_split[1] == 'highPrice'){
				alignList[1].setAttribute('class', 'subMenu1')
			}else if(pageSplit2_split[1] == 'lowPrice'){
				alignList[2].setAttribute('class', 'subMenu1')
			}else if(pageSplit2_split[1] == 'starscore'){
				alignList[3].setAttribute('class', 'subMenu1')			
			}else if(pageSplit2_split[1] == 'reviewCount'){
				alignList[4].setAttribute('class', 'subMenu1')			
			}
			
			/* 매거진, 스냅 */
			if (pageSplit2_split[1] == 'newest'){
				alignList[1].setAttribute('class', 'subMenu1')
			}else if(pageSplit2_split[1] == 'oldest'){
				alignList[2].setAttribute('class', 'subMenu1')
			}
		}
		
		let pageSplit1 = pageSplit[1];
		let pageSplit1_split = pageSplit1.split("=");
		
		if(pageSplit1_split[1] == 'product'){
			menuList[1].setAttribute('class', 'menu1');
		}else if(pageSplit1_split[1] == 'snap'){
			menuList[2].setAttribute('class', 'menu1');
		}else if(pageSplit1_split[1] == 'magazine'){
			menuList[3].setAttribute('class', 'menu1');
		}
	</script>
