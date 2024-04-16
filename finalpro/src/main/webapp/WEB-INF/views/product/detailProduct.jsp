<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%
	request.setCharacterEncoding("utf-8");
%>    
<c:set var="contextPath" value="#{pageContext.request.contextPath }" />
<c:set var="oneYearSalesTotalFemale" value="#{oneYearSalesTotal-oneYearSalesTotalMale}" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<link rel="stylesheet" type="text/css" href="/finalpro/resources/css/detailProduct.css">
<head>
	<script type="text/javascript">
		sessionStorage.clear();
		const userId = '${loginId}'; // 사용자 ID  세션에서 가져오기
		const pageProductNo="${dto.productNo}";
	
	    function statusGraphOutput(button) {
	        var status=document.querySelectorAll('.status');
	        status.forEach(function(status) {
	            status.setAttribute('hidden', true);
	        });
	
	        var value = button.getAttribute('value');
	
	        var targetStatus=document.querySelector('#'+value+'-status');
	        targetStatus.removeAttribute('hidden');
	    }
	    
	    var productList = JSON.parse('${productListJson}'.replace(/&quot;/g, '"'));
	    var sizeList = JSON.parse('${sizeListJson}'.replace(/&quot;/g, '"'));
	    
	    function showSizeOptions(productNo) {
	        let sizeSelect=document.getElementById("sizeSelect1");
	
	        if(productNo!=""){
	        	sizeSelect.innerHTML = "";
	        	let sizeOption=document.createElement("option");
				sizeOption.textContent="옵션 선택";
				sizeOption.selected = true;
				sizeSelect.appendChild(sizeOption);
	        	for(let i = 0; i < productList.length; i++){
	        		let product=productList[i];
	        		for(let j = 0; j < sizeList.length; j++){
	        			let size=sizeList[j];
	        			if(productNo == product.productNo && product.productNo == size.productNo){
	        				let sizeOption=document.createElement("option");
							if(size.stock==0){
								sizeOption.textContent=size.productSize+"[품절]";    
								sizeOption.disabled = true;
							}else{
								sizeOption.textContent=size.productSize;
		        				sizeOption.value=size.productSize;
							}
	        				sizeSelect.appendChild(sizeOption);
	        			}
	        		}
	        	}
	        }
	    }
	    
		
		var recepitCnt =1;
	    
	    function updateSelectedOptions() {
	    	let colorSelect=document.getElementById("colorSelect");
	    	let productNo=colorSelect.value;
	    	let productColor="";
	    	let productPrice = 0;
	    	for(let i = 0; i < productList.length; i++){
	    		if(productList[i].productNo==productNo){
	    			productColor=productList[i].color1;
	    			productPrice = productList[i].price;
	                break;
	    		}
	    	}
	    	
	        let sizeSelect=document.getElementById("sizeSelect1");
	        let selectedSize=sizeSelect.value;
	        
	        let found = false;
	        for (let i = 1; i <= recepitCnt; i++) {
	            let storedProduct = JSON.parse(sessionStorage.getItem('selectedProduct' + i));
	            if (storedProduct && storedProduct.productNo == productNo && storedProduct.size == selectedSize) {
	                found = true;
	                // 수량을 업데이트합니다.
	                storedProduct.quantity += 1;
	                sessionStorage.setItem('selectedProduct' + i, JSON.stringify(storedProduct));
	                
	                // 해당하는 li의 수량 입력 필드 값을 찾아서 업데이트합니다.
	                let lis = document.querySelectorAll("#selected-option-list li");
	                lis.forEach(li => {
	                    if(li.dataset.productNo === productNo && li.dataset.size === selectedSize) {
	                        let input = li.querySelector("input[name='numberToBuy']");
	                        input.value = parseInt(input.value) + 1;
	                    }
	                });
	                break;
	            }
	        }
	        if (!found) {
		        let list=document.getElementById("selected-option-list");
		        let li = document.createElement("li");
		        li.setAttribute('data-product-no', productNo);
		        li.setAttribute('data-size', selectedSize);
		            
	         	// 사이즈를 표시하는 <em> 태그 생성 및 추가
	            let sizeEm = document.createElement("em");
	            sizeEm.className = "product-detail__sc-1hix9ji-1 eknomH";
	            sizeEm.textContent = productColor+","+ selectedSize;
	            li.appendChild(sizeEm);
	            
	         	// 제품 수량 및 조정 버튼을 포함하는 <div> 생성
	            let quantityDiv = document.createElement("div");
	            quantityDiv.className = "product-detail__sc-1hix9ji-2 dotvfd";
	            
	         	// 감소 버튼
	            let decreaseButton = document.createElement("a");
	            decreaseButton.className = "product-detail__sc-1hix9ji-4 biBZLN";
	            decreaseButton.href="javascript:void(0);"
	            decreaseButton.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18" fill="none"><path d="M15 8.99995H3" stroke="#d1d1d1"></path></svg>`;
	            quantityDiv.appendChild(decreaseButton);
	            decreaseButton.addEventListener('click', function() { adjustQuantity(false, productNo, selectedSize, this); });
	            
	         	// 수량 입력 필드
	            let quantityInput = document.createElement("input");
	            quantityInput.type = "text";
	            quantityInput.maxLength = "3";
	            quantityInput.className = "product-detail__sc-1hix9ji-3 hMlXBL";
	            quantityInput.name = "numberToBuy";
	            quantityInput.value = "1";
	            quantityDiv.appendChild(quantityInput);
	            
	         	// 증가 버튼
	            let increaseButton = document.createElement("a");
	            increaseButton.className = "product-detail__sc-1hix9ji-4 biBZLN";
	            increaseButton.href="javascript:void(0);"
	            increaseButton.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 18 18" fill="none"><path d="M9 3V15M15 9H3" stroke="#000000"></path></svg>`;
	            quantityDiv.appendChild(increaseButton);
	            increaseButton.addEventListener('click', function() { adjustQuantity(true, productNo, selectedSize, this); });
		            
	         	// 가격을 표시하는 <strong> 및 <span> 태그 생성
	            let priceStrong = document.createElement("strong");
	            priceStrong.className = "product-detail__sc-1hix9ji-6 iJkAyM";
	            
	            let priceSpan = document.createElement("span");
	            priceSpan.className = "product-detail__sc-1hix9ji-7 fTEuFK";
	            priceSpan.textContent = productPrice;
	            priceStrong.appendChild(priceSpan);
	            
	            let wonSpan = document.createElement("span");
	            wonSpan.className = "product-detail__sc-1hix9ji-8 dzBTcK";
	            wonSpan.textContent = "원";
	            priceStrong.appendChild(wonSpan);
		            
	         	// 삭제 버튼 생성
	            let deleteButton = document.createElement("button");
	            deleteButton.className = "product-detail__sc-1hix9ji-9 kKJBCa";
	            deleteButton.setAttribute('onclick', "selectedProductDel('"+productNo+"','"+selectedSize+"', this)");
	            deleteButton.innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="12" height="12" viewBox="0 0 12 12" fill="none"><path d="M2.16701 2.1667L9.83359 9.83327M9.83357 2.16663L2.16699 9.8332" stroke="#6e6e6e"></path></svg>`;
	            
	         	// 구성된 요소들을 <li>에 추가
	            li.appendChild(quantityDiv);
	            li.appendChild(priceStrong);
	            li.appendChild(deleteButton);
	            
		        li.style.border = "1px solid lightpink";
		        list.appendChild(li);
	
		        sizeSelect.selectedIndex = 0;
		        colorSelect.selectedIndex = 0;
		        
		        for(let i = 0; i < productList.length; i++){
	        		let product=productList[i];
	        			if(product.productNo==productNo){
	        				let wantProduct = {
			        				  productNo: product.productNo,
			        				  name: product.name,
			        				  brand: product.brand,
			        				  size: selectedSize,
			        				  color: product.color1,
			        				  quantity: 1,
			        				  price: product.price
			        				};
			        		
			        		sessionStorage.setItem('selectedProduct'+recepitCnt, JSON.stringify(wantProduct));
			        		setTotalPrice();
			        		recepitCnt++;
	        		}
	        	}
	        }
	    }
	    </script>
	    
	    <script>	    
	    function adjustQuantity(isIncrease, productNo, size, button) {
	        for(let k = 1; k <= recepitCnt; k++) {
	            let item = JSON.parse(sessionStorage.getItem('selectedProduct' + k));
	            if(item && item.productNo === productNo && item.size === size) {
	                let newQuantity = isIncrease ? item.quantity + 1 : Math.max(item.quantity - 1, 1); // 최소 1
	                item.quantity = newQuantity;
	                sessionStorage.setItem('selectedProduct' + k, JSON.stringify(item));
	                
	                // 페이지에서 해당 아이템의 수량 업데이트
	                let parentDiv = button.parentNode;
	                let quantityInput = parentDiv.querySelector('input');
                    if (quantityInput) { // 추가된 검증
                        quantityInput.value = newQuantity;
                        setTotalPrice();
    	                break;
                    }
	            }
	        }
	    }
	    
	    function selectedProductDel(productNo, size, button){
	    	let parentLi = button.parentNode;
	    	for(let k = 1; k <= recepitCnt; k++) {
	    		let item = JSON.parse(sessionStorage.getItem('selectedProduct' + k));
	    		if(item && item.productNo === productNo && item.size === size) {
	    			sessionStorage.removeItem('selectedProduct' + k, JSON.stringify(item));
	    		}
	    	}
	    	parentLi.parentNode.removeChild(parentLi);
	    	setTotalPrice();
	    }
	    
	    function questionAndAnswerToggle(clickedButton) {
	        var questionNo = clickedButton.getAttribute('data-question-no');
	        var questionAndAnswers = document.querySelectorAll('#question_' + questionNo + ', #answer_' + questionNo);

	        questionAndAnswers.forEach(function(element) {
	            if (element.hidden) {
	                element.hidden = false; // 요소를 보여줌
	            } else {
	                element.hidden = true; // 요소를 숨김
	            }
	        });
	    }
	    
	    function setTotalPrice() {
	        let totalPrice = 0;
	        console.log("recepitCnt : "+recepitCnt)
	        for (let i = 0; i <= recepitCnt; i++) {
	            let item = JSON.parse(sessionStorage.getItem('selectedProduct' + i));
	            if(item!=null){
		            console.log(item);
		            totalPrice += item.price * item.quantity;
	            }
	        }

	        // 총합을 출력하는 태그에 결과를 설정
	        document.getElementById('print-selected-price').innerText = totalPrice + '원';
	    }
	    
	    window.onload = function() {
            setTotalPrice();
        };

		function showPurchaseProductSize() {
	    	let subcategory ="${dto.subCategory}";
			if(userId!=null && userId!=""){
				$.ajax({
		            url: "/finalpro/mypage/purchaseOrderList.do",
		            method: 'POST',
		            contentType: 'application/json',
		            data: subcategory, // 객체를 JSON 문자열로 변환
		            success: function(data) {
		            	let ul=document.getElementById("order_history_ul");
		            	ul.innerHTML = '';
		                data.data.forEach(function(order) {
							console.log("showPurchaseProductSize : "+order);
		                	let li = document.createElement('li');
		                    li.className = "product-detail__sc-10xm6kh-5 keTSae";
		                    
		                    let label = document.createElement('label');
		                    
		                    let input = document.createElement('input');
		                    input.type = "radio";
		                    input.name = "selectOrderProduct";
		                    input.value = order.productNo + '-' + order.productSize + '-' + order.subcategory;
		                    
		                    let divImageContainer = document.createElement('div');
		                    divImageContainer.className = "product-detail__sc-10xm6kh-8 jEkgjb";
		                    
		                    let img = document.createElement('img');
		                    img.src = "${contextPath}/download.do?imageFileName=1.jpg&productNo="+order.productNo+"&path="; // 이미지 URL
		                    img.alt = order.productNo; // 이미지 설명
		                    img.className = "sizeChartImage";
		                    
		                    let divDetailContainer = document.createElement('div');
		                    divDetailContainer.className = "product-detail__sc-10xm6kh-10 kPnMlH";
		                    
		                    let strong = document.createElement('strong');
		                    strong.className = "product-detail__sc-10xm6kh-11 kxKaVj";
		                    strong.textContent = order.brand; // 제품 이름
		                    
		                    let spanTitle = document.createElement('span');
		                    spanTitle.className = "product-detail__sc-10xm6kh-12 jPHQGs";
		                    spanTitle.textContent = order.name;
		                    
		                    // 요소들을 적절히 조합
		                    divImageContainer.appendChild(img);
		                    divDetailContainer.appendChild(strong);
		                    divDetailContainer.appendChild(spanTitle);
		                    
		                    label.appendChild(input);
		                    label.appendChild(divImageContainer);
		                    label.appendChild(divDetailContainer);
		                    
		                    li.appendChild(label);
		                    
		                    // 최종적으로 <ul> 요소에 <li> 요소 추가
		                    ul.appendChild(li);
						})
						var popup = document.getElementById("sizePopup");
					    var overlay = document.getElementById("overlay");
					    var body = document.body;
					
					    if (popup.style.display == "none") {
					        popup.style.display = "block";
					        overlay.style.display = "block";
					        body.style.overflow = 'hidden';
					    }
		            },
		            error: function(error) {
		                console.error('Error:', error);
		            }
		        });
			}else{
				alert('로그인해주세요');
				location.href='/finalpro/member/loginForm.do';
			}
		}
	    	
	    function closePopup() {
	        var popup = document.getElementById("sizePopup");
	        var overlay = document.getElementById("overlay");
	        var body = document.body;
	        
            popup.style.display = "none";
            overlay.style.display = "none";
            body.style.overflow = 'auto';
	    }
	    
	    function fillMySizeInfo() {
	    	console.log("fillMySizeInfo 실행");
			let mySizeInfo = document.getElementById("my_size_info");
			
			let category= "${dto.category}";
			let sizeCategory= "${dto.subCategory}";
			
			
			if(sizeCategory=="t-shirt") {
				sizeCategory="shortT";			
			}else if(sizeCategory=="mtom") {
				sizeCategory="LongslT";			
			}else if(sizeCategory=="hood") {
				sizeCategory="LongslT";			
			}else if(sizeCategory=="knit") {
				sizeCategory="LongslT";			
			}else if(sizeCategory=="shirt") {
				sizeCategory="LongslT";			
			}else if(sizeCategory=="coat") {
				sizeCategory="coat";			
			}else if(sizeCategory=="heavyOuter") {
				sizeCategory="heavyOuter";			
			}else if(sizeCategory=="cardigan") {
				sizeCategory="jumper";			
			}else if(sizeCategory=="fleece") {
				sizeCategory="jumper";			
			}else if(sizeCategory=="jumper") {
				sizeCategory="jumper";			
			}else if(sizeCategory=="jeans") {
				sizeCategory="pants";			
			}else if(sizeCategory=="slacks") {
				sizeCategory="pants";			
			}else if(sizeCategory=="skirt") {
				sizeCategory="skirt";			
			}else if(sizeCategory=="trackPants") {
				sizeCategory="pants";			
			}else if(sizeCategory=="shorts") {
				sizeCategory="shorts";			
			}else if(sizeCategory=="dressShoes") {
				subCategory="shoes";			
			}else if(sizeCategory=="sneakers") {
				sizeCategory="sneakers";			
			}else if(sizeCategory=="athleticShoes") {
				sizeCategory="sneakers";			
			}	
			
			console.log(sizeCategory);
			
	        $.ajax({
	        	url: "/finalpro/member/infoSizeRecommend.do",
	            method: 'get',
	            contentType: 'application/json',
	            data: {sizeCategory:sizeCategory}, 
	            success: function(response) {
	            	console.log("사이즈불러오기성공");
	            	mySizeInfo.innerHTML='';
	            	let th = document.createElement('th');
	            	th.textContent = "my"; // TD에 내용 삽입
                    mySizeInfo.appendChild(th); // 생성된 TD를 TR에 추가
	            	if(category=="top" || category=="outer"){
	            		let tdData = [response.topTotalLength, response.shoulderLength, response.chestCrossLength, response.sleevelength]; // 가정: 필요한 데이터 배열
	                    tdData.forEach(function(content) {
	                    	console.log(content);
	                        let td = document.createElement('td');
	                        td.textContent = content; // TD에 내용 삽입
	                        mySizeInfo.appendChild(td); // 생성된 TD를 TR에 추가
	                    });
	            	}else if(category=="pants"){
	            		if(sizeCategory=="pants" || sizeCategory=="shorts"){
	            			let tdData = [response.pantsTotalLength, response.waistCrossLength, response.hipCrossLength, response.thighCrossLength, response.riseLength, response.hemCrossLength]; // 가정: 필요한 데이터 배열
	                        tdData.forEach(function(content) {
	                        	let td = document.createElement('td');
	                            td.textContent = content; // TD에 내용 삽입
	                            mySizeInfo.appendChild(td); // 생성된 TD를 TR에 추가
	                        });
	            		}else if(sizeCategory=="skirt"){
	            			let tdData = [response.pantsTotalLength, response.waistCrossLength, response.hipCrossLength, response.hemCrossLength]; // 가정: 필요한 데이터 배열
	                        tdData.forEach(function(content) {
	                        	let td = document.createElement('td');
	                            td.textContent = content; // TD에 내용 삽입
	                            mySizeInfo.appendChild(td); // 생성된 TD를 TR에 추가
	                        });
	            		}
	            		
	            	}
	            },
	            error: function(xhr, status, error) {
	                
	                if(xhr.status == 404) {
	                	mySizeInfo.innerHTML='';
		            	let th = document.createElement('th');
		            	th.textContent = "my"; // TD에 내용 삽입
	                    mySizeInfo.appendChild(th); // 생성된 TD를 TR에 추가
	                    let td = document.createElement('td');
                        td.textContent = '로그인 하시면 사이즈 정보를 확인할 수 있습니다.'; // TD에 내용 삽입
                        td.colSpan = "4";
                        mySizeInfo.appendChild(td); // 생성된 TD를 TR에 추가
	                    console.log("Error fetching size data : 사이즈 정보 없음" );
	                } else {
	                	mySizeInfo.innerHTML='';
		            	let th = document.createElement('th');
		            	th.textContent = "my"; // TD에 내용 삽입
	                    mySizeInfo.appendChild(th); // 생성된 TD를 TR에 추가
	                    let td = document.createElement('td');
                        td.textContent = '로그인 하시면 사이즈 정보를 확인할 수 있습니다.'; // TD에 내용 삽입
                        td.colSpan = "4";
                        mySizeInfo.appendChild(td); // 생성된 TD를 TR에 추가
	                    console.log("Error fetching size data: " + error);
	                }
	            }
	        });
		}
	    
	    function mysizeChangeOrderSize() {
	        // 라디오 버튼이 선택되어 있는지 확인
	        var selectedRadio = document.querySelector('input[name="selectOrderProduct"]:checked');
	        if (selectedRadio) {
	            // 선택된 라디오 버튼의 value 가져오기
	            let selectedValue = selectedRadio.value;
	            let dataToSend={
	            		productNo: selectedValue.split('-')[0],
	            		productSize: selectedValue.split('-')[1],
	            		subCategory: selectedValue.split('-')[2]
	            }
	            $.ajax({
		            url: "/finalpro/member/mysizeChangeOrderSize.do",
		            method: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify(dataToSend), // 객체를 JSON 문자열로 변환
		            success: function(data) {
		                if (data.success) {
		                    console.log("success");
		                    closePopup();
		    	            fillMySizeInfo();
		                } else {
		                    console.log("사이즈 입력 실패");
		                }
		            },
		            error: function(error) {
		                console.error('Error:', error);
		            }
		        });	            
	        } else {
	            // 라디오 버튼이 선택되지 않았을 경우의 처리
	            alert("제품 옵션을 선택해주세요.");
	        }
	    }
	    
	    function openQuestionForm() {
	    	if(userId!=null && userId!=''){
		        let popOption = "width = 550px, height=550px, top = 120px, left = 500px";
		        let openUrl = '${contextPath}/popup/question_form.do?productNo='+pageProductNo;
		        window.open(openUrl, 'pop', popOption);
	    	}else{
	    		alert('로그인 해주세요');
	    	}
	     }	        
	    
	    function loadAllComments(reviewNo) {
	        let container = document.getElementById('comment_wrap'+reviewNo);
	        
	    	console.log("함수 시작 container : "+container);

	        let dataToSend={reviewNo:reviewNo}
	        $.ajax({
	            url: "/finalpro/product/loadAllComments.do",
	            method: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify(dataToSend), // reviewNo를 객체로 변환 후 JSON 문자열로
	            success: function(comments) {
	            	console.log("ajax성공");
	                comments.forEach(function(comment) {
	                    // 댓글 컨테이너 생성
	                    var commentDiv = document.createElement('div');
	                    commentDiv.className = 'one_comment_wrap';

	                    // 댓글 내용
	                    var recommentRightDiv = document.createElement('div');
	                    recommentRightDiv.className = 'recomment_right';
	                    var recommentTxtP = document.createElement('p');
	                    recommentTxtP.className = 'recomment_txt';
	                    var cmtSummarySpan = document.createElement('span');
	                    cmtSummarySpan.className = 'cmt_summary';
	                    cmtSummarySpan.textContent = comment.content;
	                    recommentTxtP.appendChild(cmtSummarySpan);
	                    recommentRightDiv.appendChild(recommentTxtP);
	                    commentDiv.appendChild(recommentRightDiv);

	                    // 작성자 및 작성일
	                    var recommentReplyDiv = document.createElement('div');
	                    recommentReplyDiv.className = 'recomment_reply';
	                    var recommentProfileP = document.createElement('p');
	                    recommentProfileP.className = 'recomment_profile';
	                    var notCrawlTextSpan = document.createElement('span');
	                    notCrawlTextSpan.className = 'notCrawlText';
	                    notCrawlTextSpan.textContent = comment.memberId + ' | ';
	                    var recommentDateSpan = document.createElement('span');
	                    recommentDateSpan.className = 'recomment_date';
	                    recommentDateSpan.textContent = comment.regDate;
	                    recommentProfileP.appendChild(notCrawlTextSpan);
	                    recommentProfileP.appendChild(recommentDateSpan);
	                    recommentReplyDiv.appendChild(recommentProfileP);
	                    commentDiv.appendChild(recommentReplyDiv);

	                    // 추가된 댓글 컨테이너를 기존 컨테이너에 추가
	                    container.appendChild(commentDiv);
	                });

	                // 모든 댓글을 불러왔으므로 "더보기" 버튼 숨김
	                let moreViewButton = container.parentNode.querySelector('.comment_more_btn');
	                let littleViewButton = container.parentNode.querySelector('.comment_Little_btn');
	                if (moreViewButton) {
	                    moreViewButton.style.display = 'none';
	                    littleViewButton.style.display='block';
	                }
	            },
	            error: function(error) {
	                console.log('댓글 불러오기 에러:', error);
	            }
	        });
	    }
	    
	    function loadLittleComments(reviewNo) {
	        let container = document.getElementById('comment_wrap'+reviewNo);
	        var removeCommentWrap = container.querySelectorAll('.one_comment_wrap');
	        removeCommentWrap.forEach(function(comment){
	        	if (comment.getAttribute('data-static') != 'true') {
	                console.log('동적 요소');
	                comment.parentNode.removeChild(comment);
	            }
	        });
            let littleViewButton = container.parentNode.querySelector('.comment_Little_btn');
	        let moreViewButton = container.parentNode.querySelector('.comment_more_btn');
            if (littleViewButton) {
                moreViewButton.style.display = 'block';
                littleViewButton.style.display='none';
            }
	    }
	    
	    function showChildReply(button, replyNo, reviewNo) {
	    	let upButton = button.querySelector('.up');
	    	let downButton = button.querySelector('.down');
	    	let childReplyDiv = button.parentNode.parentNode.parentNode.querySelector('.child_reply')
	    	if(upButton.style.display=="inline"){
	    		childReplyDiv.hidden=false;
	    		upButton.style.display = 'none';
	    		downButton.style.display='inline';
	    		
				let dataToSend={parentReplyNo : replyNo}
	    		
	    		$.ajax({
		            url: "/finalpro/product/loadChildReply.do",
		            method: 'POST',
		            contentType: 'application/json',
		            data: JSON.stringify(dataToSend), // reviewNo를 객체로 변환 후 JSON 문자열로
		            success: function(childReply) {
		            	childReplyDiv.innerHTML='';
		            	
		            	let childReplyForm = document.createElement('form');
		            	childReplyForm.method = "post";
		            	childReplyForm.action = "/finalpro/product/insertReply.do";
		            	childReplyForm.onclick = function(event) {
		                    event.stopPropagation();
		                };

		                // reviewNo를 위한 hidden input 생성
		                let inputReviewNo = document.createElement('input');
		                inputReviewNo.type = "hidden";
		                inputReviewNo.name = "reviewNo";
		                inputReviewNo.value = reviewNo; // reviewNo 값은 함수의 매개변수 또는 다른 방법으로 설정

		                // parentReplyNo를 위한 hidden input 생성
		                let inputParentReplyNo = document.createElement('input');
		                inputParentReplyNo.type = "hidden";
		                inputParentReplyNo.name = "parentReplyNo";
		                inputParentReplyNo.value = replyNo; // parentReplyNo 값 설정

		                // 댓글 입력을 위한 textarea 생성
		                let childReplyTextarea = document.createElement('textarea');
		                childReplyTextarea.classList.add('comment-inner-text');
		                childReplyTextarea.name = "content";
		                childReplyTextarea.tabIndex = 1;

		                // 댓글 입력과 submit 버튼을 포함할 새로운 div 생성
		                let commentFormContainer = document.createElement('div');
		                commentFormContainer.classList.add('comment-form-container');

		                // 댓글 입력을 위한 textarea가 포함된 div
		                let div = document.createElement('div');
		                div.classList.add('cForm', 'comment');
		                div.id = "comment_0";
		                div.style.backgroundColor = "#fff";
		                div.appendChild(childReplyTextarea); // 이미 생성된 textarea를 div에 추가

		                // submit 버튼 생성
		                let submitInput = document.createElement('input');
		                submitInput.classList.add('comment_writting');
		                submitInput.type = "submit";
		                submitInput.value = "댓글작성";

		                // 새로운 div에 기존 div와 submit 버튼 추가
		                commentFormContainer.appendChild(div);
		                commentFormContainer.appendChild(submitInput);

		                // form에 reviewNo와 parentReplyNo 입력 필드, 그리고 새로운 div 추가
		                childReplyForm.appendChild(inputReviewNo);
		                childReplyForm.appendChild(inputParentReplyNo);
		                childReplyForm.appendChild(commentFormContainer); // 수정된 부분: 이제 form에는 commentFormContainer만 추가됩니다.
		                childReplyDiv.appendChild(childReplyForm);
		            	
		            	childReply.forEach(function(reply) {
		            		let childWrap=document.createElement('div');
		            		childWrap.className = 'child_wrap';
		            		
		            		let recommentDiv = document.createElement('div');
		            		recommentDiv.className = 'recomment_right';
		                    
		            		let recommentTxt = document.createElement('p');
		                    recommentTxt.className = 'recomment_txt';
		                    
		                    let cmtSummary = document.createElement('span');
		                    cmtSummary.className = 'cmt_summary';
		                    cmtSummary.textContent = reply.content;
		                    
		                    recommentTxt.appendChild(cmtSummary);
		                    recommentDiv.appendChild(recommentTxt);
		                    
		                    let recommentReply = document.createElement('div');
		                    recommentReply.className = 'recomment_reply';
		                    
		                    let recommentProfile = document.createElement('p');
		                    recommentProfile.className = 'recomment_profile';
		                    
		                    let notCrawlText = document.createElement('span');
		                    notCrawlText.className = 'notCrawlText';
		                    notCrawlText.textContent = reply.memberId;
		                    
		                    let recommentDate = document.createElement('span');
		                    recommentDate.className = 'recomment_date';
		                    recommentDate.textContent = reply.regDate;
		                    
		                    recommentProfile.appendChild(notCrawlText);
		                    recommentProfile.appendChild(recommentDate);
		                    recommentReply.appendChild(recommentProfile);
		                    
		                    childWrap.appendChild(recommentDiv);
		                    childWrap.appendChild(recommentReply);
		                    childReplyDiv.appendChild(childWrap);
		            	});
		                
		            },
		            error: function(error) {
		                console.log('대댓글 불러오기 에러:', error);
		            }
		        });
	    	}else if(downButton.style.display=="inline"){
	    		childReplyDiv.hidden=true;
	    		downButton.style.display='none';
	    		upButton.style.display = 'inline';
	    	}
		}

	    function toggleCommentsArea(area) {
	    	console.log("삐삐");
			if(area.getAttribute('status')=="off"){
				area.querySelector(".comment_area_span").style.display="none";
				area.querySelector(".cFormBox").style.display="inline";
				area.setAttribute('status', "on");
			}else if(area.getAttribute('status')=="on"){
				area.querySelector(".cFormBox").style.display="none";
				area.querySelector(".comment_area_span").style.display="inline";
				area.setAttribute('status', "off");
			}
		}

	</script>
	
<!-- 페이지 순서 만들때는 이거 사용하면 됨 -->


<script>
var selectedProductId = null;
var currentPage = 1;
var itemsPerPage = 2;

function reviewSelectSimilar(productNo) {
    selectedProductId = productNo; // 전역 변수 업데이트
    currentPage = 1; // 페이지 번호 초기화
    var reviews = document.querySelectorAll('.review');
    var reviewFound = false; // 리뷰 존재 여부를 체크할 변수

    reviews.forEach(function(review) {
        if (review.getAttribute('itemid') == productNo) {
            review.style.display = 'block'; // 'hidden' 속성 대신 'display' 속성 사용
            reviewFound = true;
        } else {
            review.style.display = 'none'; // 'hidden' 속성 대신 'display' 속성 사용
        }
    });

    if (!reviewFound) {
        document.getElementById('noReviewMessage').style.display = 'block';
    } else {
        document.getElementById('noReviewMessage').style.display = 'none';
    }

    createPaginationButtons(); // 제품 선택 시 페이지네이션 버튼도 업데이트
    updateItemsDisplay(); // 아이템 표시 업데이트
}


function goToPage(pageNum) {
    currentPage = pageNum;
    updateItemsDisplay();
}

function nextPage() {
    var allItems = document.querySelectorAll('.review');
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
    var paginationContainer = document.querySelector('.reviewPage');
    var allItems = document.querySelectorAll('.review');
    var filteredItems = selectedProductId ? Array.from(allItems).filter(item => item.getAttribute('itemid') === selectedProductId) : Array.from(allItems);
    var totalPages = Math.ceil(filteredItems.length / itemsPerPage);

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
    createPaginationButtons(); // 댓글 페이지네이션 버튼을 생성하는 함수

});



function updateItemsDisplay() {
    var allItems = document.querySelectorAll('.review');
    var filteredItems = []; // 필터링된 항목을 담을 배열
    if (selectedProductId) {
        filteredItems = Array.from(allItems).filter(function(item) {
            return item.getAttribute('itemid') === selectedProductId;
        });
    } else {
        filteredItems = Array.from(allItems); // 제품이 선택되지 않았다면 모든 항목 사용
    }

    var startItem = (currentPage - 1) * itemsPerPage;
    var endItem = startItem + itemsPerPage;

    // 필터링된 항목에 대해서만 루프
    filteredItems.forEach(function(item, index) {
        if (index >= startItem && index < endItem) {
            item.style.display = 'block';
        } else {
            item.style.display = 'none';
        }
    });

    createPaginationButtons(); // 필터링된 항목을 기반으로 페이지네이션 버튼 업데이트

}

</script>





<!-- Q&A 페이지 생성 -->

<script>
var selectedQuestionProductId = null; // 선택된 상품의 ID를 저장할 전역 변수
var currentQuestionPage = 1; // 현재 페이지 번호
var questionsPerPage = 2; // 페이지당 질문 수, 필요에 따라 조정 가능


function questionSelectSimilar(productNo) {
    selectedQuestionProductId = productNo; // 전역 변수 업데이트
    currentQuestionPage = 1; // 페이지 번호 초기화
    var questions = document.querySelectorAll('.question');
    var questionFound = false; // 질문 존재 여부를 체크할 변수

    questions.forEach(function(question) {
        if(question.getAttribute('itemid') == productNo){
            question.hidden = false;
            questionFound = true;
        } else {
            question.hidden = true;
        }
    });

    if (!questionFound) {
        document.getElementById('noQuestionMessage').style.display = 'block';
    } else {
        document.getElementById('noQuestionMessage').style.display = 'none';
    }

    createQuestionPaginationButtons(); // 제품 선택 시 페이지네이션 버튼도 업데이트
    updateQuestionsDisplay(); // 아이템 표시 업데이트
}




// 페이지 이동 함수
function goToPage2(pageNum) {
    currentQuestionPage = pageNum;
    updateQuestionsDisplay();
}

function nextPage2() {
    var allQuestions = document.querySelectorAll('.question');
    var totalPages = Math.ceil(allQuestions.length / questionsPerPage);
    if (currentQuestionPage < totalPages) {
        currentQuestionPage++;
        updateQuestionsDisplay();
    }
}

function previousPage2() {
    if (currentQuestionPage > 1) {
        currentQuestionPage--;
        updateQuestionsDisplay();
    }
}

function firstPage2() {
    currentQuestionPage = 1;
    updateQuestionsDisplay();
}

function lastPage2() {
    var allQuestions = document.querySelectorAll('.question');
    var totalPages = Math.ceil(allQuestions.length / questionsPerPage);
    currentQuestionPage = totalPages;
    updateQuestionsDisplay();
}


// 페이지네이션 버튼 생성 함수
function createQuestionPaginationButtons() {
    var paginationContainer = document.querySelector('.QAPage');
    
    var allQuestions = document.querySelectorAll('.question');
    var totalPages = Math.ceil(filteredQuestionItems.length / questionsPerPage);

    paginationContainer.innerHTML = ''; // 이전에 생성된 페이지네이션 버튼 제거

    // 버튼 스타일 설정을 위한 함수
    function styleButton(button, isActive) {
        button.style.padding = '8px 16px';
        button.style.backgroundColor = 'white';
        button.style.border = '1px solid #ccc';
        button.style.cursor = 'pointer';
        button.style.transition = 'background-color 0.3s ease';

        // 현재 페이지의 버튼에 대한 배경색 설정
        if (isActive) {
            button.style.backgroundColor = '#e9e9e9';
        }
    }

    // 페이지네이션 버튼 생성 로직
    const createButton = (text, handler, isActive) => {
        let button = document.createElement('button');
        button.innerText = text;
        button.addEventListener('click', handler);
        styleButton(button, isActive); // isActive를 styleButton 함수에 전달
        paginationContainer.appendChild(button);
    };

    if (currentQuestionPage > 1) {
        createButton('<<', firstPage2, false);
        createButton('<', previousPage2, false);
    }

    for (let i = 1; i <= totalPages; i++) {
        createButton(i.toString(), function() { goToPage2(i); }, i === currentQuestionPage);
    }

    if (currentQuestionPage < totalPages) {
        createButton('>', nextPage2, false);
        createButton('>>', lastPage2, false);
    }
}


// 페이지 로드 완료 시 함수 실행
document.addEventListener('DOMContentLoaded', function() {
	createQuestionPaginationButtons();
    updateQuestionsDisplay(); // 처음에 문의 항목 표시 업데이트
});

var filteredQuestionItems = []; // 전역 변수로 선언

//문의 항목을 필터링하고 표시하는 함수
function updateQuestionsDisplay() {
    var allQuestions = document.querySelectorAll('.question');
    if (selectedQuestionProductId) {
        // 제품이 선택되었다면, 해당 제품에 대한 질문만 필터링
        filteredQuestionItems = Array.from(allQuestions).filter(function(item) {
            return item.getAttribute('itemid') === selectedQuestionProductId;
        });
    } else {
        // 제품이 선택되지 않았다면, 모든 질문을 사용
        filteredQuestionItems = Array.from(allQuestions);
    }
    
    var startItem = (currentQuestionPage - 1) * questionsPerPage;
    var endItem = startItem + questionsPerPage;

    // 전체 질문을 숨기고, 현재 페이지에 해당하는 질문만 표시
    allQuestions.forEach(item => item.hidden = true); // 먼저 모든 질문을 숨깁니다.
    filteredQuestionItems.forEach((item, index) => {
        if (index >= startItem && index < endItem) {
            item.hidden = false; // 현재 페이지에 해당하는 항목만 표시
        }
    });

    createQuestionPaginationButtons(); // 페이지네이션 버튼 생성 함수 호출
}
</script>








<script>
document.addEventListener('DOMContentLoaded', function() {
    var showMoreButton = document.querySelector('.show-more-info');
    var salesCompanyProductImage = document.querySelector('.sales_company_product_image');
    var infoImageNumber = parseInt(salesCompanyProductImage.getAttribute('data-image-number'), 10);
    var hiddenImages = document.querySelectorAll('.sales_company_product_image ul li.hidden');
    var firstImageContainer = document.querySelector('.sales_company_product_image ul li:first-child');

    if (infoImageNumber === 1) {
        // infoImageNumber가 1인 경우의 로직
        // 첫 번째 이미지의 최대 높이를 설정
        firstImageContainer.style.maxHeight = '1000px';
        firstImageContainer.style.overflow = 'hidden';

        // "상품 정보 더보기" 버튼 클릭 시 첫 번째 이미지의 높이 제한을 해제하고, 숨겨진 이미지를 보여줌
        showMoreButton.addEventListener('click', function() {
            var isExpanded = showMoreButton.getAttribute('data-expanded') === 'true';

            if (isExpanded) {
                firstImageContainer.style.maxHeight = '400px'; // 첫 번째 이미지 높이 제한 재적용
                hiddenImages.forEach(function(img) {
                    img.classList.add('hidden');
                });
            } else {
                firstImageContainer.style.maxHeight = 'none'; // 첫 번째 이미지 높이 제한 해제
                hiddenImages.forEach(function(img) {
                    img.classList.remove('hidden');
                });
            }

            // 버튼 텍스트 및 속성 업데이트
            showMoreButton.textContent = isExpanded ? '상품 정보 더보기 ▽' : '상품 정보 접기 △';
            showMoreButton.setAttribute('data-expanded', !isExpanded);
        });
    } else {
        // infoImageNumber가 1이 아닌 경우의 로직
        // 모든 숨겨진 이미지를 토글하는 기능만 있음
        showMoreButton.addEventListener('click', function() {
            var isExpanded = showMoreButton.getAttribute('data-expanded') === 'true';
            hiddenImages.forEach(function(img) {
                img.style.display = isExpanded ? 'none' : 'block';
            });

            // 버튼 텍스트 및 속성 업데이트
            showMoreButton.textContent = isExpanded ? '상품 정보 더보기 ▽' : '상품 정보 접기 △';
            showMoreButton.setAttribute('data-expanded', !isExpanded);
        });
    }

    // 첫 번째 이미지 높이에 따라 "상품 정보 더보기" 버튼 표시 조건 추가
    var firstImage = firstImageContainer.querySelector('img');
    firstImage.onload = function() {
        if (firstImage.clientHeight > 1000) {
            showMoreButton.style.display = 'block'; // 첫 번째 이미지의 높이가 400px을 초과하면 버튼 표시
        }
    };
});

</script>



<script>
function changeImage(element) {
  // 이전에 선택된 요소의 테두리 스타일 제거
  var previouslySelected = document.querySelector('.product_second_image .image-hover');
  if (previouslySelected) {
    previouslySelected.classList.remove('image-hover');
  }

  // 현재 요소에 테두리 스타일 추가
  element.classList.add('image-hover');

  // 메인 이미지 변경
  var mainImage = document.getElementById('mainImage');
  var newSrc = element.children[0].src; // element의 첫 번째 자식 요소인 img 태그의 src를 가져옵니다.
  mainImage.src = newSrc;
}

function resetImage() {
  var mainImage = document.getElementById('mainImage');
  mainImage.src = "${contextPath}/download.do?imageFileName=1.jpg&productNo=${dto.productNo}&path=";
}


function buyRightNow() {
    if(userId!=null && userId!=''){
       location.href='${contextPath}/mypage/recepit1.do';
     }else{
        alert('로그인해주세요');
      location.href='/finalpro/member/loginForm.do';
     }
}
</script>	
	
</head>
<body>
    <div class="wrap">
        <div class="root">
            <header>
                <div class="">
                    <a href="${contextPath }" title="메인페이지" class="">메인페이지</a>
                    <span>&gt;</span>
                    <a href="${contextPath }/brand/brandList.do?brand=${dto.brand}" title="해당 브랜드" class="">${dto.brand}(${dto.brandEng})</a>
                </div>
                <a id="brandImage" href="${contextPath }/brand/brandList.do?brand=${dto.brand}" title="해당 브랜드" class="" style="display: block;">
                    <img alt="해당브랜드 이미지" src='${contextPath}/download.do?imageFileName=2.jpg&productNo=${dto.brand}&path=brand' style="background-color: gray;">
                </a>
            </header>
            <!-- 제품 상세+구매버튼 -->
            <div class="info_container">
                <!-- 제품 상세 위쪽 -->
                <div class="info_container_top" class="">
                    <div class="category_path">
                        <span>
                            ${dto.category }
                        </span>
                        <span class="">&nbsp;&gt;&nbsp;</span>
                        <a href="/finalpro/product/listProducts.do?subCategory=${dto.subCategory }" title="하위 카테고리" class=""> 
                            ${dto.subCategory }
                        </a>
                        &nbsp;
                        <a href="${contextPath }/brand/brandList.do?brand=${dto.brand}" title="해당 브랜드" class="">
                            ${dto.brand}
                        </a>
                    </div>
                    <div class="">
                        <div class="product_name">
                            <h3 class="">${dto.name }</h3>
                        </div>
                    </div>
                </div>
                <!-- 제품 상세 아래쪽 -->
                <div class="info_container_bottom">
	                <!-- 제품 상세 왼쪽 -->
					<div class="info_container_left_side">
						<div class="product-detail-thumbnail">
							<div class="product_first_image">
								<img id="mainImage" src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${dto.productNo}&path=">
							</div>
							<div class="product_second_image">
								<ul class="product_second_image" style="list-style: none;">
									<c:forEach var="image" items="${imageList }">
										<c:if test="${image.productNo==dto.productNo }">
											<li onmouseover="changeImage(this)">
												<img src="${contextPath}/download.do?imageFileName=${image.imageFileName}&productNo=${image.productNo}&path=product">
											</li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
						</div>
								
						<div>
							<c:if test="${dto.category=='shoes' }">
								<script type="text/javascript">
									document.querySelectorAll(".size_info").forEach(function(el) {
										el.style.display = 'none'; // 요소를 숨깁니다.
									});
								</script>
							</c:if>
							<div class="size_info">
								<h4 class="">
									<strong class="">Size Info</strong>
									<span class="">사이즈정보</span>
								</h4>
								<div class="purchase_detail_size">
									<button title="구매내역 실측 선택" id="purchase_detail_size_button" onclick="showPurchaseProductSize()">구매내역 실측 선택</button>
									<a href="/finalpro/member/sizeRecommend.do" class="purchase_detail_size_input">실측 직접 입력</a>
								</div>
								<table class="" border="1px">
									<thead class="">
										<tr class="">
											<th class="size_info_div">cm</th>
											<c:if test='${!empty sizeList[0].topTotalLength && sizeList[0].topTotalLength!=0}'>
												<td class="">총장</td>
											</c:if>
											<c:if test='${!empty sizeList[0].shoulderLength && sizeList[0].shoulderLength!=0}'>
												<td class="">어깨너비</td>
											</c:if>
											<c:if test='${!empty sizeList[0].chestCrossLength && sizeList[0].chestCrossLength!=0}'>
												<td class="">가슴단면</td>
											</c:if>
											<c:if test='${!empty sizeList[0].sleevelength && sizeList[0].sleevelength!=0}'>
												<td class="">소매길이</td>
											</c:if>
											<c:if test='${!empty sizeList[0].waistCrossLength && sizeList[0].waistCrossLength!=0}'>
												<td class="">허리단면</td>
											</c:if>
											<c:if test='${!empty sizeList[0].hipCrossLength && sizeList[0].hipCrossLength!=0}'>
												<td class="">엉덩이단면</td>
											</c:if>
											<c:if test='${!empty sizeList[0].thighCrossLength && sizeList[0].thighCrossLength!=0}'>
												<td class="">허벅지단면</td>
											</c:if>
											<c:if test='${!empty sizeList[0].riseLength && sizeList[0].riseLength!=0}'>
												<td class="">밑위</td>                                      	
											</c:if> 
											<c:if test='${!empty sizeList[0].hemCrossLength && sizeList[0].hemCrossLength!=0}'>
												<td class="">밑단단면</td>                                      	
											</c:if>
											<c:if test='${!empty sizeList[0].footLength && sizeList[0].footLength!=0}'>
												<td class="">발길이</td>                                                       	
											</c:if>
											<c:if test='${!empty sizeList[0].ballOfFoot && sizeList[0].ballOfFoot!=0}'>
												<td class="">발볼</td>                                                       	
											</c:if>
											<c:if test='${!empty sizeList[0].ankleHeight && sizeList[0].ankleHeight!=0}'>
												<td class="">발목높이</td>                                                       	
											</c:if>
											<c:if test='${!empty sizeList[0].instepHeight && sizeList[0].instepHeight!=0}'>
												<td class="">굽높이</td>                                                       	
											</c:if>
										</tr>
									</thead>
									<tbody class="">
										<tr id="my_size_info">
											<th class="">MY</th>
										</tr>
										<c:forEach var="size" items="${sizeList}">
											<c:if test="${size.productNo==dto.productNo }">
												<tr class="size_info_div2">
													<th class="">${size.productSize}</th>
													<c:if test='${!empty size.topTotalLength && size.topTotalLength!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.topTotalLength, '.')}">
														        <td><fmt:formatNumber value="${size.topTotalLength}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.topTotalLength}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
													<c:if test='${!empty size.shoulderLength && size.shoulderLength!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.shoulderLength, '.')}">
														        <td><fmt:formatNumber value="${size.shoulderLength}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.shoulderLength}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
													<c:if test='${!empty size.chestCrossLength && size.chestCrossLength!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.chestCrossLength, '.')}">
														        <td><fmt:formatNumber value="${size.chestCrossLength}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.chestCrossLength}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
													<c:if test='${!empty size.sleevelength && size.sleevelength!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.sleevelength, '.')}">
														        <td><fmt:formatNumber value="${size.sleevelength}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.sleevelength}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
													<c:if test='${!empty size.waistCrossLength && size.waistCrossLength!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.waistCrossLength, '.')}">
														        <td><fmt:formatNumber value="${size.waistCrossLength}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.waistCrossLength}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
													<c:if test='${!empty size.hipCrossLength && size.hipCrossLength!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.hipCrossLength, '.')}">
														        <td><fmt:formatNumber value="${size.hipCrossLength}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.hipCrossLength}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
													<c:if test='${!empty size.thighCrossLength && size.thighCrossLength!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.thighCrossLength, '.')}">
														        <td><fmt:formatNumber value="${size.thighCrossLength}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.thighCrossLength}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
													<c:if test='${!empty size.riseLength && size.riseLength!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.riseLength, '.')}">
														        <td><fmt:formatNumber value="${size.riseLength}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.riseLength}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
													<c:if test='${!empty size.hemCrossLength && size.hemCrossLength!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.hemCrossLength, '.')}">
														        <td><fmt:formatNumber value="${size.hemCrossLength}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.hemCrossLength}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
													<c:if test='${!empty size.footLength && size.footLength!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.footLength, '.')}">
														        <td><fmt:formatNumber value="${size.footLength}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.footLength}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
													<c:if test='${!empty size.ballOfFoot && size.ballOfFoot!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.ballOfFoot, '.')}">
														        <td><fmt:formatNumber value="${size.ballOfFoot}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.ballOfFoot}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
													<c:if test='${!empty size.ankleHeight && size.ankleHeight!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.ankleHeight, '.')}">
														        <td><fmt:formatNumber value="${size.ankleHeight}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.ankleHeight}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
													<c:if test='${!empty size.instepHeight && size.instepHeight!=0}'>
														<c:choose>
														    <c:when test="${fn:contains(size.instepHeight, '.')}">
														        <td><fmt:formatNumber value="${size.instepHeight}" pattern="#,##0.0"/></td>
														    </c:when>
														    <c:otherwise>
														        <td><fmt:formatNumber value="${size.instepHeight}" pattern="#,##0"/></td>
														    </c:otherwise>
														</c:choose>
													</c:if>
												</tr>
											</c:if>
										</c:forEach>
									</tbody>
								</table>
							</div>
								
							<div class="size_info" id="sizePopup" style="display:none;">
								<div class="product-detail__sc-10xm6kh-1 fspQXD">
									<h4 class="product-detail__sc-10xm6kh-2 eKpryC">나의 구매내역</h4>
									<button id="close_popup_btn" onclick="closePopup()">
										<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 30 30" fill="none">
											<rect x="22.7637" y="6.5" width="1" height="23" transform="rotate(45 22.7637 6.5)" fill="#000000">
											</rect>
											<rect x="7.20703" y="6.5" width="23" height="1" transform="rotate(45 7.20703 6.5)" fill="#000000">
											</rect>
										</svg>
									</button>
								</div>
								<ul id="order_history_ul"></ul>
								<button class="product-detail__sc-10xm6kh-18 fIcSYT" onclick="mysizeChangeOrderSize()">선택하기</button>
							</div>
								
							<div id="overlay" style="display:none;" onclick="closePopup()"></div>
						</div>
					</div>	
		            <!-- 제품 상세 오른쪽-->
					<div class="info_container_right_side">
						<!-- 제품 정보 + 관련 태그 -->
						<div class="product_info">
		                    <h4 class="">
		                        <strong class="">Product Info</strong>
		                        <span class="">제품정보</span>
		                    </h4>
	                        <table>
	                            <tr>
	                                <td>브랜드/품번</td>
	                                <td class="bold-text">${productList[0].brand}/${dto.productNo }</td>
	                            </tr>
	                            <tr>
	                                <td>성별</td>
	                                <c:choose>
	                                	<c:when test='${empty productList[0].gender || productList[0].gender=="both"}'>
	                                		<td class="bold-text">남성, 여성</td>
	                                	</c:when>
	                                	<c:when test='${productList[0].gender=="male"}'>
	                                		<td class="bold-text">남성</td>
	                                	</c:when>
	                                	<c:when test='${productList[0].gender=="female"}'>
	                                		<td class="bold-text">여성</td>
	                                	</c:when>
	                                </c:choose>
	                            </tr>
	                            <tr>
	                                <td>조회수(1개월)</td>
	                                <td class="bold-text">${dto.viewCount }</td>
	                            </tr>
	                            <tr>
	                                <td>누적 판매량</td>
	                                <td class="bold-text">${oneMonthSalesTotal }</td>
	                            </tr>
	                            <tr>
	                                <td>좋아요</td>
	                                <td class="bold-text">
							    		<img src="/finalpro/resources/image/like.png" class="like_image">
							    		<span class="like_txt">${dto.likeCount}</span>
									</td>
	                            </tr>
	                        </table>
	                        <div class="tag_area">
		                       	<c:forEach var="tag" items="${tagList}">
		                       		<a href="" title="관련태그" class="">#${tag }</a>
		                       	</c:forEach>
	                        </div>
						</div>  
						<!-- 가격정보 표시 칸 -->
	                    <div class="price_info">
	                        <h4 class="">
	                            <strong class="">Price Info</strong>
	                            <span class="">가격정보</span>
	                        </h4>
	                        <div class="price_div">
	                            <table>
	                                <tr>
	                                    <td>가격</td>
	                                    <td class="bold-text">${productList[0].price }원</td>
	                                </tr>
	                            </table>
	                        </div>
	                    </div>  
	                    <!-- 옵션(색상, 사이즈) 선택 + 선택시 금액 -->
	                    <div class="">
	                        <div class="selectOption_div">
	                            <!-- 1번 옵션 -->
	                            <c:choose>
	                             <c:when test="${productList[0].color1!=productList[1].color1 }">
	                             	<select id="colorSelect" class="" onchange="showSizeOptions(this.value)">
	                                    <option value="" selected="selected">옵션 선택</option>
										<c:forEach var="product" items="${productList}">
											<option value="${product.productNo }">${product.name }</option>
										</c:forEach>
	                             	</select>
	                             	
	                              <select id="sizeSelect1" class="sizeSelect" onchange="updateSelectedOptions()">
	                              </select>
	                             </c:when>
	                             <c:otherwise>
	                             	<select id="sizeSelect2" class="sizeSelect">
	                                  <option value="" selected="selected">옵션 선택</option>
	                                  <c:forEach var="size" items="${sizeList}">
	                                  	<c:if test="${size.productNo==dto.productNo }">
		                                  	<c:choose>
		                                  		<c:when test="${size.stock }>1">
		                                  			<option value="${size.productSize }">${size.productSize }</option>
		                                  		</c:when>
		                                  		<c:otherwise>
		                                  			<option disabled="disabled">${size.productSize } / 품절</option>
		                                  		</c:otherwise>
		                                  	</c:choose>		                                    	
	                                  	</c:if>
	                                  </c:forEach>
	                              </select>
	                             </c:otherwise>
	                            </c:choose>
	                        </div>
	                        <ul id="selected-option-list" class="product-detail__sc-quxbyg-0 bQIQFY"></ul>
	                        
	                        <ul class="total_price_div">
	                            <em class="">총 상품 금액</em>
	                            <strong id="print-selected-price">0원</strong>
	                        </ul>
						</div>
						<!-- 구매하기, 좋아요, 장바구니 담기 버튼 -->
						<div class=""> 
							<ul class="want-product-form-ul" style="list-style: none;">
	                           	<li style="display: inline-block;">
	                                <button class="buy-right-now" onclick="buyRightNow()">
                                       <strong class="">바로구매</strong>
                                   </button>
								</li>
	                            <li style="display: inline-block;">
	                            	<a id="likeButton" class="like_basket" href="javascript:void(0);">
		                            	<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" viewBox="0 0 30 30" fill="none" id="like-heart">
		                                	<path d="M15.3779 9.38123L13.6524 7.65578C11.5073 5.51066 8.02936 5.51065 5.88423 7.65578C3.73911 9.8009 3.73911 13.2788 5.88423 15.424L14.9992 24.539L18.5248 21.0134C18.6735 20.8647 18.8127 20.7102 18.9425 20.5505L23.0949 16.3982M16.396 7.56125C18.5447 5.46384 21.9869 5.4797 24.116 7.60884C26.2445 9.73732 26.261 13.178 24.1656 15.3268" stroke="#bbb">
		                                	</path>
		                           		</svg>
		                                <span class="" style="display: block;">${dto.likeCount}</span>
	                             	</a>
	                            </li>
	                            <li style="display: inline-block;">
	                            	<a id="basketButton" class="like_basket" href="javascript:void(0);">
	                                	<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 32 32" fill="none" id="basket-box">
	                                    	<path d="M6.93359 21.8667V8.00007H25.0669V27.7334H12.2669M6.93359 23.4667V27.7334H10.6669M11.2003 10.6667V9.00146C11.2003 6.09199 13.3493 3.7334 16.0003 3.7334C18.6512 3.7334 20.8003 6.09199 20.8003 9.00146V10.6667" stroke="#bbb">
	                                 		</path>
	                                	</svg>
	                             	</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
        </div>

		<!-- 설명 이미지, 구매/조회 현황 -->
		<div class=""> 
			<!-- 판매사 제공 제품 설명 이미지 -->
			<section class="sales_company_product">
					<div class="sales_company_product_info">
						<strong class="">Info</strong>
						<span class="">정보</span>
					</div>
					<div class="sales_company_product_image" data-image-number="${infoImageNumber}">
					    <ul style="list-style: none;">
					        <c:forEach var="i" begin="1" step="1" end="${infoImageNumber}" varStatus="status">
					            <li class="${status.index < 2 ? '' : 'hidden'}">
					                <img src="${contextPath}/download.do?imageFileName=${i}.jpg&productNo=${dto.productNo}&path=productInfo">
					            </li>
					        </c:forEach>
					    </ul>
					    <button class="show-more-info">상품 정보 더보기 ▽</button>
					</div>
			</section>       
			<!-- 구매 현황, 조회 현황 -->
			<section id="" class="current_situation">
				<div class="purchase-view-button">
					<button type="button" class="purchase-button" value="purchase" onclick="statusGraphOutput(this)">
						Purchase status<span class="purchase_status_1">구매 현황</span>
					</button>
					<button type="button" class="view-button" value="view-count" onclick="statusGraphOutput(this)">
						View count status<span class="view_status_1">조회 현황</span>
					</button>
				</div>
				<!-- 구매현황 -->
				<div class="status" id="purchase-status">
					<div class="charts-container">
						<div class="bar-chart-section">
							<h3>총 구매 ${oneYearSalesTotal} 개</h3>
							<p class="recent-year-purchase">최근 1년간 구매 내역 기준</p>
							<p class="age-label">연령</p>
							<canvas class="bar-chart-canvas" id="purchase-bar-chart-canvas"></canvas>
						</div>
						<div class="pie-chart-section">
							<p class="age-label">성별</p>
							<canvas class="pie-chart-canvas" id="purchase-pie-chart"></canvas>
						</div>
					</div>
				</div>
				<!-- 조회현황 -->
				<div class="status" id="view-count-status" hidden>
					<div class="charts-container">
						<div class="bar-chart-section">
							<h3>총 조회 ${genderViewList[2]} 회</h3>
							<p class="recent-year-purchase">최근 1달간 조회 내역</p>
							<p class="age-label">연령</p>
							<canvas class="bar-chart-canvas" id="view-bar-chart-canvas"></canvas>
						</div>
						<div class="pie-chart-section">
							<p class="age-label">성별</p>
							<canvas class="pie-chart-canvas" id="view-pie-chart"></canvas>
						</div>
					</div>
				</div>
			</section>
		</div>

		<!-- 후기 -->
		<div id="estimateBox">
			<c:set var="reviewList" value="${reviewList}"/>
			<h3 class="title-box font-mss">구매후기(<span id="review_total">${fn:length(reviewList)}</span>)</h3>
			<!-- // 만족도-->
			<div id="satisfaction_fragment" class="wrap-estimate-avg">
				<div class="estimate-avg">
					<!-- 별점 -->
					<div class="estimate-avg-point">
						<c:set var="totalStarScore" value="0"/>
						<c:set var="avgStarScore" value="0"/>
						
						<c:choose>
							<c:when test="${not empty reviewList}">
								<c:forEach var="review" items="${reviewList }">
									<c:set var="totalStarScore" value="${totalStarScore+review.starScore }"/>
								</c:forEach>
								<c:set var="avgStarScore" value="${totalStarScore / fn:length(reviewList)}"/>
							</c:when>
						</c:choose>
						
						
						
						<span class="tit">구매 만족도</span>
						<div class="star-rating-wrapper">
							<div class="star-rating">
								<div class="filled-stars" style="width: ${avgStarScore/5*100}%;">★★★★★</div>
								<div class="empty-stars">★★★★★</div>
							</div>
							<span class="rating-percent">
								<fmt:formatNumber value="${avgStarScore}" maxFractionDigits="2" />
							</span>
						</div>
					</div>
					<!-- //별점 -->
					<!-- 상세 만족도 -->
					<div class="estimate-avg-contents" id="satisfaction_list">
						<c:set var="size_big" value="0"/>
						<c:set var="size_normal" value="0"/>
						<c:set var="size_samll" value="0"/>
						
						<c:set var="bright_bright" value="0"/>
						<c:set var="bright_normal" value="0"/>
						<c:set var="bright_dark" value="0"/>
						
						<c:set var="color_clear" value="0"/>
						<c:set var="color_normal" value="0"/>
						<c:set var="color_murky" value="0"/>
						
						<c:set var="thick_thick" value="0"/>
						<c:set var="thick_normal" value="0"/>
						<c:set var="thick_thin" value="0"/>
						
						<c:forEach var="review" items="${reviewList }">
							<c:if test="${review.sizeAssessment==1}">
								<c:set var="size_big" value="${size_big+1 }"/>
							</c:if>
							<c:if test="${review.sizeAssessment==2}">
								<c:set var="size_normal" value="${size_normal+1 }"/>
							</c:if>
							<c:if test="${review.sizeAssessment==3}">
								<c:set var="size_samll" value="${size_samll+1 }"/>
							</c:if>
							
							<c:if test="${review.brightAssessment==1}">
								<c:set var="bright_bright" value="${bright_bright+1 }"/>
							</c:if>
							<c:if test="${review.brightAssessment==2}">
								<c:set var="bright_normal" value="${bright_normal+1 }"/>
							</c:if>
							<c:if test="${review.brightAssessment==3}">
								<c:set var="bright_dark" value="${bright_dark+1 }"/>
							</c:if>
							
							<c:if test="${review.colorAssessment==1}">
								<c:set var="color_clear" value="${color_clear+1 }"/>
							</c:if>
							<c:if test="${review.colorAssessment==2}">
								<c:set var="color_normal" value="${color_normal+1 }"/>
							</c:if>
							<c:if test="${review.colorAssessment==3}">
								<c:set var="color_murky" value="${color_murky+1 }"/>
							</c:if>
							
							<c:if test="${review.thickAssessment==1}">
								<c:set var="thick_thick" value="${thick_thick+1 }"/>
							</c:if>
							<c:if test="${review.thickAssessment==2}">
								<c:set var="thick_normal" value="${thick_normal+1 }"/>
							</c:if>
							<c:if test="${review.thickAssessment==3}">
								<c:set var="thick_thin" value="${thick_thin+1 }"/>
							</c:if>                  
						</c:forEach>
						
						<!-- 사이즈 -->
						<div class="lv-contents">
							<div class="tit">사이즈</div>
							<ul class="prd-level-graph">
								<li class="on">
									<div class="label-and-per">
										<div class="label">커요</div>
										<div class="per">(${size_big/(size_big+size_normal+size_small)*100}%)</div>
									</div>
									<div class="progress-bar">
										<div class="progress" style="width: ${size_big/(size_big+size_normal+size_small)*100}%;"></div>
									</div>
								</li>
								<li class="on">
									<div class="label-and-per">
										<div class="label">보통이에요</div>
										<div class="per">(${size_normal/(size_big+size_normal+size_small)*100}%)</div>
									</div>
									<div class="progress-bar">
										<div class="progress" style="width: ${size_normal/(size_big+size_normal+size_small)*100}%;"></div>
									</div>
								</li>
								<li class="on">
									<div class="label-and-per">
										<div class="label">작아요</div>
										<div class="per">(${size_small/(size_big+size_normal+size_small)*100}%)</div>
									</div>
									<div class="progress-bar">
										<div class="progress" style="width: ${size_small/(size_big+size_normal+size_small)*100}%;"></div>
									</div>
								</li>
							</ul>
						</div>
						
						<!-- 밝기 -->
						<div class="lv-contents">
							<div class="tit">밝기</div>
							<ul class="prd-level-graph">
								<li class="on">
									<div class="label-and-per">
										<div class="label">밝아요</div>
										<div class="per">(${bright_bright/(bright_bright+bright_normal+bright_dark)*100}%)</div>
									</div>
									<div class="progress-bar">
										<div class="progress" style="width: ${bright_bright/(bright_bright+bright_normal+bright_dark)*100}%;"></div>
									</div>
								</li>
								<li class="on">
									<div class="label-and-per">
										<div class="label">보통이에요</div>
										<div class="per">(${bright_normal/(bright_bright+bright_normal+bright_dark)*100}%)</div>
									</div>
									<div class="progress-bar">
										<div class="progress" style="width: ${bright_normal/(bright_bright+bright_normal+bright_dark)*100}%;"></div>
									</div>
								</li>
								<li class="on">
									<div class="label-and-per">
										<div class="label">어두워요</div>
										<div class="per">(${bright_dark/(bright_bright+bright_normal+bright_dark)*100}%)</div>
									</div>
									<div class="progress-bar">
										<div class="progress" style="width: ${bright_dark/(bright_bright+bright_normal+bright_dark)*100}%;"></div>
									</div>
								</li>
							</ul>
						</div>
						<div class="lv-contents">
								<div class="tit">색감</div>
							<ul class="prd-level-graph">
								<li class="on">
									<div class="label-and-per">
										<div class="label">선명해요</div>
										<div class="per">(${color_clear/(color_clear+color_normal+color_murky)*100}%)</div>
									</div>
									<div class="progress-bar">
										<div class="progress" style="width: ${color_clear/(color_clear+color_normal+color_murky)*100}%;"></div>
									</div>
								</li>
								<li class="on">
									<div class="label-and-per">
										<div class="label">보통이에요</div>
										<div class="per">(${color_normal/(color_clear+color_normal+color_murky)*100}%)</div>
									</div>
									<div class="progress-bar">
										<div class="progress" style="width: ${color_normal/(color_clear+color_normal+color_murky)*100}%;"></div>
									</div>
								</li>
								<li class="on">
									<div class="label-and-per">
										<div class="label">흐려요</div>
										<div class="per">(${color_murky/(color_clear+color_normal+color_murky)*100}%)</div>
									</div>
									<div class="progress-bar">
										<div class="progress" style="width: ${color_murky/(color_clear+color_normal+color_murky)*100}%;"></div>
									</div>
								</li>
							</ul>
						</div>
						<div class="lv-contents">
							<div class="tit">두께감</div>
							<ul class="prd-level-graph">
								<li class="on">
									<div class="label-and-per">
										<div class="label">두꺼워요</div>
										<div class="per">(${thick_thick/(thick_thick+thick_normal+thick_thin)*100}%)</div>
									</div>
									<div class="progress-bar">
										<div class="progress" style="width: ${thick_thick/(thick_thick+thick_normal+thick_thin)*100}%;"></div>
									</div>
								</li>
							</ul>
							<ul class="prd-level-graph">
								<li class="on">
									<div class="label-and-per">
										<div class="label">보통이에요</div>
										<div class="per">(${thick_normal/(thick_thick+thick_normal+thick_thin)*100}%)</div>
									</div>    
									<div class="progress-bar">
										<div class="progress" style="width: ${thick_normal/(thick_thick+thick_normal+thick_thin)*100}%;"></div>
									</div>
									
								</li>
							</ul>
							<ul class="prd-level-graph">
								<li class="on">
									<div class="label-and-per">
										<div class="label">얇아요</div>
										<div class="per">(${thick_thin/(thick_thick+thick_normal+thick_thin)*100}%)</div>
									</div>
									<div class="progress-bar">
										<div class="progress" style="width: ${thick_thin/(thick_thick+thick_normal+thick_thin)*100}%;"></div>
									</div>
									
								</li>
							</ul>
						</div>
					</div>
					<!-- //상세만족도 -->
				</div>
			</div>

			<div class="tabBox">
					<!-- wrap -->
					<div class="wrap review_list_detail" id="wrapEstimateList">
						<div class="review-list-wrap" id="reviewListFragment" border="1px">
							<p class="article_review_select">
								<select id="reviewGoodsSimilarList" class="otherColor_review" onchange="reviewSelectSimilar(this.value)">
									<option value=""  selected="selected" class="">다른 컬러 후기 보기</option>
									<c:forEach var="product" items="${productList }">
										<option value="${product.productNo }">${product.name }</option>
									</c:forEach>
								</select>
							</p>
						
							<!-- 리뷰리스트-->
							<div class="review-list">
								<p id="noReviewMessage" style="display: none;">등록된 리뷰가 없습니다.</p>
								<c:forEach var="review" items="${reviewList }">
									<div class="review" itemid="${review.productNo }">
										<div class="review-profile">
											<div class="review-profile__text">
												<p class="review-profile__name">${review.memberId }</p>
												<p class="review-profile__date">${review.regDate }</p>
											</div>
											<div class="review-profile__information">
												<p class="review-profile__body_information">
													<c:if test='${review.memberGender=="male" }'>남성</c:if>
													<c:if test='${review.memberGender=="female" }'>여성</c:if> · ${review.memberHeight}<span>cm</span> · ${review.memberWeight}<span>kg</span>
												</p>
											</div>
										</div>
										
										<div class="review-goods-information">
											<div class="review-goods-information__thumbnail">
												<a href="${contextPath}/product/detailProduct.do?productNo=${review.productNo}" class="review-goods-information__link">
													<img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${review.productNo}&path=product">
												</a>
											</div>
											<div class="review-goods-information__item">
												<a href="${contextPath}/product/detailProduct.do?productNo=${review.productNo}" class="review-goods-information__name">${review.productName }(상품페이지로 이동)</a>
												<p class="review-goods-information__option-wrap">${review.productName }<span>/</span>${review.productSize }<span>구매</span></p>
											</div>
										</div>
										
										<div class="review-list__rating-wrap">
											<div class="star-rating">
												<div class="filled-stars" style="width: ${review.starScore/5*100}%;">★★★★★</div>
												<div class="empty-stars">★★★★★</div>
											</div>
										</div>
										
										<div class="review-contents" review_type="goods_estimate" data-review-no="53250844"
											data-goods-no="3551101">
											<div class="review-evaluation--type3">
												<ul class="review-evaluation--type3__list">
													<c:if test="${review.sizeAssessment==1}">
														<li class="review-evaluation--type3__item">사이즈 <span class="review_comment">커요</span></li>
													</c:if>
													<c:if test="${review.sizeAssessment==2}">
														<li class="review-evaluation--type3__item">사이즈 <span class="review_comment">보통이에요</span></li>
													</c:if>
													<c:if test="${review.sizeAssessment==3}">
														<li class="review-evaluation--type3__item">사이즈 <span class="review_comment">작아요</span></li>
													</c:if>
													
													<c:if test="${review.brightAssessment==1}">
														<li class="review-evaluation--type3__item">밝기 <span class="review_comment">밝아요</span></li>
													</c:if>
													<c:if test="${review.brightAssessment==2}">
														<li class="review-evaluation--type3__item">밝기 <span class="review_comment">보통이에요</span></li>
													</c:if>
													<c:if test="${review.brightAssessment==3}">
														<li class="review-evaluation--type3__item">밝기 <span class="review_comment">어두워요</span></li>
													</c:if>
													
													<c:if test="${review.colorAssessment==1}">
														<li class="review-evaluation--type3__item">색감 <span class="review_comment">선명해요</span></li>
													</c:if>
													<c:if test="${review.colorAssessment==2}">
														<li class="review-evaluation--type3__item">색감 <span class="review_comment">보통이에요</span></li>
													</c:if>
													<c:if test="${review.colorAssessment==3}">
														<li class="review-evaluation--type3__item">색감 <span class="review_comment">흐려요</span></li>
													</c:if>
													
													<c:if test="${review.thickAssessment==1}">
														<li class="review-evaluation--type3__item">두께감 <span class="review_comment">두꺼워요</span></li>
													</c:if>
													<c:if test="${review.thickAssessment==2}">
														<li class="review-evaluation--type3__item">두께감 <span class="review_comment">보통이에요</span></li>
													</c:if>
													<c:if test="${review.thickAssessment==3}">
														<li class="review-evaluation--type3__item">두께감 <span class="review_comment">얇아요</span></li>
													</c:if>
													
													<c:if test="${review.deliveryAssessment==1}">
														<li class="review-evaluation--type3__item">배송 <span class="review_comment">빨라요</span></li>
													</c:if>
													<c:if test="${review.deliveryAssessment==2}">
														<li class="review-evaluation--type3__item">배송 <span class="review_comment">아쉬워요</span></li>
													</c:if>
													
													<c:if test="${review.packAssessment==1}">
														<li class="review-evaluation--type3__item">포장 <span class="review_comment">꼼꼼해요</span></li>
													</c:if>
													<c:if test="${review.packAssessment==2}">
														<li class="review-evaluation--type3__item">포장 <span class="review_comment">아쉬워요</span></li>
													</c:if>
												</ul>
											</div>
		
											<div class="review-contents__text">${review.content }</div>
		
											<!--고객이 등재한 이미지 -->
		
											<div class="review-content-photo">
												<img src="" alt="고객이 등재한 이미지(${review.imageFileName })">
											</div>
										</div>
										
										<span class="review-list__comment-wrap">
											댓글 <span class="review-list__comment" comment_cnt="8">${review.replyCount }개</span>
										</span>
		
										<!--comment-->
										<div class="comments-list">
											<div class="comments comments-input" c_idx="53250844" est_type="style" is_open="">
												<!--댓글작성-->
												<!-- 클릭시 댓글 입력 창 생성 -->
												<div class="comment_store cFormTriger" onclick="toggleCommentsArea(this);" status="off">
													<div class="cFormBox" style="display: none;">
													   <form class="cFormBox_text" method="post" onclick="event.stopPropagation();" action="/finalpro/product/insertReply.do">
													   		<input type="hidden" name="reviewNo" id="" value="${review.reviewNo}">
													   		<input type="hidden" name="parentReplyNo" id="" value="">
													       	<!-- 댓글 쓰는 TextArea -->
													       	<div class="cForm comment" id="comment_0" style="background-color:#fff">
													           	<textarea class="comment-inner-text" name="content" tabindex="1"></textarea>
													       	</div>
													       	<input class="comment_writting" type="submit" value="댓글작성">
													   </form>
													</div>
		                                            <span class="comment_area_span">댓글작성</span>
												</div>
												<div class="comment-post comment_box" id="comment_53250844" c_idx="53250844">
													<!-- 댓글 내용 -->
													<div class="comment_recomment comment_wrap" id="comment_wrap${review.reviewNo }">
														<c:set var="replyCnt" value="0"/>
														<c:forEach var="reply" items="${replyList}">
															<c:if test="${reply.reviewNo==review.reviewNo }">
																<c:set var="replyCnt" value="${replyCnt + 1}"/>
																<div class="one_comment_wrap" data-static="true">
			                                            			<div class="recomment_right">
					                                                    <p class="recomment_txt">
					                                                        <span class="cmt_summary">${reply.content }</span> 
					                                                    </p>
					                                                </div>
					                                                
					                                                <!-- 댓글 작성 회원 프로필 -->
					                                                <div class="recomment_reply">
					                                                    <p class="recomment_profile">
					                                                        <span class="notCrawlText">${reply.memberId } | </span>
					                                                        <span class="recomment_date">${reply.regDate }</span>
					                                                    </p>
					                                                </div>
					                                                
					                                                <div class="">
					                                                    <div class="recomment_reply replies-info">
					                                                        <p class="add_recomment">
					                                                            <a href="javascript:void(0);" class="replies-toggle" onclick="showChildReply(this, ${reply.replyNo},${reply.reviewNo})">
					                                                                <span>댓글</span>
					                                                                <span class="reply-cnt" reply_cnt="0">${reply.childReplyCount }개</span>
					                                                                <span class="up" style="display: inline;">펼치기▼</span>
					                                                                <span class="down" style="display: none;">접기▲</span>
					                                                            </a>
					                                                        </p>
					                                                   		<div class="child_reply" hidden="true">
					                                                   		</div>
					                                                    </div>
					                                                </div>
					                                        	</div>
															</c:if>
														</c:forEach> 
													</div>
													<!-- //댓글 내용 -->
		
													<!--댓글 더보기버튼-->
													<c:if test="${replyCnt>=2 }">
			                                            <!--댓글 더보기버튼-->
			                                            <p class="box_btn_more commentMoreView">
			                                                <a href="javascript:void(0);" onclick="loadAllComments(${review.reviewNo })" class="comment_more_btn">댓글 더보기</a>
			                                            </p>
			                                            <p class="box_btn_little commentLittleView">
			                                                <a href="javascript:void(0);" onclick="loadLittleComments(${review.reviewNo })" class="comment_Little_btn" style="display: none;">댓글 접기</a>
			                                            </p>
			                                            <!--//댓글 더보기버튼-->
		                                            </c:if>
													<!--//댓글 더보기버튼-->
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
							<!-- //리뷰리스트 -->
							
							<!-- 페이지 만들기 -->
							<div class="reviewPageContainer">
								<div class="reviewPage"></div>
							</div>
						</div>
						<!-- //리뷰-->
					</div>
					<!-- //wrap -->
			</div>
		</div>

        <div id="rootBottom">
	        <!-- Q&A -->
            <section class="product-detail__sc-1e5oif5-0 fHnvbG">
                <div class="product-detail__sc-1e5oif5-1 GAnbV">
                    <h4 class="product-detail__sc-1e5oif5-2 jNPyxw">Q&amp;A 상품문의 (1,537)</h4>
                    <div class="product-detail__sc-kv50sg-0 jqdWzo">
                    	<select id="questionGoodsSimilarList" onchange="questionSelectSimilar(this.value)">
                    		<option value="" selected="selected">다른 컬러 문의보기</option>
                            <c:forEach var="item" items="${productList }">
                            	<option value="${item.productNo }">${item.name }</option>
                            </c:forEach>
                        </select>
                    </div>
                    <table class="product-detail__sc-ushjex-0 RTUsZ">
                        <colgroup>
                        </colgroup>
                        <thead>
                            <tr class="product-detail__sc-ushjex-1 iiGhCB">
                                <th scope="col" class="product-detail__sc-ushjex-2 cCPEPP">번호</th>
                                <th scope="col" class="product-detail__sc-ushjex-2 cCPEPP">답변여부</th>
                                <th scope="col" class="product-detail__sc-ushjex-2 cCPEPP">제목</th>
                                <th scope="col" class="product-detail__sc-ushjex-2 cCPEPP">작성자</th>
                                <th scope="col" class="product-detail__sc-ushjex-2 cCPEPP">등록일자</th>
                            </tr>
                        </thead>
                        <tbody id="noQuestionMessage" style="display: none;">
                        	<tr>
                        		<td colspan="6" style="text-align: center;">등록된 문의가 없습니다.</td>
                        	</tr>
                        </tbody>
						<c:forEach var="quest" items="${questionList }">
	                        <tbody class="question" itemid="${quest.productNo }">
								<tr class="product-detail__sc-1fucc5w-0 jtELsc">
									<td class="product-detail__sc-1fucc5w-2 ibrTta">${quest.questionNo }</td>
									<c:set var="answerFound" value="false" />
									<c:forEach var="answer" items="${answerList}">
										<c:if test="${answer.questionNo == quest.questionNo}">
											<c:set var="answerFound" value="true" />
										</c:if>
									</c:forEach>
									<c:choose>
										<c:when test="${answerFound}">  
											<td class="product-detail__sc-1fucc5w-2 ibrTta"><strong>답변완료</strong></td>
										</c:when>
										<c:otherwise>
											<td class="product-detail__sc-1fucc5w-2 ibrTta"><strong>답변예정</strong></td>
										</c:otherwise>
									</c:choose>
									<td class="product-detail__sc-1fucc5w-2 ibrTta">
										<button type="button" onclick="questionAndAnswerToggle(this)" data-question-no="${quest.questionNo}">${quest.title}</button>
									</td>
									<td class="product-detail__sc-1fucc5w-2 ibrTta">${quest.memberId }</td>
									<td class="product-detail__sc-1fucc5w-2 ibrTta"><strong>${quest.regDate }</strong></td>
								</tr>
								<tr class="question_and_answer_hidden" id="question_${quest.questionNo}" hidden="true">
									<td colspan="6" class="product-detail__sc-1fucc5w-2 ibrTta">
										<c:forEach var="product" items="${productList }">
											<c:if test="${product.productNo==quest.productNo }">
												<p class="quest_content1">${quest.content }</p>
											</c:if>
										</c:forEach>
									</td>
								</tr>
								
								
								
								<c:forEach var="answer" items="${answerList}">
									<c:if test="${answer.questionNo == quest.questionNo}"> 
											<tr class="question_and_answer_hidden" id="answer_${answer.questionNo}" hidden="true">
														<td class="product-detail__sc-1fucc5w-2 ibrTta1">${dto.brand }담당자</td>
											<td colspan="3" class="product-detail__sc-1fucc5w-2 ibrTta2">
												<p class="product-detail__sc-1fucc5w-3 fQkXJL">${answer.content }</p>
											</td>
											<td class="product-detail__sc-1fucc5w-2 ibrTta3"><strong>${answer.regDate }</strong></td>
											</tr>
									</c:if>
								</c:forEach>
	                        </tbody>
						</c:forEach>
                    </table>
                    
                    <!-- 페이지 만들기 -->
					<div class="QAPageContainer">
					    <div class="QAPage"></div>
					</div>
                    
                    <div class="product-detail__sc-14kn1gi-0 jzBbBe">
                        <p class="product-detail__sc-14kn1gi-1 QuuaX">타 쇼핑몰 언급, 거래 글, 분쟁 유발, 허위 사실 유포는 금지됩니다.</p>
                        <button class="product-detail__sc-14kn1gi-2 bTKrcG" onclick="openQuestionForm()">작성하기</button>
                    </div>
                </div>
            </section>
           	<!-- 상품정보 제공고시 -->
            <section class="product-detail__sc-99ltlm-0 bcUgsM">
                <table class="product-detail__sc-gzx3oy-0 hJSnPs">
                    <colgroup>
                        <col width="220px">
                        <col width="*">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col" colspan="2" class="my-custom-th" >상품정보 제공고시</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="row" class="product-material">제품 소재</th>
                            <td class="product-detail__sc-99ltlm-1 eYXAnX">${dto.material }</td>
                        </tr>
                        <tr>
                            <th scope="row" class="product-material">색상</th>
                            <td class="product-detail__sc-99ltlm-1 eYXAnX">
                            	<c:if test="${!empty dto.color1}">${dto.color1 } </c:if>
                            	<c:if test="${!empty dto.color2}">,${dto.color2 } </c:if>
                            	<c:if test="${!empty dto.color3}">,${dto.color3 } </c:if>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </section>
           	<!-- 반송지정보 -->
            <section class="product-detail__sc-4sk063-0 hhAoMa">
                <table class="product-detail__sc-gzx3oy-0 hJSnPs">
                    <colgroup>
                        <col width="220px">
                        <col width="*">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col" colspan="2" class="return-info" >반송지정보</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <th scope="row" class="exchange_address">교환 / 반품 주소</th>
                            <td class="noting">그런거 없습니다</td>
                        </tr>
                    </tbody>
                </table>
            </section>
            <!-- 교환 및 환불 규정 -->
            <section class="product-detail__sc-1ce0e6d-0 iXyRNl">
                <div class="product-detail__sc-1ce0e6d-1 cFXKlp">
                    <h3 class="product-detail__sc-1ce0e6d-2 cXAkoN">
                        <span>무신사의 모든제품</span>은 정품으로 안심하시고 구매하셔도 됩니다.
                    </h3>
                    <p class="product-detail__sc-1ce0e6d-3 hHVOuO">구매를 결정하시기 전 교환 및 환불 규정을 꼭 숙지하신 후 구매하시기 바랍니다.</p>
                </div>
                <table class="product-detail__sc-gzx3oy-0 hJSnPs">
                    <colgroup>
                        <col width="220px">
                        <col width="*">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col" colspan="2" class="delivery_related">배송관련</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="middleSize">
                            <th scope="row" class="delivery1">택배배송</th>
                            <td>
                                <ol class="infoList">
                                    <li>1. 무신사는 <strong>전 상품 무료배송(가구 등 일부 상품 제외)</strong>입니다.</li>
                                    <li>2. 브랜드 및 제품에 따라 입점 업체(브랜드) 배송과 무신사 자체 배송으로 나뉩니다.</li>
                                    <li>3. 결제확인 후 <strong>1~3일 정도 소요</strong>됩니다. (예약상품, 해외배송 상품은 배송기간이 다를 수 있습니다.) </li>
                                </ol>
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table class="product-detail__sc-gzx3oy-0 hJSnPs">
                    <colgroup>
                        <col width="220px">
                        <col width="*">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col" colspan="2" class="payment_related">결제관련<span>각 상품은 현금, 카드, 무신사 적립금, 쿠폰으로 결제가 가능합니다.</span></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="middleSize">
                            <th scope="row" class="payment_1">카드결제</th>
                            <td class="payment_2"><strong>전체 카드사 사용가능</strong> (일부 카드사 무이자 할부)</td>
                        </tr>
                        <tr class="middleSize">
                            <th scope="row" class="payment_1">가상계좌(무통장 입금)</th>
                            <td class="payment_2">주문 시마다 새로운 계좌번호를 발급하는 방식으로 해당 계좌에 입금 즉시 입금확인이 되는 방식 입니다. <br>
                                단, 1원 단위까지 정확히 입금하셔야만 입금이 정상적으로 처리됩니다.</td>
                        </tr>
                        <tr class="middleSize">
                            <th scope="row" class="payment_1">적립금(선결제)</th>
                            <td class="payment_2">적립금은 결제 시 상품 금액의 최대 7%까지 사용 가능합니다.<br>
                                <strong>적립 예정금액을 미리 사용(선결제)하여 할인</strong>받으실 수 있습니다. (일부 상품 제외)</td>
                        </tr>
                    </tbody>
                </table>
                <table class="product-detail__sc-gzx3oy-0 hJSnPs">
                    <colgroup>
                        <col width="220px">
                        <col width="*">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col" colspan="2" class="exchange_refund">교환/환불</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="middleSize">
                            <th scope="row" colspan="2" class="delivery2">택배배송</th>
                        </tr>
                        <tr class="isBackground">
                            <th scope="row" class="delivery_company">자동회수 택배사</th>
                            <td class="delivery_company2">CJ대한통운</td>
                        </tr>
                        <tr class="isBackground">
                            <th scope="row"  class="delivery_company">배송비</th>
                            <td class="delivery_company2">왕복 6,000원(지역별 추가배송비(편도): 제주 3,000원 / 제주 외 도서산간 3,000원)<br> 
                                교환/환불 요청 상품의 수량에 따라서 상이, 구매자 책임 사유일 경우에만 발생</td>
                        </tr>
                        <tr class="isBackground">
                            <th scope="row"  class="delivery_company">보내실 곳</th>
                            <td class="delivery_company2">04702 서울 성동구 청계천로 458 (동원빌딩) 3층<br>
                                <a class="returnButton" href="https://www.musinsa.com/order-service/mypage/order_list_opt">교환 / 환불 접수하기</a></td>
                        </tr>
                        <tr class="isBackground">
                            <th scope="row"  class="delivery_company3">교환/환불 시<br>주의 사항</th>
                            <td class="delivery_company2">
                                <ul class="dotList">
                                    <li>상품 수령 후 7일 이내 교환/환불을 요청해야 합니다.</li>
                                    <li>동일 업체일 경우라도 상품별로 반품비용이 상이하게 발생할 수 있습니다.</li>
                                    <li>교환/환불 시 반품비용은 선결제함으로 동봉하지 마시고, 동봉하여 발송하신 경우 확인 후 반품비 환불 처리됩니다.</li>
                                    <li>고객님의 사유로 교환 진행 중인 상품이 품절될 경우, 반품비가 발생될 수 있으며 이를 제외한 결제금액이 환불 처리됩니다.</li>
                                    <li>자동회수 접수 시 영업일 기준 2~3일 내에 택배기사님 연락 후 방문하여 회수 진행됩니다.</li>
                                    <li>자동회수 미지원 업체 및 직접발송의 경우 수령하신 택배사로 착불(신용)로 반품 접수하여 발송 부탁드리겠습니다.</li>
                                    <li>수령하신 택배사가 아닌 다른 택배사로 발송하시는 경우(신규 택배 접수 포함) 추가 비용이 발생 할 수 있습니다.</li>
                                    <li>반품 주소지는 브랜드(업체)마다 다르므로 확인 후 각각 보내셔야 합니다.</li>
                                    <li>상품의 내용이 표시, 광고 내용과 다르거나 계약 내용이 다를 경우 상품을 공급받은 날부터 3개월 이내, 
                                        그 사실을 안 날 또는 알 수 있었던 날부터 30일 내 청약 철회를 할 수 있습니다.</li>
                                    <li>상품을 반환받은 날로부터 영업일 기준 3일 내 지급받은 대금을 환급합니다.</li>
                                    <li>미성년자가 체결한 계약은 법정대리인이 동의하지 않는 경우 본인 또는 법정대리인이 취소할 수 있습니다.</li>
                                    <li>도서산간 지역의 경우 결제하신 기본 교환/환불 배송비 외에 편도 기준 최대 8천원(왕복 기준 최대 16천원)까지 추가 비용이 
                                        발생할 수 있습니다. 택배사, 판매업체, 지역별로 도서산간 발생 금액이 상이해 구매 시점에서는 정확한 금액 안내가 어렵습니다.</li>
                                </ul>
                            </td>
                        </tr>
                        <tr class="isBackground">
                            <th scope="row"  class="delivery_company4">교환/환불이<br>불가능한 경우</th>
                            <td class="delivery_company2">
                                <ul class="dotList">
                                    <li>반품 요청 기간(수령 후 7일 이내)이 경과한 경우</li>
                                    <li>상품을 사용(또는 착용, 착화) 혹은 훼손하여 재판매가 어려울 정도로 상품가치가 현저히 감소한 경우</li>
                                    <li>상품의 택(Tag) 또는 라벨 제거, 분리, 분실, 훼손하거나<br>세트 구성품을 누락한 경우</li>
                                    <li>신발 브랜드 박스를 분실하거나 훼손(오염, 테이핑 등)한 경우<br>(상품 확인 목적으로 단순 개봉한 경우는 제외)</li>
                                    <li>상품을 설치/장착하거나 전원을 연결한 경우(테크, 가전 제품 등)</li>
                                    <li>고객의 주문에 따라 개별적으로 생산된 상품인 경우(맞춤 주문 제작 상품 등)</li>
                                </ul>
                                <img class="packingImg" src="" alt="예시 이미지">
                            </td>
                        </tr>
                    </tbody>
                </table>
                <table class="product-detail__sc-gzx3oy-0 hJSnPs">
                    <colgroup>
                        <col width="220px">
                        <col width="*">
                    </colgroup>
                    <thead>
                        <tr>
                            <th scope="col" colspan="2" class="customer_center2">고객센터</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr class="bigSize">
                            <th scope="row" class="center_number">1544-7199</th>
                            <td class="product_inquiry">상품 문의 &gt; 각 상품 Q&amp;A 이용 평일 09:00~18:00 / 토,일,공휴일 휴무</td>
                        </tr>
                    </tbody>
                </table>
            </section>
		</div>
    </div> <!--//wrap-->
</body>
<script type="text/javascript">
	/* 원그래프 */
	var pieChart = document.querySelectorAll('.pie-chart-canvas');
	pieChart.forEach(function(canvas) {
	    canvas.width = 500;
	    canvas.height = 500;
	    
	    let ctx = canvas.getContext('2d');

	    // 각 캔버스에 대한 독립적인 데이터 복사본 생성
	    const genderRatioData = {
		    '남성': 0,
		    '여성': 0
		};
	    
		const colors = {
		    '남성': '#161b46',
		    '여성': '#ff5d6c'
		};

	    if (canvas.id == "purchase-pie-chart") {
	    	genderRatioData['남성'] = ${oneYearSalesTotalMale};
	    	genderRatioData['여성'] = ${oneYearSalesTotalFemale};
	    } else if (canvas.id == "view-pie-chart") {
	    	genderRatioData['남성'] = ${genderViewList[0]};
	    	genderRatioData['여성'] = ${genderViewList[1]};
	    }
	    
	    drawPieChart(genderRatioData, colors, ctx);
	    drawLegend(genderRatioData, colors, canvas.parentElement); // canvas.parentElement 또는 적절한 요소를 대상으로 설정
	});
	
	function drawPieChart(data, colors, ctx) {
	    const total = Object.values(data).reduce((sum, value) => sum + value, 0);
	    let startAngle = -0.5 * Math.PI; // 12시 방향에서 시작

	    for (const [key, value] of Object.entries(data)) {
	        const sliceAngle = (value / total) * 2 * Math.PI;
	        ctx.beginPath();
            ctx.arc(250, 250, 100, startAngle, startAngle + sliceAngle, false); // 외부 반지름
            ctx.arc(250, 250, 50, startAngle + sliceAngle, startAngle, true); // 내부 반지름
            ctx.closePath();
	        ctx.fillStyle = colors[key];
	        ctx.fill();
	        startAngle += sliceAngle;
	    }
        // 도넛 차트 중앙에 전체 합계 출력
        ctx.fillStyle = '#000'; // 텍스트 색상 설정
        ctx.font = '20px Arial'; // 폰트 스타일 설정
        ctx.textAlign = 'center'; // 텍스트 가운데 정렬
        ctx.fillText(total+'개', 250, 250); // 중앙에 텍스트 출력
	}
	
	function drawLegend(data, colors, targetElement) {
	    const legendContainer = document.createElement('div');
	
	    for (const [key, color] of Object.entries(colors)) {
	        const legendItem = document.createElement('div');
	        legendItem.style.display = 'flex';
	        legendItem.style.alignItems = 'center';
	        legendItem.style.marginTop = '5px';
	
	        const colorBox = document.createElement('div');
	        colorBox.style.width = '20px';
	        colorBox.style.height = '20px';
	        colorBox.style.backgroundColor = color;
	        colorBox.style.marginRight = '10px';
	
	        const labelText = document.createTextNode(key +":"+data[key]);
	
	        legendItem.appendChild(colorBox);
	        legendItem.appendChild(labelText);
	        legendContainer.appendChild(legendItem);
	        
	        targetElement.appendChild(legendContainer); // 범례를 DOM에 추가
	    }
	}
	/* 원그래프 끝 */
	
	/* 막대그래프 */
	var purchaseRawData = ${agePurchaseList};
	var purchaseTotal = purchaseRawData.reduce(function (accumulator, currentValue) {
	    return accumulator + currentValue;
	}, 0);
	var purchasePercentageData = purchaseRawData.map(function (value) {
	    return (value / purchaseTotal * 100).toFixed(2); // 각 데이터를 비율로 변환 후 소수점 둘째자리까지
	});
	
	var viewRawData = ${ageViewList};
	var viewTotal = viewRawData.reduce(function (accumulator, currentValue) {
	    return accumulator + currentValue;
	}, 0);
	var viewPercentageData = viewRawData.map(function (value) {
	    return (value / viewTotal * 100).toFixed(2); // 대소문자 오류 수정
	});	
	
	var barChart = document.querySelectorAll('.bar-chart-canvas');
	barChart.forEach(function(canvas) {
	    let ctx = canvas.getContext('2d');

	    // 데이터와 라벨을 조건에 따라 설정
	    let data, label;
	    if (canvas.id == "purchase-bar-chart-canvas") {
	        label = '판매 비율(%)';
	        data = purchasePercentageData;
	    } else if (canvas.id == "view-bar-chart-canvas") {
	        label = '조회 비율(%)';
	        data = viewPercentageData;
	    }

	    // 차트 생성
	    var chart = new Chart(ctx, {
	        type: 'bar',
	        data: {
	            labels: ['~18세', '19~23세', '24~28세', '29~33세', '34~39세', '40세~'],
	            datasets: [{
	                label: label,
	                data: data,
	                backgroundColor: '#0000FF',
	                borderColor: '#0000FF'
	            }]
	        },
	        // 나머지 옵션은 변경 없음
	        options: {
	            scales: {
	                yAxes: [{
	                    ticks: {
	                        min: 0,
	                        max: 100,
	                        beginAtZero: true,
	                        callback: function(value) {
	                            return value + "%";
	                        }
	                    }
	                }]
	            },
	            tooltips: {
	                callbacks: {
	                    label: function(tooltipItem, data) {
	                        var label = data.datasets[tooltipItem.datasetIndex].label || '';
	                        if (label) {
	                            label += ': ';
	                        }
	                        label += parseFloat(tooltipItem.yLabel).toFixed(2) + '%'; // 퍼센트 값의 소수점 조정
	                        return label;
	                    }
	                }
	            },
	            legend: {
	                display: false
	            }
	        }
	    });
	});
	
	// 좋아요 빈 하트 or 빨간 하트
	const likeButton = document.getElementById('likeButton');
    const likeHeart = document.getElementById('like-heart');
	
	window.onload=function(){
		checkLikeStatus(pageProductNo);
	    fillMySizeInfo();
	    reviewSelectSimilar(pageProductNo);
	    questionSelectSimilar(pageProductNo);
	};
	
	function checkLikeStatus(likeCheckProductNo) {
        // 전송할 데이터 객체
        let dataToSend = {
            productNo: likeCheckProductNo
        };
        if(userId!=null && userId!=''){
        	$.ajax({
    			url: "/finalpro/mypage/likeCheck.do",
    			method: 'POST',
    			contentType: 'application/json',
    			data: JSON.stringify(dataToSend), // 객체를 JSON 문자열로 변환
    			success: function(data) {
    				if (data.liked) {
    					likeHeart.setAttribute('fill', 'red');
    				} else {
    					likeHeart.setAttribute('fill', 'none');
    				}
    			},
    			error: function(error) {
    				console.error('Error:', error);
    			}
    		});
        }else{
        	likeHeart.setAttribute('fill', 'none');
        }
    }
	
	// 좋아요 버튼 클릭
	likeButton.addEventListener('click', function () {
        if(userId!=null && userId!=''){
			likeButtonClick();
        }else{
        	alert('로그인해주세요');
			location.href='/finalpro/member/loginForm.do';
        }
	});
	
	function likeButtonClick() {
		if(likeHeart.getAttribute('fill')=="none"){
	    	addLike(pageProductNo);
    	}else if(likeHeart.getAttribute('fill')=="red"){
    		deleteLike(pageProductNo);
    	}
	}
	
	function addLike(emptyHeartProductNo) {
        // 전송할 데이터 객체
        let dataToSend = {
            productNo: emptyHeartProductNo
        };

        $.ajax({
            url: "/finalpro/mypage/addLike.do",
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(dataToSend), // 객체를 JSON 문자열로 변환
            success: function(data) {
                if (data.success) {
                	checkLikeStatus(emptyHeartProductNo);
                } else {
                	if(data.logined=="none"){
                		console.log("아이디 없음");
                		alert("로그인 해주세요");
                	}
                	console.log("좋아요 추가 실패");
                }
            },
            error: function(error) {
                console.error('Error:', error);
            }
        });
    }
	
	function deleteLike(filledHeartProductNo) {
        // 전송할 데이터 객체
        let dataToSend = {
        	productNo: filledHeartProductNo
        };

        $.ajax({
        	url: "/finalpro/mypage/deleteLike.do",
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(dataToSend), // 객체를 JSON 문자열로 변환
            success: function(data) {
                if (data.success) {
                	checkLikeStatus(filledHeartProductNo);
                }else {
                	if(data.logined=="none"){
                		console.log("아이디 없음");
                		alert("로그인 해주세요");
                	}
                	console.log("좋아요 삭제 실패");
                }
            },
            error: function(error) {
                console.error('Error:', error);
            }
        });
    }
	
	function addbasket() {
	    let basketProductList = [];

	    // sessionStorage에서 'selectedProduct'로 시작하는 모든 아이템을 찾아 basketProductList에 추가
	    for (let i = 0; i < sessionStorage.length; i++) {
	        let key = sessionStorage.key(i);
	        if (key.startsWith('selectedProduct')) {
	            let value = sessionStorage.getItem(key);
	            if (value) {
	            	console.log("value : "+value);
	                basketProductList.push(value);
	            }
	        }
	    }

	    // 아이템이 없는 경우 사용자에게 알림
	    if (basketProductList.length === 0) {
	        alert('상품을 담고 눌러주세요.');
	        return;
	    }
	    // 각 아이템에 대해 장바구니에 추가 요청을 서버로 전송
	    basketProductList.forEach((productStr, index) => {
	        $.ajax({
	            url: "/finalpro/mypage/addbasket.do",
	            method: 'POST',
	            contentType: 'application/json',
	            data: productStr, // 객체를 JSON 문자열로 변환
	            success: function(data) {
	                if (data.result == "success") {
	                    alert("장바구니 추가 완료");
	                    console.log("vv : " +value);
	                } else if (data.result == "already") {
	                    alert("이미 추가된 상품입니다.");
	                } else {
	                    console.log("장바구니 추가 실패");
	                }
	            },
	            error: function(error) {
	                console.error('Error:', error);
	            }
	        });
	    });
	}
	
	// 장바구니 버튼
	const basketButton = document.getElementById('basketButton');
	
	// 장바구니 버튼 클릭
	basketButton.addEventListener('click', function () {
		if(userId!=null && userId!=''){
			addbasket();
        }else{
        	alert('로그인해주세요');
			location.href='/finalpro/member/loginForm.do';
        }
	});
</script>