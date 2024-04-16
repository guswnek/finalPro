<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var = "contextPath" value="${pageContext.request.contextPath}" />
<c:set var="deliveryStatus" value="${param.deliveryStatus}" />

<link rel ="stylesheet" href="${contextPath }/resources/css/myPage.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script>

	var currentPage = 1;
	var itemsPerPage = 5;   
	
	function goToPage(pageNum) {
	    currentPage = pageNum;
	    updateItemsDisplay();
	}
	
	function nextPage() {
	    var allItems = document.querySelectorAll('.orderListDiv');
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
    var totalItems = document.querySelectorAll('.orderListDiv').length;
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
	    var allItems = document.querySelectorAll('.orderListDiv');
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

  function OrderDate(duration) {
    var toDate = new Date();
    var fromDate = new Date();

    switch (duration) {
      case '1year':
        fromDate.setFullYear(fromDate.getFullYear() - 1);
        break;
      case '1week':
        fromDate.setDate(fromDate.getDate() - 7);
        break;
      case '1month':
        fromDate.setMonth(fromDate.getMonth() - 1);
        break;
      case '3month':
        fromDate.setMonth(fromDate.getMonth() - 3);
        break;
    }

    // yyyy-mm-dd 형식으로 변환
    var fromDateString = formatDate(fromDate);
    var toDateString = formatDate(toDate);

    document.getElementsByName('fromDate')[0].value = fromDateString;
    document.getElementsByName('toDate')[0].value = toDateString;
  }
  
  function formatDate(date) {
	  var dd = date.getDate();
	  var mm = date.getMonth() + 1;
	  var yyyy = date.getFullYear();

	  // 한 자릿수인 경우 앞에 0 추가
	  if (dd < 10) {
	    dd = '0' + dd;
	  }

	  if (mm < 10) {
	    mm = '0' + mm;
	  }

	  return yyyy + '-' + mm + '-' + dd;
	}
  
  function changeDeliveryStatus(deliveryStatus, orderNo) {
	  if(confirm("선택하신 상품을 "+ deliveryStatus + "하시겠습니까?")){
		  location.href = "${contextPath}/mypage/changeDeliveryStatus.do?deliveryStatus="+ deliveryStatus + "&orderNo=" + orderNo;
	  }
  }
  
  function reviewClick(productNo, productSize, orderNo){
	  location.href = "${contextPath}/product/reviewForm.do?productNo=" + productNo + "&productSize=" + productSize + "&orderNo=" + orderNo;
  }
  
  function deliveryInfo(orderNo) {
	  let popOption = "width = 550px, height=550px, top = 120px, left = 500px";
	  let openUrl = '${contextPath}/popup/orderInfo.do?orderNo='+orderNo;
	  window.open(openUrl, 'pop', popOption);
  }
  
  function modifyReview(orderNo){
	  location.href = "${contextPath}/product/modifyReviewForm.do?orderNo=" + orderNo;
  }
  
  function deleteReview(orderNo){
	  location.href = "${contextPath}/product/deleteReview.do?orderNo=" + orderNo;
  }
  
</script>

<style>
	.orderListbar ul{
		padding: 0px;
		margin: 15px 0 20px 27px; 
	}
	
	.orderListbar ul li{
		padding-right: 10px;
		display: inline;
		list-style: none;
	}
	
	.orderListbar ul li a{
		text-decoration: none;
		color : lightgray;
		font-weight: bold;
	}
	
	.listbar li a:hover {
        text-decoration: underline;
    }
	
	h2.orderTitle {
        margin: 15px 25px 0;
    }
    
    .listbar li a.active {
        color: black;
    }

    hr {
        margin: 17px 0 10px 20px;
		height: 1px;
		background-color: black;
		width : 95%;
	}
	
	.orderListInfo{
		padding : 5px 0 20px 0;
		font-size: 13px;
		color: gray;
		font-weight: bold;
		margin: 0 0 0 28px;
	}
	
	.orderListDate{
		margin: 0 0 10px 17px;
	}
	
	.orderListDate input[type=button], button.requestBtn, .submitBtn{
		background-color: lightgary;
		border: none;
		border-radius: 5px;
		color: gray;
		font-weight: 600;
		width: 70px;
		height: 30px;
		margin: 10px 0;
	}
	
	.orderListDate input[type=date]{
		border : 1px solid gray;
		border-radius: 5px;
		color: gray;
		font-weight: 600;
		width: 140px;
		height: 30px;
	}
	
	 .orderListDate input[type=text]{
	 	border : 1px solid gray;
	 	border-radius: 5px;
		color: gray;
		font-weight: 600;
		width: 200px;
		height: 28px;
	 }
	 
	 /* 날짜 기간 클릭하면 이거 적용  */
	 #orderListDate_click, .oderListDate input[type=submit]{
		background-color: #0078FF;
		border: none;
		border-radius: 5px;
		color: white;
		font-weight: 600;
		width: 70px;
		height: 30px;
		z-index: 3;
	}
	
	 .table th,  .table td{
		padding: 17px;
	}
	 
	 .table {
	 	margin: 20px 0 0 17px;
	 	width: 95%;
	 	border-collapse: collapse;
	 	border-spacing: 5px;
	 	font-size: 15px;
	 }
	 
	 .table tr{
	 	margin: 20px 0 0 0;
	 	width: 100%;
	 	border: 1px solid black;
	 	border-left: none;
	 	border-right: none;
	 }
	 
    .orderListDate input[type=button]:hover, button.requestBtn:hover {
        background-color: black;
        color: white;
    }
    
    .orderListDate input[type=button].active, .submitBtn{
        background-color: black;
        color: white;
    }
    
   p.noItem {
   		display: flex;
        justify-content: center;
        align-items: center;
        height: 200px; /* 필요에 따라 높이 조정 */
        font-size: 18px;
        font-weight: bold;
   }
   
   .paginationSnap {
   		display: flex;
        justify-content: center;
        margin-top: 20px; /* 필요에 따라 여백 조정 */
   }
   
   
