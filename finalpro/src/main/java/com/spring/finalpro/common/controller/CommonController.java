package com.spring.finalpro.common.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.finalpro.common.dto.ProductDTO2;

public interface CommonController {
	// 메인화면 출력
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response);
	// 다운로드
	
	public void download(@RequestParam("imageFileName") String imageFileName,
            @RequestParam("productNo") String productNo, @RequestParam(value = "magazineNo") Integer magazineNo, @RequestParam("path") String path,
            HttpServletResponse response) throws Exception;
	
	
	// 고객센터로 이동
	public ModelAndView complaint(HttpServletRequest request, HttpServletResponse response);

	
	// 폼 공통
	public ModelAndView Form(HttpServletRequest request, HttpServletResponse response);
	
	
	
	public String upload(MultipartHttpServletRequest mRequest, String path) throws IOException;
	
	
	// 브랜드 사이드 
	public ResponseEntity listBrand2(@RequestBody Map<String, Object> requestData, 
			HttpServletRequest request);
	
	// 브랜드 페이지
	public ModelAndView brandList(
			@RequestParam(value = "brand") String brand,
			HttpServletRequest request, HttpServletResponse response);

	
}
