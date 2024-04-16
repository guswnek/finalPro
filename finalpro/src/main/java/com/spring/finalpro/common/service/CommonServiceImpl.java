package com.spring.finalpro.common.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finalpro.common.dao.CommonDAO;
import com.spring.finalpro.post.dto.BrandSnapDTO;
import com.spring.finalpro.common.dto.ImageDTO;
import com.spring.finalpro.post.dto.MagazineDTO2;
import com.spring.finalpro.common.dto.ProductDTO2;

@Service
@Transactional(propagation = Propagation.REQUIRED)
public class CommonServiceImpl implements CommonService {
	@Autowired
	private CommonDAO dao;
	
	// 메인화면에서 조회수 top 10에 있는 사진 및 사진에 있는 제품 정보들 가져오기
	@Override
	public Map viewProduct() {
		// TODO Auto-generated method stub
		Map productMap = new HashMap();
		List<ProductDTO2> productDTO = dao.viewProduct();
		List<ImageDTO> imageFileList = dao.selectImageFileList();
		List<ProductDTO2> productDTOOuter = dao.viewProductOuter();
		List<ImageDTO> imageFileListOuter = dao.selectImageFileListOuter();
		List<ProductDTO2> productDTOTop = dao.viewProductTop();
		List<ImageDTO> imageFileListTop = dao.selectImageFileListTop();
		List<ProductDTO2> productDTOPants = dao.viewProductPants();
		List<ImageDTO> imageFileListPants = dao.selectImageFileListPants();
		List<ProductDTO2> productDTOShoes = dao.viewProductShoes();
		List<ImageDTO> imageFileListShoes = dao.selectImageFileListShoes();
		
		// 전체 순위중에 탑 10개 가져오기
		productMap.put("product", productDTO);
		// 전체 순위중에 탑 10개 이미지 가져오기
		productMap.put("imageFileList", imageFileList);
		
		// 아우터 순위중에 탑 10개 가져오기
		productMap.put("productOuter", productDTOOuter);
		// 아우터 순위중에 탑 10개 이미지 가져오기
		productMap.put("imageFileListOuter", imageFileListOuter);
		
		// 상의 순위중에 탑 10개 가져오기
		productMap.put("productTop", productDTOTop);
		// 상의 순위중에 탑 10개 이미지 가져오기
		productMap.put("imageFileListTop", imageFileListTop);
		
		// 하의 순위중에 탑 10개 가져오기
		productMap.put("productPants", productDTOPants);
		// 하의 순위중에 탑 10개 이미지 가져오기
		productMap.put("imageFileListPants", imageFileListPants);
		
		// 신발 순위중에 탑 10개 가져오기
		productMap.put("productShoes", productDTOShoes);
		// 신발 순위중에 탑 10개 이미지 가져오기
		productMap.put("imageFileListShoes", imageFileListShoes);
		
		
		return productMap;
	}
	
	// 랭킹에서 특정 사진을 클릭하면 그 사진에 있는 제품 정보 및 사진들 가져오기
	@Override
	public Map infoProduct(String productNo) {
		// TODO Auto-generated method stub
		Map productMap = new HashMap();
		ProductDTO2 productDTO2 = dao.infoProduct(productNo);
		List<ImageDTO> imageFileList2 = dao.selectImageFileList2(productNo);
		
		productMap.put("product2", productDTO2);
		productMap.put("imageFileList2", imageFileList2);
		return productMap;
	}
	
	// 메인화면에서 조회수 top4에 있는 브랜드 스냅 사진 및 사진에 있는 제품 정보들 가져오기
	@Override
	public Map viewBrandSnap() {
		// TODO Auto-generated method stub
		Map brandSnapMap = new HashMap();
		List<BrandSnapDTO> brandSnapDTO = dao.viewBrandSnap();
		List<ImageDTO> imageFileList3 = dao.selectImageFileList3();
		
		brandSnapMap.put("brandSnap", brandSnapDTO);
		brandSnapMap.put("imageFileList3", imageFileList3);
		return brandSnapMap;
	}
	
	
	// 메인화면에서 조회수 top4에 있는 스트릿 스냅 사진 및 사진에 있는 제품 정보들 가져오기
	@Override
	public Map viewStreetSnap() {
		// TODO Auto-generated method stub
		Map streetSnapMap = new HashMap();
		List<BrandSnapDTO> brandSnapDTO = dao.viewStreetSnap();
		List<ImageDTO> imageFileList5 = dao.selectImageFileList5();
		
		streetSnapMap.put("streetSnap", brandSnapDTO);
		streetSnapMap.put("imageFileList5", imageFileList5);
		return streetSnapMap;
	}
	
	// 메인 화면에 화보 사진 및 정보 가져오기
	@Override
	public Map viewPictorialMap() {
		// TODO Auto-generated method stub
		Map pictorialMap = new HashMap();
		List<ImageDTO> pictorialMainImage = dao.selectPictorialMainImage();
		
		pictorialMap.put("pictorialMainImage", pictorialMainImage);
		
		return pictorialMap;
	}
	
	// 메인 화면에 룩북 사진 및 정보 가져오기
	@Override
	public Map viewLookbookMap() {
		// TODO Auto-generated method stub
		Map lookbookMap = new HashMap();
		List<ImageDTO> lookbookMainImage = dao.selectLookbookMainImage();
		
		lookbookMap.put("lookbookMainImage", lookbookMainImage);
		
		return lookbookMap;
	}
	

	
	
	// 브랜드 제품 리스트 페이지 만들기
	@Override
	public Map brandList(String brand) {
		// TODO Auto-generated method stub
		Map brandListMap = new HashMap();
		List<ProductDTO2> allBrandProductDTO = dao.allBrandProductList(brand);
		List<ImageDTO> allBrandProductImageList = dao.allBrandProductImageList(brand);
		List<ImageDTO> brandImage = dao.brandImage(brand);
		
		brandListMap.put("brandImage", brandImage);
		brandListMap.put("allBrandProductDTO", allBrandProductDTO);
		brandListMap.put("allBrandProductImageList", allBrandProductImageList);
		return brandListMap;
	}
	
	
	// 브랜드 사이드 만들기
	@Override
	public List listBrand2(Map<String, Object> requestData) {
		// TODO Auto-generated method stub
		return dao.listBrand2(requestData);
	}

	

}
