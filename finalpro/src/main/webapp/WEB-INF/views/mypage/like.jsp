<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link rel ="stylesheet" href="${contextPath }/resources/css/myPage.css">

<script>
		function changeText() {
			showDelButton();
			hideBeforeChoice();
			updateItemsDisplay1();
		}
		
		// 삭제 버튼을 클릭하고 클릭된 제품들을 리스트에 넣고 해당 리스트를 db에서 삭제하고 다시 like.do로 가서 출력
		// 클릭한 제품들이 없을 경우 다시 선택해달라는 메시지창
		function deleteText() {
			var frm = document.getElementById("likeListForm");
			var choiceBtn = document.getElementById("choiceBtn");
			var deleteBtn = document.getElementById("deleteBtn");
			var cancelBtn = document.getElementById("cancelBtn");
			var beforeChoice = document.getElementsByClassName("beforeChoice");
			var choice = document.getElementsByClassName("choice");

			choiceBtn.style.display = "inline"; // 선택 버튼 표시
			deleteBtn.style.display = "none"; // 삭제 버튼 숨김
			cancelBtn.style.display = "none"; // 취소 버튼 숨김
				  
			var productNoList = [];
			var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
			 
			checkboxes.forEach(function(checkbox) {
				productNoList.push(checkbox.value);
			});
				
			if(checkboxes != null && checkboxes.length != 0){
				if(confirm("선택하신 상품을 삭제 하시겠습니까?")){
					location.href = "${contextPath}/mypage/deleteLike.do?productNoList=" + productNoList.join(",");
				}
			}else{
				alert('선택하신 상품이 없습니다.');
			}
		}
		
		function cancelSelection() {
			showChoiceButton();
			hideChoice();
			updateItemsDisplay();
		}
		
		// 삭제, 취소 버튼만 보이게
		function showDelButton() {
	        var choiceBtn = document.getElementById("choiceBtn");
	        var deleteBtn = document.getElementById("deleteBtn");
	        var cancelBtn = document.getElementById("cancelBtn");

	        choiceBtn.style.display = "none"; // 선택 버튼 표시
	        deleteBtn.style.display = "inline"; // 삭제 버튼 숨김
	        cancelBtn.style.display = "inline"; // 취소 버튼 숨김
	    }
		
		// 선택 버튼만 보이게
		function showChoiceButton() {
	        var choiceBtn = document.getElementById("choiceBtn");
	        var deleteBtn = document.getElementById("deleteBtn");
	        var cancelBtn = document.getElementById("cancelBtn");

	        choiceBtn.style.display = "inline"; // 선택 버튼 표시
	        deleteBtn.style.display = "none"; // 삭제 버튼 숨김
	        cancelBtn.style.display = "none"; // 취소 버튼 숨김
	    }
		
		// 누르기 전(페이지 이동) - beforeChoice 보이게
		function hideChoice() {
			var beforeChoice = document.getElementsByClassName("beforeChoice");
			var choice = document.getElementsByClassName("choice");
			
			for(var i = 0; i < beforeChoice.length; i++){
				  beforeChoice[i].style.display = "block";
				  choice[i].style.display = "none";
	        }
		}
		
		// 누르고 난 후(삭제) - choice 보이게
		function hideBeforeChoice() {
			var beforeChoice = document.getElementsByClassName("beforeChoice");
			var choice = document.getElementsByClassName("choice");
			
			for(var i = 0; i < beforeChoice.length; i++){
				  beforeChoice[i].style.display = "none";
				  choice[i].style.display = "block";
	        }
		}

