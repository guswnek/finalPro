package com.spring.finalpro.common.dao;

import java.util.List;
import java.util.Map;

import com.spring.finalpro.post.dto.BrandSnapDTO;
import com.spring.finalpro.common.dto.ImageDTO;
import com.spring.finalpro.post.dto.MagazineDTO2;
import com.spring.finalpro.common.dto.ProductDTO2;

public interface CommonDAO {

	List<ImageDTO> selectImageFileList();

	List<ProductDTO2> viewProduct();
	
	List<ProductDTO2> viewProductOuter();

	List<ImageDTO> selectImageFileListOuter();
	
	List<ProductDTO2> viewProductTop();

	List<ImageDTO> selectImageFileListTop();

	List<ProductDTO2> viewProductPants();

	List<ImageDTO> selectImageFileListPants();

	List<ProductDTO2> viewProductShoes();

	List<ImageDTO> selectImageFileListShoes();
	

	ProductDTO2 infoProduct(String productNo);

	List<ImageDTO> selectImageFileList2(String productNo);

	List<BrandSnapDTO> viewBrandSnap();

	List<ImageDTO> selectImageFileList3();
	
	List<BrandSnapDTO> viewStreetSnap();

	List<ImageDTO> selectImageFileList5();

	
	// 브랜드 제품 리스트 페이지 만들기
	List<ProductDTO2> allBrandProductList(String brand);

	List<ImageDTO> allBrandProductImageList(String brand);
	
	// 브랜드 이미지 및 소개글 가져오기
	List<ImageDTO> brandImage(String brand);

	
	
	// 메인 화면에 화보 사진 가져오기
	List<ImageDTO> selectPictorialMainImage();
	
	// 메인 화면에 룩북 사진 가져오기
	List<ImageDTO> selectLookbookMainImage();
	
	

	// 브랜드 사이드 
	List listBrand2(Map<String, Object> requestData);

	


	

	

	

	



}
