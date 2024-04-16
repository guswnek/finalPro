<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var = "contextPath" value="${pageContext.request.contextPath}" />

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script>
	function getStar(target) {
		document.querySelector(`.star span`).style.width = target.value * 10 + "%"; 
	}
	
	function reviewSubmit(obj){
		var sizeChecked = document.querySelector('input[name="sizeAssessment"]:checked');
		var brightCheked = document.querySelector('input[name="brightAssessment"]:checked');
		var colorChecked = document.querySelector('input[name="colorAssessment"]:checked');
		var thickChecked = document.querySelector('input[name="thickAssessment"]:checked');
		var deliveryChecked = document.querySelector('input[name="deliveryAssessment"]:checked');
		var packChecked = document.querySelector('input[name="packAssessment"]:checked');
		var ContentChecked = document.getElementById('reveiwContent').value;
		
		if(!sizeChecked) {
			alert('사이즈 선택해주세요.');
			return;
		}else if(!brightCheked) {
			alert('밝기 선택해주세요.');
			return;
		}else if(!colorChecked){
			alert('색감 선택해주세요.');
			return;
		}else if(!thickChecked){
			alert('두께감 선택해주세요.');
			return;
		}else if(!deliveryChecked){
			alert('배송 선택해주세요.');
			return;
		}else if(!packChecked){
			alert('포장 선택해주세요.');
			return;
		}
		
		console.log(ContentChecked);
		if (ContentChecked.length < 10) {
			alert('10글자 이상 입력해주세요.');
			reviewContent.focus();
			return;
		}
		
		obj.action = "${contextPath}/product/modifyReview.do";
		obj.submit();

	}
	
	function readURL(input) {
		if(input.files && input.files[0]){
			let reader = new FileReader();
			reader.onload = function(e) {
				$('#preview').attr('src', e.target.result);
			}
			reader.readAsDataURL(input.files[0]);
		}
	}
	
	document.addEventListener('DOMContentLoaded', function() {
		var radioButtons = document.querySelectorAll('input[type="radio"]');

	    radioButtons.forEach(radioButton => {
	        radioButton.addEventListener('click', function() {
	        	var labels = document.querySelectorAll('label[name="' + this.name + '"]');
	            labels.forEach(label => {
	                label.classList.remove('active');
	            });

	            // 클릭된 라디오 버튼에 해당하는 라벨 요소에 .active 클래스를 추가합니다.
	            const label = this.nextElementSibling;
	            label.classList.add('active');
	        });
	    });
		
	});
	
	 document.addEventListener("DOMContentLoaded", function() {
	        var reviewSizeAssessment = "${review.sizeAssessment}";
	        var reviewBrightAssessment = "${review.brightAssessment}";
	        var reviewColorAssessment = "${review.colorAssessment}";
	        var reviewThickAssessment = "${review.thickAssessment}";
	        var reviewDeliveryAssessment = "${review.deliveryAssessment}";
	        var reviewPackAssessment = "${review.packAssessment}";
	        var reviewGender = "${review.gender}"

	        // review 객체의 값에 따라 라디오 버튼과 해당하는 라벨에 active 클래스를 추가합니다.
	        addActiveClass(reviewSizeAssessment, "size");
	        addActiveClass(reviewBrightAssessment, "bright");
	        addActiveClass(reviewColorAssessment, "color");
	        addActiveClass(reviewThickAssessment, "thick");
	        addActiveClass(reviewDeliveryAssessment, "delivery");
	        addActiveClass(reviewPackAssessment, "pack");
	        addActiveClass(reviewGender, "gender");

	        function addActiveClass(value, prefix) {
	            var radio = document.getElementById(prefix + value);
	            if (radio) {
	                radio.checked = true;
	                var label = document.querySelector('label[for="' + prefix + value + '"]');
	                if (label) {
	                    label.classList.add("active");
	                }
	            }
	        }
	    });
	
	
</script>

