package com.spring.finalpro.post.dao;

import java.util.List;
import java.util.Map;

import com.spring.finalpro.common.dto.ImageDTO;
import com.spring.finalpro.post.dto.MagazineDTO;
import com.spring.finalpro.post.dto.MagazineProductDTO;

public interface MagazineDAO {

	List listBrand(Map<String, Object> requestData);

	MagazineDTO getMagazine(Map<String, Object> magazineMap);

	List<String> listTags(Integer magazineNo);

	List<MagazineProductDTO> listMagazineProducts(Integer magazineNo);
	
	// 화보 리스트 페이지에 정보 전달하기
	List<ImageDTO> selectpictorialAllList();
	
	// 룩북 리스트 페이지에 정보 전달하기
	List<ImageDTO> selectlookbookAllList();

	
	// 들어온 브랜드에 해당하는 화보 리스트
	List<ImageDTO> selectPictorialListByBrand(String brand);
	
	// 들어온 브랜드에 해당하는 룩북 리스트
	List<ImageDTO> selectLookbookListByBrand(String brand);
	
}
