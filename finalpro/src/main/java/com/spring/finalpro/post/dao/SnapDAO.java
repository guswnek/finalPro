package com.spring.finalpro.post.dao;

import java.util.List;

import com.spring.finalpro.common.dto.ImageDTO;
import com.spring.finalpro.common.dto.ProductDTO2;
import com.spring.finalpro.post.dto.BrandSnapDTO;

public interface SnapDAO {
	
	
	BrandSnapDTO infoBrandSnap(String snapNo);

	List<ImageDTO> selectImageFileList4(String snapNo);
	
	List<BrandSnapDTO> tag(String snapNo);
	
	List<ProductDTO2> brandSnapProduct(String snapNo);

	List<ImageDTO> brandSnapProductImage(String snapNo);
	
	List<ProductDTO2> brand(String brand);

	List<ImageDTO> brandImageList(String brand);
	
	List<BrandSnapDTO> allBrandSnapList();

	List<ImageDTO> allBrandSnapImageList();

	List<BrandSnapDTO> allStreetSnapList();

	List<ImageDTO> allStreetSnapImageList();
	
	// 브랜드 이미지 및 소개글 가져오기
	List<ImageDTO> brandImage(String brand);

	int addViewSnap(String snapNo, String loginId);

	int addViewSnap2(String snapNo);
}
