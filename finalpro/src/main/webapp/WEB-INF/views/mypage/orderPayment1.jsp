<%@page import="com.spring.finalpro.mypage.dto.MypageDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    

<c:set var = "contextPath" value="${pageContext.request.contextPath}" />

<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<c:if test = "${msg == 'noAddress' }">
	<script>
		alert('주소를 추가해주세요.');
 		location.href = "${contextPath}/member/addressDetailForm.do?id=${loginId}"
	</script>
</c:if>

<script>
window.onload = function() {
    showAddressInfo();
    showProductInfo();
};



var addressList = [
    <c:forEach var="address" items="${addressList}" varStatus="status">
        {
            addressName: "${address.addressName}",
            recipient: "${address.recipient}",
            addressPhone: "${address.addressPhone}",
            address: "${address.address}"
        }<c:if test="${not status.last}">,</c:if>
    </c:forEach>
];

function showProductInfo() {
	let i = 1;
	
    while (true) {
        let storedProductStr = sessionStorage.getItem('selectedProduct' + i);
        
        if (storedProductStr == null){
        	break;
        }
        
        let storedProduct = JSON.parse(storedProductStr);
        console.log(storedProduct);
        console.log(storedProduct.productNo);
        console.log(storedProduct.name);
        console.log(storedProduct.brand);
        console.log(storedProduct.size);
        console.log(storedProduct.color);
        console.log(storedProduct.quantity);
        console.log(storedProduct.price);
        let price = addCommasToNumber(storedProduct.price);
        // 테이블에 상품 정보 추가
        let tableRow = document.createElement('tr');
        let productInfoList = storedProduct.productNo + "," + storedProduct.size+"," + storedProduct.quantity + ","+storedProduct.price * storedProduct.quantity;
        console.log(productInfoList);
        
        tableRow.innerHTML = '<td align="center" width="7%" height="95px"><a href = "${contextPath }/product/detailProduct.do?productNo='+ storedProduct.productNo + '">' 
        + '<img width="80px" height="90px" src="${contextPath}/download.do?imageFileName=1.jpg&productNo='
        + storedProduct.productNo + '&path=procuct"></a></td><td align="left" width="15%"><b style="font-size:13px; margin: 0 10px;"><a href = "${contextPath }/brand/brandList.do?brand='+ storedProduct.brand + '">['
        + storedProduct.brand + ']</a><a href = "${contextPath }/product/detailProduct.do?productNo='+ storedProduct.productNo + '">' + storedProduct.name + '</a></b><br><span class="option">옵션: ' + storedProduct.size
        + '</span></td><td>'+ storedProduct.quantity + '개</td><td>무료</td><td>'+ price +'원</td>' + 
        '<input type="hidden" name="productInfoList" value="' + productInfoList + '">';
        
        document.getElementById('productInfoTable').appendChild(tableRow);
        
        let orderPriceBtn = document.getElementById('submitButton');
        
        orderPriceBtn.value = addCommasToNumber((storedProduct.price * storedProduct.quantity)) + '원 결제하기';
        
        i++;
    }
}
	
	function showAddressInfo(){
		var selectedAddressName = document.querySelector('input[name="addressName"]:checked').value;
	
	    for (var i = 0; i < addressList.length; i++) {
	        var address = addressList[i];
	        if (address.addressName == selectedAddressName) {
	            document.querySelector("input[name='receiverName']").value = address.recipient;
	            document.querySelector("input[name='receiverPhone']").value = address.addressPhone;
	            document.querySelector("input[name='receiverAdress']").value = address.address;
	            break;
	        }
	    }
	}
	
	function paymentETC(payType) {
		document.querySelectorAll('#payETC > div').forEach(div => {
            div.style.display = 'none';
        });
		document.querySelectorAll('.' + payType).forEach(element => {
	        element.style.display = 'block';
	    });
	}
	
	function addCommasToNumber(number) {
	    return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function orderProduct(obj){
		var deliveryRequest = document.getElementsByName("deliveryRequest")[0].value;
	    var paymentType = document.querySelector('input[name="payment"]:checked').value;

	    if (deliveryRequest == 0) {
	        alert("배송 시 요청 사항을 선택해주세요.");
	        document.getElementsByName("deliveryRequest")[0].focus();
	        return;
	    } else if (paymentType == 1) {
	        var paymentCard = document.getElementsByName("paymentCard")[0].value;
	        var paymentMonth = document.getElementsByName("paymentMonth")[0].value;
	        
	        if (paymentCard == 0 || paymentMonth == 0) {
	            alert("결제 카드와 결제 기간을 선택해주세요.");
	            if (paymentCard == 0) {
	                document.getElementsByName("paymentCard")[0].focus();
	                return;
	            } else {
	                document.getElementsByName("paymentMonth")[0].focus();
	                return;
	            }
	        }
	        
	    } else if (paymentType == 2) {
	        var paymentBank = document.getElementsByName("paymentBank")[0].value;

	        if (paymentBank == 0) {
	            alert("입금은행을 선택해주세요.");
	            document.getElementsByName("paymentBank")[0].focus();
	            return;
	        }
	    }
		obj.action = "${contextPath}/mypage/insertOrderList.do";
		obj.submit();
	}
	
	document.addEventListener('DOMContentLoaded', function() {
        var buttons = document.querySelectorAll('.pay_type input[type=radio]+label');
        buttons.forEach(function(button) {
            button.addEventListener('click', function() {
                // 현재 활성화된 버튼을 찾아 이전에 활성화된 버튼의 클래스를 제거합니다.
                var currentActiveButton = document.querySelector('.pay_type input[type=radio]+label.active');
                if (currentActiveButton) {
                    currentActiveButton.classList.remove('active');
                }
                
                // 현재 클릭된 버튼에 활성화 클래스를 추가합니다.
                button.classList.add('active');
            });
        });
    });
	
</script>

<style>
	body {
		margin: 0;
	}
	
	hr {
		width: 97%;
	}
	
	.title {
		position: relative;
	}
	
	.title h2 {
		margin: 0 0 30px 20px;
	}
	
	.title .titleInfo {
		position: absolute;
		right: 38px;
		top: 25%;
	}
	
	.deliveryInfo {
		margin: 20px 20px;
	}
	
	.deliveryInfo h3, .productInfo h3, .paymentInfo h3 {
		margin: 35px 0 20px 0;
	}
	
	.deliveryInfo table, .deliveryInfo tr{
		border : 1px solid #aaaaaa;
		border-collapse: collapse;
		width: 100%;
	}
	
	.deliveryInfo td, .deliveryInfo th {
		padding: 10px;
	}
	
	.deliveryInfo th {
		text-align: left;
		font-size: 14px;
	}
	
	.productInfo {
		margin: 10px 0 0 20px;
	}
	
	.productInfo table, .productInfo tr{
		border-collapse: collapse;
		width: 98%;
		text-align: center;
	}
	
	.productInfo td, .productInfo th{
		border : 1px solid #aaaaaa;
		padding : 8px;
	}
	
	.productInfo .option {
		color : black;
		background-color: #efefef;
		padding: 10px;
		font-size: 10px;
		border : 1px solid #c8c8c8;
		display: block;
		width : 500px;
		margin: 7px 10px 7px 10px;
	}
	
	.buyInfo{
		padding : 0 0 10px 0;
		font-size: 13px;
		color: gray;
		font-weight: bold;
		margin : 0;
	}
	
	.buyInfo p {
		padding-top: 10px;
	}
	
	.paymentInfo {
		margin: 0 0 100px 20px;
	}
	
	.paymentInfo table {
		border : 1px solid #aaaaaa;
		border-collapse: collapse;
		width: 98%;
		height: 250px;
	}
	
	.paymentInfo td, .paymentInfo th {
		padding: 10px 15px;
		border : 1px solid #aaaaaa;
		height: 50px;
		font-size: 14px;
	}
	
	tr .pay_type_title {
		text-align: center;
		font-weight: bold;
		width: 150px;
	}
	
	.paymentInfo 
	
	.pay_type input[type=radio] {
		display : none;
	}
	
	.pay_type input[type=radio]+label {
		display:inline-block;
		height: 40px;
		width: 130px;
		border: 1px solid #aaaaaa;
		border-radius: 3px;
		text-align: center;
		padding-top: 10px;
		margin: 15px 10px;
	}
	
	.pay_type input[type=radio]+label:hover, .pay_type input[type=radio]+label.active {
		background-color : black;
		color: white;
	}
	
	.pay_type select {
		width: 130px;
		padding: 5px;
		border-radius: 3px;
		margin-left: 10px;
		border : 1px solid #aaaaaa;
		text-align: left;
	}
	
	.pay_type p {
		margin-left: 10px;
	}
	
	.totalPrice input {
		color: white;
	    vertical-align: middle;
	    border: 0;
	    border-radius: 3px;
	    outline: none;
	    background-color: black;
	    width: 250px;
	    height: 50px;
	    font-size: 18px;
	    display: block;
	    margin: 50px auto;
	}
	
	.add-button, .del-button {
		background-color: lightGray;
		padding: 5px;
		border-radius: 5px;
		border : 1px solid lightGray;
	}
	
	.add-button:hover, .del-button:hover {
		background-color: black;
		color : white;
		padding: 5px;
		border-radius: 5px;
		border : 1px solid black;
	}
	
</style>

<body>
	<div class = "title">
		<h2>Order / Payment</h2>
		<div class = "titleInfo"><b style="color:#aaaaaa;">장바구니 > </b><b>주문서</b><b style="color:#aaaaaa;"> > 주문 완료</b></div>
	</div>
	
	<hr>
	
	<form name='frm'>
	<div class = "deliveryInfo">
		<h3>배송 정보</h3>
		<table class = "table">
			<tr>
				<th width="17%">배송지</th>
				<td>
					<c:forEach var="address" items="${addressList }" varStatus="status">
						<input type="radio" onclick="showAddressInfo()" name="addressName" 
							<c:if test="${status.index == 0}">checked="checked"</c:if> value="${address.no}">
							${address.addressName}
					</c:forEach>
					<c:if test="${fn:length(addressList) < 3}">
					    <button class="add-button" onclick="sendPostRequest()">새 배송지 추가</button>
					</c:if>
					<c:if test="${fn:length(addressList) > 0}">
 						<button class = "del-button" onclick = "delAddress()">배송지 삭제</button>
 					</c:if>
				</td>
			</tr>
			<c:forEach begin="0" end="0" var="address" items="${addressList }">
				<tr>
					<th>이름/연락처</th>
					<td id = "nameAndPhone">
						<input type = "text" name = "receiverName" readonly="readonly" value = "${address.recipient }"> | 
						<input type = "text" name = "receiverPhone" readonly="readonly" value = "${address.addressPhone }">
					</td>
				</tr>
				<tr>
					<th>주소</th>
					<td>
						<input type = "text" name = "receiverAdress" readonly="readonly" value = "${address.address }">
					</td>
				</tr>
			</c:forEach>
			<tr>
				<th>배송 요청사항</th>
				<td>
					<select name="deliveryRequest">
						<option value = "0">배송 시 요청사항을 선택해주세요.</option>
						<option value = "1">부재 시 경비실에 맡겨주세요.</option>
						<option value = "2">부재 시 택배함에 넣어주세요.</option>
						<option value = "3">부재 시 집 앞에 놔주세요.</option>
						<option value = "4">배송 전 연락 바랍니다.</option>
						<option value = "5">파손의 위험이 있는 상품입니다. 배송 시 주의해 주세요.</option>
					</select>
				</td>
			</tr>
		</table>
	</div>
	
	<div class = "productInfo">
		<h3>상품 정보</h3>
		<table class = "table" id = "productInfoTable">
			<tr>
				<th colspan="2">상품정보</th>
				<th>수량</th>
				<th>배송비</th>
				<th>주문금액</th>
			</tr>
		</table>
		<div class = "buyInfo">
			<p>· 구매 가능 수량이 1개로 제한된 상품은 주문 취소 시, 24시간 내 가상계좌 재주문이 불가합니다.</p>
			<p>· 대한민국 내 제주도 및 도서 산간 지역 제외 전 지역, 전 상품 무료배송입니다.</p>
			<p>· 해외 배송 상품이나 일부 업체의 경우, 교환/환분 시 반송료가 다를 수 있으며 상품 페이지에 별도 표기되어 있습니다.</p>
			<p>· 두개 이상의 브랜드(업체) 상품을 주문하신 경우, 각 개별 배송됩니다.</p>
		</div>
		
	</div>
	
	<div class = "paymentInfo">
		<h3>결제 정보</h3>
		<table class = "pay_type">
			<tr>
				<td rowspan="2" class = "pay_type_title">결제 수단</td>
				<td class = "payment_type_choice">
					<input type = "radio" id = "card" onclick="paymentETC('card')" name = "payment" checked="checked" value = "1" />
					<label for="card">카드</label>
					<input type = "radio" id = "virtualAccount" onclick="paymentETC('virtualAccount')" name = "payment" value = "2"/>
					<label for="virtualAccount">가상계좌</label>
					<input type = "radio" id = "applePay" onclick="paymentETC('applePay')" name = "payment" value = "3"/>
					<label for="applePay">Apple Pay</label>
					<input type = "radio" id = "phonePay" onclick="paymentETC('phonePay')" name = "payment" value = "4"/>
					<label for="phonePay">휴대폰</label><br>
					<input type = "radio" id = "kakaoPay" onclick="paymentETC('kakaoPay')" name = "payment" value = "5"/>
					<label for="kakaoPay">카카오페이</label>
					<input type = "radio" id = "samsungPay" onclick="paymentETC('samsungPay')" name = "payment" value = "6"/>
					<label for="samsungPay">삼성페이</label>
					<input type = "radio" id = "naverPay" onclick="paymentETC('naverPay')" name = "payment" value = "7"/>
					<label for="naverPay">네이버페이</label>
					<input type = "radio" id = "payco" onclick="paymentETC('payco')" name = "payment" value = "8"/>
					<label for="payco">페이코</label><br>
				</td>
			</tr>
			<tr>
				<td>	
					<div id = "payETC">
						<div class = "card">
							<select name = "paymentCard">
								<option value = "0">카드선택</option>
								<option value = "1">KB카드</option>
								<option value = "2">신한카드</option>
								<option value = "3">현대카드</option>
								<option value = "4">삼성카드</option>
								<option value = "5">농협카드</option>
								<option value = "6">카카오뱅크</option>
								<option value = "7">BC카드</option>
								<option value = "8">하나카드</option>
								<option value = "9">우리카드</option>
								<option value = "10">롯데카드</option>
								<option value = "11">새마을금고</option>
								<option value = "12">케이뱅크</option>
							</select>	
							<select name = "paymentMonth">
								<option value = "0">개월선택</option>
								<option value = "1">일시불</option>
								<option value = "2">2개월(무이자)</option>
								<option value = "3">3개월(무이자)</option>
								<option value = "4">4개월</option>
								<option value = "5">5개월</option>
								<option value = "6">6개월</option>
								<option value = "7">7개월</option>
								<option value = "8">8개월</option>
								<option value = "9">9개월</option>
								<option value = "10">10개월</option>
								<option value = "11">11개월</option>
								<option value = "12">12개월</option>
							</select>
						</div>	
						<div class = "virtualAccount" style="display : none;">
							<select name="paymentBank">
								<option value = "0">입금은행 선택</option>
								<option value = "1">기업은행</option>
								<option value = "2">국민은행</option>
								<option value = "3">우리은행 </option>
								<option value = "4">수협은행</option>
								<option value = "5">농협중앙회</option>
								<option value = "6">부산은행</option>
								<option value = "7">신한은행</option>
								<option value = "8">하나은행</option>
								<option value = "9">광주은행</option>
								<option value = "10">우체국</option>
								<option value = "11">대구은행</option>
								<option value = "12">경남은행</option>
							</select>
						</div>
						<div class = "phonePay" style="display : none;">
							<p>· 부분환불/결제 월이 지난 경우, 계좌로 환불 됩니다.
						</div>
						<div class = "naverPay" style="display : none;">
							<p>· 네이버페이 카드 간편결제 시 카드사별 무이자, 청구할인은 네이버페이에서 제공하는 혜택만 적용됩니다.
						</div>
						<div class = "kakaoPay" style="display : none;">
							<p>· 모든 카드(신용/체크), 계좌 결제 가능, 카카오페이포인트 결제 가능
						</div>
					</div>
				</td>
			</tr>
		</table>
		
		<div class = "totalPrice">
			<input id="submitButton" type = "button" onclick="orderProduct(this.form)" value="${totalPrice}원 결제하기"> 
		</div>
	</div>
	</form>
</body>

<script>
function sendPostRequest() {
    var form = document.createElement("form");
    form.setAttribute("method", "post");
    form.setAttribute("action", "${contextPath}/member/addAddressForm.do");
    form.setAttribute("target", "popupWindow"); 

   
    var idField = document.createElement("input");
    idField.setAttribute("type", "hidden");
    idField.setAttribute("name", "id");
    idField.setAttribute("value", "${param.id }");
    form.appendChild(idField);

    document.body.appendChild(form);


    var popupWindow = window.open('', 'popupWindow', 'width=700,height=600,scrollbars=yes');
    form.submit();


    document.body.removeChild(form);
}

function delAddress() {
    var selectedAddress = document.querySelector('input[name="addressName"]:checked').value;
    console.log(selectedAddress);

    let frm = document.frm;
    console.log(frm);
    frm.action = "${contextPath}/member/delAddress1.do?no=" + selectedAddress;
    frm.method = 'post';
    frm.submit();
}
</script>