<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
</head>



<link rel="stylesheet"
	href="/finalpro/resources/css/customerService.css">

<!-- <script type="text/javascript">
document.addEventListener('DOMContentLoaded', function() {
    var faqQuestions = document.querySelectorAll('.faqQuestion');

    faqQuestions.forEach(function(question) {
        question.addEventListener('click', function() {
            var answer = this.nextElementSibling;
            var isAnswerVisible = answer.style.display === 'block';
            // Hide all answers
            document.querySelectorAll('.faqAnswer').forEach(function(a) {
                a.style.display = 'none';
            });
            // Show this answer if it was previously hidden
            if (!isAnswerVisible) {
                answer.style.display = 'block';
            }
        });
    });
});
</script> -->




<script type="text/javascript">
	// Assuming the login status is passed from the server and stored in a JavaScript variable
	var isLoggedIn = <c:out value="${isLoggedIn}"/>;

	function checkLoginBeforeMyOrder() {
		if (!isLoggedIn) {
			alert('로그인 해주세요');
		} else {
			window.location.href = '/finalpro/mypage/orderList.do';
		}
	}

	function checkLoginBeforeFindId() {
		if (isLoggedIn) {
			alert('이미 로그인 되어 있습니다.');
		} else {
			window.location.href = '/finalpro/member/FindId.do';
		}
	}

	function checkLoginBeforeFindPass() {
		if (isLoggedIn) {
			alert('이미 로그인 되어 있습니다.');
		} else {
			window.location.href = '/finalpro/member/FindPw.do';
		}
	}
</script>

