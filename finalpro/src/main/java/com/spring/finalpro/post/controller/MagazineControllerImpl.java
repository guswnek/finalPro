package com.spring.finalpro.post.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.spring.finalpro.post.dto.MagazineBrandDTO;
import com.spring.finalpro.post.dto.MagazineDTO;
import com.spring.finalpro.post.dto.MagazineProductDTO;
import com.spring.finalpro.post.service.MagazineService;

@Controller
@RequestMapping("/magazine")
public class MagazineControllerImpl implements MagazineController{
	@Autowired
	MagazineService service;
	
	@RequestMapping("/listBrand.do")
	public ResponseEntity listBrand(@RequestBody Map<String, Object> requestData, 
			HttpServletRequest request) {
		if(requestData.get("kindOfMagazine").equals("lookbookInfo")){
			requestData.put("kindOfMagazine", "lookbook");
		}else if(requestData.get("kindOfMagazine").equals("pictorialInfo")){
			requestData.put("kindOfMagazine", "pictorial");
		}else if(requestData.get("kindOfMagazine").equals("pictorialList")){
			requestData.put("kindOfMagazine", "pictorial");
		}else if(requestData.get("kindOfMagazine").equals("lookbookList")){
			requestData.put("kindOfMagazine", "lookbook");
		}
		
		List<MagazineBrandDTO> brandList=service.listBrand(requestData);
		
		Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("brandList", brandList);

        return ResponseEntity.ok(responseMap);
	}
	
	@RequestMapping("/pictorialInfo.do")
	public ModelAndView pictorial(@RequestParam(value = "magazineNo", required = false) Integer magazineNo, HttpServletRequest request, 
			HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");
		System.out.println(viewName);
		Map<String, Object> magazineMap=new HashMap<String, Object>();
		magazineMap.put("category", "pictorial");
		magazineMap.put("magazineNo", magazineNo);
		
		MagazineDTO pictorial=service.getMagazine(magazineMap);
		
		// 입력 문자열을 콤마로 분리
        String[] parts = pictorial.getStaff().split(",");

        // 각 부분 처리
        for (String part : parts) {
            // 콜론으로 키와 값을 분리
            String[] keyValue = part.split(":");
            if (keyValue.length == 2) {
                String key = keyValue[0].trim(); // 앞뒤 공백 제거
                String value = keyValue[1].trim(); // 앞뒤 공백 제거

                System.out.println("key : " + key);
                // 키에 따라 dto 객체에 값 설정
                if(key.equals("에디터")) {
                	System.out.println(value + "는 에디터");
                	pictorial.setEditor(value);
                }else if(key.equals("포토그래퍼")) {
                	System.out.println(value + "는 포토그래퍼");
                	pictorial.setPhotographer(value);
                }else if(key.equals("디자이너")) {
                	System.out.println(value + "는 디자이너");
                	pictorial.setDesigner(value);
                }else if(key.equals("어시스턴트 에디터")) {
                	System.out.println(value + "는 어시스턴트");
                	pictorial.setAssist(value);
                }
            }
        }
        
        List<String> tagList=service.listTags(magazineNo);
        
        List<MagazineProductDTO> magazineProductList=service.listMagazineProducts(magazineNo);
        System.out.println(magazineProductList);
		
		
		ModelAndView mav=new ModelAndView(viewName);
		mav.addObject("pictorial", pictorial);
		mav.addObject("tagList", tagList);
		mav.addObject("magazineProductList", magazineProductList);
		return mav;
	}
	
	@RequestMapping("/lookbookInfo.do")
	public ModelAndView lookbook(@RequestParam(value = "magazineNo", required = false) Integer magazineNo, HttpServletRequest request, 
			HttpServletResponse response) {
		String viewName = (String) request.getAttribute("viewName");
		Map<String, Object> magazineMap=new HashMap<String, Object>();
		magazineMap.put("category", "lookbook");
		magazineMap.put("magazineNo", magazineNo);
		
		MagazineDTO lookbook=service.getMagazine(magazineMap);
		
		// 입력 문자열을 콤마로 분리
        String[] parts = lookbook.getStaff().split(",");

        // 각 부분 처리
        for (String part : parts) {
            // 콜론으로 키와 값을 분리
            String[] keyValue = part.split(":");
            if (keyValue.length == 2) {
                String key = keyValue[0].trim(); // 앞뒤 공백 제거
                String value = keyValue[1].trim(); // 앞뒤 공백 제거

                // 키에 따라 dto 객체에 값 설정
                if (key.equals("모델")) {
                	lookbook.setModel(value);
                } else if (key.equals("포토그래퍼")) {
                	lookbook.setPhotographer(value);
                }
            }
        }
        
        List<String> tagList=service.listTags(magazineNo);
        
        List<MagazineProductDTO> magazineProductList=service.listMagazineProducts(magazineNo);
        System.out.println(magazineProductList);
		
		
		ModelAndView mav=new ModelAndView(viewName);
		mav.addObject("lookbook", lookbook);
		mav.addObject("tagList", tagList);
		mav.addObject("magazineProductList", magazineProductList);
		return mav;
	}
	
	// (화보를 클릭했을 때) 전체를 클릭하면 화보 전체 목록 나오는 페이지로 가기
	
	 @Override
	 @RequestMapping("/pictorialList.do")
	 public ModelAndView pictorial(
			 @RequestParam(value = "brand", required = false) String brand,
			 HttpServletRequest request, HttpServletResponse response){
		 // TODO Auto-generated method stub 
	 String viewName = (String) request.getAttribute("viewName");
	 ModelAndView mav = new ModelAndView(viewName);
	 Map pictorialMap = service.pictorialList(brand);
	 mav.addObject("pictorialMap", pictorialMap);
	 return mav; 
	 }
	 
	 // (룩북을 클릭했을 때) 전체를 클릭하면 룩북 전체 목록 나오는 페이지로 가기
	 
	 @Override
	 @RequestMapping("/lookbookList.do")
	 public ModelAndView lookbook(
			 @RequestParam(value = "brand", required = false) String brand,
			 HttpServletRequest request, HttpServletResponse response) {
		 // TODOAuto-generated method stub
	 String viewName = (String) request.getAttribute("viewName");
	 ModelAndView mav = new ModelAndView(viewName);
	 Map lookbookMap = service.lookbookList(brand);
	 mav.addObject("lookbookMap", lookbookMap );
	 return mav; 
	 }
	
	
	
}
