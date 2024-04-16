package com.spring.finalpro.post.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalpro.common.dto.ImageDTO;
import com.spring.finalpro.post.dao.MagazineDAO;
import com.spring.finalpro.post.dto.MagazineDTO;
import com.spring.finalpro.post.dto.MagazineProductDTO;

@Service
public class MagazineServiceImpl implements MagazineService{
	@Autowired
	MagazineDAO dao;

	@Override
	public List listBrand(Map<String, Object> requestData) {
		// TODO Auto-generated method stub
		return dao.listBrand(requestData);
	}

	@Override
	public MagazineDTO getMagazine(Map<String, Object> magazineMap) {
		// TODO Auto-generated method stub
		return dao.getMagazine(magazineMap);
	}

	@Override
	public List<String> listTags(Integer magazineNo) {
		// TODO Auto-generated method stub
		return dao.listTags(magazineNo);
	}

	@Override
	public List<MagazineProductDTO> listMagazineProducts(Integer magazineNo) {
		// TODO Auto-generated method stub
		return dao.listMagazineProducts(magazineNo);
	}
	
	// 화보 전체 리스트 페이지 , 브랜드 값이 들어오면 해당 브랜드 룩북 전체 페이지
	@Override
	public Map pictorialList(String brand) {
	    Map pictorialMap = new HashMap();
	    List<ImageDTO> pictorialList;
	    List<ImageDTO> pictorialListBrand;

	    // Check if the brand parameter is not null and not empty
	    if (brand != null && !brand.isEmpty()) {
	        pictorialListBrand = dao.selectPictorialListByBrand(brand);
	        pictorialMap.put("pictorialListBrand", pictorialListBrand);
	    } else {
	        pictorialList = dao.selectpictorialAllList();
	        pictorialMap.put("pictorialList", pictorialList);
	    }

	    return pictorialMap;
	}
	
	// 룩북 전체 리스트 페이지 , 브랜드 값이 들어오면 해당 브랜드 룩북 전체 페이지
	@Override
	public Map lookbookList(String brand) {
	    Map lookbookMap = new HashMap();
	    List<ImageDTO> lookbookList;
	    List<ImageDTO> lookbookListBrand;

	    if (brand != null && !brand.isEmpty()) {
	        lookbookListBrand = dao.selectLookbookListByBrand(brand);
	        lookbookMap.put("lookbookListBrand", lookbookListBrand);
	    } else {
	        lookbookList = dao.selectlookbookAllList();
	        lookbookMap.put("lookbookList", lookbookList);
	    }
	    
	    return lookbookMap;
	}

	
	

}
