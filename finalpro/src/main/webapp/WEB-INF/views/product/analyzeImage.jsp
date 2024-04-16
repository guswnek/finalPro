<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="#{pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
    <title>Image Color Picker</title>
    <style>
        body {
            position: relative;
        }
        img {
            max-width: 100%; /* 이미지가 페이지 너비를 초과하지 않도록 설정 */
        }
        #magnifier {
            position: absolute;
            border: 1px solid #000;
            border-radius: 50%;
            width: 60px; /* 돋보기의 지름 */
            height: 60px;
            pointer-events: none; /* 마우스 이벤트가 돋보기를 통과하도록 설정 */
        }
        #color-send {
            position: relative;
            margin-top: 20px;
        }
        #select-color {
            width: 100px;
            height: 100px;
            border: 1px solid #000;
        }
		.frequency li:hover {
		    border: 2px solid #000; 
		    border-radius: 5px; 
		}
		li {
		    width: 205px;
		}
        
    </style>
    <script type="text/javascript">
    	function modChange(mod) {
				let frequencyDiv = document.querySelectorAll(".frequency");
				let magnifierDiv = document.querySelectorAll(".magnifier");
				let frequencyBtn = document.querySelector("#frequency-btn");
				let magnifierBtn = document.querySelector("#magnifier-btn");
			if(mod=="frequency"){
				magnifierDiv.forEach(function(element) {
				    element.style.display = "none";
				});
				frequencyDiv.forEach(function(element) {
					element.style.display="";
				});
				frequencyBtn.disabled = true;
				magnifierBtn.disabled = false;
			}else if(mod=="magnifier"){
				frequencyDiv.forEach(function(element) {
				    element.style.display = "none";
				});
				magnifierDiv.forEach(function(element) {
					element.style.display="";
				});
				magnifierBtn.disabled = true;
				frequencyBtn.disabled = false;
			}
		}
    	
    	function goSearchList(keyword) {
    		keyword = keyword.slice(1); // "World"
    	    window.location.href = "product/searchList.do?keyword=%23" + keyword;
    	}
    	
    	// 현빈씨 직접 찾기에서 주소 보내는 것 입니다. ㅎ_ㅎ
    	function goSearchList2() {
		    // hidden-selected-color 요소의 값 가져오기
		    let selectedColor = document.getElementById("hidden-selected-color").value;
		
		    // 2번째 글자부터 가져오기
		    let substringSelectedColor = selectedColor.substring(1);
		
		    // URL에 키워드 값을 포함하여 이동
		    window.location.href = "product/searchList.do?keyword=%23" + substringSelectedColor;
		
		    // 폼 제출 막기
		    return false;
		}
    	
    </script>
    
    
</head>
<body>
	<button id="frequency-btn" onclick="modChange(this.value)" value="frequency" disabled="disabled">목록보기</button>
	<button id="magnifier-btn" onclick="modChange(this.value)" value="magnifier">직접찾기</button>
    <img id="imageToAnalyze" src="${imageSrc}" style="width: auto; max-width: 100%; height: auto;">
    
    <div class="frequency">
		<h3>Top Colors</h3>
		<ul>
		    <c:forEach var="entry" items="${colorFrequencyMap}">
		        <li onclick="goSearchList(this.getAttribute('value'))" value="${entry.key}">
		        	<span style="background:${entry.key};width:20px;height:20px;display:inline-block;"></span> 
		        	<span>${entry.key} - ${entry.value} times</span>
		        </li>
		    </c:forEach>
		</ul>
	</div>
    
    <canvas class="magnifier" id="magnifier" style="display: none;"></canvas>
    
   <div class="magnifier" id="color-send" style="display: none;">
	    <div id="select-color"></div>
	    <form action="" onsubmit="return goSearchList2()">
	        <input type="hidden" id="hidden-selected-color">
	        <input type="submit" value="이 색깔로 검색하기">
	    </form>
	</div>
    
    <script type="text/javascript">
    document.addEventListener('DOMContentLoaded', function() {
        const img = document.getElementById('imageToAnalyze');
        const magnifier = document.querySelector('#magnifier');
        const canvas = document.createElement('canvas');
        const context = canvas.getContext('2d');
        
        const selectColor = document.getElementById('select-color');
        const hiddenSelectColor = document.getElementById('hidden-selected-color');

        // 이미지 로드를 확인하고, canvas에 그리기
        img.onload = function() {
            canvas.width = img.naturalWidth;
            canvas.height = img.naturalHeight;
            context.drawImage(img, 0, 0, canvas.width, canvas.height);
        };

        // 이미지가 이미 로드된 경우에 대비하여 수동으로 onload 이벤트 트리거
        if (img.complete) {
            img.onload();
        }

        document.addEventListener('mousemove', function(e) {
            if (e.target === img) {
                const bounds = img.getBoundingClientRect();
                const x = Math.floor((e.clientX - bounds.left) * (img.naturalWidth / bounds.width));
                const y = Math.floor((e.clientY - bounds.top) * (img.naturalHeight / bounds.height));
                const pixel = context.getImageData(x, y, 1, 1).data;
                const color = 'rgba('+pixel[0]+','+ pixel[1]+','+pixel[2]+','+(pixel[3] / 255)+')';

                magnifier.style.left = e.pageX + 15 + 'px'; // 돋보기 위치 조정
                magnifier.style.top = e.pageY + 10 + 'px';
                magnifier.style.background = color;
            }
		});
        
        document.addEventListener('click', function(e) {
            if (e.target === img) {
                selectColor.style.background = magnifier.style.background;
                hiddenSelectColor.value = backgroundColorToHex(magnifier.style.background);
            }
        });
	});
    
    function backgroundColorToHex(backgroundColor) {
        // 백그라운드 컬러를 RGB 값으로 추출
        var rgbArray = backgroundColor.match(/\d+/g);

        // RGB 값을 각각 추출
        var r = parseInt(rgbArray[0]);
        var g = parseInt(rgbArray[1]);
        var b = parseInt(rgbArray[2]);

        // RGB 값을 Hex 색상으로 변환하여 반환
        return "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
    }
    </script>
</body>
</html>
