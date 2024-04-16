package com.spring.finalpro.product.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

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

public interface ProductService {

   ProductDTO detailProduct(String productNo);

   List<ProductDTO> listProducts(String targetProductNo);

   //List<String> listTags(String targetProductNo);
   
   String listTags(String productNo);

   List<ProductImageDTO> listImages(String targetProductNo);

	int getInfoImageNumber(String productNo);

   List<ReviewDTO> listReviews(String targetProductNo);

   List<ReviewReplyDTO> listReplies(List<Integer> reviewNoList, Integer reviewNo);

   List<QuestionDTO> listQuestions(String targetProductNo);

   List<AnswerDTO> listAnswers(List<Integer> questionNoList);
   
   List<ProductSizeDTO> listSizes(String targetProductNo);

   int getSalesTotal(String productNo, int month, String gender);

   List<Integer> getViewCnt(String productNo);

   List<Integer> listAgePurchase(String productNo);

   List<Integer> listAgeView(String productNo);

   int addView(Map<String, Object> params);
   
   List<ReviewReplyDTO> listChildReplies(Integer parentReplyNo);

   int insertReply(Map<String, Object> replyMap);
   
   
   
   
    ReviewDTO productInfo(String productNo);

	ReviewDTO memberInfo(String id);

	int insertReview(Map<String, Object> reviewMap);

	ReviewDTO deletReview(int orderNo);

	ReviewDTO selectReviewList(int orderNo);

	void updateReview(Map<String, Object> reviewMap);

	List<SearchDTO> searchBrand(String keyword);

	int brandCount(String keyword);

	List<SearchDTO> searchProductList(Map<String, String> map);

	List<SearchDTO> searchMagazineList(Map<String, String> map);
   
	List<SearchDTO> searchSnapList(Map<String, String> map);
	
	
	
	
	
	
	//유진 상품리스트
	// 카테고리값 받아서 상품 list 출력하는 메서드
	List<Product_totalDTO> selectProductList(Map<String, Object> total);

	
   
   
}