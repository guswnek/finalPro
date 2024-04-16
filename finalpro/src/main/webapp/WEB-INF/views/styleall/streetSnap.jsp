<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="contextPath" value="${pageContext.request.contextPath }" /> 

<c:set var="allStreetSnap" value="${allStreetSnapMap.allStreetSnapDTO }" />
<c:set var="allStreetSnapImage" value="${allStreetSnapMap.allStreetSnapImageList }" />

<link rel="stylesheet" href="/finalpro/resources/css/snapAll.css">

<!-- 페이지 순서 만들때는 이거 사용하면 됨 -->

<script>
var currentPage = 1;
var itemsPerPage = 9;

function updateItemsDisplay() {
    var allItems = document.querySelectorAll('.brandItemInfo');
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

function goToPage(pageNum) {
    currentPage = pageNum;
    updateItemsDisplay();
}

function nextPage() {
    var allItems = document.querySelectorAll('.brandItemInfo');
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

function lastPage() {
    var totalItems = document.querySelectorAll('.brandItemInfo').length;
    var totalPages = Math.ceil(totalItems / itemsPerPage);
    currentPage = totalPages;
    updateItemsDisplay();
}

// 페이지네이션 버튼을 동적으로 생성하는 함수
function createPaginationButtons() {
    var paginationContainer = document.querySelector('.paginationSnap');
    var totalItems = document.querySelectorAll('.brandItemInfo').length;
    var totalPages = Math.ceil(totalItems / itemsPerPage);

    // 기존 페이지네이션 버튼을 모두 제거합니다.
    paginationContainer.innerHTML = '';

    // 맨 처음 페이지로 이동하는 버튼 추가
    if (currentPage > 1) {
        let firstButton = document.createElement('button');
        firstButton.className = 'pagination_button';
        firstButton.innerText = '<<';
        firstButton.addEventListener('click', firstPage);
        paginationContainer.appendChild(firstButton);
    }

    // 이전 페이지 버튼을 추가합니다.
    if (currentPage > 1) {
        let prevButton = document.createElement('button');
        prevButton.className = 'pagination_button';
        prevButton.innerText = '<';
        prevButton.addEventListener('click', previousPage);
        paginationContainer.appendChild(prevButton);
    }

    // 페이지 번호에 해당하는 버튼을 추가합니다.
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

    // 다음 페이지 버튼을 추가합니다.
    if (currentPage < totalPages) {
        let nextButton = document.createElement('button');
        nextButton.className = 'pagination_button';
        nextButton.innerText = '>';
        nextButton.addEventListener('click', nextPage);
        paginationContainer.appendChild(nextButton);
    }

    // 맨 끝 페이지로 이동하는 버튼 추가
    if (currentPage < totalPages) {
        let lastButton = document.createElement('button');
        lastButton.className = 'pagination_button';
        lastButton.innerText = '>>';
        lastButton.addEventListener('click', lastPage);
        paginationContainer.appendChild(lastButton);
    }
}

document.addEventListener('DOMContentLoaded', function() {
    updateItemsDisplay();
});
</script>




<body>
	<h1>StreetSnap</h1>
	<div class="title_box">
   		<div class="tool-tabBtn">
   			<a href="${contextPath }/styleall/brandSnap.do" class="plain-btn btn">브랜드 스냅</a>
   			<a href="${contextPath }/styleall/streetSnap.do" class="plain-btn btn">스트릿 스냅</a>
   		</div>
   	</div>
   	
   	
   	<div class="brandSnapWrap">
		<!-- 페이지 버튼 -->	  
	 	<div class="paginationSnap"></div>
	
			<div class="brandSnapGrid">
		   		<c:forEach var="ass" items="${allStreetSnap}" varStatus="status">
				    <div class="brandItemInfo" id="ass${status.index + 1}">
				       <a href="${contextPath }/styleall/brandSnapInfo.do?snapNo=${ass.snapNo}">
				            <img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${ass.snapNo}&path=snap" id="preview${status.index + 1}">
				            <p>${ass.street}</p>
				            <h3>${ass.name}</h3>
				            <p>조회 : ${ass.viewCount}</p>
				        </a>
				    </div>
			   </c:forEach>
		  	</div>
		
	</div>	
   	
   	
   	
   	
   	
   		
</body>