<body>
	<div class="customer_service"> 
		<h2 class="title">CS Center</h2>
		<div class="main">
			<div class="main-content">
				<div class="flex-container">
					<div class="title2">
						<h2>TEL. 0000-0000</h2>
						<div class="user">
							<div class="time">- 평일 9:00~1800</div>
							<div class="user-email">- 토,일 공휴일 휴무</div>
						</div>
					</div>
					<div class="title3">
						<a href="javascript:void(0);" onclick="checkLoginBeforeMyOrder();"
							class="myOrder">My Order</a> <a href="javascript:void(0);"
							onclick="checkLoginBeforeFindId();" class="FindId">Find Id</a> <a
							href="javascript:void(0);" onclick="checkLoginBeforeFindPass();"
							class="FindPass">Find Pass</a>
					</div>
				</div>
			</div>
		</div>
	
		<!-- <div class="FAQ" id="faqSection">
	    <div class="faqItem">
	        <div class="faqQuestion">휴먼 회원 전환 예정 메일을 받았어요.</div>
	        <div class="faqAnswer">여기에는 답변 내용이 들어갑니다. 답변은 클릭 시 보입니다.</div>
	    </div>
	    Repeat the above for each FAQ item
	</div> -->
	
		
		<h2 class="blind">FAQ</h2>
			
		<div class="MFaqTable">
			<div class="CFaqTableHeader">
				<p class="CFaqTableHeader__category">구분</p>
				<p class="CFaqTableHeader__title">제목</p>
			</div>
			<div class="CFaqTableItem-box">
				<div class="CFaqTableItem">
				    <div class="CFaqTableItem__list">
				        <em class="CFaqTableItem__category">로그인/정보</em>
				        <p class="CFaqTableItem__question">아이디와 비밀번호가 기억나지 않아요.</p>
				    </div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								로그인 화면에서 &nbsp;아이디 찾기/비밀번호 찾기를 통해 확인 가능합니다.<br>
								<br> 아이디 찾기는 아래 3가지 방법 중 하나로 진행해 주세요.<br>
								<br> <br>
								<br> ■ 휴대전화<br>
								<br> 회원 정보에 등록된 본인의 휴대전화 번호를 인증하는 방법입니다.<br>
								<br> <br>
								<br> ■ 이메일<br>
								<br> 회원 정보에 등록된 본인의 이메일 주소를 인증하는 방법입니다.<br>
								<br> <br>
								<br> ■ 본인인증<br>
								<br> 이용 중인 통신사와 휴대전화 번호를 인증하는 방법입니다.<br>
								<br> <br>
								<br> ※ 비밀번호 재설정을 완료한 휴면 회원은 휴면 해제 및 탈퇴 신청이 취소됩니다.<br>
								<br> ※ 비밀번호 찾기는 휴대전화 본인 인증으로만 가능합니다.<br>
								<br> <br>
							</p>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">로그인/정보</em>
						<p class="CFaqTableItem__question">회원 정보 수정은 어디서 하나요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								회원 정보 수정은 아래 경로로 직접 변경 가능합니다.&nbsp;<br>
								<br> <br>
								<br> ■ 회원 정보 수정&nbsp;<br>
								<br> 모바일(앱/웹) : 마이페이지 &gt; 내 정보 관리 &gt; 오른쪽 위 톱니바퀴<br>
								<br> PC(웹) : 마이페이지 &gt; 회원정보 변경<br>
								<br> ※ 원활한 주문 및 배송을 위해 회원 정보를 정확하게 기재해 주세요.<br>
								<br> <br>
								<br> ■ 이름 개명 시 수정<br>
								<br> 모바일(앱/웹) : 마이페이지 &gt; 내 정보 관리 &gt; 오른쪽 위 톱니바퀴 &gt; 회원
								정보 &gt; 이름/휴대전화/생년월일<br>
								<br> PC(웹) : 마이페이지 &gt; 회원정보 변경 &gt; 이름수정<br>
								<br> <br>
								<br> ※ 개명한 이름이 NICE 평가 정보에 등록되어 있어야 합니다.<br>
								<br> ※ 본인인증을 통해 NICE 평가 정보 적용된 이름(실명)을 기준으로 변경됩니다.<br>
							</p>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">상품 문의</em>
						<p class="CFaqTableItem__question">구매했을 때 보다 가격이 떨어졌어요 차액 환불이
							되나요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								상품 금액은 온라인 판매처 특성상 유동적으로 변동될 수 있어 차액 환불은 가능하지 않습니다.&nbsp;<br>
								<br> <br>
								<br> ※ 판매 가격 변동으로 인한 교환(환불) 신청 시 반품 배송비는 회원님 부담으로
								진행됩니다.&nbsp;<br>
								<br> ※ 출고 처리중인 경우 취소는 가능하지 않습니다.&nbsp;
							</p>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">상품 문의</em>
						<p class="CFaqTableItem__question">재고가 없어요. 언제쯤 구입할 수 있을까요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								품절 상품 재입고 여부 및 일정은 정확한 확인이 가능하지 않지만 재입고 알림을 등록하면 알림톡으로 확인 할 수
								있습니다. &nbsp;<br>
								<br> 알림 신청 방법은 아래내용을 확인해 주세요.<br>
								<br> <br>
								<br> ■ 재입고 알림 신청&nbsp;<br>
								<br> 모바일(앱) : 상품 선택 &gt; 구매하기 &gt; 재입고 알림 받기 선택<br>
								<br> <br>
								<br> ※ 재입고 알림 신청은 APP에서만 신청이 가능합니다.<br>
								<br> ※ 재고 입고 수량에서 요청순서에 따라 순차적으로 발송 됩니다.<br>
								<br> ※ 재입고 알림 버튼이 보이지 않거나 재입고 관련 상세확인은 상품 페이지의 상품문의를 이용해
								주세요.<br>
								<br> <br>
							</p>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">결제수단</em>
						<p class="CFaqTableItem__question">결제하는 방법에 따라 할인 이벤트가 있나요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								결제하는 수단에 따라 할인 이벤트가 있습니다.&nbsp;<br>
								<br> 할인 이벤트 확인 하는 방법은 아래 경로를 확인 해주세요.&nbsp;<br>
								<br> <br>
								<br> ■ 할인 이벤트 확인 경로&nbsp;<br>
								<br> 모바일(앱/웹) : 이벤트 &gt; 혜택에서 확인 가능&nbsp;<br>
								<br> PC(웹) : 세일 &gt; 기획전 에서 확인 가능&nbsp;<br>
								<br> <br>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">결제수단</em>
						<p class="CFaqTableItem__question">결제 방법에는 어떤 것들이 있나요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								주문서 작성 시 무신사페이 또는 일반결제로 결제 항목에서 선택이 가능합니다.&nbsp;<br>
								<br> <br>
								<br> ■ 무신사페이&nbsp;<br>
								<br> 신용카드 또는 은행 계좌 연결해서 간편하게 결제할 수 있습니다.<br>
								<br> <br>
								<br> ■ 일반 결제&nbsp;<br>
								<br> 신용카드, 가상계좌,&nbsp;Apple pay, 휴대폰결제, 토스 페이, 카카오 페이, 네이버
								페이, 페이코 결제가 있습니다.&nbsp;<br>
								<br> <br>
								<br> ※ 신용카드 결제 선택 시 안전 결제(ISP) 또는 안심클릭으로 결제됩니다. (30만원 이상 결제
								시 공인인증서 필요)<br>
								<br> ※ 원하는 결제 수단으로 체크 후 결제 가능합니다. (단, 복합 결제는 불가)&nbsp;<br>
								<br> ※ 그 외 문의 및 오류 관련 문의는 해당 결제 수단 고객센터로 문의해 주세요.&nbsp;<br>
								<br> ※ 주문 완료 후 결제 방법 변경은 가능하지 않습니다. (입금 확인 상태에서 취소 후 다시 주문)<br>
								<br> <br>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">주문</em>
						<p class="CFaqTableItem__question">상품을 받는 주소(배송지) 등록은 어떻게 하나요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								마이페이지 &gt; 배송지 관리 또는 주문서 작성 시 배송지 관리에서 배송 주소를 등록/수정/삭제할 수
								있습니다.&nbsp;<br>
								<br> <br>
								<br> 모바일(앱/웹) : 마이페이지 &gt; 내 정보 관리(오른쪽 위 톱니바퀴) &gt; 배송지 관리<br>
								<br> PC(웹) : 마이페이지 &gt; 회원정보 변경 &gt; 배송지 관리<br>
								<br> <br>
								<br> ※ 신규 배송지를 등록하더라도 기본배송지로 설정 되지 않으며, 기본 배송지로 설정 원할 경우
								기본배송지 설정을 별도로 해주셔야 합니다.<br>
								<br> ※ 주소지는 행정안전부의 [도로명 조회 사이트]에서 검색되는 주소를 기반으로 합니다.<br>
								<br> ※ 띄어쓰기, 오타 여부 및 검색을 통해 실제 있는 주소인지 확인해 주세요.<br>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">기타</em>
						<p class="CFaqTableItem__question">주문한 상품이 일부만 도착했어요.</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								브랜드 및 상품에 따라 출고지가 다르기 때문에 여러 개 상품을 주문한 경우에는 각각 배송이 됩니다.&nbsp;<br>
								<br> 브랜드가 달라도 상품 주문 시 한 번에 결제할 수 있습니다.&nbsp;<br>
								<br> <br>
								<br> 아직 도착하지 않는 상품은 아래 경로에서 배송진행 상황을 확인해 주세요.&nbsp;<br>
								<br> <br>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">배송 일반</em>
						<p class="CFaqTableItem__question">일반 배송 상품은 언제 배송 되나요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								일반배송은 브랜드마다 일정이 다르고 평일 기준으로 출고 됩니다.&nbsp;<br>
								<br> 출고 일정은 상품의 상세페이지 출고 정보에서 확인 가능합니다.&nbsp;<br>
								<br> <br>
								<br> ※ 평일 기준 출고로 연휴 및 공휴일은 배송일에서 제외됩니다.<br>
								<br> ※ 무신사스토어는 전 상품 100% 무료 배송입니다.&nbsp;<br>
								<br> ※ 배송 지연 상품의 경우 상품명에 지연으로 아이콘이 표시됩니다.&nbsp;<br>
								<br> ※ 출고 지연 발생 시에는 알림톡 또는 문자를 통해 안내해 드립니다.<br>
								<br> ※ 주문 시 배송 메모에 배송 희망 일자를 작성하셔도 해당일에 지정 배송은 어렵습니다.<br>
								<br> <br>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">취소/반품(환불)</em>
						<p class="CFaqTableItem__question">반품접수는 어떻게 하나요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								교환(환불) 접수 시 선택했던 방법으로 반품 접수해 주세요.<br>
								<br> <br>
								<br> ■ 회수해 주세요<br>
								<br> 무신사 자동회수 서비스로 택배기사가 요청한 회수지로 평일 기준 1일 ~ 3일 이내
								방문합니다.&nbsp;<br>
								<br> ※ 방문 전 택배 기사분이 연락 후 방문 예정이며, 비대면으로 상품을 전달할 때는 반품 상자를
								구분할 수 있도록 표시 후 회수 장소에 보관해 주세요.<br>
								<br> <br>
								<br> ■ 직접 보냈어요<br>
								<br> 상품을 받은 택배사와 같은 택배사로 고객님께서 직접 반품 예약을 해주셔야 합니다.<br>
								<br> 상품 회수 완료 시 반송장 정보를 입력해 주세요.<br>
								<br> <br>
								<br> ※ 계약된 택배사가 아닌 다른 택배사 이용 시 추가 비용 발생할 수 있고 2개 이상의 브랜드 반송
								시, 각각 반송지로 보내주세요.<br>
								<br> ※ 안내서에 배송비 동봉 등에 대한 내용이 있더라도, 동봉하면 안 됩니다.<br>
								<br> <br>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">취소/반품(환불)</em>
						<p class="CFaqTableItem__question">반송장 입력, 수정은 어떻게 하나요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								마이 페이지 &gt; 주문/배송/픽업 조회에서 교환(환불) 요청한 상품에 반송장 입력해 주셔야 빠른 처리가
								가능합니다.<br>
								<br> <br>
								<br> ■ 반송장 입력하기<br>
								<br> 마이 페이지 &gt; 주문/배송/픽업 조회&nbsp;<br>
								<br> 반송장 입력을 눌러 반품을 보낸 택배 업체와 송장 번호, 반품 날짜를 등록할 수 있습니다.<br>
								<br> <br>
								<br> ■ 반송장 수정하기<br>
								<br> 마이 페이지 &gt; 주문/배송/픽업 조회&nbsp;<br>
								<br> 반송장 수정을 선택 후 택배 업체, 송장 번호, 날짜를 변경 하면 완료됩니다.<br>
								<br> <br>
								<br> ※ "회수해 주세요"를 선택하여 반품한 경우에는 반송장 입력을 하지않습니다.&nbsp;<br>
								<br> ※ 교환(환불) 요청 다음 날부터 9일 이내 입력을 하지 않거나 상품이 반품 주소지에 도착하지 않는
								경우 반품은 취소되고 주문 상태는 구매 확정으로 변경됩니다.<br>
								<br> <br>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">교환/반품</em>
						<p class="CFaqTableItem__question">상품은 보냈는데 언제 교환상품이 배송 되나요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								교환 진행 과정은 아래 내용 참고해 주세요.&nbsp;<br>
								<br> <br>
								<br> ■ 교환 진행 과정&nbsp;<br>
								<br> 상품 회수 &gt; 반품 도착 &gt; 검수 진행 &gt; &nbsp;교환 상품 출고<br>
								<br> <br>
								<br> ※ 상품 회수 후 반품 도착까지 평일 기준 1일 ~ 2일 소요됩니다.&nbsp;<br>
								<br> ※ 검수 기간은 평일 기준 1일 ~ 3일 소요됩니다.&nbsp;<br>
								<br> ※ 교환 상품 출고 까지는 평일 기준 1일 ~ 3일 소요됩니다.&nbsp;<br>
								<br> ※ 해외 배송 교환의 경우 평일 기준 2주 이상 소요됩니다.&nbsp;<br>
								<br> <br>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">교환/반품</em>
						<p class="CFaqTableItem__question">같은 브랜드 다른 상품으로 교환 가능 한가요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								같은 브랜드 상품이라도 품번 및 상품이 다르면 교환이 가능하지 않습니다.<br>
								<br> <br>
								<br> ※ 동일한 상품명의 옵션으로만 교환 신청이 가능합니다.&nbsp;<br>
								<br> ※ 품절된 옵션이거나 추가 금액이 포함된 옵션은 교환이 가능하지 않습니다.<br>
								<br> ※ 회원님의 사유로 교환 진행중인 상품이 품절될 경우, 반품비가 발생될 수 있고 이를 제외한 결제
								금액이 환불 처리됩니다.&nbsp;<br>
								<br> ※ 다른 상품으로 교환 희망 시 환불 후 재주문해 주세요.
							</p>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">교환/반품</em>
						<p class="CFaqTableItem__question">상품을 받았는데 교환하고 싶어요.</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								교환은 배송 완료 일자 포함 7일 이내일 경우에만 주문/배송/픽업 조회에서 접수 가능합니다.<br>
								<br> (예시 : 3월 8일 상품을 받으신 경우 3월 14일까지 교환 접수 가능)<br>
								<br> <br>
								<br> 모바일(앱/웹): 마이페이지 &gt; 주문/배송/픽업 조회 &gt; 교환 요청<br>
								<br> PC(웹): 마이페이지 &gt; 주문 내역 조회 &gt; 교환 요청<br>
								<br> <br>
								<br> 1. 반품할 상품의 교환을 선택 해주세요.<br>
								<br> <br>
								<br> 2. 반품 방법을 선택해 주세요.<br>
								<br> - 회수해 주세요 : 무신사 자동회수 서비스로 택배기사가 요청한 회수지로 평일 기준 1일 ~ 3일
									이내 방문합니다.&nbsp;<br>
								<br> - 직접 보냈어요 : 상품을 받은 택배사와 같은 택배사로 반품 예약해야 합니다.&nbsp;<br>
								<br> ※ 반송장 번호가 아직 없다면 반송장 정보는 '다음에 등록하기'를 선택해 주세요.&nbsp;<br>
								<br> <br>
								<br> 3. 교환 배송비를 선결제해야 합니다.<br>
								<br> 신용카드 또는 가상 계좌 결제만 가능합니다.<br>
								<br> <br>
								<br> 4. 상품은 받아본 그대로 포장해서 반품해 주셔야 합니다.<br>
								<br> <br>
								<br> ※ 회원님의 사유로 교환 진행중인 상품이 품절될 경우, 반품비가 발생될 수 있고 이를 제외한 결제
									금액이 환불 처리됩니다.&nbsp;<br>
								<br>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">취소/반품(환불)</em>
						<p class="CFaqTableItem__question">상품은 보냈는데 언제 환불 되나요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								환불 진행 과정은 아래 내용 참고해 주세요.&nbsp;<br>
								<br> <br>
								<br> ■ 환불 진행 과정&nbsp;<br>
								<br> 상품 회수 &gt; 반품 도착 &gt; 검수 진행 &gt; &nbsp;환불 진행<br>
								<br> <br>
								<br> ※ 상품 회수 후 반품 도착까지 평일 기준 1일 ~ 2일 소요됩니다.&nbsp;<br>
								<br> ※ 검수 기간은 평일 기준 1일 ~ 3일 소요됩니다.&nbsp;<br>
								<br> ※ 환불 완료되었어도 결제한 수단으로 환불까지 기간이 소요됩니다.&nbsp;<br>
								<br> ※ 해외 배송 환불의 경우 평일 기준 7일 이상 소요됩니다.&nbsp;<br>
								<br> <br>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">취소/반품(환불)</em>
						<p class="CFaqTableItem__question">상품을 받았는데 환불하고 싶어요.</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								환불은 배송 완료 일자 포함 7일 이내일 경우에만 주문/배송/픽업 조회에서 접수 가능합니다.<br>
								<br> (예시 : 3월 8일 상품을 받으신 경우 3월 14일까지 환불 접수 가능)<br>
								<br> <br>
								<br> 모바일(앱/웹): 마이페이지 &gt; 주문/배송/픽업 조회 &gt; 환불 요청<br>
								<br> PC(웹): 마이페이지 &gt; 주문 내역 조회 &gt; 환불 요청<br>
								<br> <br>
								<br> 1. 반품할 상품의 환불을 선택해 주세요.<br>
								<br> <br>
								<br> 2. 반품 방법을 선택해 주세요.<br>
								<br> - 회수해 주세요 : 무신사 자동회수 서비스로 택배기사가 요청한 회수지로 평일 기준 1일 ~ 3일
								이내 방문합니다.&nbsp;<br>
								<br> - 직접 보냈어요 :&nbsp;상품을 받은 택배사와 같은 택배사로 고객님께서 직접 반품 예약을
								해주셔야 합니다.<br>
								<br> ※ 반송장 번호가 아직 없다면 반송장 정보는 다음에 등록하기를 선택해 주세요.&nbsp;<br>
								<br> <br>
								<br> 3. 환불 배송비는 상품 도착 및 검수 완료 후 주문 금액에서 차감 환불 됩니다.<br>
								<br> ※ 휴대전화 결제, 반품 배송비가 상품 금액보다 클 경우 반품비 결제 후 접수 가능합니다.<br>
								<br> <br>
								<br> 4. 상품은 받아본 그대로 포장해서 반품해 주셔야 합니다.<br>
								<br> ※ 받은 사은품이 있다면 같이 포장해서 반품해 주세요.<br>
								<br> <br>
						</div>
					</div>
				</div>
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">취소/반품(환불)</em>
						<p class="CFaqTableItem__question">주문을 취소(옵션변경)를 하고 싶어요.</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								주문 후 주문 상태에 따라 &nbsp;마이페이지 &gt; 주문/배송/픽업 조회에서 즉시 취소 또는 취소 요청이
								가능합니다.&nbsp;<br>
								<br> <br>
								<br> ■ 주문 상태별 취소 안내<br>
								<br> - 입금 확인: 신청 즉시 주문이 취소되고, 사용한 적립금과 쿠폰은 반환되어 재사용 가능합니다.<br>
								<br> - 출고 처리중: 취소 요청 승인 시 주문이 자동 취소됩니다. 배송 준비가 완료된 경우 취소 요청이
								거절될 수 있습니다.<br>
								<br> <br>
								<br> ※ 가상 계좌 결제는 2일 이내 입금하지 않을 경우와 재고 품절 시 주문은 자동으로 취소됩니다.<br>
								<br> ※ 반환된 쿠폰의 유효기간이 만료된 경우 재사용이 가능하지 않습니다.<br>
								<br> ※ 옵션 변경의 경우 입금 확인 상태에서만 가능하며, 입금하지 않은 주문의 옵션 변경을 원하는 경우
								주문 취소 후 재주문해 주세요.<br>
								<br> <br>
						</div>
					</div>
				</div>
				
				<div class="CFaqTableItem ">
					<div class="CFaqTableItem__list">
						<em class="CFaqTableItem__category">AS</em>
						<p class="CFaqTableItem__question">상품이 불량인 것을 착용하고나서 확인했어요 어떻게
							하나요?</p>
					</div>
					<div class="CFaqTableItem__contents-box">
						<em class="CFaqTableItem__answer">답변</em>
						<div class="CFaqTableItem__contents">
							<p>
								착용 후 불량 확인 시에는 초기 불량 여부 확인이 어려워 교환 및 환불이 가능하지 않습니다.<br>
								<br> <br>
								<br> * 브랜드 측으로 A/S 가능 여부 확인 후 A/S 처리 진행이 가능합니다.<br>
								<br> * 미 착용 상태에서 불량 확인 시, 무상으로 환불 및 교환 처리가 가능합니다.<br>
								<br> <br>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	

<script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        var faqQuestions = document.querySelectorAll('.CFaqTableItem__question');

        faqQuestions.forEach(function(question) {
            question.addEventListener('click', function() {
                // Find the closest parent item
                var faqItem = this.closest('.CFaqTableItem');
                // Toggle the active class on the item
                faqItem.classList.toggle('CFaqTableItem--active');
            });
        });
    });
</script>


</body>
</html>