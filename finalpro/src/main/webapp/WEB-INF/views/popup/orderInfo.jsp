<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var = "contextPath" value="${pageContext.request.contextPath}" />

<style>
	.title {
		text-align: center;
		margin: 30px;
	}
	
	h3 {
		margin: 0 0 10px 29px;
	}
	
	.table{
		border-collapse: collapse;
		margin: 10px 0 30px 30px;
	}
	
	.table td {
		padding : 10px;
		font-size: 14px;
		width: 270px;
		height: 20px;
	}
	
	.table th {
		width: 130px;
		font-size: 14px;
	}
	
	p {
		padding: 0;
		margin: 0
	}
	
</style>

<body>
	<h2 class = "title">배송 / 결제 정보</h2>

	<div class = "pop_content">
		<div class = "pop_orderInfo">
			<h3>배송 정보</h3>
			<div class = "pop_orderInfo_body">
				<table class = "table" border = "1">
					<tr>
						<th>이름</th>
						<td>${mypage.receiverName }</td>
					</tr>
					<tr>
						<th>주소</th>
						<td>${mypage.receiverAdress }</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>${mypage.receiverPhone }</td>
					</tr>
					<tr>
						<th>배송 요청 사항</th>
						<td>
							<c:choose>
								<c:when test="${mypage.deliveryRequest == 1}">
									<span>부재 시 경비실에 맡겨주세요.</span>
								</c:when>
								<c:when test="${mypage.deliveryRequest == 2}">
									<span>부재 시 택배함에 넣어주세요.</span>
								</c:when>
								<c:when test="${mypage.deliveryRequest == 3}">
									<span>부재 시 집 앞에 놔주세요.</span>
								</c:when>
								<c:when test="${mypage.deliveryRequest == 4}">
									<span>배송 전 연락 바랍니다.</span>
								</c:when>
								<c:when test="${mypage.deliveryRequest == 5}">
									<span>파손의 위험이 있는 상품입니다. 배송 시 주의해 주세요</span>
								</c:when>		
							</c:choose>
						</td>
					</tr>
				</table>
			</div>
		</div>
		
		<div class = "pop_paymentInfo">
			<h3>결제 정보</h3>
			<div class = "pop_paymentInfo_body">
				<table class = "table" border = "1">
					<tr>
						<th>결제</th>
						<td>
							<c:choose>
								<c:when test="${mypage.payment == 1 }">
									<c:choose>
										<c:when test = "${mypage.paymentCard == 1 }">
											<span>KB카드</span> /
										</c:when>
										<c:when test = "${mypage.paymentCard == 2 }">
											<span>신한카드</span> /
										</c:when>
										<c:when test = "${mypage.paymentCard == 3 }">
											<span>현대카드</span> /
										</c:when>
										<c:when test = "${mypage.paymentCard == 4 }">
											<span>삼성카드</span> /
										</c:when>
										<c:when test = "${mypage.paymentCard == 5 }">
											<span>농협카드</span> /
										</c:when>
										<c:when test = "${mypage.paymentCard == 6 }">
											<span>카카오뱅크</span> /
										</c:when>
										<c:when test = "${mypage.paymentCard == 7 }">
											<span>BC카드</span> /
										</c:when>
										<c:when test = "${mypage.paymentCard == 8 }">
											<span>하나카드</span> /
										</c:when>
										<c:when test = "${mypage.paymentCard == 9 }">
											<span>우리카드</span> /
										</c:when>
										<c:when test = "${mypage.paymentCard == 10 }">
											<span>롯데카드</span> /
										</c:when>
										<c:when test = "${mypage.paymentCard == 11 }">
											<span>새마을금고</span> /
										</c:when>
										<c:when test = "${mypage.paymentCard == 12 }">
											<span>케이뱅크</span> /
										</c:when>
									</c:choose>
									<c:choose>
										<c:when test = "${mypage.paymentMonth == 1 }">
											<span>일시불</span>
										</c:when>
										<c:when test = "${mypage.paymentMonth == 2 }">
											<span>2개월(무이자)</span>
										</c:when>
										<c:when test = "${mypage.paymentMonth == 3 }">
											<span>3개월(무이자)</span>
										</c:when>
										<c:when test = "${mypage.paymentMonth == 4 }">
											<span>4개월</span>
										</c:when>
										<c:when test = "${mypage.paymentMonth == 5 }">
											<span>5개월</span>
										</c:when>
										<c:when test = "${mypage.paymentMonth == 6 }">
											<span>6개월</span>
										</c:when>
										<c:when test = "${mypage.paymentMonth == 7 }">
											<span>7개월</span>
										</c:when>
										<c:when test = "${mypage.paymentMonth == 8 }">
											<span>8개월</span>
										</c:when>
										<c:when test = "${mypage.paymentMonth == 9 }">
											<span>9개월</span>
										</c:when>
										<c:when test = "${mypage.paymentMonth == 10 }">
											<span>10개월</span>
										</c:when>
										<c:when test = "${mypage.paymentMonth == 11 }">
											<span>11개월</span>
										</c:when>
										<c:when test = "${mypage.paymentMonth == 12 }">
											<span>12개월</span>
										</c:when>
									</c:choose>
								</c:when>
								<c:when test="${mypage.payment == 2 }">
									<span>가상 계좌 은행 : </span>
									<c:choose>
										<c:when test = "${mypage.paymentBank == 1 }">
											<span>기업은행</span>
										</c:when>
										<c:when test = "${mypage.paymentBank == 2 }">
											<span>국민은행</span>
										</c:when>
										<c:when test = "${mypage.paymentBank == 3 }">
											<span>우리은행</span>
										</c:when>
										<c:when test = "${mypage.paymentBank == 4 }">
											<span>수협은행</span>
										</c:when>
										<c:when test = "${mypage.paymentBank == 5 }">
											<span>농협중앙회</span>
										</c:when>
										<c:when test = "${mypage.paymentBank == 6 }">
											<span>부산은행</span>
										</c:when>
										<c:when test = "${mypage.paymentBank == 7 }">
											<span>신한은행</span>
										</c:when>
										<c:when test = "${mypage.paymentBank == 8 }">
											<span>하나은행</span>
										</c:when>
										<c:when test = "${mypage.paymentBank == 9 }">
											<span>광주은행</span>
										</c:when>
										<c:when test = "${mypage.paymentBank == 10 }">
											<span>우체국</span>
										</c:when>
										<c:when test = "${mypage.paymentBank == 11 }">
											<span>대구은행</span>
										</c:when>
										<c:when test = "${mypage.paymentBank == 12 }">
											<span>경남은행</span>
										</c:when>
									</c:choose>
								</c:when>
								<c:when test="${mypage.payment == 3 }">
									<p>Apple Pay</p>
								</c:when>
								<c:when test="${mypage.payment == 4 }">
									<p>휴대폰</p>
								</c:when>
								<c:when test="${mypage.payment == 5 }">
									<p>카카오페이</p>
								</c:when>
								<c:when test="${mypage.payment == 6 }">
									<p>삼성페이</p>
								</c:when>
								<c:when test="${mypage.payment == 7 }">
									<p>네이버페이</p>
								</c:when>
								<c:when test="${mypage.payment == 8 }">
									<p>페이코</p>
								</c:when>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th>결제 금액</th>
						<td>${mypage.orderPrice }원</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	
</body>
