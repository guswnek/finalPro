package com.spring.finalpro.mypage.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.finalpro.member.dto.MemberAddressDTO;
import com.spring.finalpro.member.dto.MemberDTO;
import com.spring.finalpro.mypage.dao.MyPageDAO;
import com.spring.finalpro.mypage.dto.MypageDTO;

@Service
public class MyPageServiceImpl implements MyPageService{
   @Autowired
   MyPageDAO dao;

   @Override
   public int addLike(Map<String, Object> addLikeMap) {
      // TODO Auto-generated method stub
      return dao.addLike(addLikeMap);
   }

   @Override
   public int addbascket(Map<String, Object> productMap) {
      // TODO Auto-generated method stub
      return dao.addbascket(productMap);
   }

   @Override
   public int modLike(Map<String, Object> addLikeMap) {
      // TODO Auto-generated method stub
      return dao.modLike(addLikeMap);
   }

   @Override
   public int modbascket(Map<String, Object> productMap) {
      // TODO Auto-generated method stub
      return dao.modbascket(productMap);
   }
   
   @Override
	public List<MypageDTO> cartList(String id) {
		return dao.selectCartList(id);
	}

	@Override
	public int selectOrderQuantity(int no) {
		// 구매한 수량 가져오기
		return dao.selectCountSize(no);
	}

	@Override
	public void updateCount(String productNo, String productSize, int count, int no) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productNo", productNo);
		map.put("productSize", productSize);
		
		// 상품번호, 사이즈에 따른 재고 가져오기
		int stock = dao.selectStockbySize(map);
		
//		System.out.println("count : " + count);
//		System.out.println("stock : " + stock);
		
