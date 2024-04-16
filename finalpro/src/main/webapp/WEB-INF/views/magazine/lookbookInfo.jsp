<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	request.setCharacterEncoding("utf-8");
%>    
<c:set var="contextPath" value="#{pageContext.request.contextPath }" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

<link rel="stylesheet" href="/finalpro/resources/css/lookbookInfo.css">

<script>
document.addEventListener('DOMContentLoaded', function () {
    var tagListString = "${tagList}"; // 예: "[태그1,태그2,태그3]"
    tagListString = tagListString.replace(/^\[/, "").replace(/\]$/, ""); // '['와 ']'를 제거합니다.
    var tags = tagListString.split(','); // 쉼표로 구분된 문자열을 배열로 변환

    var tagContainer = document.getElementById('tagContainer'); // 태그 컨테이너 선택

    // 배열의 각 요소(태그)에 대해 링크 생성
    tags.forEach(function(tag) {
        var dd = document.createElement('dd');
        dd.className = 'listItem';

        var tagLink = document.createElement('a');
        tagLink.href = "${contextPath}/product/searchList.do?keyword=" + tag.trim();
        tagLink.textContent = tag.trim();

        dd.appendChild(tagLink); // <dd> 요소에 <a> 태그 추가
        tagContainer.appendChild(dd); // <dl class="article-tag-list list">에 <dd> 요소 추가
    });
});


</script>



<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<style type="text/css">
	
	/* .arrowBtnBox svg {
	    display: none;
	}
	
	.arrowBtnBox:hover svg {
	    display: block;
	} */
	
	.listMagazineImage {
	    display: none; /* 모든 슬라이드를 기본적으로 숨깁니다. */
	}

	
	</style>
	<script>
	document.addEventListener('DOMContentLoaded', function () {
		console.log("오긴함");
	    var slides = document.querySelectorAll('.listMagazineImage'); // 모든 슬라이드를 선택합니다.
	    console.log(slides);
	    var currentIndex = 0; // 현재 보이는 슬라이드의 인덱스입니다.
	    slides[currentIndex].style.display = 'block'; // 초기 상태에서 첫 번째 슬라이드를 보이게 합니다.
	
	    // 'prev' 버튼에 클릭 이벤트 리스너를 추가합니다.
	    document.getElementById('prev').addEventListener('click', function() {
	        slides[currentIndex].style.display = 'none'; // 현재 슬라이드를 숨깁니다.
	        currentIndex = (currentIndex - 1 + slides.length) % slides.length; // 이전 슬라이드로 인덱스를 업데이트합니다.
	        slides[currentIndex].style.display = 'block'; // 업데이트된 인덱스의 슬라이드를 보이게 합니다.
	    });
	
	    // 'next' 버튼에 클릭 이벤트 리스너를 추가합니다.
	    document.getElementById('next').addEventListener('click', function() {
	        slides[currentIndex].style.display = 'none'; // 현재 슬라이드를 숨깁니다.
	        currentIndex = (currentIndex + 1) % slides.length; // 다음 슬라이드로 인덱스를 업데이트합니다.
	        slides[currentIndex].style.display = 'block'; // 업데이트된 인덱스의 슬라이드를 보이게 합니다.
	    });
	});
	</script>
	
<!-- 페이지 만들기 -->	


<script>
var currentPage = 1;
var itemsPerPage = 1; // 여기서는 아이템 수를 1로 설정했지만, 필요에 따라 조정하세요.

function goToPage(pageNum) {
    currentPage = pageNum;
    updateItemsDisplay();
}

