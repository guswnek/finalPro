<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
%>    
<c:set var = "contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/finalpro/resources/css/questionForm.css">
<style type="text/css">
.n-qa-write-pop {
  padding: 0 20px 50px;
  width: 572px;
  box-sizing: border-box;
}
.n-qa-write-pop header {
  padding: 20px 0;
}
.n-qa-write-pop .qa-product {
  position: relative;
  padding: 5px 0 20px 90px;
  min-height: 96px;
  margin-bottom: 10px;
  border-bottom: 1px solid #f5f5f5;
}
.n-qa-write-pop .qa-product .qa-product-img {
  overflow: hidden;
  position: absolute;
  left: 0;
  top: 0;
  width: 80px;
  height: 96px;
  background-color: #f5f5f5;
}
.n-qa-write-pop .qa-product .qa-product-img img {
  position: absolute;
  left: 0;
  top: 50%;
  max-width: 100%;
  transform: translateY(-50%);
}
.n-qa-write-pop .qa-write-table th {
  text-align: left;
  padding: 10px 0;
  width: 110px;
  font-size: 14px;
}
.n-qa-write-pop .qa-write-table td {
  text-align: left;
  padding: 10px 0 10px 12px;
}
.n-qa-write-pop .qa-write-table td .n-input {
  width: 50%;
}
.n-qa-write-pop .qa-write-table td.qa-title-area .n-input {
  width: 288px;
  box-sizing: border-box;
}
.n-qa-write-pop .qa-write-table td.qa-subject-area textarea {
  padding: 10px;
  width: 100%;
  margin-bottom: 10px;
  border: 1px solid #e5e5e5;
  resize: none;
  font-size: 14px;
  line-height: 21px;
  box-sizing: border-box;
}
.n-qa-write-pop .qa-comment li {
  position: relative;
  padding-left: 10px;
  color: #777;
  font-size: 14px;
  line-height: 21px;
  font-weight: lighter;
}
.n-qa-write-pop .qa-comment li strong {
  color: #000;
}
/* 하단 버튼 */
.qa-btn-area{
  text-align: center;
}