<style>

		.star {
		    position: relative;
		    font-size: 2rem;
		    color: #ddd;
	  	}
	  
		.star input {
		    width: 100%;
		    height: 100%;
		    position: absolute;
		    left: 0;
		    opacity: 0%;
		    cursor: pointer;
		}
	  
	  	.star span {
		    width: 0;
		    position: absolute; 
		    left: 0;
		    color: red;
		    overflow: hidden;
		    pointer-events: none;
	    }
  
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            font-size: 15px;
        }
        
        hr {
        	width: 600px;
        	margin: 0 auto;
        }

        .container {
            max-width: 800px;
            margin: 0 auto;
            padding: 20px;
            text-align: center; /* 모든 내용을 가운데 정렬 */
        }
        
        .title {
            margin: 35px 0;
            text-align: center;
        }

        .productInfo {
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 20px 160px 20px 0;
            font-size: 15px;
            font-weight: 600;
        }

        .productInfo img {
            margin-right: 20px;
        }

        form table {
            width: 100%;
            margin-bottom: 20px;
            text-align: left; /* 테이블 내용을 왼쪽 정렬 */
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        form table th {
        	width: 100px;
        }

        form table tr td {
            padding: 10px 0;
        }

        form table tr td label {
            margin-right: 10px;
        }
        
        input[type=radio] {
        	display : none;
        }
        
        .left {
        	border: 1px solid gray;
        	border-right: none;
        	border-radius: 15px 0 0 15px;
        	padding: 10px 20px;
        	margin: 0;
        	font-size: 14px;
        	display: inline-block;
        	width: 70px;
        	color: gray;
        }
        
        .mid {
        	border: 1px solid gray;
        	padding: 10px;
        	margin: 0 0px 0 -5px;
        	font-size: 14px;
        	display: inline-block;
        	width: 90px;
        	text-align: center;
        	color: gray;
        }
        
        .right1 {
        	border: 1px solid gray;
        	border-left: none;
        	border-radius:  0 15px 15px 0;
        	padding: 10px 20px;
        	margin: 0 0px 0 -5px;
        	font-size: 14px;
        	display: inline-block;
        	width: 70px;
        	text-align: center;
        	color: gray;
        }
        
        .right2 {
        	border: 1px solid gray;
        	border-radius:  0 15px 15px 0;
        	padding: 10px 20px;
        	margin: 0 0px 0 -5px;
        	font-size: 14px;
        	display: inline-block;
        	width: 70px;
        	text-align: center;
        	color: gray;
        }
        
        .left:hover, .mid:hover, .right1:hover, .right2:hover {
        	background-color: gray;
        	color: white;
        }
        
        .left.active, .mid.active, .right1.active, .right2.active{
        	background-color: gray;
        	color: white;
        }
        
        .table1 {
        	margin: 20px 0 20px -57px;
        }
        
        input[type=text] {
        	padding: 9px;
        	border-radius: 12px;
        	border: 1px solid gray;
        	color: gray;
        }
        
        .contentTitle {
        	font-weight: 600;
        	text-align: center;
        	margin: 20px 0 10px -410px;
        }
        
        .textArea {
        	display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 0 30px 15px;
        }
        
        .file {
        	display: flex;
            align-items: center;
            justify-content: center;
            margin: 30px 0 30px 15px;
        }
        
        input[type=button] {
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
        
        a {
        	text-decoration: none;
        	color : black;
        }
    </style>
    
<body>
	
	<h2 class = "title">리뷰 수정</h2>
	<hr>
	<div class = "productInfo">
		<a href = "${contextPath }/product/detailProduct.do?productNo=${review.productNo}">
			<img width = "100px" height = "130px" src = "${contextPath }/download.do?imageFileName=1.jpg&productNo=${review.productNo}&path=product">
		<div>
			<p><a href = "${contextPath }/brand/brandList.do?brand=${review.brand}">[ ${review.brand } ]</a></p>
			<p><a href = "${contextPath }/product/detailProduct.do?productNo=${review.productNo}">${review.name }</a></p>
		</div>
		</a>
	</div>
	<hr>
	
	<form method = "post" action = "${contextPath}/product/insertReview.do" enctype="multipart/form-data">
		<table>
			<tr>
				<th>별점</th>
				<td>
					<span class="star">
					  ★★★★★
					  <span>★★★★★</span>
					  <input type="range" onclick="getStar(this)" step="2" min="0" max="10" name = "starScore">
					</span>
				</td>
			</tr>
			<tr>
				<th>사이즈</th>
				<td>
					<input type = "radio" id = "size1" <c:if test="${review.sizeAssessment == 1}">checked="checked"</c:if>name = "sizeAssessment" value = "1">
					<label class = "left" for = "size1" name = "sizeAssessment">커요</label>
					<input type = "radio" id = "size2" <c:if test="${review.sizeAssessment == 2}">checked="checked"</c:if>name = "sizeAssessment" value = "2">
					<label class = "mid" for = "size2" name = "sizeAssessment">보통이에요</label>
					<input type = "radio" id = "size3" <c:if test="${review.sizeAssessment == 3}">checked="checked"</c:if>name = "sizeAssessment" value = "3">
					<label class = "right1" for = "size3" name = "sizeAssessment">작아요</label>
				</td>
			</tr>
			<tr>
				<th>밝기</th>
				<td>
					<input type = "radio" id = "bright1" <c:if test="${review.brightAssessment == 1}">checked="checked"</c:if>name = "brightAssessment" value = "1">
					<label class = "left" for = "bright1" name = "brightAssessment">밝아요</label>
					<input type = "radio" id = "bright2" <c:if test="${review.brightAssessment == 2}">checked="checked"</c:if>name = "brightAssessment" value = "2">
					<label class = "mid" for = "bright2" name = "brightAssessment">보통이에요</label>
					<input type = "radio" id = "bright3" <c:if test="${review.brightAssessment == 3}">checked="checked"</c:if>name = "brightAssessment" value = "3">
					<label class = "right1" for = "bright3" name = "brightAssessment">어두워요</label>
				</td>
			</tr>
			<tr>
				<th>색감</th>
				<td>
					<input type = "radio" id = "color1" <c:if test="${review.colorAssessment == 1}">checked="checked"</c:if>name = "colorAssessment" value = "1">
					<label class = "left" for = "color1" name = "colorAssessment">선명해요</label>
					<input type = "radio" id = "color2" <c:if test="${review.colorAssessment == 2}">checked="checked"</c:if>name = "colorAssessment" value = "2">
					<label class = "mid" for = "color2" name = "colorAssessment">보통이에요</label>
					<input type = "radio" id = "color3" <c:if test="${review.colorAssessment == 3}">checked="checked"</c:if> name = "colorAssessment" value = "3">
					<label class = "right1" for = "color3" name = "colorAssessment">흐려요</label>
				</td>
			</tr>
			<tr>
				<th>두께감</th>
				<td>
					<input type = "radio" id = "thick1" <c:if test="${review.thickAssessment == 1}">checked="checked"</c:if>name = "thickAssessment" value = "1">
					<label class = "left" for = "thick1" name = "thickAssessment">두꺼워요</label>
					<input type = "radio" id = "thick2" <c:if test="${review.thickAssessment == 2}">checked="checked"</c:if>name = "thickAssessment" value = "2">
					<label class = "mid" for = "thick2" name = "thickAssessment">보통이에요</label>
					<input type = "radio" id = "thick3" <c:if test="${review.thickAssessment == 3}">checked="checked"</c:if>name = "thickAssessment" value = "3">
					<label class = "right1" for = "thick3" name = "thickAssessment">얇아요</label>
				</td>
			</tr>
			<tr>
				<th>배송</th>
				<td>
					<input type = "radio" id = "delivery1" <c:if test="${review.deliveryAssessment == 1}">checked="checked"</c:if>name = "deliveryAssessment" value = "1">
					<label class = "left" for = "delivery1" name = "deliveryAssessment">빨라요</label>
					<input type = "radio" id = "delivery2" <c:if test="${review.deliveryAssessment == 2}">checked="checked"</c:if>name = "deliveryAssessment" value = "2">
					<label class = "right2" for = "delivery2" name = "deliveryAssessment">아쉬워요</label>
				</td>
			</tr>
			<tr>
				<th>포장</th>
				<td>
					<input type = "radio" id = "pack1" <c:if test="${review.packAssessment == 1}">checked="checked"</c:if>name = "packAssessment" value = "1">
					<label class = "left" for = "pack1" name = "packAssessment">꼼꼼해요</label>
					<input type = "radio" id = "pack2" <c:if test="${review.packAssessment == 2}">checked="checked"</c:if>name = "packAssessment" value = "2">
					<label class = "right2" for = "pack2" name = "packAssessment">아쉬워요</label>
				</td>
			</tr>
		</table>
		
		<hr>
		
		<table class = "table1">
			<tr>
				<th>성별</th>
				<td>
					<input type = "radio" id = "gender남성" name = "gender" <c:if test="${review.gender eq '남성'}">checked="checked"</c:if> value = "남성">
					<label class = "left" for = "gender남성" name = "gender">남성</label>
					<input type = "radio" id = "gender여성" name = "gender" <c:if test="${review.gender eq '여성'}">checked="checked"</c:if> value = "여성">
					<label class = "right2" for = "gender여성" name = "gender">여성</label>
				</td>
			</tr>
			<tr>
				<th>키</th>
				<td>
					<div>
						<input type = "text" id = "height" value = "${review.height }" placeholder="cm">
					</div>
				</td>
			</tr>
			<tr>
				<th>몸무게</th>
				<td>
					<div>
						<input type = "text" id = "weight" value ="${review.weight }" placeholder="kg">
					</div>
				</td>
			</tr>
		</table>
		
		<hr>
		
		<p class = "contentTitle">내용</p>
		<div class = "textArea">
			<textarea id = "reveiwContent" rows="10" cols="65" name = "content">${review.content }</textarea>
		</div>
		
		<hr>
		
		<div class = "file">
			<input type = "file" name = "imageFileName" onchange="readURL(this)"><br>
			<img id = "preview" src="${contextPath }/download.do?imageFileName=${review.imageFileName}&productNo=${review.reviewNo}&path=review" width = "150" height = "180">
		</div>
		
		<input type = "hidden" name = "productNo" value = "${review.productNo }">
		<input type = "hidden" name = "productSize" value = "${review.productSize }">
		<input type = "hidden" name = "orderNo" value = "${review.orderNo }">
		<input type = "hidden" name = "reviewNo" value = "${review.reviewNo }">
		
		<hr>
		
		<input type = "button" onclick="reviewSubmit(this.form)" value = "리뷰 수정">
	</form>
</body>