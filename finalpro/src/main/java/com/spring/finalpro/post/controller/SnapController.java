package com.spring.finalpro.post.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface SnapController {
	
	// 스타일(브랜드)
	public ModelAndView styleBrand(HttpServletRequest request, HttpServletResponse response);
	// 스타일(스트릿)
	public ModelAndView styleStreet(HttpServletRequest request, HttpServletResponse response);
	// 스타일(퍼스널컬러)
	public ModelAndView stylePersonalcolor(HttpServletRequest request, HttpServletResponse response);
	
	
	// 스타일 구역에서 해당하는 제품 상세 페이지로 이동
	public ModelAndView brandSnapInfo(
			@RequestParam("snapNo") String snapNo,
			@RequestParam(value = "brand", required = false) String brand,
			HttpServletRequest request, HttpServletResponse response);
}
