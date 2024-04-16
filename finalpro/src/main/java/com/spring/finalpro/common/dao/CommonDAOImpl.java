package com.spring.finalpro.common.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finalpro.post.dto.BrandSnapDTO;
import com.spring.finalpro.common.dto.ImageDTO;
import com.spring.finalpro.post.dto.MagazineDTO2;
import com.spring.finalpro.common.dto.ProductDTO2;

@Repository
public class CommonDAOImpl implements CommonDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<ImageDTO> selectImageFileList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.selectImageFileList");
	}

	@Override
	public List<ProductDTO2> viewProduct() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.selectProduct");
	}
	
	@Override
	public List<ProductDTO2> viewProductOuter() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.outerProduct");
	}

	@Override
	public List<ImageDTO> selectImageFileListOuter() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.outerImageFileList");
	}
	
	
	@Override
	public List<ProductDTO2> viewProductTop() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.topProduct");
	}

	@Override
	public List<ImageDTO> selectImageFileListTop() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.topImageFileList");
	}

	@Override
	public List<ProductDTO2> viewProductPants() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.pantsProduct");
	}

	@Override
	public List<ImageDTO> selectImageFileListPants() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.pantsImageFileList");
	}

	@Override
	public List<ProductDTO2> viewProductShoes() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.shoesProduct");
	}

	@Override
	public List<ImageDTO> selectImageFileListShoes() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.shoesImageFileList");
	}
	
	

	@Override
	public ProductDTO2 infoProduct(String productNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.common.selectOneProduct", productNo);
	}

	@Override
	public List<ImageDTO> selectImageFileList2(String productNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.selectImageFileList2", productNo);
	}

	@Override
	public List<BrandSnapDTO> viewBrandSnap() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.selectBrandSnap");
	}

	@Override
	public List<ImageDTO> selectImageFileList3() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.selectImageFileList3");
	}

	@Override
	public List<BrandSnapDTO> viewStreetSnap() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.selectStreetSnap");
	}

	@Override
	public List<ImageDTO> selectImageFileList5() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.selectImageFileList5");
	}
	

	@Override
	public List<ImageDTO> selectPictorialMainImage() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.selectPictorialMainImage");
	}

	@Override
	public List<ImageDTO> selectLookbookMainImage() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.selectLookbookMainImage");
	}

	// 브랜드 제품 리스트 페이지 만들기

	@Override
	public List<ProductDTO2> allBrandProductList(String brand) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.brandProductList", brand);
	}
	
	
	@Override
	public List<ImageDTO> allBrandProductImageList(String brand) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.brandProductImageList", brand);
	}


	@Override
	public List<ImageDTO> brandImage(String brand) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.brandImage", brand);
	}
	
	
	// 브랜드 사이드
	@Override
	public List listBrand2(Map<String, Object> requestData) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.common.listBrand", requestData);
	}
	

	
}
