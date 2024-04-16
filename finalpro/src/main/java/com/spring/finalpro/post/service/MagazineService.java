package com.spring.finalpro.post.service;

import java.util.List;
import java.util.Map;

import com.spring.finalpro.post.dto.MagazineDTO;
import com.spring.finalpro.post.dto.MagazineProductDTO;

public interface MagazineService {

	List listBrand(Map<String, Object> requestData);

	MagazineDTO getMagazine(Map<String, Object> magazineMap);

	List<String> listTags(Integer magazineNo);

	List<MagazineProductDTO> listMagazineProducts(Integer magazineNo);
	
	// 화보 전체 리스트
	Map pictorialList(String brand);
	
	// 룩북 전체 리스트
	Map lookbookList(String brand);
	
	

}
