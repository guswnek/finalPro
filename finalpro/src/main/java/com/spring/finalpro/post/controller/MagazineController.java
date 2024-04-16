package com.spring.finalpro.post.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

public interface MagazineController {
	public ResponseEntity listBrand(@RequestBody Map<String, Object> requestData, 
			HttpServletRequest request);
	
	// 매거진(화보 전체 페이지로 이동)
	public ModelAndView pictorial(
			@RequestParam(value = "brand", required = false) String brand,
			HttpServletRequest request,HttpServletResponse response);
	// 매거진(룩북 전체 페이지로 이동)
	public ModelAndView lookbook(
			@RequestParam(value = "brand", required = false) String brand,
			HttpServletRequest request, HttpServletResponse response);
}
