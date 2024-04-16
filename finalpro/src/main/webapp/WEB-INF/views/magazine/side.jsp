<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
request.setCharacterEncoding("utf-8");
%>

<style>
.name-container {
    display: flex;
    flex-direction: column;
}

.kor-reply-container {
    display: flex;
    align-items: center; /* Align kor and replyCnt vertically */
}
</style>



<!-- 사이드 바 숨김/나타내기 -->
<script>
	document.addEventListener('DOMContentLoaded', function() {
		var btn = document.querySelector('.btn_show');
		var sidebar = document.querySelector('.sidebar');

		btn.addEventListener('click', function() {

			if (sidebar.style.display === 'none'
					|| sidebar.style.display === '') {
				sidebar.style.display = 'block';
			} else {
				sidebar.style.display = 'none';
			}
		});
	});
</script>
<c:set var="contextPath" value="#{pageContext.request.contextPath }" />
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	window.onload = function() {
		// 사용자가 텍스트를 입력할 때마다 listBrand 함수 호출
		
		listBrand('');
		
		document.getElementById('brandInput').addEventListener('keyup',
				function() {
					listBrand(this.value); // 입력된 값으로 listBrand 함수 호출
				});
	};

	function listBrand(alphabet) {
		var currentURL = window.location.href;
		var extractedString = currentURL.match(/\/([^\/.]+)\./)[1];

		let dataToSend = {
			firstLetter : alphabet,
			kindOfMagazine : extractedString
		};

		$.ajax({
			url : "/finalpro/magazine/listBrand.do",
			method : 'POST',
			contentType : 'application/json',
			data : JSON.stringify(dataToSend),
			success: function(data) {
		        var brandList = data.brandList.slice(0, 20);
		        var filteredBrandList = brandList.filter(function(brand) {
		            // Filter brands by user input in both English and Korean brand names
		            return brand.brandEng.toLowerCase().includes(alphabet.toLowerCase()) || 
		                   brand.brand.toLowerCase().includes(alphabet.toLowerCase());
		        });

				var brandListUl = document.getElementById('brandlistslide');
				brandListUl.innerHTML = ''; // 리스트 초기화
				console.log(brandListUl);

				// 필터링된 목록으로 UI 업데이트
				filteredBrandList.forEach(function(brand) {
				    var listItem = document.createElement('li');
				    listItem.className = 'listItem';

				    var brandLink = document.createElement('a');
				    brandLink.href = extractedString + '.do?brand=' + brand.brand;
				    brandLink.className = 'command-brand-link';

				    var titleSpan = document.createElement('span');
				    titleSpan.className = 'title';

				    var nameContainerDiv = document.createElement('div');
				    nameContainerDiv.className = 'name-container';

				    var engSpan = document.createElement('span');
				    engSpan.className = 'eng';
				    engSpan.textContent = brand.brandEng;

				    var korReplyContainer = document.createElement('div');
				    korReplyContainer.className = 'kor-reply-container';

				    var korSpan = document.createElement('span');
				    korSpan.className = 'kor';
				    korSpan.textContent = brand.brand;

				    var replyCntSpan = document.createElement('span');
				    replyCntSpan.className = 'replyCnt parentheses';
				    replyCntSpan.textContent = '(' + brand.magazineCount + ')';
				    
				    
				    korReplyContainer.appendChild(korSpan);
				    korReplyContainer.appendChild(replyCntSpan);


				    nameContainerDiv.appendChild(engSpan);
				    nameContainerDiv.appendChild(korReplyContainer);


				    titleSpan.appendChild(nameContainerDiv);
				    brandLink.appendChild(titleSpan);
				    listItem.appendChild(brandLink);
				    brandListUl.appendChild(listItem);
				});
			},
			error : function(error) {
				console.error('Error:', error);
			}
		});
	}
</script>
</head>

<body>

	<h2></h2>

	<div class="sidebar">
		<div class="searchTab tabBox" br-data-name="magazine_left_tab">
			<ul class="brand-option-list list">
				<li class="listItem"><label class="spell">브랜드명 입력 <input
						type="text" class="ui-brand-kwd" id="brandInput">
				</label>
					<ul class="letter-list">
						<li class="listItem btn ui-brand-btn tyA" ktype="A">A</li>
						<li class="listItem btn ui-brand-btn tyB" ktype="B">B</li>
						<li class="listItem btn ui-brand-btn tyC" ktype="C">C</li>
						<li class="listItem btn ui-brand-btn tyD" ktype="D">D</li>
						<li class="listItem btn ui-brand-btn tyE" ktype="E">E</li>
						<li class="listItem btn ui-brand-btn tyF" ktype="F">F</li>
						<li class="listItem btn ui-brand-btn tyG" ktype="G">G</li>
						<li class="listItem btn ui-brand-btn tyH" ktype="H">H</li>
						<li class="listItem btn ui-brand-btn tyI" ktype="I">I</li>
						<li class="listItem btn ui-brand-btn tyJ" ktype="J">J</li>
						<li class="listItem btn ui-brand-btn tyK" ktype="K">K</li>
						<li class="listItem btn ui-brand-btn tyL" ktype="L">L</li>
						<li class="listItem btn ui-brand-btn tyM" ktype="M">M</li>
						<li class="listItem btn ui-brand-btn tyN" ktype="N">N</li>
						<li class="listItem btn ui-brand-btn tyO" ktype="O">O</li>
						<li class="listItem btn ui-brand-btn tyP" ktype="P">P</li>
						<li class="listItem btn ui-brand-btn tyQ" ktype="Q">Q</li>
						<li class="listItem btn ui-brand-btn tyR" ktype="R">R</li>
						<li class="listItem btn ui-brand-btn tyS" ktype="S">S</li>
						<li class="listItem btn ui-brand-btn tyT" ktype="T">T</li>
						<li class="listItem btn ui-brand-btn tyU" ktype="U">U</li>
						<li class="listItem btn ui-brand-btn tyV" ktype="V">V</li>
						<li class="listItem btn ui-brand-btn tyW" ktype="W">W</li>
						<li class="listItem btn ui-brand-btn tyX" ktype="X">X</li>
						<li class="listItem btn ui-brand-btn tyY" ktype="Y">Y</li>
						<li class="listItem btn ui-brand-btn tyZ" ktype="Z">Z</li>
					</ul></li>
				<li class="listItem">
					<ul class="brand-list list area-list-brand" id="brandlistslide">
					</ul>
				</li>
			</ul>
		</div>
	</div>

	<button type="button" class="btn_show">
		<svg width="30" height="30" viewBox="0 0 30 30 file="
			none" xmlns="http://www.w3.org/2000/svg">
					<path fill-rule="evenodd" clip-rule="evenodd"
				d="M5 9.5H25V8.5H5V9.5ZM25 15.5H5V14.5H25V15.5ZM25 21.5H5V20.5H25V21.5Z"
				fill="black"></path>	 
				</svg>
	</button>
</body>
<script type="text/javascript">
	let letterListItems = document.querySelectorAll('.letter-list > li'); // CSS 선택자 수정

	letterListItems.forEach(function(item) {
		item.addEventListener('click', function(event) {
			var alphabet = event.target.getAttribute('ktype'); // 커스텀 데이터 속성 사용 권장
			listBrand(alphabet);
		});
	});
</script>