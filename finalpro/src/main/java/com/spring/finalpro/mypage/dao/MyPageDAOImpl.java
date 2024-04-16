package com.spring.finalpro.mypage.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.finalpro.common.controller.CommonControllerImpl;
import com.spring.finalpro.common.dao.CommonDAO;
import com.spring.finalpro.common.dao.CommonDAOImpl;
import com.spring.finalpro.member.dto.MemberAddressDTO;
import com.spring.finalpro.member.dto.MemberDTO;
import com.spring.finalpro.mypage.dto.MypageDTO;

@Repository
public class MyPageDAOImpl implements MyPageDAO{
   @Autowired
   SqlSession sqlsession;
   
   @Override
   public int maxOrderNo(String tableName) {
      Map<String, Object> params = new HashMap<>();
      params.put("tableName", tableName);
      System.out.println("maxOrderNo tableName : " + params.get("tableName"));
      return sqlsession.selectOne("mapper.mypage.maxOrderNo", params);
   }

   @Override
   public int addLike(Map<String, Object> addLikeMap) {
      // TODO Auto-generated method stub
      int maxOrderNo=maxOrderNo("product_like_bascket_tbl");
      addLikeMap.put("maxOrderNo", maxOrderNo);
      
      return sqlsession.insert("mapper.mypage.addLike", addLikeMap);
   }

   @Override
   public int checkBasket(Map<String, String> map) {
      return sqlsession.selectOne("mapper.mypage.checkBasket", map);
   }

   @Override
   public int addbascket(Map<String, Object> productMap) {
      // TODO Auto-generated method stub
      int maxOrderNo=maxOrderNo("product_like_bascket_tbl");
      productMap.put("maxOrderNo", maxOrderNo);
      return sqlsession.insert("mapper.mypage.addbascket", productMap);
   }

   @Override
   public int modLike(Map<String, Object> addLikeMap) {
      // TODO Auto-generated method stub
      System.out.println("addLikeMap : "+addLikeMap);
      return sqlsession.update("mapper.mypage.modLike", addLikeMap);
   }

   @Override
   public int modbascket(Map<String, Object> productMap) {
      // TODO Auto-generated method stub
      System.out.println("productMap : "+productMap);
      return sqlsession.update("mapper.mypage.modbascket", productMap);
   }
   
   @Override
	public List<MypageDTO> selectCartList(String id) {
		return sqlsession.selectList("mapper.mypage.selectCartList", id);
	}

	@Override
	public int selectCountSize(int no) {
		return sqlsession.selectOne("mapper.mypage.selectCountSize", no);
	}

	@Override
	public int selectStockbySize(Map<String, Object> map) {
		return sqlsession.selectOne("mapper.mypage.selectStockbySize", map);
	}

	@Override
	public void updateCount(Map<String, Object> map) {
		sqlsession.update("mapper.mypage.updateCount", map);
	}

	@Override
	public int checkLike(int no) {
		return sqlsession.update("mapper.mypage.checkLike", no);
	}

	@Override
	public void updateCart(int no) {
		sqlsession.update("mapper.mypage.updateCart", no);
	}

	@Override
	public void deleteCart(int no) {
		sqlsession.update("mapper.mypage.deleteCart", no);
	}

	@Override
	public List<MypageDTO> selectNoCountProduct(String id) {
		return sqlsession.selectList("mapper.mypage.selectNoCountProduct", id);
	}

	@Override
	public List<MemberAddressDTO> addressList(String id) {
		return sqlsession.selectList("mapper.mypage.addressList", id);
	}

	@Override
	public MypageDTO recepitList(int no) {
		return sqlsession.selectOne("mapper.mypage.recepitList", no);
	}

	@Override
	public void insertOrderList(Map<String, Object> map) {
		sqlsession.selectOne("mapper.mypage.insertOrderList", map);
	}

	@Override
	public void updateStock(Map<String, Object> map) {
		sqlsession.update("mapper.mypage.updateStock", map);
	}

	@Override
	public List<MypageDTO> selectOrderListAll(Map<String, Object> map) {
		return sqlsession.selectList("mapper.mypage.selectOrderListAll", map);
	}

	@Override
	public List<MypageDTO> selectReviewOrderNos() {
		return sqlsession.selectList("mapper.mypage.selectReviewOrderNos");
	}

	@Override
	public MypageDTO delivery_pay_info(int orderNo) {
		return sqlsession.selectOne("mapper.mypage.delivery_pay_info", orderNo);
	}

	@Override
	public void updateDeliveryStatus(Map<String, Object> map) {
		sqlsession.update("mapper.mypage.updateDeliveryStatus", map);
	}

	@Override
	public MypageDTO selectCountProductSize(int orderNo) {
		return sqlsession.selectOne("mapper.mypage.selectCountProductSize", orderNo);
	}
	
	@Override
	public List<MypageDTO> selectlikeList(String id) {
		System.out.println("selectlikeList" + id);
		return sqlsession.selectList("mapper.mypage.selectlikeList", id);
	}

	@Override
	public void updateLike(Map<String, String> map) {
		sqlsession.update("mapper.mypage.updateLike", map);
	}

	@Override
	public void deleteLike(Map<String, String> map) {
		sqlsession.delete("mapper.mypage.deleteLike", map);
	}

	@Override
	public List<MypageDTO> selectRecentList(String id) {
		return sqlsession.selectList("mapper.mypage.selectRecentList", id);
	}

	@Override
	public MemberDTO selectMemberInfo(String loginId) {
		return sqlsession.selectOne("mapper.member.Selectmember", loginId);
	}
	
	 @Override
     public void insertQuestion(Map<String, Object> questionMap) {
        // TODO Auto-generated method stub
        sqlsession.insert("mapper.mypage.insertQuestion", questionMap);
     }
	 
	 @Override
	 public int selectQuestionNo() {
	    // TODO Auto-generated method stub
	    return sqlsession.selectOne("mapper.mypage.selectQuestionNo");
	 }



}