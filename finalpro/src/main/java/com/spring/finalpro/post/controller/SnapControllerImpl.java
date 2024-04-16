package com.spring.finalpro.post.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.finalpro.post.service.SnapService;

@Controller
@EnableAspectJAutoProxy
public class SnapControllerImpl implements SnapController  {
	
	@Autowired
	private SnapService service;
	
	// (브랜드 스냅샷을 클릭했을 때) 스타일 옆에 전체를 클릭하면 
	@Override
	@RequestMapping("/styleall/brandSnap.do")
	public ModelAndView styleBrand(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		Map allBrandSnapMap = service.allBrandSnap();
		mav.addObject("allBrandSnapMap", allBrandSnapMap);
		return mav;
	}
	
	// (스타일 스트릿을 클릭했을 때) 스타일 옆에 전체를 클릭하면
	@Override
	@RequestMapping("/styleall/streetSnap.do")
	public ModelAndView styleStreet(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		Map allStreetSnapMap = service.allStreetSnap();
		mav.addObject("allStreetSnapMap", allStreetSnapMap);
		return mav;
	}
	
	// (퍼스널 컬러를 클릭했을 때) 스타일 옆에 전체를 클릭하면 
	@Override
	@RequestMapping("/styleall/personalColor.do")
	public ModelAndView stylePersonalcolor(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	
	// 메인 페이지에 있는 브랜드 스냅샷에서 사진을 클릭하면 해당 제품 상세페이지로 넘어가는 메서드 
	@Override
	@RequestMapping("/styleall/brandSnapInfo.do")
	public ModelAndView brandSnapInfo(
			@RequestParam("snapNo") String snapNo,
			@RequestParam(value = "brand", required = false) String brand,
			HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session=request.getSession(false);
		
		String loginId=(String) session.getAttribute("loginId");
		
		int result = service.addViewSnap(loginId, snapNo);
		
		Map brandSnapMap = service.infoBrandSnap(snapNo, brand);
		mav.addObject("brandSnapMap", brandSnapMap);
		return mav;
	}
}
