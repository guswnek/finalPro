package com.spring.finalpro.post.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finalpro.common.dto.ImageDTO;
import com.spring.finalpro.common.dto.ProductDTO2;
import com.spring.finalpro.post.dao.SnapDAO;
import com.spring.finalpro.post.dto.BrandSnapDTO;


@Service
@Transactional
public class SnapServiceImpl implements SnapService {
	
	@Autowired
	private SnapDAO dao;
	
		// 브랜드 스냅샷에서 사진을 클릭하면 그 사진에 있는 제품 정보 및 사진들 가져오기
		@Override
		public Map infoBrandSnap(String snapNo, String brand) {
		    Map brandSnapMap = new HashMap();
		    BrandSnapDTO brandSnapDTO2 = dao.infoBrandSnap(snapNo);
		    List<ImageDTO> imageFileList4 = dao.selectImageFileList4(snapNo);
		    List<BrandSnapDTO> tagDTO = dao.tag(snapNo);
		    
			
		    brandSnapMap.put("brandSnap2", brandSnapDTO2);
		    brandSnapMap.put("imageFileList4", imageFileList4);
		    brandSnapMap.put("tagDTO", tagDTO);
			
		    // brand스냅 상세페이지로 갔을 때 해당하는 제품 사진들 가져오기 색이 다른 것도
		    List<ProductDTO2> brandSnapDTO3 = dao.brandSnapProduct(snapNo);
		    List<ImageDTO> brandSnapProductImageList = dao.brandSnapProductImage(snapNo);
		    
		   
		    // brand스냅 상세페이지로 갔을 때 해당하는 제품 사진들 가져오기 색이 다른 것도
		    brandSnapMap.put("brandSnapDTO3", brandSnapDTO3);
		    brandSnapMap.put("brandSnapProductImageList", brandSnapProductImageList);

		    // brand 값이 null이 아닐 때만 실행
		    if (brand != null) {
		        // brand스냅 상세페이지로 갔을 때 해당하는 brand의 다른 스냅샷 정보와 사진 가져오기
		        List<ProductDTO2> brandSnapDTO4 = dao.brand(brand);
		        List<ImageDTO> brandImageList = dao.brandImageList(brand);
		        
		        List<ImageDTO> brandImage = dao.brandImage(brand);

		        // brand스냅 상세페이지로 갔을 때 해당하는 브랜드의 브랜드 스냅샷 정보 및 사진 가져오기
		        brandSnapMap.put("brandSnapDTO4", brandSnapDTO4);
		        brandSnapMap.put("brandImageList", brandImageList);
		        
		        brandSnapMap.put("brandImage", brandImage);
		    }
		    

		    return brandSnapMap;
		}
		
		// 조회수 추가하기
		@Override
		public int addViewSnap(String loginId, String snapNo) {
		    if (loginId != null) {
		    	
		    	return dao.addViewSnap(snapNo, loginId);
		        
		    } else {
		        
		    	return dao.addViewSnap2(snapNo);
		    }
		}

		

		// 브랜드 스냅을 클릭하고 전체를 클릭했을 때 브랜드 스냅 리스트가 있는 페이지로 이동
		@Override
		public Map allBrandSnap() {
			// TODO Auto-generated method stub
			Map allBrandSnapMap = new HashMap();
			List<BrandSnapDTO> allBrandSnapDTO = dao.allBrandSnapList();
			List<ImageDTO> allBrandSnapImageList = dao.allBrandSnapImageList();
			
			allBrandSnapMap.put("allBrandSnapDTO", allBrandSnapDTO);
			allBrandSnapMap.put("allBrandSnapImageList", allBrandSnapImageList);
			return allBrandSnapMap;
		}
		
		// 스트릿 스냅을 클릭하고 전체를 클릭했을 때 스트릿 스냅 리스트가 있는 페이지로 이동
		@Override
		public Map allStreetSnap() {
			// TODO Auto-generated method stub
			Map allStreetSnapMap = new HashMap();
			List<BrandSnapDTO> allStreetSnapDTO = dao.allStreetSnapList();
			List<ImageDTO> allStreetSnapImageList = dao.allStreetSnapImageList();
			
			allStreetSnapMap.put("allStreetSnapDTO", allStreetSnapDTO);
			allStreetSnapMap.put("allStreetSnapImageList", allStreetSnapImageList);
			return allStreetSnapMap;
		}



		
}
