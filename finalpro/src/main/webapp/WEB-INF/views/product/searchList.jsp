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
	
	.brand-list {
        display: flex;
        flex-wrap: wrap;
        list-style: none;
        padding: 0;
        margin: 0 0 0 20px;
        overflow: hidden;
    }

    .brand-item {
        width: calc(33.333% - 60px);
        border: 1px solid #aaaaaa;
        margin: 0 0 20px 20px;
        padding: 10px;
    }

    .brand-item a {
        text-align: center;
        display: block;
        text-decoration: none;
    }

    .brand-item img {
    	width: 150px;
        height: 50px;
    }

    .brand-name {
        margin-top: 10px;
        font-weight: bold;
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
	
	.allProduct1 {
		margin-left: 980px;
		right: 9%;
		font-size: 13px;
		color: #CD0000;
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
	
	.snapStyle, .magazineStyle {
		font-size: 13px;
		color: gray;
	}
	
	.result-list-content {
		margin-bottom: 80px;
	}
	
	p.noItem {
   		display: flex;
        justify-content: center;
        align-items: center;
        height: 200px; /* 필요에 따라 높이 조정 */
        font-size: 18px;
        font-weight: bold;
   }
	
</style>

<body>
    <div class = "allContent">
        <div class="pagenation">
            <div class="nav_sub">
                <a href="${contextPath }/main.do">STORE</a>
                <span class="icon_entity">&gt;</span><span> 검색</span>
            </div>
        </div>
        
        <section class="right_contents n-contents-area search-contnts-area">

            <h2 class="n-search-result">
            	<span>'${keyword }'</span>에 대한 검색결과
            </h2>
			
			<c:choose>
				<c:when test = "${searchBrandList != null && searchBrandList.size() != 0 }">
		            <div class="result-shortcuts-content">
		                <div class="n-result-brand-shop brand">
		                    <h3 class = "subTitle">브랜드숍</h3>
		                    <ul class="brand-list">
		                    
							    <c:forEach var="brand" items="${searchBrandList}">
							        <li class="brand-item">
							            <a href="${contextPath }/brand/brandList.do?brand=${brand.brand}">
							                <div>
							                    <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${brand.brand}&path=brand" alt="${brand.brand}">
							                </div>
							                <div class="brand-name">
							                	${brand.brand}
							                </div>
							            </a>
							        </li>
							    </c:forEach>
							    
							</ul>
		                </div>
		            </div>
	            </c:when>
            </c:choose>

            <nav class="n-search-nav">
				<c:choose>
					<c:when test = "${fn:contains(keyword, '#') }">
						<a class = "menu1" href="${contextPath}/product/searchList.do?keyword=${fn:replace(keyword, '#', '%23')}">통합</a>
					</c:when>
					<c:otherwise>
						<a class = "menu1"  href="${contextPath }/product/searchList.do?keyword=${keyword}">통합</a>				
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
			
 			<c:choose>
				<c:when test = "${searchProductList != null && searchProductList.size() != 0 || searchSnapList != null && searchSnapList.size() != 0 && searchMagazineList != null || searchMagazineList.size() != 0}">
					<c:choose>
						<c:when test = "${searchProductList != null && searchProductList.size() != 0 }">
							<section>
				            	<div class="n-result-all">
				                	<header>
				                   		<c:choose>
							                <c:when test = "${fn:contains(keyword, '#') }">
												<a href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=product"><h3 class = "subTitle">상품</h3></a>
											</c:when>
											<c:otherwise>
												<a href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=product"><h3 class = "subTitle">상품</h3></a>				
											</c:otherwise>
										</c:choose>
				                	</header>
				                	
				                	<div class="list-box">
									    <ul id="searchList">
									        <c:forEach var="product" items="${searchProductList}" varStatus="loop">
									            <c:if test="${product.productNo != null}">
									                <c:if test="${loop.index < 10}">
									                    <li class="li_box">
									                        <a href="${contextPath }/product/detailProduct.do?productNo=${product.productNo}">
									                            <img width="145" height="160" src="${contextPath}/download.do?imageFileName=${product.imageFileName}&productNo=${product.productNo}&path=product" alt="${product.name}">
									                            <div class="article_info">
									                                <p class="item_title"><a href="${contextPath }/brand/brandList.do?brand=${product.brand}"><b>${product.brand}</b></a></p>
									                                <p class="list_info"><a href="${contextPath }/product/detailProduct.do?productNo=${product.productNo}">${product.name}</a></p>
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
									            </c:if>
									        </c:forEach>
									    </ul>
									</div>
				                	
				                	<c:choose>
						                <c:when test = "${fn:contains(keyword, '#') }">
											<a class = "allProduct1" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=product">상품 전체보기 > </a>
										</c:when>
										<c:otherwise>
											<a class = "allProduct1" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=product">상품 전체보기 > </a>				
										</c:otherwise>
									</c:choose>
									
				             	</div>
				             </section>
				         </c:when>
					</c:choose>
					
					<c:choose>
						<c:when test = "${searchSnapList != null && searchSnapList.size() != 0 }">
				        	<section class="result-list-content">
				            	<header>
				            		<c:choose>
						                <c:when test = "${fn:contains(keyword, '#') }">
											<a href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=snap"><h3 class = "subTitle">스냅</h3></a>
										</c:when>
										<c:otherwise>
											<a href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=snap"><h3 class = "subTitle">스냅</h3></a>				
										</c:otherwise>
									</c:choose>
				           		</header>
				           		<ul class = "snapItems">
									<c:forEach var="snap" items="${searchSnapList}" varStatus="loop">
										    <c:if test="${snap.snapNo != null}">
										        <c:if test="${loop.index < 4}">
										            <li class = "snapItem">
										                <a href="${contextPath }/styleall/brandSnapInfo.do?snapNo=${snap.snapNo }&brand=${snap.brand}">
										                    <div class="result-img">
										                        <img width="228px" height="280px" src="${contextPath}/download.do?imageFileName=${snap.snapImageFileName}&productNo=${snap.snapNo}&path=snap" alt="${snap.brand}">
										                    </div>
										                    <c:if test="${fn:contains(snap.snapNo, 'b')}">
										                        <span class = "snapStyle">브랜드스냅</span><br>
										                    </c:if>
										                    <c:if test="${fn:contains(snap.snapNo, 's')}">
										                        <span class = "snapStyle">스트릿스냅</span><br>
										                    </c:if>
										                    <strong>${snap.modelName}</strong>
										                    <p class="result-date">${snap.snapRegDate}</p>
										                </a>
										            </li>
										        </c:if>
										    </c:if>
									</c:forEach>
								</ul>	
				                	<c:choose>
						                <c:when test = "${fn:contains(keyword, '#') }">
											<a class = "allProduct1" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=snap">스냅 전체보기 > </a>
										</c:when>
										<c:otherwise>
											<a class = "allProduct1" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=snap">스냅 전체보기 > </a>				
										</c:otherwise>
									</c:choose>
				              	
							</section>
						</c:when>
					</c:choose>
		
					<c:choose>
						<c:when test = "${searchMagazineList != null && searchMagazineList.size() != 0 }">
				               <section class="result-list-content">
				                   	<header>
				                       	<c:choose>
						                <c:when test = "${fn:contains(keyword, '#') }">
											<a href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=magazine"><h3 class = "subTitle">매거진</h3></a>
										</c:when>
										<c:otherwise>
											<a href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=magazine"><h3 class = "subTitle">매거진</h3></a>				
										</c:otherwise>
									</c:choose>
				                   	</header>
				                   	
				                   	<ul class="magazineItems" id="coordi_list">
				                   
				                   		<c:forEach var="magazine" items="${searchMagazineList}" varStatus="loop">
										    <c:if test="${magazine.magazineNo != null}">
										        <c:if test="${loop.index < 4}">
										            <li class = "magazineItem">
										                <a href="${contextPath }/magazine/pictorialInfo.do?magazineNo=${magazine.magazineNo}">
										                    <div class="result-img">
										                        <c:if test = "${magazine.category eq 'pictorial' }">
			                                                        <img width="228" height="280" src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${magazine.magazineNo}&path=pictorial" alt="${magazine.title}">
			                                                     </c:if>
			                                                     <c:if test = "${magazine.category eq 'lookbook' }">
			                                                        <img width="228" height="280" src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${magazine.magazineNo}&path=lookbook" alt="${magazine.title}">
			                                                     </c:if>
										                    </div>
										                    <c:if test="${magazine.category eq 'pictorial'}">
										                        <span class = "magazineStyle">화보</span><br>
										                    </c:if>
										                    <c:if test="${magazine.category eq 'lookbook'}">
										                        <span class = "magazineStyle">룩북</span><br>
										                    </c:if>
										                    <strong>${magazine.title}</strong>
										                    <p>${magazine.magRegdate}</p>
										                </a>
										            </li>
										        </c:if>
										    </c:if>
										</c:forEach>
				                   </ul>
				                   
				                   <c:choose>
							                <c:when test = "${fn:contains(keyword, '#') }">
												<a class = "allProduct1" href="${contextPath}/product/searchDetailList.do?keyword=${fn:replace(keyword, '#', '%23')}&category=magazine">매거진 전체보기 > </a>
											</c:when>
											<c:otherwise>
												<a class = "allProduct1" href="${contextPath }/product/searchDetailList.do?keyword=${keyword}&category=magazine">매거진 전체보기 > </a>				
											</c:otherwise>
								   </c:choose>
				               </section>
						</c:when>
					</c:choose>
 				</c:when>
				<c:otherwise>
					<p class = "noItem">검색하신 상품이 없습니다. 검색어를 변경해 보세요.</p>
				</c:otherwise>
			</c:choose> 
		</section>
	</div>
</body>
