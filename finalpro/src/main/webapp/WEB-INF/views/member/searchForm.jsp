<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
%>
<c:set var = "contextPath" value="${pageContext.request.contextPath}" />

<script>
    // 검색어 보내기
    function submitForm(obj) {
        var searchTerm = document.querySelector('.input_search').value;
        
        console.log("검색어:", searchTerm);
        
        obj.action = "${contextPath}/product/searchList.do";
        obj.submit();
    }
    
    document.addEventListener("DOMContentLoaded", function() {
        var inputSearch = document.querySelector(".input_search");
        inputSearch.addEventListener("keypress", handleEnterKey);
    });
    
    function handleEnterKey(event) {
        // 눌린 키가 Enter 키인지 확인
        if (event.keyCode === 13) {
            // form을 제출
            submitForm(document.getElementById("searchForm"));
        }
    }
    
    
    function imageFormSubmit() {
        var form = document.getElementById('searchForm');
        
        // 폼의 속성을 변경
        form.action = "/finalpro/analyzeImage.do";
        form.enctype = "multipart/form-data";
        form.method = "POST";
        
        // 폼 제출
        form.submit();
    }    

</script>

<body>
	<a href="/finalpro/main.do"><img src="/finalpro/resources/image/cancel2.png" id="cancel"></a>
    <div id="all">
        <div class="search_container">
            <div class="search_wrap">
                <div class="search_area">
                    <div class="search">
                        <form id="searchForm">
                           <input type="text" placeholder="브랜드, 상품, 프로필, 태그 등" title="검색창" class="input_search" name = "keyword">
                           <img src="/finalpro/resources/image/camera-removebg-preview.png" id="camera">
                           <input type="file" id="upload-image" name="image" onchange="imageFormSubmit();" hidden="hidden">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="search_content_wrap">
            <div class="recent_area">
                <div class="layer_search_item recent_keywords">
                    <div class="layer_search_item_content_wrap">
                        <div class="layer_search_title_wrap">
                        </div><span data-v-50e9c89a="" class="title __web-inspector-hide-shortcut__">최근 검색어</span>
                        <div data-v-50e9c89a="" class="title_sub_text"><a data-v-c71c7ed4="" data-v-50e9c89a="" href="#">지우기</a></div>
                    </div>
                    <div data-v-50e9c89a="" class="layer_search_item_content_wrap">
                        <div data-v-704623ba="" data-v-c71c7ed4="" class="recent_box" data-v-50e9c89a="">
                            <div data-v-704623ba="" class="search_list">
                                <!-- 최근검색어가 추가되는 구역. -->
                            </div>
                        </div>
                    </div>
                </div>
            </div>
			<div class="search_card_items">
				<div class="layer_search_item_ranking">
					<div class="layer_search_title_wrap">
						<span class="title">인기 검색어</span>
					</div>
					<div class="layer_search_item_content_wrap">
						<div class="layer_search_card">
							<ol class="search_card_ranking">
								<li class="search_card_ranking_item">
									<span class="ranking_idx">1</span>
										<a href="#">
											<span class="ranking_title">mm112</span>
										</a>
										<span class="ranking_description"></span>
								</li>
								<li class="search_card_ranking_item">
									<span class="ranking_idx">2</span>
										<a href="#">
											<span class="ranking_title">팔라스 엄브로</span>
										</a>
										<span class="ranking_description"></span>
								</li>
								<li class="search_card_ranking_item">
									<span class="ranking_idx">3</span>
										<a href="#">
											<span class="ranking_title">스투스 바람막이</span>
										</a>
										<span class="ranking_description"></span>
								</li>
								<li class="search_card_ranking_item">
									<span class="ranking_idx">4</span>
										<a href="#">
											<span class="ranking_title">860</span>
										</a>
										<span class="ranking_description"></span>
								</li>
								<li class="search_card_ranking_item">
									<span class="ranking_idx">5</span>
										<a href="#">
											<span class="ranking_title">보메로</span>
										</a>
										<span class="ranking_description"></span>
								</li>
								<li class="search_card_ranking_item">
									<span class="ranking_idx">6</span>
										<a href="#">
											<span class="ranking_title">아디다스 져지</span>
										</a>
										<span class="ranking_description"></span>
								</li>
								<li class="search_card_ranking_item">
									<span class="ranking_idx">7</span>
										<a href="#">
											<span class="ranking_title">v2k</span>
										</a>
										<span class="ranking_description"></span>
								</li>
								<li class="search_card_ranking_item">
									<span class="ranking_idx">8</span>
										<a href="#">
											<span class="ranking_title">574</span>
										</a>
										<span class="ranking_description"></span>
								</li>
								<li class="search_card_ranking_item">
									<span class="ranking_idx">9</span>
										<a href="#">
											<span class="ranking_title">아디다스 가젤</span>
										</a>
										<span class="ranking_description"></span>
								</li>
								<li class="search_card_ranking_item">
									<span class="ranking_idx">10</span>
										<a href="#">
											<span class="ranking_title">코스</span>
										</a>
										<span class="ranking_description"></span>
								</li>
							</ol>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
<script type="text/javascript">
  document.getElementById('camera').addEventListener('click', function() {
      document.getElementById('upload-image').click();
  });
</script>			
</body>
</html>