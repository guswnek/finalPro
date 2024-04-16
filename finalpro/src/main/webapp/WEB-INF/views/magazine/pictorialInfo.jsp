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

<link rel="stylesheet" href="/finalpro/resources/css/pictorialInfo.css">

<script>
document.addEventListener('DOMContentLoaded', function () {
    var tagListString = "${tagList}"; // 서버로부터 받은 데이터
    tagListString = tagListString.replace(/^\[/, "").replace(/\]$/, "");
    var tags = tagListString.split(',');

    var tagContainer = document.getElementById('tagContainer');

    tags.forEach(function(tag) {
        var tagLink = document.createElement('a');
        tagLink.href = "${contextPath}/product/searchList.do?keyword=" + tag.trim();
        tagLink.textContent = tag.trim();
        tagLink.className = 'tagItem'; // CSS 클래스 할당
        tagContainer.appendChild(tagLink);
    });
});

</script>



<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>

<body>
	<div class="warp">
		<div class="pagenation">
			<div class="nav_sub">
				<a href="${contextPath }/main">무신사 스토어</a>
				<span class="icon_entity">&gt;</span>
				<a href="/finalpro/magazine/pictorialList.do" id="location_category_1_depth">매거진</a>
				<span class="icon_entity">&gt;</span>
				<a href="/finalpro/magazine/pictorialList.do" id="location_category_1_depth">화보</a>
				<span class="icon_entity">&gt;</span>
				<span id="location_category_2_depth">${pictorial.title }</span>
			</div>
		</div>
		<div class="contents">
			<!-- 컨텐츠 캔버스 -->
			<div class="cmsCanvas cmsPc designType-specialissue" style="display: block; --vwidth: 450;">
				<section class="static-cover-bg ">
					<div class="cp-rate-coverBox cm-rate-1x1">
						<img src="${contextPath}/download.do?imageFileName=1.jpg&magazineNo=${pictorial.magazineNo}&path=pictorial" class="upload-Img bg-cover cm-bgSize-w100 cm-bgPosition-centerCenter">
						<div  style="background-image: url('');" ></div>
					</div>
				</section>
				<section class="static-cover-title " componentname="static-cover-title">
					<h2 edittype="text-align" class="cm-textAlign-center">
						<span class="cp-editBox-text notuse-link" meta-subject="">${pictorial.title }</span>
					</h2>
					<div class="cp-text-coverBox">
						<span class="date">${pictorial.regdate }</span>
					</div>
				</section>
				<section class="text-title " componentname="text-title">
					<h4 edittype="text-align" class="cm-textAlign-left">
						<span class="cp-editBox-text">${pictorial.subTitle }<br></span>
					</h4>
				</section>
				<section class="text-contents " componentname="text-contents">
					<p edittype="text-align">
						<span class="cp-editBox-text">
							${pictorial.content }
						</span>
					</p>
				</section>
				<c:forEach var="i" begin="2" step="1" end="${pictorial.imageNumber }">
					<section class="img-img " componentname="img-img">
						<div edittype="rate" class="cp-rate-imgBox cm-rate-free cc-marginMinus">
							<div edittype="upload-Img" class="upload-Img cm-img cm-imgSize-w100 cm-imgPosition-centerCenter" filekey="65f0ee7089e024.97664551.jpg">
								<img src="${contextPath}/download.do?imageFileName=${i }.jpg&magazineNo=${pictorial.magazineNo}&path=pictorial" class="lazy-img" alt="반스 빈티지를 소장하는 방법" title="반스 빈티지를 소장하는 방법">
							</div>
						</div>
					</section>
				</c:forEach>
				<section class="static-from " componentname="static-from">
					<div class="cp-section-colorMode cp-section-bgcolor cp-section-textcolor">
						<h2 class="hide">출처</h2>
						<ul edittype="text-align" class="cp-from cc-marginMinus">
							<li><span class="opt-editable --data-text-color">에디터 : ${pictorial.editor } | </span></li>
							<li><span class="opt-editable --data-text-color">포토그래퍼 : ${pictorial.photographer } |</span></li>
							<li><span class="opt-editable --data-text-color">디자이너 : ${pictorial.designer } |</span></li>
							<li><span class="opt-editable --data-text-color">어시스턴트 에디터 : ${pictorial.assist }</span></li>
						</ul>
					</div>
				</section>
				<section class="static-tag" componentname="static-tag">
				    <h2 class="hide">태그</h2>
				    <div class="tagBox" id="tagContainer">
				    </div>
				</section>
			</div>
			<!--// 컨텐츠 캔버스 -->

			<!-- 관련상품 -->
			<section class="goods-tabCloum ui-section-meta-items " componentname="goods-tabCloum">
				<h2>관련상품</h2>

				<ul class="goodsRows">
					<c:forEach var="item" items="${magazineProductList }">
						<li class="goods-unit re-freshed like-checked">
							<div class="img">
								<a href="${contextPath}/product/detailProduct.do?productNo=${item.productNo}">
									<img alt="" src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${item.productNo }&path=" class="lazy-img">
								</a>
							</div>
							<p class="info">
								<a href="${contextPath}/brand/brandList?brnad=${item.brand}" class="brand mgtm-catch-click gtm-like-click">${item.brand }</a>
								<a href="${contextPath}/product/detailProduct.do?productNo=${item.productNo}" class="name">${item.name }</a>
								<span class="price">${item.price }원</span>
	
								<span class="totalLike">
									<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg">
										<path d="M14.6817 4.35298C13.2775 2.94875 11.0007 2.94875 9.59651 4.35298L8.98593 4.96356L8.40351 4.38114C6.99928 2.97691 4.72257 2.97691 3.31834 4.38114C1.91411 5.78537 1.91411 8.06208 3.31834 9.46631L8.99948 15.1474L11.3269 12.82C11.4196 12.7273 11.5068 12.631 11.5883 12.5316L14.6817 9.43815C16.0859 8.03392 16.0859 5.75721 14.6817 4.35298Z" fill="#FF0000"></path>
									</svg> ${item.totalLikes }
								</span>
							</p>
						</li> 
					</c:forEach>
				</ul>
			</section>
		</div>
	</div>
</body>