function nextPage() {
    var allItems = document.querySelectorAll('.listMagazineImage');
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

function firstPage() {
    currentPage = 1;
    updateItemsDisplay();
}

function lastPage(totalPages) {
    currentPage = totalPages;
    updateItemsDisplay();
}

// 페이지네이션 버튼을 동적으로 생성하는 함수를 수정합니다.
function createPaginationButtons() {
    var paginationContainer = document.querySelector('.paginationSnap');
    var totalItems = document.querySelectorAll('.listMagazineImage').length;
    var totalPages = Math.ceil(totalItems / itemsPerPage);
    var maxPageButtons = 10; // 한 번에 보여줄 최대 페이지 버튼 수
    var visiblePages = Math.min(totalPages, maxPageButtons);
    var currentPageGroup = Math.ceil(currentPage / maxPageButtons);

    // 기존 페이지네이션 버튼을 모두 제거
    paginationContainer.innerHTML = '';

    // 맨 처음 페이지와 이전 페이지 버튼 추가
    if (currentPage > 1) {
        paginationContainer.appendChild(createButton('<<', firstPage));
        paginationContainer.appendChild(createButton('<', previousPage));
    }

    // 페이지 버튼 생성
    var startPage = (currentPageGroup - 1) * maxPageButtons + 1;
    var endPage = startPage + visiblePages - 1;
    for (let i = startPage; i <= endPage && i <= totalPages; i++) {
        let button = createButton(i, function() { goToPage(i); }, i === currentPage);
        paginationContainer.appendChild(button);
    }

    // 다음 페이지와 맨 끝 페이지 버튼 추가
    if (currentPage < totalPages) {
        paginationContainer.appendChild(createButton('>', nextPage));
        paginationContainer.appendChild(createButton('>>', function() { lastPage(totalPages); }));
    }
}

function createButton(text, eventHandler, isActive=false) {
    let button = document.createElement('button');
    button.className = 'pagination_button' + (isActive ? ' active' : '');
    button.innerText = text;
    button.addEventListener('click', eventHandler);
    return button;
}

function updateItemsDisplay() {
    var allItems = document.querySelectorAll('.listMagazineImage');
    var startItem = (currentPage - 1) * itemsPerPage;
    var endItem = startItem + itemsPerPage;

    allItems.forEach(function(item, index) {
        item.style.display = (index >= startItem && index < endItem) ? 'block' : 'none';
    });

    createPaginationButtons();
}

document.addEventListener('DOMContentLoaded', function() {
    updateItemsDisplay();
    createPaginationButtons();
});
</script>
	



<!-- 관련 상품 페이지 수 만들기 -->


<script>
var currentPage_lookbook = 1;
var itemsPerPage_lookbook = 9;

function goToPage_lookbook(pageNum) {
    currentPage_lookbook = pageNum;
    updateItemsDisplay_lookbook();
}

function nextPage_lookbook() {
    var allItems = document.querySelectorAll('.listItem_lookbook');
    var totalPages = Math.ceil(allItems.length / itemsPerPage_lookbook);
    if (currentPage_lookbook < totalPages) {
        currentPage_lookbook++;
        updateItemsDisplay_lookbook();
    }
}

function previousPage_lookbook() {
    if (currentPage_lookbook > 1) {
        currentPage_lookbook--;
        updateItemsDisplay_lookbook();
    }
}

function firstPage_lookbook() {
    currentPage_lookbook = 1;
    updateItemsDisplay_lookbook();
}

function lastPage_lookbook(totalPages) {
    currentPage_lookbook = totalPages;
    updateItemsDisplay_lookbook();
}

function createPaginationButtons_lookbook() {
    var paginationContainer = document.querySelector('.paginationItem');
    var totalItems = document.querySelectorAll('.listItem_lookbook').length;
    var totalPages = Math.ceil(totalItems / itemsPerPage_lookbook);

    paginationContainer.innerHTML = '';

    if (currentPage_lookbook > 1) {
        paginationContainer.appendChild(createButton_lookbook('<<', firstPage_lookbook));
        paginationContainer.appendChild(createButton_lookbook('<', previousPage_lookbook));
    }

    for (let i = 1; i <= totalPages; i++) {
        let button = createButton_lookbook(i, function() { goToPage_lookbook(i); }, i === currentPage_lookbook);
        paginationContainer.appendChild(button);
    }

    if (currentPage_lookbook < totalPages) {
        paginationContainer.appendChild(createButton_lookbook('>', nextPage_lookbook));
        paginationContainer.appendChild(createButton_lookbook('>>', function() { lastPage_lookbook(totalPages); }));
    }
}

function createButton_lookbook(text, eventHandler, isActive=false) {
    let button = document.createElement('button');
    button.className = 'pagination_button2' + (isActive ? ' active' : '');
    button.innerText = text;
    button.addEventListener('click', eventHandler);
    return button;
}

function updateItemsDisplay_lookbook() {
    var allItems = document.querySelectorAll('.listItem_lookbook');
    var startItem = (currentPage_lookbook - 1) * itemsPerPage_lookbook;
    var endItem = startItem + itemsPerPage_lookbook;

    allItems.forEach(function(item, index) {
        item.style.display = (index >= startItem && index < endItem) ? 'block' : 'none';
    });

    createPaginationButtons_lookbook();
}

document.addEventListener('DOMContentLoaded', function() {
    updateItemsDisplay_lookbook();
    createPaginationButtons_lookbook();
});
</script>


</head>

<body>
	<div class="column-wrapper" id="wrapper">
		<div class="bottom-column column clearfix leftClose">
			<!-- 본문 -->
			<div class="main-content-wrapper">
				<div class="lookbook_header">
					<!-- @D : navi -->
					<div class="breadCrumb-wrapper">
						<a href="/finalpro/main.do" class="breadCrumb">무신사</a>
						<span>&gt;</span>
						<a href="/finalpro/magazine/lookbookList.do" class="breadCrumb">매거진</a>
						<span>&gt;</span>
						<span class="breadCrumb">
							<a href="/finalpro/magazine/lookbookList.do">브랜드룩북</a>
						</span>
						<span>&gt;</span>
						<span class="breadCrumb">${lookbook.title }</span>
						 
					</div>
					<div class="breadCrumb-wrapper sub">
						<a href="/finalpro/magazine/lookbookList.do" class="breadCrumb">Magazine</a>
						<span>&gt;</span>
						<span class="breadCrumb">
							<a href="/finalpro/magazine/lookbookList.do" style="text-transform: capitalize">brandlookbook</a>
						</span>
						<p class="page_intro">다양한 브랜드의 컬렉션을 집중 소개하며 합리적인 쇼핑에 도움을 줄 유용한 가이드를 담은 콘텐츠를 제공합니다.</p>
					</div>
				</div>
				
				<div class="content-wrapper article wrapper">

					<div class="section">
						<div class="dbInfo-box box clearfix">
							<div class="dbImg">
								<img src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${lookbook.magazineNo}&path=lookbook" alt="라퍼_돌아온 패트와 매트">
								<div class="controlBox">
									<a href="/finalpro/magazine/lookbookList.do">
										<span class="plain-btn btn">목록으로</span>
									</a>
								</div>
							</div>
							<div class="snapInfo">
								<table>
									<caption>
										<p class="title">돌아온 패트와 매트</p>
										<p class="info">
											<span class="date division">${lookbook.regdate }</span>
											<span class="brand">관련브랜드 : 
												<a href="/finalpro/magazine/lookbookList.do?brand=${lookbook.brand }">${lookbook.brand }(바로가기)</a>
											</span>
										</p>
									</caption>
									<tbody>
										<tr class="first">
											<th>
												<span>년도/시즌</span>
											</th>
											<td>
												<span><a href="/finalpro/magazine/lookbookList.do">${lookbook.season }</a></span>
											</td>
										</tr>
										<tr>
											<th>
												<span>모델</span>
											</th>
											<td>
												<span>${lookbook.model }</span>
											</td>
											<th>
												<span>포토그래퍼</span>
											</th>
											<td>
												<span>${lookbook.photographer }</span>
											</td>
										</tr>
										<tr class="description">
											<th>
												<span>설명</span>
											</th>
											<td colspan="3">
												<p>${lookbook.content }</p>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>

					<div class="section lookbook-content-area">
						<div class="contentsNav pageBoxV2" data-current-page="1" br-data-name="lookbook_content_tab">
							<div class="content-list-wrapper">
								<div class="controller">
									<div class="arrowBtnBox" id="prev">
										<svg height="50px" id="Layer_1" style="enable-background:new 0 0 512 512;" version="1.1" viewBox="0 0 512 512" width="100px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
										   <polygon points="352,115.4 331.3,96 160,256 331.3,416 352,396.7 201.5,256 " />
										</svg>
									</div>
									<div class="arrowBtnBox" id="next">
										<svg height="50px" id="Layer_1" style="enable-background:new 0 0 512 512;" version="1.1" viewBox="0 0 512 512" width="100px" xml:space="preserve" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
										   <polygon points="160,115.4 180.7,96 352,256 180.7,416 160,396.7 310.5,256 " />
										</svg>
									</div>
								</div>
								<div class="slider">
									<ul class="content-list">
										<c:forEach var="i" begin="1" step="1" end="${lookbook.imageNumber }">
											<li class="listMagazineImage" style="width: 1200px;" itemid="${i }">
												<div class="contentMedia ui-sc-contents">
													<a href="./매거진_브랜드룩북_돌아온패트와매트_files/f3ccdd27d2000e3f9255a7e3e2c48800104050.jpg"
														title="라퍼_돌아온 패트와 매트" class="lbox" related_goods_no="" __ind="0">
														<img title="라퍼_돌아온 패트와 매트" alt="라퍼_돌아온 패트와 매트"
															src="${contextPath}/download.do?imageFileName=${i }.jpg&magazineNo=${lookbook.magazineNo}&path=lookbook"
															align="top" class="photo" style="max-width: 1200px;"></a>
												</div>
											</li>
										</c:forEach>
									</ul>
								</div>
							</div>
							
							
							<!-- 페이지 버튼 -->	  
	 						<div class="paginationSnap"></div>
							
							
							 <%-- <div class="page-list-wrapper page-bottom clearfix">
								<ul class="page-list list clearfix btn-cscontents-pages blockClass0" blockpage="0">
									<li class="listItem number-btn btn  blockClass0"><span>처음으로</span></li>
									<c:forEach var="i" begin="1" step="1" end="${lookbook.imageNumber }">
										<li class="listItem number-btn btn  blockClass0"><span>${i }</span></li>
									</c:forEach>
									<li class="listItem number-btn btn  blockClass0"><span>끝으로</span></li>
								</ul>
							</div> --%>
							
							
						</div>

						<div class="tag-box box tagList">
						    <dl class="article-tag-list list" id="tagContainer"> <!-- ID 변경 -->
						        <dt>태그</dt>
						        <!-- JavaScript가 여기에 동적으로 태그를 추가합니다 -->
						    </dl>
						</div>
					</div>

					<!-- 무신사 스토어 상품-->
					<div class="section store_goods" id="rel_store_goods_div" _p="0">
						<p class="header_store_tit">
								<span class="eng_store">Related Store</span>
								<span class="kor_store_product">스토어 관련상품</span>
								<div class="paginationItem"></div>
						<div class="related-box box">
							
							<ul class="store-article-list article-list list ul-goodSticker" id="ul-goodSticker-sgoods">
								<c:forEach var="item" items="${magazineProductList }">
									<li class="listItem_lookbook">
										<div class="articleImg">
											<a href="${contextPath }/product/detailProduct.do?productNo=${item.productNo}" target="_top">
												<img class="lazy-load-image" alt="라퍼_[PAT&amp;MAT] 더 웨이 홈 티셔츠 - 화이트" 
												src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${item.productNo }&path=">
											</a>
										</div>
										<div class="articleInfo">
											<p class="brandName">
													<span class="brackets">${item.brand }</span>
											</p>
												<p class="description">${item.name }</p>
										</div>
										<div class="priceInfo noCouponP">
											<div class="priceBox">
												<p class="originalPrice">${item.price }원</p>
											</div>
										</div>
										<span class="txt_cnt_like">${item.totalLikes}</span>
									</li>
								</c:forEach>
							</ul>
						</div>
						<div class="viewBtnBox">
							<a href="/finalpro/magazine/lookbookList.do" class="plain-btn btn">목록으로</a>
						</div>
							
					</div>

					

				</div>
			</div>
			<!-- // main-content-wrapper -->
		</div>
		<!-- // bottom-column -->
	</div>
</body>