package com.spring.finalpro.post.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finalpro.common.dto.ImageDTO;
import com.spring.finalpro.post.dto.MagazineDTO;
import com.spring.finalpro.post.dto.MagazineProductDTO;

@Repository
public class MagazineDAOImpl implements MagazineDAO{
	@Autowired
	SqlSession sqlSession;

	@Override
	public List listBrand(Map<String, Object> requestData) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.magazine.listBrand", requestData);
	}

	@Override
	public MagazineDTO getMagazine(Map<String, Object> magazineMap) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.magazine.getMagazine", magazineMap);
	}

	@Override
	public List<String> listTags(Integer magazineNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.magazine.listTags", magazineNo);
	}

	@Override
	public List<MagazineProductDTO> listMagazineProducts(Integer magazineNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.magazine.listMagazineProducts", magazineNo);
	}
	
	
	// 화보 리스트 페이지에 정보 전달하기
	@Override
	public List<ImageDTO> selectpictorialAllList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.magazine.selectpictorialAllList");
	}
	
	// 룩북 리스트 페이지에 정보 전달하기
	@Override
	public List<ImageDTO> selectlookbookAllList() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.magazine.selectlookbookAllList");
	}

	@Override
	public List<ImageDTO> selectPictorialListByBrand(String brand) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.magazine.selectpictorialBrandAllList", brand);
	}

	@Override
	public List<ImageDTO> selectLookbookListByBrand(String brand) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.magazine.selectlookbookBrandAllList", brand);
	}
	

}
