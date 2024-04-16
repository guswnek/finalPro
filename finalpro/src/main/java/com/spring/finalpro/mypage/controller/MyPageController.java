package com.spring.finalpro.mypage.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.finalpro.mypage.dto.MypageDTO;

public interface MyPageController {
	
	// 장바구니로 이동
	public ModelAndView shoppingBasket(HttpServletRequest request, HttpServletResponse response)  throws Exception;
		
	// 장바구니 수량 변경
	public ModelAndView changeCount(@ModelAttribute("mypage") MypageDTO mypage, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 장바구니 삭제
	public ResponseEntity deleteShoppingBasket(@RequestParam(value = "noList", required = false) String noList,
			@RequestParam(value = "no", required = false) Integer no, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 품절된 상품 모두 삭제
	public ResponseEntity deleteNonStockProduct(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 작성한 주문서 데이터 받기 - 장바구니 -> 주문서
	public ModelAndView recepit(@RequestParam("noList") String noList, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 작성한 주문서 데이터 받기 - 바로구매 -> 주문서
	public ModelAndView recepit1(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 주문하면 orderlist에 저장
	// 재고에서 구매한 수 빼기
	// 구매한 목록 장바구니에서 빼기
	public ResponseEntity insertOrderList(@ModelAttribute("mypage") MypageDTO mypage, @RequestParam(value = "noList", required = false) int[] noList,
			@RequestParam(value = "productInfoList", required = false) String[] productInfoList,
			HttpServletRequest request, HttpServletResponse response) throws Exception;

	// 마이페이지로 이동
	public ModelAndView orderList(@ModelAttribute("mypage") MypageDTO mypage, @RequestParam(value = "fromDate", required = false)String fromDate,
			@RequestParam(value = "toDate", required = false)String toDate, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 배송정보 팝업창
	public ModelAndView orderInfoPopup(@RequestParam("orderNo") int orderNo, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 환불이나 교환 요청 했을 때 deliveryStatus 수정
	public ResponseEntity changeDeliveryStatus(@RequestParam("deliveryStatus") String deliveryStatus, @RequestParam("orderNo") int orderNo, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 좋아요로 이동
	public ModelAndView like(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 좋아요 삭제
	public ResponseEntity deleteLike(String productNoList, @RequestBody(required  = false) Map<String, Object> requestData, HttpServletRequest request, HttpServletResponse response) throws Exception;
	
	// 최근 본 상품으로 이동
	public ModelAndView recentProduct(HttpServletRequest request, HttpServletResponse response) throws Exception;
	
}