<!-- 페이지 순서 만들때는 이거 사용하면 됨 -->

	var currentPage = 1;
	var itemsPerPage = 10;   
	
	function goToPage(pageNum) {
	    currentPage = pageNum;
	    showChoiceButton();
		hideChoice();
		updateItemsDisplay();
	}
	
	function nextPage() {
	    var allItems = document.querySelectorAll('.beforeChoice');
	    var totalPages = Math.ceil(allItems.length / itemsPerPage);
	    if (currentPage < totalPages) {
	        currentPage++;
	        showChoiceButton();
			hideChoice();
			updateItemsDisplay();
	    }
	}
	
	function previousPage() {
	    if (currentPage > 1) {
	        currentPage--;
	        showChoiceButton();
			hideChoice();
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
    var totalItems = document.querySelectorAll('.beforeChoice').length;
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
	    showChoiceButton();
		hideChoice();
		updateItemsDisplay();
	}
	
	function lastPage(totalPages) {
	    currentPage = totalPages;
	    showChoiceButton();
		hideChoice();
		updateItemsDisplay();
	}
	
	document.addEventListener('DOMContentLoaded', function() {
	    updateItemsDisplay(); // 아이템을 업데이트하는 함수
	    createPaginationButtons(); // 페이지네이션 버튼을 생성하는 함수
	});
	
	function updateItemsDisplay() {
	    var allItems = document.querySelectorAll('.beforeChoice');
	    var startItem = (currentPage - 1) * itemsPerPage;
	    var endItem = startItem + itemsPerPage;
	
	    allItems.forEach(function(item, index) {
	        if (index >= startItem && index < endItem) {
	            item.style.display = 'block'; // 현재 페이지 아이템만 보여주기
	        } else {
	            item.style.display = 'none'; // 다른 페이지 아이템 숨기기
	        }
	    });
	
	    createPaginationButtons(); // 페이지네이션 버튼 업데이트
	}
	
	function updateItemsDisplay1() {
	    var allItems = document.querySelectorAll('.choice');
	    var startItem = (currentPage - 1) * itemsPerPage;
	    var endItem = startItem + itemsPerPage;
	
	    allItems.forEach(function(item, index) {
	        if (index >= startItem && index < endItem) {
	            item.style.display = 'block'; // 현재 페이지 아이템만 보여주기
	        } else {
	            item.style.display = 'none'; // 다른 페이지 아이템 숨기기
	        }
	    });
	
	    createPaginationButtons(); // 페이지네이션 버튼 업데이트
	}
	
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
    
    <style>
	h2.likeTitle {
        margin: 15px 25px 0; /* 상단 마진을 10px로 수정 */
    }

    hr {
        margin-top: 17px;
		height: 1px;
		background-color: black;
		width : 100%;
	}

	 #productBox {
        overflow: hidden; /* 부모 요소의 높이를 자식 요소의 높이에 맞게 조절 */
        font-size : 15px;
    }

    .beforeChoice, .choice {
        float: left; /* 왼쪽으로 부유시킴 */
        width: calc(20% - 50px); /* 너비를 20%로 설정하고 간격을 20px로 조절 */
        margin: 15px;
        padding: 10px;
        position: relative;
        height: 350px;
    }
    
    .beforeChoice p, .choice p {
        margin: 5px 0;
    }

    .choice {
        position: relative;
    }

    .choice input[type="checkbox"] {
        position: absolute;
        top: 10;
        left: 10;
    }
    
    .choiceBtn {
    	background-color: lightgary;
		border: none;
		border-radius: 5px;
		color: black;
		font-weight: 600;
		width: 70px;
		height: 30px;
		margin: 10px;
    }
    
    .choiceBtn:hover {
    	background-color: black;
		border-radius: 5px;
		color: white;
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
        text-align: center;
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
			<h2 class = "likeTitle">좋아요</h2>
			<hr>
			
			<c:choose>
				<c:when test="${likeList.size() != 0 && likeList != null}">
					<div id="productBox">
						<c:forEach var="like" items="${likeList}">
							<div class="beforeChoice">
								<a href = "${contextPath }/product/detailProduct.do?productNo=${like.productNo}">
									<img width="150px" height="180px" src="${contextPath }/download.do?imageFileName=${like.imageFileName}&productNo=${like.productNo}&path=product" alt = "${like.name }">
									<p>
										<a href="${contextPath }/brand/brandList.do?brand=${like.brand}">${like.brand}</a>
									</p>
									<p>
										<a href="${contextPath }/product/detailProduct.do?productNo=${like.productNo}">${like.name}</a>
									<p>
									<p>${like.price}</p>
									<p>♥ ${like.likeCount}</p>
								</a>
							</div>
							<div class="choice" style="display: none;">
								<input id="${like.productNo }" type="checkbox" name="productNoList"
									value="${like.productNo}"> <label for="${like.productNo }">
									<img width="150px" height="180px" src="${contextPath }/download.do?imageFileName=${like.imageFileName}&productNo=${like.productNo}&path=product" alt = "${like.name }">
									<p>${like.brand}</p>
									<p>${like.name}</p>
									<p>${like.price}</p>
									<p>♥ ${like.likeCount}</p>
								</label>
							</div>
						</c:forEach>
					</div>
				
					<div>
						<button class = "choiceBtn" id="choiceBtn" type="button" onclick="changeText()">선택</button>
						<button class = "choiceBtn"  id="deleteBtn" style="display: none;" type="button"
							onclick="deleteText()">삭제</button>
						<button class = "choiceBtn" id="cancelBtn" style="display: none;" type="button"
							onclick="cancelSelection()">취소</button>
					</div>
				</c:when>
				<c:otherwise>
					<p class = "noItem">좋아하는 상품이 없습니다.<br>상품을 추가해보세요..</p>
				</c:otherwise>
			</c:choose>
			
			<div class = "paginationSnap"></div>
			
		</div>
			
	</div>

	
</body>