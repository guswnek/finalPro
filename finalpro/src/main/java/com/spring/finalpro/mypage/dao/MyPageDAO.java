package com.spring.finalpro.mypage.dao;

import java.util.List;
import java.util.Map;

import com.spring.finalpro.member.dto.MemberAddressDTO;
import com.spring.finalpro.member.dto.MemberDTO;
import com.spring.finalpro.mypage.dto.MypageDTO;

public interface MyPageDAO {

   int addLike(Map<String, Object> addLikeMap);
   
   int checkBasket(Map<String, String> map);

   int addbascket(Map<String, Object> productMap);

   int modLike(Map<String, Object> addLikeMap);

   int modbascket(Map<String, Object> productMap);

   List<MypageDTO> selectCartList(String id);

	int selectCountSize(int no);

	int selectStockbySize(Map<String, Object> map);

	void updateCount(Map<String, Object> map);

	int checkLike(int no);

	void updateCart(int no);

	void deleteCart(int no);

	List<MypageDTO> selectNoCountProduct(String id);

	List<MemberAddressDTO> addressList(String id);

	MypageDTO recepitList(int no);

	int maxOrderNo(String tableName);

	void insertOrderList(Map<String, Object> map);

	void updateStock(Map<String, Object> map);

	List<MypageDTO> selectOrderListAll(Map<String, Object> map);

	List<MypageDTO> selectReviewOrderNos();

	MypageDTO delivery_pay_info(int orderNo);

	void updateDeliveryStatus(Map<String, Object> map);

	MypageDTO selectCountProductSize(int orderNo);

	List<MypageDTO> selectlikeList(String id);

	void updateLike(Map<String, String> map);

	void deleteLike(Map<String, String> map);

	List<MypageDTO> selectRecentList(String id);

	MemberDTO selectMemberInfo(String loginId);
	
	
	void insertQuestion(Map<String, Object> questionMap);
	
	int selectQuestionNo();

}