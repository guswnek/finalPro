<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var = "contextPath" value="${pageContext.request.contextPath}" />
<script>
  // 오른쪽 사이바에 있는 위 아래 버튼(화면 맨 아래로 내려가면 위로가는 버튼이 활성화 됨.)
  // 누르면 각각 맨 위로 올라가ㅗ
  document.addEventListener('DOMContentLoaded', function() {
    var moveToTopButton = document.querySelector('button.move:not([disabled])');
    var moveToBottomButton = document.querySelector('button.move[disabled]');

    moveToTopButton.addEventListener('click', function() {
      window.scrollTo({ top: document.body.scrollHeight, behavior: 'smooth' });
    });

    moveToBottomButton.addEventListener('click', function() {
      window.scrollTo({ top: 0, behavior: 'smooth' });
    });

    function toggleMoveButton() {
      
      if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
        
        moveToBottomButton.disabled = false;
        moveToBottomButton.style.opacity = 1; 
      } else {
       
        moveToBottomButton.disabled = true;
        moveToBottomButton.style.opacity = 0.5; 
      }
    }

    window.addEventListener('scroll', toggleMoveButton);

    toggleMoveButton();
  });
</script>    

<script>
   document.addEventListener('DOMContentLoaded', function() {
     var mypageButton = document.querySelector('.mypage');
     var likeButton = document.querySelector('.like');
     var cartButton = document.querySelector('.cart');
     var closeButton = document.querySelector('.close');
     
     // Initial state
     var isMenuOpen = false;

     mypageButton.addEventListener('click', function(event) {
       // 메뉴가 이미 열려있는 경우 mypage.jsp로 이동
       if (isMenuOpen) {
         window.location.href = '${contextPath}/mypage/orderList.do'; // mypage.jsp로 이동
         return; // 함수 실행을 여기서 종료
       }
       
       // 메뉴 상태 토글
       isMenuOpen = !isMenuOpen;

       // 좋아요, 장바구니, 닫기 버튼 보여주기
       likeButton.style.display = 'block';
       cartButton.style.display = 'block';
       closeButton.style.display = 'block';
       
       // href 속성 방지
       event.preventDefault();
     });
     
     // 닫기 버튼을 클릭했을 때 좋아요, 장바구니, 닫기 버튼 숨기기
     closeButton.addEventListener('click', function() {
       // 좋아요, 장바구니, 닫기 버튼 숨김
       likeButton.style.display = 'none';
       cartButton.style.display = 'none';
       closeButton.style.display = 'none';
       isMenuOpen = false;
     });
   });
</script>     
    
<body>
	<div class="right_area">
		<button class="allbutton"></button>
			<button class="mypage">MY</button>
			<button class="close">닫기</button>
			<a href="#" class="shoppingBasket">
				<svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6.5 20.5V7.5H23.5V26H11.5M6.5 22V26H10M10.5 10V8.43881C10.5 5.71118 12.5147 3.5 15 3.5C17.4853 3.5 19.5 5.71118 19.5 8.43881V10" stroke="black"></path></svg>
			</a> 
			<button class="like" style="display:none;">좋아요</button>
			<button class="cart" style="display:none;">장바구니</button>
			<button disabled class="move">
				<svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M24 22L15 13L10 18M8.62503 19.375L6 22M5 9H25" stroke="#ddd"></path></svg>
			</button>
			<button class="move">
				<svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5 11L6.99988 13M25 11L14.9994 21L8.49979 14.5" stroke="#ddd"></path></svg>
			</button>
	</div>
	<div class="footMenu">
		<div class="inner">
			<div class="service_area">
				<div class="customer_service">
					<strong class="service_title">
					<a href="/finalpro/member/customer.do">고객센터</a>
					<a href="tel:1588-7813" class="service_tel">1588-7813</a>
					</strong>
					<div class="service_time">
						<dl class="time_box">
							<dt class="time_term">
							운영시간 평일 10:00 - 18:00 (토.일, 공휴일 휴무)
							점심시간 평일 13:00 - 14:00</dt>
						</dl>
					</div>
					<p class="service_noti">1:1 문의하기는 앱에서만 가능합니다.</p>
					<div class="service_btn_box">
						<a href="#" class="btn solid small">자주 묻는 질문</a>
					</div>
				</div>
				<div class="footer_menu">
					<div class="menu_box">
						<strong class="menu_title">이용안내</strong>
						<ul class="menu_list">
								<li class="menu_item">
									<a href="#" class="menu_link">검수기준</a>
								</li>
								<li class="menu_item">
									<a href="#" class="menu_link">이용정책</a>
								</li>
								<li class="menu_item">
									<a href="#" class="menu_link">페널티 정책</a>
								</li>
								<li class="menu_item">
									<a href="#" class="menu_link">커뮤티니 가이드라인</a>	
								</li>
							</ul>			
					</div>
					<div class="menu_box">
						<strong class="menu_title">고객지원</strong>
						<ul class="menu_list">
								<li class="menu_item">
									<a href="#" class="menu_link">공지사항</a>
								</li>
								<li class="menu_item">
									<a href="#" class="menu_link">서비스소개</a>
								</li>
								<li class="menu_item">
									<a href="#" class="menu_link">스토어 안내</a>
								</li>
								<li class="menu_item">
									<a href="#" class="menu_link">판매자 방문접수</a>	
								</li>
							</ul>
					</div>
				</div>
			</div>
			<div class="corporation_area">
				<ul class="term_list">
					<li class="term_item">
						<a href="#" class="term_link">회사소개</a>
					</li>
					<li class="term_item">
						<a href="#" class="term_link">인재채용</a>
					</li>
					<li class="term_item">
						<a href="#" class="term_link">이용약관</a>
					</li>
					<li class="term_item privacy">
						<a href="#" class="term_link">개인정보처리방침</a>
					</li>
				</ul>
				<div class="footer_sns">
					<div class="sns_box">
						<a href="#" aria-label="인스타그램" class="sns">
							<img src="/finalpro/resources/image/insta.png">
						</a>
						<a href="#" aria-label="페이스북" class="sns">
							<img src="/finalpro/resources/image/facebook.png">
						</a> 
						<a href="#" aria-label="카카오톡" class="sns">
							<img src="/finalpro/resources/image/kakao.png">
						</a>  
					</div>
				</div>
				<div class="business_info">
					<div class="info_list">
						<dl class="info_term">
							<dt class="business_title">
							고양이 주식회사 . 대표 최현빈
							<span class="blank">
							</span>
							사업자등록번호 : 050-66-11111
							<a href= "#">사업자정보확인</a>
							<span class="blank"></span>
							통신판매업 : 제 2024-분당 C-0000호
							<span class="blank"></span><br>
							사업소재지: 경기도 성남시 분당구 분당내곡로 131 판교테크원 타워1, 17층
							<span class="blank"></span>
							호스팅 서비스 : 네이버 클라우드 (주)
							</dt>
						</dl>
					</div>
				</div>
			</div>
		</div>
	
	</div>
</body>
