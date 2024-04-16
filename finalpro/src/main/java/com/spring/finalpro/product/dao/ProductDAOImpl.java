package com.spring.finalpro.product.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.spring.finalpro.mypage.dao.MyPageDAO;
import com.spring.finalpro.mypage.dao.MyPageDAOImpl;
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

@Repository
public class ProductDAOImpl implements ProductDAO{
   @Autowired
   private SqlSession sqlSession;
   @Autowired
   MyPageDAO myDao;

   @Override
   public ProductDTO detailProduct(String productNo) {
      // TODO Auto-generated method stub
      return sqlSession.selectOne("mapper.product.detailProduct", productNo);
   }
   
   @Override
   public List<ProductDTO> listProducts(String targetProductNo) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("mapper.product.listProducts", targetProductNo);
   }

//   @Override
//   public List<String> listTags(String targetProductNo) {
//      // TODO Auto-generated method stub
//      return sqlSession.selectList("mapper.product.listTags", targetProductNo);
//   }
   
   @Override
   public String listTags(String productNo) {
       // TODO Auto-generated method stub
       return sqlSession.selectOne("mapper.product.listTags", productNo);
   }

   @Override
   public List<ProductImageDTO> listImages(String targetProductNo) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("mapper.product.listImages", targetProductNo);
   }

	@Override
	public int getInfoImageNumber(String productNo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.product.getInfoImageNumber", productNo);
	}

   @Override
   public List<ReviewDTO> listReviews(String targetProductNo) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("mapper.product.listReviews", targetProductNo);
   }

   @Override
   public List<ReviewReplyDTO> listReplies(@Param("reviewNoList") List<Integer> reviewNoList, Integer reviewNo) {
      // TODO Auto-generated method stub
      Map<String, Object> reviewMap=new HashMap<String, Object>();
      reviewMap.put("reviewNoList", reviewNoList);
      reviewMap.put("reviewNo", reviewNo);
      return sqlSession.selectList("mapper.product.listReplies", reviewMap);
   }

   @Override
   public List<QuestionDTO> listQuestions(String targetProductNo) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("mapper.product.listQuestions", targetProductNo);
   }

   @Override
   public List<AnswerDTO> listAnswers(List<Integer> questionNoList) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("mapper.product.listAnswers", questionNoList);
   }
   
   @Override
   public List<ProductSizeDTO> listSizes(String targetProductNo) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("mapper.product.listSizes", targetProductNo);
   }
   
   @Override
   public int getSalesTotal(String productNo, int month, String gender) {
      // TODO Auto-generated method stub
      Map<String, Object> productMonthMap=new HashMap<String, Object>();
      productMonthMap.put("productNo", productNo);
      productMonthMap.put("month", month);
      productMonthMap.put("gender", gender);
      
      Integer returnInt=sqlSession.selectOne("mapper.product.getSalesTotal", productMonthMap);
      
      
      if(returnInt!=null) {
         return returnInt;
      }else {
         return 0;
      }
   }

   @Override
   public List<Integer> getViewCnt(String productNo) {
      // TODO Auto-generated method stub
      Map<String, Object> params = new HashMap<>();
      params.put("productNo", productNo);
      
      params.put("gender", null);
      int totalView=sqlSession.selectOne("mapper.product.getGenderViewCnt", params);
      
      params.put("gender", "male");
      int maleView=sqlSession.selectOne("mapper.product.getGenderViewCnt", params);
      
      params.put("gender", "female");
      int femaleView=sqlSession.selectOne("mapper.product.getGenderViewCnt", params);
      
      List<Integer> genderView=new ArrayList<Integer>();
      genderView.add(maleView);
      genderView.add(femaleView);
      genderView.add(totalView);
      
      return genderView;
   }

   @Override
   public List<Integer> listAgePurchase(String productNo) {
      // TODO Auto-generated method stub
      List<Integer> returnList = new ArrayList<Integer>();
      
      Map<String, Object> params = new HashMap<>();
      params.put("productNo", productNo);
      
      params.put("ageLimit", 18);
      Integer tempResult = sqlSession.selectOne("mapper.product.listAgePurchase", params);
      returnList.add(tempResult != null ? tempResult : 0);
      
      params.put("ageLimit", 19);
      tempResult = sqlSession.selectOne("mapper.product.listAgePurchase", params);
      returnList.add(tempResult != null ? tempResult : 0);
      
      params.put("ageLimit", 24);
      tempResult = sqlSession.selectOne("mapper.product.listAgePurchase", params);
      returnList.add(tempResult != null ? tempResult : 0);
      
      params.put("ageLimit", 29);
      tempResult = sqlSession.selectOne("mapper.product.listAgePurchase", params);
      returnList.add(tempResult != null ? tempResult : 0);
      
      params.put("ageLimit", 34);
      tempResult = sqlSession.selectOne("mapper.product.listAgePurchase", params);
      returnList.add(tempResult != null ? tempResult : 0);
      
      params.put("ageLimit", 39);
      tempResult = sqlSession.selectOne("mapper.product.listAgePurchase", params);
      returnList.add(tempResult != null ? tempResult : 0);
      
      return returnList;
   }

   @Override
   public List<Integer> listAgeView(String productNo) {
      // TODO Auto-generated method stub
      List<Integer> returnList = new ArrayList<Integer>();
      Integer tempResult=0;
      
      Map<String, Object> params = new HashMap<>();
      params.put("productNo", productNo);
      
      params.put("ageLimit", 18);
      tempResult = sqlSession.selectOne("mapper.product.listAgeView", params);
      returnList.add(tempResult != null ? tempResult : 0);
      
      params.put("ageLimit", 19);
      tempResult = sqlSession.selectOne("mapper.product.listAgeView", params);
      returnList.add(tempResult != null ? tempResult : 0);
      
      params.put("ageLimit", 24);
      tempResult = sqlSession.selectOne("mapper.product.listAgeView", params);
      returnList.add(tempResult != null ? tempResult : 0);
      
      params.put("ageLimit", 29);
      tempResult = sqlSession.selectOne("mapper.product.listAgeView", params);
      returnList.add(tempResult != null ? tempResult : 0);
      
      params.put("ageLimit", 34);
      tempResult = sqlSession.selectOne("mapper.product.listAgeView", params);
      returnList.add(tempResult != null ? tempResult : 0);
      
      params.put("ageLimit", 39);
      tempResult = sqlSession.selectOne("mapper.product.listAgeView", params);
      returnList.add(tempResult != null ? tempResult : 0);
      
      return returnList;
   }

   @Override
   public int addView(Map<String, Object> params) {
      // TODO Auto-generated method stub
      int maxNo=myDao.maxOrderNo("view_history");
      params.put("no", maxNo);
      return sqlSession.insert("mapper.product.addView", params);
   }
   
   @Override
   public List<ReviewReplyDTO> listChildReplies(Integer parentReplyNo) {
      // TODO Auto-generated method stub
      return sqlSession.selectList("mapper.product.listChildReplies", parentReplyNo);
   }

   @Override
   public int insertReply(Map<String, Object> replyMap) {
      // TODO Auto-generated method stub
      return sqlSession.insert("mapper.product.insertReply", replyMap);
   }
   
   
   
   
   
   
   @Override
	public ReviewDTO productInfo(String productNo) {
		return sqlSession.selectOne("mapper.product.productInfo", productNo);
	}

	@Override
	public ReviewDTO memberInfo(String id) {
		return sqlSession.selectOne("mapper.product.memberInfo", id);
	}

	@Override
	public int selectReviewNo() {
		return sqlSession.selectOne("mapper.product.selectReviewNo");
	}

	@Override
	public void insertReview(Map<String, Object> reviewMap) {
		sqlSession.insert("mapper.product.insertReview", reviewMap);
	}

	@Override
	public void deletReview(int orderNo) {
		sqlSession.delete("mapper.product.deletReview", orderNo);
	}

	@Override
	public ReviewDTO selectNoImgName(int orderNo) {
		return sqlSession.selectOne("mapper.product.selectNoImgName",orderNo);
	}

	@Override
	public ReviewDTO selectReviewList(int orderNo) {
		return sqlSession.selectOne("mapper.product.selectReviewList",orderNo);
	}

	@Override
	public void updateReview(Map<String, Object> reviewMap) {
		sqlSession.update("mapper.product.updateReview",reviewMap);
	}

	@Override
	public List<SearchDTO> searchBrand(String keyword) {
		return sqlSession.selectList("mapper.product.searchBrand", keyword);
	}

	@Override
	public int brandCount(String keyword) {
		return sqlSession.selectOne("mapper.product.brandCount", keyword);
	}

	@Override
	public List<SearchDTO> searchBycolor(Map colorMap) {
		return sqlSession.selectList("mapper.product.searchBycolor", colorMap);
	}

	@Override
	public List<SearchDTO> searchProductList(Map<String, String> map) {
		return sqlSession.selectList("mapper.product.searchProductList", map);
	}

	@Override
	public List<SearchDTO> searchMagazineBycolor(Map colorMap) {
		return sqlSession.selectList("mapper.product.searchMagazineBycolor", colorMap);
	}

	@Override
	public List<SearchDTO> searchMagazineList(Map<String, String> map) {
		return sqlSession.selectList("mapper.product.searchMagazineList", map);
	}
	
	@Override
	public List<SearchDTO> searchSnapList(Map<String, String> map) {
		return sqlSession.selectList("mapper.product.searchSnapList", map);
	}

	@Override
	public List<SearchDTO> searchSnapBycolor(Map colorMap) {
		return sqlSession.selectList("mapper.product.searchSnapBycolor", colorMap);
	}

	
	
	
	
	//유진 상품리스트
	@Override
	public List<Product_totalDTO> selectProductList(Map<String, Object> total) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.product.selectProductList",total);
	}


   
   
}