</style>

<!-- 클릭되면 스타일 변경 -->
<script>
	document.addEventListener('DOMContentLoaded', function() {
	    var links = document.querySelectorAll('.listbar li a');
	    var currentUrl = window.location.href;
	    links.forEach(function(link) {
	        // 현재 URL과 링크의 href 속성을 비교하여 active 클래스 추가
	        if (link.href == currentUrl) {
	            link.classList.add('active');
	        }
	    });
	});
	
	document.addEventListener('DOMContentLoaded', function() {
        var buttons = document.querySelectorAll('.orderListDate input[type=button]');
        buttons.forEach(function(button) {
            button.addEventListener('click', function() {
                // 현재 활성화된 버튼을 찾아 이전에 활성화된 버튼의 클래스를 제거합니다.
                var currentActiveButton = document.querySelector('.orderListDate input[type=button].active');
                if (currentActiveButton) {
                    currentActiveButton.classList.remove('active');
                }
                // 현재 클릭된 버튼에 활성화 클래스를 추가합니다.
                button.classList.add('active');
            });
        });
    });
</script>

<script>
        function sendMemberDetail() {
            // 폼 생성
            var form = document.createElement("form");
            form.setAttribute("method", "post");
            form.setAttribute("action", "${contextPath}/member/memberDetail.do");

            // memberId를 위한 input 요소 생성
            var idField = document.createElement("input");
            idField.setAttribute("type", "hidden");
            idField.setAttribute("name", "id");
            idField.setAttribute("value", "${loginId}"); // 여기서 member.id는 서버 사이드 코드에서 제공되어야 합니다.
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
            idField.setAttribute("value", "${loginId}"); // 여기서 member.id는 서버 사이드 코드에서 제공되어야 합니다.
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
            idField.setAttribute("value", "${myPage.id}"); // 여기서 member.id는 서버 사이드 코드에서 제공되어야 합니다.
            form.appendChild(idField);

            // 생성된 폼을 문서에 추가
            document.body.appendChild(form);

            // 폼 제출
            form.submit();
        }
    </script>

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
			<h2 class = "orderTitle">주문내역 조회</h2>
			
			<div class = "orderListbar">
				<ul class = "listbar">
					<li><a href="${contextPath }/mypage/orderList.do">전체</a></li>
					<li><a href="${contextPath }/mypage/orderList.do?deliveryStatus=결제">결제</a></li>
					<li><a href="${contextPath }/mypage/orderList.do?deliveryStatus=배송중">배송중</a></li>
					<li><a href="${contextPath }/mypage/orderList.do?deliveryStatus=배송완료">배송완료</a></li>
					<li><a href="${contextPath }/mypage/orderList.do?deliveryStatus=구매확정">구매확정</a></li>
					<li><a href="${contextPath }/mypage/orderList.do?deliveryStatus=교환">교환</a></li>
					<li><a href="${contextPath }/mypage/orderList.do?deliveryStatus=교환완료">교환완료</a></li>
					<li><a href="${contextPath }/mypage/orderList.do?deliveryStatus=환불">환불</a></li>
					<li><a href="${contextPath }/mypage/orderList.do?deliveryStatus=환불완료">환불완료</a></li>
				</ul>
			</div>
			<hr>
			
			<div class = "orderListInfo">
				<p>· 동일한 주문번호라도 2개 이상의 브랜드에서 주문하신 경우 출고지 주소가 달라 각각 출고됩니다. (택배 박스를 2개 이상 수령 가능)</p><br>
				<p>· 출고 완료 직후 교환/환불 요청을 하더라도 상품을 수령하신 후 택배 업체를 통해 보내주셔야 처리 가능합니다.
			</div>
			
			<div class = "orderListDate">
				<form name = "orderListSearchForm">
					<input type = "hidden" name = "deliveryStatus" value = "${deliveryStatus }">
					<input type = "button" onclick = "OrderDate('1year')" name = "1year" value="최근 1년">
					<input type = "button" onclick = "OrderDate('1week')" name = "1week" value="1주일">
					<input type = "button" onclick = "OrderDate('1month')" name = "1month" value="1개월">
					<input type = "button" onclick = "OrderDate('3month')" name = "3month" value="3개월">
					<input type = "date" placeholder="-" name = "fromDate"> - 
					<input type = "date" placeholder="-" name = "toDate">
					<input type = "text" placeholder="상품명/브랜드명으로 검색" name = "name">
					<input class = "submitBtn" type = "submit" value = "조회하기">
				</form>
			</div>
			
			<c:choose>
				<c:when test="${orderList.size() != 0 && orderList != null}">
					<div class = "orderList">
						<table class = "table">
							<tr class = "tableHeader">
								<th colspan="2">상품정보</th>
								<th>주문일자</th>
								<th>주문번호</th>
								<th>주문금액<br>(수량)</th>
								<th colspan="2">주문 상태</th>
							</tr>
							
							<c:forEach var="order" items="${orderList }" >
							<tr class = "orderListDiv">
								<td align="center" width="7%" height = "95px">
									<a href = "${contextPath }/product/detailProduct.do?productNo=${order.productNo}">
										<img width="100px" height = "130px" src="${contextPath }/download.do?imageFileName=${order.imageFileName}&productNo=${order.productNo}&path=product" alt = "${order.name }">
									</a>
								</td>
								<td align="left" width ="13%">
									<span>
										<a href = "${contextPath }/brand/brandList.do?brand=${order.brand}">${order.brand }</a>
									</span><br>
									<b>
										<a href = "${contextPath }/product/detailProduct.do?productNo=${order.productNo}">${order.name }</a>
									</b><br>
									
									<c:choose>
										<c:when test="${order.productSize != null and order.color1 != null}">
											<span style ="color : gray">옵션 : ${order.productSize }</span>
										</c:when>
										<c:when test = "${order.productSize != null }">
											<span style ="color : gray">옵션 : ${order.productSize }</span>
										</c:when>
										<c:when test = "${order.color1 != null }">
											<span style ="color : gray">옵션 : ${order.color1 }</span>
										</c:when>
									</c:choose>
									
								</td>
								<td align="center" width="7%"><fmt:formatDate value="${order.orderDate}" pattern="yyyy.MM.dd" /></td>
								<td align="center" width="9%">${order.orderNo }</td>
								<td align="center" width="7%">${order.orderPrice }원<br><span style="color:gray;">${order.quantity }개</span></td>
								<td align="center" width="10%">
									<c:choose>
										<c:when test="${order.deliveryStatus eq '결제' }">
											<span>결제확인</span><br><button type="button" onclick="deliveryInfo(${order.orderNo})" name="deliveryInfo" class = "requestBtn">주문정보</button><br>
										</c:when>
										<c:when test="${order.deliveryStatus eq '배송중'}">
											<span>배송중</span><br><button type="button" onclick="deliveryInfo(${order.orderNo})" name="deliveryInfo" class = "requestBtn">주문정보</button><br>
										</c:when>
										<c:when test="${order.deliveryStatus eq '배송완료' }">
											<span>배송완료</span><br><button type="button" onclick="deliveryInfo(${order.orderNo})" name="deliveryInfo" class = "requestBtn">주문정보</button><br>
										</c:when>
										<c:when test="${order.deliveryStatus eq '구매확정' }">
											<span>구매확정</span><br><button type="button" onclick="deliveryInfo(${order.orderNo})" name="deliveryInfo" class = "requestBtn">주문정보</button><br>
										</c:when>
										<c:when test="${order.deliveryStatus eq '교환' }">
											<span>교환진행중</span><button type="button" onclick="deliveryInfo(${order.orderNo})" name="deliveryInfo" class = "requestBtn">주문정보</button><br>
										</c:when>
										<c:when test="${order.deliveryStatus eq '교환완료' }">
											<span>교환완료</span><button type="button" onclick="deliveryInfo(${order.orderNo})" name="deliveryInfo" class = "requestBtn">주문정보</button><br>
										</c:when>
										<c:when test="${order.deliveryStatus eq '환불' }">
											<span>환불진행중</span><button type="button" onclick="deliveryInfo(${order.orderNo})" name="deliveryInfo" class = "requestBtn">주문정보</button><br>
										</c:when>
										<c:when test="${order.deliveryStatus eq '환불완료' }">
											<span>환불완료</span><button type="button" onclick="deliveryInfo(${order.orderNo})" name="deliveryInfo" class = "requestBtn">주문정보</button><br>
										</c:when>
									</c:choose>
								</td>
								<td align="center" width="10%">
									<c:choose>
										<c:when test="${order.deliveryStatus eq '결제'}" >
											<button type="button" onclick="changeDeliveryStatus('환불', ${order.orderNo })" name="refund" class = "requestBtn">환불요청</button><br>
										</c:when>
										<c:when test = "${order.deliveryStatus eq '배송중'}">
											<button type="button" onclick="changeDeliveryStatus('환불', ${order.orderNo })" name="refund" class = "requestBtn">환불요청</button><br>
											<button type="button" onclick="changeDeliveryStatus('교환', ${order.orderNo })" name="change" class = "requestBtn">교환요청</button><br>
										</c:when>
										<c:when test = "${order.deliveryStatus eq '배송완료' }">
											<button type="button" onclick="changeDeliveryStatus('환불', ${order.orderNo })" name="refund" class = "requestBtn">환불요청</button><br>
											<button type="button" onclick="changeDeliveryStatus('교환', ${order.orderNo })" name="change" class = "requestBtn">교환요청</button><br>
											<button type="button" onclick="changeDeliveryStatus('구매확정', ${order.orderNo})" name = "confirm" class = "requestBtn">구매확정</button><br>
										</c:when>
										<c:when test="${order.deliveryStatus eq '구매확정'}">
											
											<c:choose>
												<c:when test="${order.checkReview == 1 }">
													<button type="button" name="modifyReview" onclick="modifyReview(${order.orderNo })" class = "requestBtn">리뷰수정</button>
													<button type="button" name="deleteReview" onclick="deleteReview(${order.orderNo })" class = "requestBtn">리뷰삭제</button>
												</c:when>
												<c:otherwise>
													<button type="button" onclick="reviewClick('${order.productNo}', '${order.productSize}', ${order.orderNo })" name="review" class = "requestBtn">리뷰작성</button><br>
												</c:otherwise>
												
											</c:choose>	
												
										</c:when>
										<c:when test="${order.deliveryStatus eq '환불' || order.deliveryStatus eq '환불완료'}">
											<p>주문일자+1 이내<br> 카드 취소 예정</p>
										</c:when>
										<c:when test="${order.deliveryStatus eq '교환' || order.deliveryStatus eq '교환완료'}">
											<p>주문일자+5 이내<br> 교환 예정</p>
										</c:when>
									</c:choose>
								</td>
							</tr>
							</c:forEach>
						</table>
					</div>
				</c:when>
				
				<c:otherwise>
					<p class = "noItem">구매하신 내역이 없습니다.</p>
				</c:otherwise>
				
			</c:choose>
			<div class = "paginationSnap"></div>
		</div>
			
		</div>
		
</body>
