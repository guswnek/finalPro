package com.spring.finalpro.post.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finalpro.common.dto.ImageDTO;
import com.spring.finalpro.common.dto.ProductDTO2;
import com.spring.finalpro.post.dto.BrandSnapDTO;

@Repository
public class SnapDAOImpl implements SnapDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public BrandSnapDTO infoBrandSnap(String snapNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.snap.selectOneBrandSnap", snapNo);
	}

	@Override
	public List<ImageDTO> selectImageFileList4(String snapNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.snap.selectImageFileList4", snapNo);
	}
	
	@Override
	public List<BrandSnapDTO> tag(String snapNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.snap.brandSnapTag", snapNo);
	}

	
	@Override
	public List<ImageDTO> brandImage(String brand) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.snap.brandImage", brand);
	}
	
	// 브랜드 스냅샷 들어갔을 때 해당하는 상품 정보 및 이미지
	@Override
	public List<ProductDTO2> brandSnapProduct(String snapNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.snap.brandSnapProductList", snapNo);
	}

	@Override
	public List<ImageDTO> brandSnapProductImage(String snapNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.snap.brandSnapProductImage", snapNo);
	}
	
	
	
	// 브랜드 스냅샷 전체 페이지
	@Override
	public List<BrandSnapDTO> allBrandSnapList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.snap.allBrandSnapList");
	}

	@Override
	public List<ImageDTO> allBrandSnapImageList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.snap.allBrandSnapImageList");
	}

	@Override
	public List<BrandSnapDTO> allStreetSnapList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.snap.allStreetSnapList");
	}

	@Override
	public List<ImageDTO> allStreetSnapImageList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.snap.allStreetSnapImageList");
	}

	
	// 브랜드 스냅 상세 페이지에서 관련 브랜드 스냅샷 가져오기
	
	@Override
	public List<ProductDTO2> brand(String brand) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.snap.brandList", brand);
	}

	@Override
	public List<ImageDTO> brandImageList(String brand) {
		// TODO Auto-generated method stub
		 return sqlSession.selectList("mapper.snap.brandImageList", brand);
	}

	@Override
	public int addViewSnap(String snapNo, String loginId) {
		// TODO Auto-generated method stub
		 Map<String, Object> params = new HashMap<>();
        params.put("snapNo", snapNo);
        params.put("loginId", loginId);
        
        return sqlSession.insert("mapper.snap.addViewSnap", params);
	}

	@Override
	public int addViewSnap2(String snapNo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.snap.addViewSnap2", snapNo);
	}
}