.n-btn {
  display: inline-block;
  min-width: 100px;
  height: 40px;
  line-height: 36px;
  color: #ffffff;
  box-sizing: border-box;
  padding: 2px 8px 0 8px;
  font-size: 14px;
  text-align: center;
  cursor: pointer;
  vertical-align: middle;
  -webkit-transition: border 0.2s, background 0.2s ease-in-out;
  -moz-transition: border 0.2s, background 0.2s ease-in-out;
  -o-transition: border 0.2s, background 0.2s ease-in-out;
  transition: border 0.2s, background 0.2s ease-in-out;
}
#btn-accent {
  border: 1px solid #000000;
  background-color: #000000;
}
#btn-accent:hover:not(.disabled) {
  border-color: #0078ff;
  background-color: #0078ff;
}
#btn-lighter {
  border: 1px solid #f1f1f1;
  background-color: #f1f1f1;
  color: #000000;
}
#btn-lighter:hover {
  border-color: #d8d8d8;
  background-color: #d8d8d8;
}
</style>
<script type="text/javascript">
	function questionSubmit(){
		var selectElement = document.getElementById("option");
		var subjectInput  = document.querySelector('input[name="title"]');
		var questionTextarea  = document.getElementById('question');
		console.log("성공");
		
	    // 선택된 옵션 가져오기
	    var selectedOption = selectElement.value;
	    
	    // 선택된 옵션이 비어 있는지 확인
	    if (selectedOption === "") {
	        // 선택되지 않았을 경우 알림 표시
			alert('사이즈 선택해주세요.');
			selectElement.focus();
	        return; // 선택되지 않았음을 반환
	    }
		
		if (subjectInput.value.trim() =='') {
			alert('제목을 입력하세요.');
			subjectInput.focus();
			return;
		}else if (questionTextarea.value.trim().length <20) {
			alert('20글자 이상 입력해주세요.');
			questionTextarea.focus();
			return;
		}
		
		var questionForm  = document.getElementById('qa_write_form');
		console.log(questionForm);
		questionForm.action = "/finalpro/mypage/insertQuestion.do";
		questionForm.submit();
	
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
</script>
</head>
<body>
	<section class="n-qa-write-pop">
		<header>
			<h2>상품문의</h2>
		</header>
		<form name="qa_write_form" id="qa_write_form" action="/finalpro/mypage/insertQuestion.do" method="post" enctype="multipart/form-data">
			<div class="qa-product">
				<div class="qa-product-img">
					<img src="${contextPath}/download.do?imageFileName=1.jpg&productNo=${questionProduct.productNo}&path=" alt="${questionProduct.name }">
				</div>
				<div class="qa-product-info">
					<p class="qa-info-brand">${questionProduct.brand }</p>
					<p class="qa-info-name">${questionProduct.name } / ${questionProduct.productNo }</p>
					<p class="box_price">${questionProduct.price }<span class="txt_unit_price">원</span></p>
				</div>
			</div>
			<table class="qa-write-table">
				<tbody>
					<tr>
						<th>문의옵션</th>
						<td class="qa-type-area">
							<div>
								<select name="productSize" id="option" class="tit n-input">
									<option value="">옵션 선택</option>
									<c:forEach var="size" items="${sizeList }">
										<option value="${size.productSize }">${size.productSize }</option>
									</c:forEach>
								</select>
							</div>
						</td>
					</tr>

					<tr>
						<th>제목</th>
						<td class="qa-title-area">
							<input type="text" name="title" class="tit n-input" maxlength="15" placeholder="15자 이내 입력" value="">
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td class="qa-subject-area">
							<textarea name="content" id="question" class="" rows="10" cols="45" placeholder="내용 입력"></textarea>
							<input type="file" name="imageFileName" onchange="readURL(this);" style="display: none;"><br>
							<img id="preview" src="#" width="200" height="200" style="display: none;">
						</td>
					</tr>
					<tr>
						<td colspan="2" class="comment-td">
							<ul class="qa-comment">
								<li>파일명에 한글, 영문, 숫자를 제외한 특수문자 및 공백이 사용된 경우 파일 첨부가 되지 않습니다.</li>
								<li>이미지 크기가 2MB를 초과 시 업로드되지 않습니다.</li>
							</ul>
						</td>
					</tr>
				</tbody>
			</table>
			<dl class="qa-info-area">
				<dt>상품문의 안내</dt>
				<dd>
					<ul class="qa-comment">
						<li>상품문의는 재입고, 사이즈, 배송 등 상품에 대하여 브랜드 담당자에게 문의하는 게시판입니다.</li>
						<li><strong>욕설, 비방, 거래 글, 분쟁 유발, 명예훼손, 허위사실 유포, 타 쇼핑몰 언급,광고성 등의 부적절한 게시글은 금지합니다. 
							더불어 상품 문의 시 비밀글만 작성되도록 제한됩니다.</strong></li>
						<li><strong>주문번호, 연락처, 계좌번호 등의 개인 정보 관련 내용은 공개되지 않도록 비밀글로 문의해 주시기 바랍니다.</strong>
							공개된 글은 비밀글로 전환될 수있으며, 개인 정보 노출로 인한 피해는 무신사 스토어가 책임지지 않습니다.</li>
					</ul>
				</dd>
			</dl>
			<div class="qa-btn-area">
				<input type="hidden" name="productNo" value="${questionProduct.productNo}">
				<a href="javascript:void(0)" id="btn-lighter" class="n-btn" onclick="window.close();">취소</a>
				<a href="javascript:void(0)" id="btn-accent" class="n-btn" onclick="questionSubmit()">작성하기</a>
			</div>
		</form>
	</section>
</body>
</html>