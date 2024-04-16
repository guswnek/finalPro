package com.spring.finalpro.product.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalpro.product.dao.ProductDAO;
import com.spring.finalpro.product.dto.AnswerDTO;
import com.spring.finalpro.product.dto.ProductDTO;
import com.spring.finalpro.product.dto.ProductImageDTO;
import com.spring.finalpro.product.dto.ProductInfoImageDTO;
import com.spring.finalpro.product.dto.ProductSizeDTO;
import com.spring.finalpro.product.dto.Product_totalDTO;
import com.spring.finalpro.product.dto.QuestionDTO;
import com.spring.finalpro.product.dto.ReviewDTO;
import com.spring.finalpro.product.dto.ReviewReplyDTO;
import com.spring.finalpro.product.dto.SearchDTO;

@Service
public class ProductServiceImpl implements ProductService{
   @Autowired
   ProductDAO dao;

   @Override
   public ProductDTO detailProduct(String productNo) {
      // TODO Auto-generated method stub
      return dao.detailProduct(productNo);
   }
   
   @Override
   public List<ProductDTO> listProducts(String targetProductNo) {
      // TODO Auto-generated method stub
      return dao.listProducts(targetProductNo);
   }

//   @Override
//   public List<String> listTags(String targetProductNo) {
//      // TODO Auto-generated method stub
//      return dao.listTags(targetProductNo);
//   }
   
   @Override
   public String listTags(String productNo) {
       // TODO Auto-generated method stub
       return dao.listTags(productNo);
   }
   
   @Override
   public List<ProductImageDTO> listImages(String targetProductNo) {
      // TODO Auto-generated method stub
      return dao.listImages(targetProductNo);
   }

	@Override
	public int getInfoImageNumber(String productNo) {
		// TODO Auto-generated method stub
		return dao.getInfoImageNumber(productNo);
	}

   @Override
   public List<ReviewDTO> listReviews(String targetProductNo) {
      // TODO Auto-generated method stub
      return dao.listReviews(targetProductNo);
   }

   @Override
   public List<ReviewReplyDTO> listReplies(@Param("reviewNoList") List<Integer> reviewNoList, Integer reviewNo) {
      // TODO Auto-generated method stub
      return dao.listReplies(reviewNoList, reviewNo);
   }

   @Override
   public List<QuestionDTO> listQuestions(String targetProductNo) {
      // TODO Auto-generated method stub
      return dao.listQuestions(targetProductNo);
   }

   @Override
   public List<AnswerDTO> listAnswers(List<Integer> questionNoList) {
      // TODO Auto-generated method stub
      return dao.listAnswers(questionNoList);
   }
   
   @Override
   public List<ProductSizeDTO> listSizes(String targetProductNo) {
      // TODO Auto-generated method stub
      return dao.listSizes(targetProductNo);
   }

   @Override
   public int getSalesTotal(String productNo, int month, String gender) {
      // TODO Auto-generated method stub
      return dao.getSalesTotal(productNo, month, gender);
   }

   @Override
   public List<Integer> listAgePurchase(String productNo) {
      // TODO Auto-generated method stub
      return dao.listAgePurchase(productNo);
   }

   @Override
   public List<Integer> getViewCnt(String productNo) {
      // TODO Auto-generated method stub
      return dao.getViewCnt(productNo);
   }

   @Override
   public List<Integer> listAgeView(String productNo) {
      // TODO Auto-generated method stub
      return dao.listAgeView(productNo);
   }

   @Override
   public int addView(Map<String, Object> params) {
      // TODO Auto-generated method stub
      return dao.addView(params);
   }
   
   
   @Override
   public List<ReviewReplyDTO> listChildReplies(Integer parentReplyNo) {
      // TODO Auto-generated method stub
      return dao.listChildReplies(parentReplyNo);
   }

   @Override
   public int insertReply(Map<String, Object> replyMap) {
      // TODO Auto-generated method stub
      return dao.insertReply(replyMap);
   }
   
   
   
   
   
   public ReviewDTO productInfo(String productNo) {
		return dao.productInfo(productNo);
	}

	public ReviewDTO memberInfo(String id) {
		return dao.memberInfo(id);
	}

	public int insertReview(Map<String, Object> reviewMap) {
		
		// reviewNo 가져오기(max(reviewNo))
		int reviewNo = dao.selectReviewNo();
		System.out.println(reviewNo);
		
		// 해당 상품 넣기
		reviewMap.put("reviewNo", reviewNo);
		
		dao.insertReview(reviewMap);
		
		return reviewNo;
	}

	@Override
	public ReviewDTO deletReview(int orderNo) {
		// reviewNo와 image 이름 가져오기
		ReviewDTO dto = dao.selectNoImgName(orderNo);
		
		// 삭제하기
		dao.deletReview(orderNo);
		return dto;
	}

	@Override
	public ReviewDTO selectReviewList(int orderNo) {
		return dao.selectReviewList(orderNo);
	}

	@Override
	public void updateReview(Map<String, Object> reviewMap) {
		dao.updateReview(reviewMap);
	}

	@Override
	public List<SearchDTO> searchBrand(String keyword) {
		return dao.searchBrand(keyword);
	}

	@Override
	public int brandCount(String keyword) {
		return dao.brandCount(keyword);
	}

	@Override
	public List<SearchDTO> searchProductList(Map<String, String> map) {
		
		List<SearchDTO> productList = new ArrayList<SearchDTO>();
		
		// #으로 들어오면 색과 관련된 것만 출력
		if (map.get("keyword").startsWith("#")) {
			System.out.println("색으로 입력 : " + map.get("keyword"));
			String colorCode = map.get("keyword"); // 예제 색상 코드

			// 색상 코드에서 '#' 제거
			String hex = colorCode.substring(1);

			System.out.println(hex);
			// RGB 값으로 변환
			int red = Integer.parseInt(hex.substring(0, 2), 16);
			int green = Integer.parseInt(hex.substring(2, 4), 16);
			int blue = Integer.parseInt(hex.substring(4, 6), 16);

			Map colorMap = new HashMap();
			colorMap.put("red", red);
			colorMap.put("green", green);
			colorMap.put("blue", blue);
			colorMap.put("orderBy", map.get("orderBy"));
			
			System.out.println("red 입력 : " + red);
			System.out.println("green 입력 : " + green);
			System.out.println("blue 입력 : " + blue);

			productList = dao.searchBycolor(colorMap);
		}else {
			System.out.println("그냥 모든 검색 : " + map.get("keyword"));
			productList = dao.searchProductList(map);
		}
		return productList;
	}

	@Override
	public List<SearchDTO> searchMagazineList(Map<String, String> map) {
		
		List<SearchDTO> magazineList = new ArrayList<SearchDTO>();
		magazineList = dao.searchMagazineList(map);
		
		return magazineList;
	}
	
	@Override
	public List<SearchDTO> searchSnapList(Map<String, String> map) {
		List<SearchDTO> snapList = new ArrayList<SearchDTO>();
		snapList = dao.searchSnapList(map);
		return snapList;
	}

	
	// 유진 상품리스트
	@Override
	public List<Product_totalDTO> selectProductList(Map<String, Object> total) {
		// TODO Auto-generated method stub
		return dao.selectProductList(total);
	}



}