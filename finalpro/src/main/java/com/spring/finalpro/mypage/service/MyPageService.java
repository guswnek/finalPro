package com.spring.finalpro.mypage.service;

import java.util.List;
import java.util.Map;

import com.spring.finalpro.member.dto.MemberAddressDTO;
import com.spring.finalpro.member.dto.MemberDTO;
import com.spring.finalpro.mypage.dto.MypageDTO;

public interface MyPageService {

   int addLike(Map<String, Object> addLikeMap);

   int addbascket(Map<String, Object> productMap);

   int modLike(Map<String, Object> addLikeMap);

   int modbascket(Map<String, Object> productMap);
   
   List<MypageDTO> cartList(String id);

	int selectOrderQuantity(int no);

	void updateCount(String productNo, String productSize, int count, int no);

	void changeCount(MypageDTO mypage);

	void deleteCart(int no1, String id);

	List<MypageDTO> selectNoCountProduct(String id);

	List<MemberAddressDTO> addressList(String id);

	MypageDTO recepitList(int no);

	void insertOrderList(MypageDTO buyProductInfo);

	void deleteCount(int count, String productNo, String productSize);

	List<MypageDTO> orderList(MypageDTO mypage, String fromDate, String toDate);

	List<MypageDTO> selectReviewOrderNos();

	MypageDTO delivery_pay_info(int orderNo);

	void updateDeliveryStatus(String deliveryStatus, int orderNo);

	List<MypageDTO> selectlikeList(String id);

	void deleteLike(String productNo, String id);

	List<MypageDTO> recentList(String id);

	MemberDTO selectMemberInfo(String loginId);

	int insertQuestion(Map<String, Object> questionMap);
}
