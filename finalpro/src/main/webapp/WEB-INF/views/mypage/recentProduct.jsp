<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel ="stylesheet" href="${contextPath }/resources/css/myPage.css">

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

<script>

	var currentPage = 1;
	var itemsPerPage = 10;   
	
	
	function goToPage(pageNum) {
	    currentPage = pageNum;
	    updateItemsDisplay();
	}
	
	function nextPage() {
	    var allItems = document.querySelectorAll('.recentDiv');
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
    var totalItems = document.querySelectorAll('.recentDiv').length;
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
        if (i === currentPage) {
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
	    var allItems = document.querySelectorAll('.recentDiv');
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

	h2.recentTitle {
        margin: 15px 25px 0; /* 상단 마진을 10px로 수정 */
    }

    hr {
        margin-top: 17px; /* hr의 상단 마진을 수정 */
		height: 1px;
		background-color: black;
		width : 100%;
	}
	
	 #productContent {
        overflow: hidden; /* 부모 요소의 높이를 자식 요소의 높이에 맞게 조절 */
        font-size : 15px;
    }

    .recentDiv {
        float: left; /* 왼쪽으로 부유시킴 */
        width: calc(20% - 50px); /* 너비를 20%로 설정하고 간격을 20px로 조절 */
        margin: 15px;
        padding: 10px;
        position: relative;
        height : 350px;
    }
    
    .recentDiv p {
        margin: 5px 0;
    }
    
    .paginationSnap {
   		display: flex;
        justify-content: center;
        margin-top: 20px; /* 필요에 따라 여백 조정 */
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
			<h2 class = "recentTitle">최근 본 상품</h2>
			
			<hr>
		 	<c:choose>
				<c:when test="${recentList.size() != 0 && recentList != null}">
					<div id="productContent">
						<c:forEach var="recent" items="${recentList }">
							<div class="recentDiv">
								<a href="${contextPath }/product/detailProduct.do?productNo=${recent.productNo}">
								<img width="150px" height="180px" src="${contextPath }/download.do?imageFileName=${recent.imageFileName}&productNo=${recent.productNo}&path=product" alt = "${recent.name }">
								</a>
								<p>
									<!-- 브랜드 페이지로 이동(상품 번호 필요 - productNo)
										브랜드 이름 보내려고 했는데 안데르셑%20안데르센 나옴
									  -->
									<a href="${contextPath }/brand/brandList.do?brand=${recent.brand}">${recent.brand }</a>
								</p>
								<p>
									<!-- 선택한 상품 페이지로 이동(상품 번호 필요 - productNo)  -->
									<a href="${contextPath }/product/detailProduct.do?productNo=${recent.productNo}">${recent.name }</a>
								<p>
								<p>${recent.price }</p>
							</div>
						</c:forEach>
					</div>
				</c:when>
				
				<c:otherwise>
					<p class = "noItem">최근 보신 상품이 없습니다.</p>
				</c:otherwise>
				
			</c:choose>
			
			<div class = "paginationSnap"></div>
		</div>
			
	</div>
</body>