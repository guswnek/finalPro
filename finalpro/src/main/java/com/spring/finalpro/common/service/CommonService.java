package com.spring.finalpro.common.service;

import java.util.List;
import java.util.Map;

import com.spring.finalpro.common.dto.ProductDTO2;

public interface CommonService {
	
	// 메인페이지에 사진 과 정보 가져오기
	Map viewProduct();

	Map infoProduct(String productNo);

	Map viewBrandSnap();

	Map viewStreetSnap();
	
	Map viewPictorialMap();

	Map viewLookbookMap();
		
	// 브랜드 페이지
	Map brandList(String brand);
	
	List listBrand2(Map<String, Object> requestData);


}