		if(count > stock) {
			count = stock;
		}
//		System.out.println(count);
		map.put("count", count);
		map.put("no", no);
		dao.updateCount(map);
		
	}

	@Override
	public void changeCount(MypageDTO mypage) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("no", mypage.getNo());
		map.put("count", mypage.getCount());
		dao.updateCount(map);
	}

	@Override
	public void deleteCart(int no, String id) {
	 	
	 	List<MypageDTO> likeList = new ArrayList<MypageDTO>();
	 	
	 	likeList = dao.selectlikeList(id);
	 
	 	for(MypageDTO dto:likeList) {
	 		// 좋아요와 장바구니 모두 1일때 -> 좋아요를 0으로 수정
          if (dto.getNo() == (no) && dto.getInlike() == 1 && dto.getInbascket()==1) {
       	   dao.updateCart(no);
          }// 좋아요가 0일때, 장바구니가 1일때 -> 삭제 
          else if (dto.getNo() == (no) && dto.getInbascket()==1) {
       	   dao.deleteCart(no);
          }// 장바구니가 0일때, 좋아요가 1일때 -> 그대로
	 	}
	}

	@Override
	public List<MypageDTO> selectNoCountProduct(String id) {
		return dao.selectNoCountProduct(id);
	}

	@Override
	public List<MemberAddressDTO> addressList(String id) {
		return dao.addressList(id);
	}

	@Override
	public MypageDTO recepitList(int no) {
		return dao.recepitList(no);
	}

	@Override
	public void insertOrderList(MypageDTO buy) {
		
		String tableName = "orderHistory";
		int orderNo = dao.maxOrderNo(tableName);
		buy.setOrderNo(orderNo);
		String[] strPrice = (buy.getOrderPrice().split(","));
		
		String fullPrice = "";
		for(String str: strPrice) {
			fullPrice += str;
		}
		int intPrice = Integer.parseInt(fullPrice);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orderNo", orderNo);
		map.put("memberId", buy.getMemberId());
		map.put("productNo", buy.getProductNo());
		map.put("productSize", buy.getProductSize());
		map.put("intPrice", intPrice);
		map.put("count", buy.getCount());
		map.put("deliveryRequest", buy.getDeliveryRequest());
		map.put("receiverName", buy.getReceiverName());
		map.put("receiverPhone", buy.getReceiverPhone());
		map.put("receiverAdress", buy.getReceiverAdress());
		map.put("payment", buy.getPayment());
		map.put("paymentCard", buy.getPaymentCard());
		map.put("paymentMonth", buy.getPaymentMonth());
		map.put("paymentBank", buy.getPaymentBank());
		
		dao.insertOrderList(map);
	}

	@Override
	public void deleteCount(int count, String productNo, String productSize) {
		// 상품번호와 사이즈로 재고 가져오기
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("productNo", productNo);
		map.put("productSize", productSize);
		int stock = dao.selectStockbySize(map);
		
		stock = stock - count;
		map.put("stock", stock);
		
		System.out.println();
		System.out.println(map.get("productNo"));
		System.out.println(map.get("productSize"));
		System.out.println(map.get("stock"));
		
		dao.updateStock(map);
	}

	@Override
	public List<MypageDTO> orderList(MypageDTO mypage, String fromDate, String toDate) {
		List<MypageDTO> orderList = new ArrayList<MypageDTO>();
		Map<String, Object> map = new HashMap<String, Object>();		
		map.put("memberId", mypage.getMemberId());
		map.put("deliveryStatus", mypage.getDeliveryStatus() != null ? mypage.getDeliveryStatus() : "");
		map.put("productName", mypage.getName() != null ? mypage.getName() : "");
		map.put("fromDate", fromDate != null ? fromDate : "");
		map.put("toDate", toDate != null ? toDate : "");
		
		orderList = dao.selectOrderListAll(map);
			
		return orderList;
	}

	@Override
	public List<MypageDTO> selectReviewOrderNos() {
		return dao.selectReviewOrderNos();
	}

	@Override
	public MypageDTO delivery_pay_info(int orderNo) {
		return dao.delivery_pay_info(orderNo);
	}

	@Override 
	 public void updateDeliveryStatus(String deliveryStatus, int orderNo) {
		 Map<String, Object> map = new HashMap<String, Object>();
		 map.put("deliveryStatus", deliveryStatus);
		 map.put("orderNo", orderNo);
		 dao.updateDeliveryStatus(map);
		
		 if(deliveryStatus.equals("환불")) {
			 // orderNo에 대한 productNo, size, 구매 수 가져오기
			 MypageDTO my = dao.selectCountProductSize(orderNo);
			 
			 System.out.println(my.getProductNo());
			 System.out.println(my.getProductSize());
			 System.out.println(my.getQuantity());
			 
			 // prouductNo와 size에 따라 재고 가져오기
			 map.put("productNo", my.getProductNo());
			 map.put("productSize", my.getProductSize());
			 
			 int stock = dao.selectStockbySize(map);
			 
			 // productNo와 size에 따라 재고 + quantity 업데이트
			 stock += my.getQuantity();
			 map.put("stock", stock);
			 dao.updateStock(map);
		 }

	}


	@Override
	public List<MypageDTO> selectlikeList(String id) {
		List<MypageDTO> likeList1 = dao.selectlikeList(id);
		List<MypageDTO> likeList2 = new ArrayList<MypageDTO>();
		for(MypageDTO dto : likeList1) {
			if(dto.getInlike()==1) {
				likeList2.add(dto);				
			}
		}
		return likeList2;
	}

	@Override
	public void deleteLike(String productNo, String id) {
		Map<String, String> map = new HashMap<String, String>();
	 	map.put("productNo", productNo);
	 	map.put("id", id);
	 	
	 	List<MypageDTO> likeList = new ArrayList<MypageDTO>();
	 	
	 	likeList = dao.selectlikeList(id);
	 
	 	for(MypageDTO dto:likeList) {
	 		// 좋아요와 장바구니 모두 1일때 -> 좋아요를 0으로 수정
          if (dto.getProductNo().equals(productNo) && dto.getInlike()==1 && dto.getInbascket()==1) {
       	   dao.updateLike(map);
          }// 좋아요가 1일때, 장바구니가 0일때 -> 삭제 
          else if (dto.getProductNo().equals(productNo) && dto.getInlike()==1) {
       	   dao.deleteLike(map);
          }// 장바구니가 1일때, 좋아요가 0일때 -> 그대로
	 	}
	}

	@Override
	public List<MypageDTO> recentList(String id) {
		return dao.selectRecentList(id);
	}

	@Override
	public MemberDTO selectMemberInfo(String loginId) {
		return dao.selectMemberInfo(loginId);
	}
	
	@Override
    public int insertQuestion(Map<String, Object> questionMap) {
       // TODO Auto-generated method stub
       // reviewNo 가져오기(max(reviewNo))
       int questionNo = dao.selectQuestionNo();
      
       // 해당 상품 넣기
       questionMap.put("questionNo", questionNo);
      
       dao.insertQuestion(questionMap);
      
       return questionNo;
    }

   
   

}