<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />
<c:set var = "msg" value = '<%=request.getParameter("msg") %>' />
<link rel ="stylesheet" href="${contextPath }/resources/css/mainEx.css">

<title>장바구니</title>

<c:if test = '${ msg == "notProduct" }'>
	<script>
			alert('선택하신 상품이 없습니다.');
	</script>
</c:if>

<script>
	function selectOne(){
		const checkboxes = document.getElementsByName('product-checkbox');
		let checkedCount = 0;
		
		checkboxes.forEach(checkbox => {
			if(checkbox.checked) {
				checkedCount++;
			}
		});
		
		const selectall = document.getElementById('selectAllProduct');
		
		if(checkboxes.length == checkedCount) {
			selectall.checked = true;
		}else{
			selectall.checked = false;
		}
		console.log(checkboxes);
		console.log(checkboxes.length);
		console.log(selectall);
		console.log(checkedCount);
	}

	function selectAll(selectAll){
		const checkboxes = document.getElementsByName('product-checkbox');
		
		checkboxes.forEach((checkbox) => {
			checkbox.checked = selectAll.checked;
		})
	}
	
	function decreaseCount(no, orginalPrice){
		let clickName = document.getElementById('count'+no);
		let count = parseInt(clickName.textContent);
		let totalPrice = document.getElementById('price'+no);
		let total = parseInt(totalPrice.textContent.replace(/,/g, ''));
		let size = document.getElementById('size'+no);
		console.log(no);
		let productSize = size.textContent;
		
		if(count > 1){
			count--;
			total = orginalPrice * count;
		}else {
			alert('1개 이상 구매 가능합니다.')
		}
		location.href = "${contextPath}/mypage/changeCount.do?count=" + count + "&no=" + no;
	}
	
	function increaseCount(no, stock, orginalPrice){
		const clickName = document.getElementById('count'+no);
		let count = parseInt(clickName.textContent);
		const totalPrice = document.getElementById('price'+no);
		let total = parseInt(totalPrice.textContent.replace(/,/g, ''));
		const size = document.getElementById('size'+no);
		let productSize = size.textContent;
		
		if(count <= stock){
			count++;
			total = orginalPrice * count;
		}
		
		if(count > stock){
			alert('재고가 부족합니다.');
			count--;
		}
		location.href = "${contextPath}/mypage/changeCount.do?count=" + count + "&no=" + no;
	}
	
	function addCommasToNumber(number) {
	    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function deleteCart1(no) {
		if(confirm("선택하신 상품을 삭제 하시겠습니까?")){
			location.href = "${contextPath}/mypage/deletecart.do?no=" + no;
		}
	}
	
	function deleteCart2() {
		var noList = [];
		var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
		if(checkboxes != null && checkboxes.length != 0){
			if(confirm("선택하신 상품을 삭제 하시겠습니까?")){
				  
				checkboxes.forEach(function(checkbox) {
					if(checkbox.value != 'on'){
						noList.push(checkbox.value);
					}
				});
				location.href = "${contextPath}/mypage/deletecart.do?noList=" + noList.join(",");
			}
		}else {
			alert('선택하신 상품이 없습니다.');
		}
	}
	
	function orderButton() {
		
		var noList = [];
		var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
		
		if(checkboxes != null && checkboxes.length != 0){
			checkboxes.forEach(function(checkbox) {
	            if (checkbox.value != 'on') {
	                noList.push(checkbox.value);
	            }
	        });	  
			location.href = "${contextPath}/mypage/recepit.do?noList=" + noList.join(",");
		}else {
			alert('상품을 선택해주세요.');
		}
	}
	
	function checkNone(obj) {
		obj.checked = false;
		alert('재고가 없어 구매할 수 없습니다.');
	}
	
	function deleteNonStockProduct() {
	    if(confirm("품절된 상품을 모두 삭제하시겠습니까?")) {
	            location.href = "${contextPath}/mypage/deleteNonStockProduct.do";
	    }
	}
	
	function nonOrder() {
		alert('상품이 없습니다. 상품을 추가해 주세요.');
	}
	
</script>

<style>
	.title {
		position: relative;
	}
	
	.title h2 {
		margin-left: 20px;
	}
	
	.title .titleInfo {
		position: absolute;
		right: 38px;
		top: 25%;
	}

    .product-info-container {
        display: flex;
        align-items: center;
    }

    .product-info-container .options {
        margin-left: 10px;
    }

    .product-info-container .options span {
        margin-right: 5px;
    }
    
    .table th, .table td{
		padding: 17px;
	}
	 
	.table {
	 	margin: 30px 0 20px 17px;
	 	width: 95%;
	 	border-collapse: collapse;
	 	border-spacing: 5px;
	 	text-align: center;
	 	font-size: 14px;
	}
	 
	 .table tr{
	 	margin: 20px 0 0 0;
	 	width: 100%;
	 	border: 1px solid black;
	 	border-left: none;
	 	border-right: none;
	 }
	 
	 button.requestBtn {
		background-color: lightgary;
		border: none;
		border-radius: 5px;
		color: gray;
		font-weight: 600;
		width: 100px;
		height: 30px;
	}
	
	button.requestBtn:hover {
        background-color: black;
        color: white;
    }
    
    button.orderSubmit {
    	background-color: black;
		border: none;
		border-radius: 5px;
		color: white;
		font-weight: 600;
		width: 150px;
		height: 50px;
		display: block;
    	margin: 30px auto;
    	font-size: 18px;
    }
    
    .orderListInfo, .textNonBasket {
    	padding : 0 0 10px 20px;
		font-size: 13px;
		color: gray;
		font-weight: bold;
		margin : 0;
    }
    .orderListInfo p, .textNonBasket {
    	padding-top: 15px;
    }
    
    .button {
    	margin-left: 18px;
    }
    
    .basketDiv img {
    	margin: 0 8px 0 0;
    }
    
    .optionDiv {
    	color: gray;
    	font-size: 12px;
    }
    
    .all {
    	overflow: hidden;
    	width: 1070px;
    }
    
</style>

<body>
	
	<div class = "all">
	<div class="title">
		<h2>Order / Payment</h2>
		<div class="titleInfo">
			<b>장바구니</b><b style="color: #aaaaaa;"> > 주문서</b><b
				style="color: #aaaaaa;"> > 주문 완료</b>
		</div>
	</div>

	<c:choose>
		<c:when test="${cartList != null && cartList.size() != 0 }">
			<form name="cartForm" action="${contextPath}/mypage/receipt.do">
				<div class = "basketDiv">
					<table class = "table">
						<tr class = "tableHeader">
							<th width="4%">전체</th>
							<th width="1%"><input id="selectAllProduct" type="checkbox" checked="checked" onclick="selectAll(this)"></th>
							<th width="23%">상품명(옵션)</th>
							<th width="7%">판매가</th>
							<th width="8%">수량</th>
							<th width="7%">주문금액</th>
							<th width="7%">삭제</th>
							<th width="10%">배송비</th>
						</tr>

						<c:forEach var="cart" items="${cartList }" varStatus="status">
							<tr>
								<td>${status.count}</td>
								<td><c:choose>
										<c:when test="${cart.count == 0}">
											<input type="checkbox" onclick="checkNone(this)" name="nonCheck">
										</c:when>
										<c:otherwise>
											<input type="checkbox" onclick="selectOne()" name="product-checkbox" checked="checked" value="${cart.no}">
										</c:otherwise>
									</c:choose></td>
								<td>
									<div class="product-info-container">
										<a href="${contextPath }/product/detailProduct.do?productNo=${cart.productNo}">
											<img width="80px" height="105px" src="${contextPath }/download.do?imageFileName=${cart.imageFileName}&productNo=${cart.productNo}&path=product" alt = "${cart.name }">
										</a>
										<div class="product-details">
											<p>
												<b><a class = "productName" href="${contextPath }/brand/brandList.do?brand=${cart.brand}">[${cart.brand }]</a><br>
												<a href="${contextPath }/product/detailProduct.do?productNo=${cart.productNo}">${cart.name }</a></b>
											</p>
											<c:choose>
												<c:when test="${cart.stock >= 5 }">
													<span class = "optionDiv">옵션: 
										                <c:if test="${cart.productSize != null }">
										                    <span id="size${cart.no }">${cart.productSize }</span> /
										                </c:if>
										                재고: 5개 이상
										            </span>
												</c:when>
												<c:otherwise>
													<span class = "optionDiv">옵션 : 
														<c:if test="${cart.productSize != null }">
															<span id="size${cart.no }">${cart.productSize }</span>
															/
														</c:if>
														재고 : ${cart.stock }
													</span>
											</c:otherwise>
											</c:choose>
										</div>
									</div>
								</td>
								<td><span class="price">${cart.price }원</span></td>
								<td>
									<svg onclick="decreaseCount('${cart.no}', ${cart.price })"  width="15px" height="15px" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg"><defs><style>.cls-1{fill:none;}</style></defs><title/><g data-name="Layer 2" id="Layer_2"><path d="M16,29A13,13,0,1,1,29,16,13,13,0,0,1,16,29ZM16,5A11,11,0,1,0,27,16,11,11,0,0,0,16,5Z"/><path d="M22,17H10a1,1,0,0,1,0-2H22a1,1,0,0,1,0,2Z"/></g><g id="frame"><rect class="cls-1" height="32" width="32"/></g></svg>
									<span id="count${cart.no }">${cart.count }</span>개
									<svg onclick="increaseCount('${cart.no}', ${cart.stock }, ${cart.price })" width="15px" height="15px" viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg"><defs><style>.cls-1{fill:none;}</style></defs><title/><g data-name="Layer 2" id="Layer_2"><path d="M16,29A13,13,0,1,1,29,16,13,13,0,0,1,16,29ZM16,5A11,11,0,1,0,27,16,11,11,0,0,0,16,5Z"/><path d="M16,23a1,1,0,0,1-1-1V10a1,1,0,0,1,2,0V22A1,1,0,0,1,16,23Z"/><path d="M22,17H10a1,1,0,0,1,0-2H22a1,1,0,0,1,0,2Z"/></g><g id="frame"><rect class="cls-1" height="32" width="32"/></g></svg>
								<td>
									<span id="price${cart.no }" class="price">${cart.orderPrice }</span>원
								</td>
								<td>
									<button class = "requestBtn" type="button" onclick="deleteCart1(${cart.no})">삭제하기</button>
								</td>
								<td>
									<p>택배배송</p>
									<p>배송무료</p>
									<p>0원 이상 무료</p>
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				
				<div class = "button">
					<button class = "requestBtn" type="button" onclick="deleteNonStockProduct()">품절모두삭제</button>
					<button class = "requestBtn" type="button" onclick="deleteCart2()">선택삭제</button>
					<br>
				</div>

				<div class = "orderListInfo">
					<p>· 제주/도서산간 지역 제외 전 지역, 전 상품 무료 배송입니다.</p>
					<p>· 2개 이상의 브랜드를 주문하신 경우, 개별 배송됩니다.</p>
					<p>· 해외배송 상품은 배송료가 추가로 발생될 수 있습니다.</p>
					<p>· 장바구니 상품은 최대 1년 보관되며 담은 시점과 현재의 판매 가격이 달라질 수 있습니다.</p>
				</div>

				<button class = "orderSubmit" type="button" onclick="orderButton()">주문하기</button>
			</form>
		</c:when>
		<c:otherwise>
			<div class = "basketDiv">
				<table class = "table">
					<tr class = "tableHeader">
						<td>전체</td>
						<td><input id="selectAllProduct" type="checkbox" checked="checked" onclick="selectAll(this)"></td>
						<td>상품명(옵션)</td>
						<td>판매가</td>
						<td>수량</td>
						<td>주문금액</td>
						<td>삭제</td>
						<td>배송비</td>
					</tr>
					<tr>
						<td class = "textNonBasket" colspan="8">장바구니에 담긴 상품이 없습니다.</td>
					</tr>
				</table>
			</div>
			
			<div class = "orderListInfo">
				<p>· 제주/도서산간 지역 제외 전 지역 전 상품 무료 배송입니다.</p>
				<p>· 2개 이상의 브랜드를 주문하신 경우, 개별 배송됩니다.</p>
				<p>· 해외배송 상품은 배송료가 추가로 발생될 수 있습니다.</p>
				<p>· 장바구니 상품은 최대 1년 보관되며 담은 시점과 현재의 판매 가격이 달라질 수 있습니다.</p>
			</div>

			<button class = "orderSubmit" type="button" onclick="nonOrder()">주문하기</button>
		</c:otherwise>
	</c:choose>
	</div>
</body>
</html>