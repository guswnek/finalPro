package com.spring.finalpro.mypage.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.finalpro.common.controller.CommonController;
import com.spring.finalpro.member.dto.MemberAddressDTO;
import com.spring.finalpro.member.dto.MemberDTO;
import com.spring.finalpro.mypage.dto.MypageDTO;
import com.spring.finalpro.mypage.service.MyPageService;
import com.spring.finalpro.product.dto.ProductDTO;
import com.spring.finalpro.product.dto.ProductSizeDTO;
import com.spring.finalpro.product.service.ProductService;

@Controller
public class MyPageControllerImpl implements MyPageController{
	@Autowired
	MyPageService service;
	
	@Autowired
    ProductService pservice;
   
    @Autowired
    CommonController common;
	
	private static final String QUESTION_IMAGE_REPO = "C:\\final_image\\question";
	
	@RequestMapping("/mypage/recepit1.do")
	public ModelAndView recepit1(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		// 배송 정보
		List<MemberAddressDTO> addressList = service.addressList(loginId);

		if(addressList != null && !addressList.isEmpty()) {
			mav = new ModelAndView(viewName);
			mav.addObject("addressList", addressList);
		}else {
			mav.addObject("msg", "noAddress");
		}
		mav.addObject("loginId", loginId);
		return mav;
	}

	public String likeBascketCheck(String productNo, String loginId) {
		List<MypageDTO> likeList = new ArrayList<MypageDTO>();
		System.out.println("받은거 : "+productNo);
		System.out.println("받은거 : "+loginId);
		
        likeList = service.selectlikeList(loginId);
        
        for(MypageDTO dto:likeList) {
        	if (dto.getProductNo().equals(productNo) && dto.getInlike()==1 && dto.getInbascket()==1) {
        		System.out.println("likeBascketCheck : both");
				return "both";
			}else if (dto.getProductNo().equals(productNo) && dto.getInlike()==1) {
				System.out.println("likeBascketCheck : like");
				return "like";
			}else if(dto.getProductNo().equals(productNo) && dto.getInbascket()==1) {
				System.out.println("likeBascketCheck : bascket");
				return "bascket";
			}
        }
        return "none";
	}
	
	@RequestMapping("/mypage/likeCheck.do")
    public ResponseEntity<Map<String, Object>> likeCheck(@RequestBody Map<String, Object> requestData, 
    		HttpServletRequest request) throws JsonProcessingException {
	    String productNo = (String) requestData.get("productNo");
		
        Map<String, Object> response = new HashMap<>();
        
        HttpSession session=request.getSession(false);
        
        
        String loginId=(String) session.getAttribute("loginId");
        
        if(session!=null && loginId!=null) {
            String lbc = likeBascketCheck(productNo, loginId);
        }
        String lbc = likeBascketCheck(productNo, loginId);
        
        if(!lbc.equals("none") && (lbc.equals("both") || lbc.equals("like"))) {
        	response.put("liked", true);
        }else {
        	response.put("liked", false);
        }
        return ResponseEntity.ok(response);
    }

	
	@RequestMapping("/mypage/addLike.do")
    public ResponseEntity<Map<String, Object>> addLike(@RequestBody Map<String, Object> requestData, 
    		HttpServletRequest request) throws JsonProcessingException {
	    String productNo = (String) requestData.get("productNo");
		

        HttpSession session=request.getSession(false);
        String loginId=(String) session.getAttribute("loginId");
        boolean success=false;
        Map<String, Object> responseMap = new HashMap<>();

        if(loginId!=null) {
        	Map<String, Object> addLikeMap=new HashMap<String, Object>();
        	addLikeMap.put("loginId", loginId);
        	addLikeMap.put("productNo", productNo);
        	
        	int i=0;
        	String lbc = likeBascketCheck(productNo, loginId);
        	if(!lbc.equals("none") && lbc.equals("bascket")) {
        		i=service.modLike(addLikeMap);
        	}else {
        		i=service.addLike(addLikeMap);
        	}
        	
        	
        	if(i!=0) {
        		success=true;
        	}
        }else {
        	responseMap.put("logined", "none");
        }
        responseMap.put("success", success);
        

        return ResponseEntity.ok(responseMap);
    }
	
	@Override
    @RequestMapping("/mypage/deleteLike.do")
    public ResponseEntity deleteLike(String productNoList, @RequestBody(required = false) Map<String, Object>  requestData, HttpServletRequest request, HttpServletResponse response) throws Exception {
       HttpSession session = request.getSession();
       String loginId = (String) session.getAttribute("loginId");  
    
       request.setCharacterEncoding("utf-8");
        
       String message;
       ResponseEntity resEnt = null;
       HttpHeaders responseHeaders = new HttpHeaders();
       responseHeaders.add("Content-Type", "text/html;charset=utf-8");
       
       try {
          if(productNoList != null) {
             String[] productNos = productNoList.split(",");
             
             for(String productNo : productNos) {
                System.out.println("productNo : " + productNo);
                service.deleteLike(productNo, loginId);
             }
             message = "<script>";
             message += "alert('상품을 삭제했습니다.');";
             message += "location.href='/finalpro/mypage/like.do';";
             message += "</script>";
             resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
          }else if (requestData!=null) {
        	  Map<String, Object> responseMap = new HashMap<String, Object>();
	          responseMap.put("success", false);
        	 if(loginId != null) {
	             String productNo = (String) requestData.get("productNo");
	             service.deleteLike(productNo, loginId);
	             responseMap.put("success", true);
        	 }else {
        		 responseMap.put("logined", "none");
        	 }
        	 resEnt = ResponseEntity.ok(responseMap);
          }
       } catch (Exception e) {
          message = "<script>";
            message += "alert('상품이 삭제되지 않았습니다. 다시 시도해 주세요.');";
            message += "location.href='/finalpro/mypage/orderList.do';";
            message += "</script>";
            resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.INTERNAL_SERVER_ERROR);
            e.printStackTrace();
        }
       System.out.println(resEnt);
        return resEnt;
    }
   
   @RequestMapping("/mypage/addbasket.do")
   public ResponseEntity addbasket(@RequestBody String bascket, HttpServletRequest request) throws JsonParseException, JsonMappingException, IOException {
	   ObjectMapper objectMapper = new ObjectMapper();
	   Map<String, Object> productMap = objectMapper.readValue(bascket, Map.class);
		
       HttpSession session=request.getSession(false);
       

       String loginId=(String) session.getAttribute("loginId");
	   productMap.put("loginId", loginId);
       
       
       if(session!=null && loginId!=null) {
           String lbc = likeBascketCheck((String) productMap.get("productNo"), loginId);
       }
       String lbc = likeBascketCheck((String) productMap.get("productNo"), loginId);
       
       Map<String, Object> response = new HashMap<>();
       if(lbc.equals("both") || lbc.equals("bascket")) {
    	   System.out.println("이미 있음");
       		response.put("result", "already");
       }else if(lbc.equals("like")){
    	   if(service.modbascket(productMap)==1) {
     			response.put("result", "success");
      			return ResponseEntity.ok(response);
      		}
       }else {
       		if(service.addbascket(productMap)==1) {
       			response.put("result", "success");
       			return ResponseEntity.ok(response);
       		}
       		response.put("result", "fail");
       }
       
       
       return ResponseEntity.ok(response);
   }

	@Override
	@RequestMapping("/mypage/shoppingBasket.do")
	public ModelAndView shoppingBasket(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		String viewName = (String)request.getAttribute("viewName");
		
		List<MypageDTO> cartList = service.cartList(loginId);
		
		for(MypageDTO dto : cartList) {
			System.out.println(dto.getCount());
		}
		
		// 장바구니 선택 수량보다 재고가 많으면 선택 수량을 재고에 맞추기
		for(MypageDTO cart : cartList) {
			int no = cart.getNo();
			String productNo = cart.getProductNo();
			String productSize = cart.getProductSize();
			
			// 장바구니에 담겨있는 제품 수량 가져오기
			int count = service.selectOrderQuantity(no);
			
			// 상품 번호와 사이즈에 따른 재고 수 가져오기
			// 재고보다 장바구니에 담겨있는 수량이 더 많으면 수량에 재고 넣기
			service.updateCount(productNo, productSize, count, no);
		}
		
		cartList = service.cartList(loginId);
		
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("cartList", cartList);
		return mav;
	}


	@Override
	@RequestMapping("/mypage/changeCount.do")
	// count, no 받기 + 아이디 추가로 넣기
	public ModelAndView changeCount(MypageDTO mypage, HttpServletRequest request, HttpServletResponse response)
			throws Exception {
//		System.out.println("no :" + mypage.getNo());
//		System.out.println("count :" +mypage.getCount());
		
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		mypage.setMemberId(loginId);
		
		// + / - 누를때마다 변하는 수량 넣기
		service.changeCount(mypage);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("redirect:/mypage/shoppingBasket.do");
		return mav;
	}


	@Override
	@RequestMapping("/mypage/deletecart.do")
	public ResponseEntity deleteShoppingBasket(String noList, Integer no, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html;charset=utf-8");
		
		try {
			if (noList != null && !noList.isEmpty()) {
	            String[] noStrings = noList.split(",");
	            int[] nos = new int[noStrings.length];
	            for (int i = 0; i < noStrings.length; i++) {
	            	nos[i] = Integer.parseInt(noStrings[i]);
	            }

	            for (int no1 : nos) {
	                service.deleteCart(no1, loginId);
	            }
	        } else if (no != null) {
	            service.deleteCart(no, loginId);
	        }
			
			message = "<script>";
	        message += "alert('상품을 삭제했습니다.');";
	        message += "location.href='/finalpro/mypage/shoppingBasket.do';";
	        message += "</script>";
	        resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.OK);

	    } catch (Exception e) {
	        message = "<script>";
	        message += "alert('상품이 삭제되지 않았습니다. 다시 시도해 주세요.');";
	        message += "location.href='/finalpro/mypage/shoppingBasket.do';";
	        message += "</script>";
	        resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.INTERNAL_SERVER_ERROR);
	        e.printStackTrace();
	    }
		return resEnt;
	}
	
	@Override
	@RequestMapping("/mypage/deleteNonStockProduct.do")
	public ResponseEntity deleteNonStockProduct(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		String message;
	    ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html;charset=utf-8");
		
		try {
			// count가 0인 productNo 리스트 가져오기
			List<MypageDTO> productNoList = service.selectNoCountProduct(loginId);
			
			// productNo와 아이디를 통해서
			// 좋아요가 1이면 장바구니를 0으로
			// 좋아요가 0이면 데이터 삭제
			for(MypageDTO dto : productNoList) {
				service.deleteCart(dto.getNo(), loginId);
			}
			message = "<script>";
	        message += "alert('품절된 상품을 모두 삭제했습니다.');";
	        message += "location.href='/finalpro/mypage/shoppingBasket.do';";
	        message += "</script>";
	        resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
			
	    } catch (Exception e) {
	        message = "<script>";
	        message += "alert('품절된 상품이 삭제되지 않았습니다. 다시 시도해 주세요.');";
	        message += "location.href='/finalpro/mypage/shoppingBasket.do';";
	        message += "</script>";
	        resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.INTERNAL_SERVER_ERROR);
	        e.printStackTrace();
	    }
	    return resEnt;
	}

	@Override
	@RequestMapping("/mypage/recepit.do")
	public ModelAndView recepit(String noList, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		ModelAndView mav = new ModelAndView();
		if (noList != null && !noList.isEmpty()) {
			String viewName = (String) request.getAttribute("viewName");
	        mav = new ModelAndView(viewName);
	        
	        // 배송 정보 출력 리스트 가져오기(id 당 3개의 배송 주소 저장)
	        List<MemberAddressDTO> addressList = service.addressList(loginId);
	        
	        if(addressList != null && !addressList.isEmpty()) {
				mav = new ModelAndView(viewName);
				
				// 장바구니에서 선택된 상품들의 주문서 리스트
		        List<MypageDTO> recepitList = new ArrayList<MypageDTO>();
		        
		        String[] noStrings = noList.split(",");
	            int[] nos = new int[noStrings.length];
	            for (int i = 0; i < noStrings.length; i++) {
	            	nos[i] = Integer.parseInt(noStrings[i]);
	            }

	            for (int no : nos) {
	            	MypageDTO dto = service.recepitList(no);
	 	            recepitList.add(dto);
	            }
	            
	            int totalPrice = 0;
		        for (MypageDTO my : recepitList) {
		            String[] number = my.getOrderPrice().split(",");
		            String orderPrice = "";
		            for (String str : number) {
		                orderPrice += str;
		            }
		            totalPrice += Integer.parseInt(orderPrice);
		        }
		        
		        mav.addObject("recepitList", recepitList);
		        mav.addObject("addressList", addressList);
		        mav.addObject("totalPrice", totalPrice);
		        mav.addObject("noList", noList);
			}else {
				mav.addObject("msg", "noAddress");
			}
			mav.addObject("loginId", loginId);
	        
		} else {
	        mav.setViewName("redirect:/mypage/shoppingBasket.do");
	        mav.addObject("msg", "notProduct");
	    }
	    return mav;
	}

@Override
@RequestMapping("/mypage/insertOrderList.do")
public ResponseEntity insertOrderList(MypageDTO mypage, int[] noList, String[] productInfoList,
		HttpServletRequest request, HttpServletResponse response) throws Exception {

	HttpSession session = request.getSession();
	String loginId = (String) session.getAttribute("loginId");
	
	String message;
    ResponseEntity resEnt = null;
	HttpHeaders responseHeaders = new HttpHeaders();
	responseHeaders.add("Content-Type", "text/html;charset=utf-8");
	
	try {
		// recepit에서 전달
		if(noList != null && noList.length != 0) {
            
            List<MypageDTO> myList = new ArrayList<MypageDTO>();
			for(int no : noList) {
				MypageDTO buyProductInfo = service.recepitList(no);
				buyProductInfo.setMemberId(loginId);
				buyProductInfo.setDeliveryRequest(mypage.getDeliveryRequest());
				buyProductInfo.setReceiverName(mypage.getReceiverName());
				buyProductInfo.setReceiverPhone(mypage.getReceiverPhone());
				buyProductInfo.setReceiverAdress(mypage.getReceiverAdress());
				buyProductInfo.setPayment(mypage.getPayment());
				buyProductInfo.setPaymentBank(mypage.getPaymentBank());
				buyProductInfo.setPaymentCard(mypage.getPaymentCard());
				buyProductInfo.setPaymentMonth(mypage.getPaymentMonth());
				
				// 구매한 제품 구매목록에 추가
				service.insertOrderList(buyProductInfo);
				
				// 재고 - 구매한 수량빼기
				service.deleteCount(buyProductInfo.getCount(), buyProductInfo.getProductNo(), buyProductInfo.getProductSize());
				
				// 구매한 목록 장바구니에서 삭제
				service.deleteCart(no, loginId);
			}
		}// recepit1에서 전달
	    else if(productInfoList != null && productInfoList.length != 0) {
	        
	        String[] product = productInfoList[0].split(",");
	        if(product.length == 1) {
	           mypage.setMemberId(loginId);
	           mypage.setProductNo(productInfoList[0]);
	           mypage.setProductSize(productInfoList[1]);
	           mypage.setCount(Integer.parseInt(productInfoList[2]));
	           mypage.setOrderPrice(productInfoList[3]);
	           
	           service.insertOrderList(mypage);
	           service.deleteCount(mypage.getCount(), mypage.getProductNo(), mypage.getProductSize());
	        }else {
	           for(String productInfo : productInfoList) {
	              String[] product1 = productInfo.split(",");
	              mypage.setMemberId(loginId);
	              mypage.setProductNo(product1[0]);
	              mypage.setProductSize(product1[1]);
	              mypage.setCount(Integer.parseInt(product1[2])); 
	              mypage.setOrderPrice(product1[3]);
	              
	              service.insertOrderList(mypage);
	              service.deleteCount(mypage.getCount(), mypage.getProductNo(), mypage.getProductSize());
	           }
	        }
	              
	     }
		message = "<script>";
        message += "alert('상품을 구매했습니다.');";
        message += "location.href='/finalpro/mypage/orderList.do';";
        message += "</script>";
        resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
		
    } catch (Exception e) {
        message = "<script>";
        message += "alert('상품이 구매되지 않았습니다. 다시 시도해 주세요.');";
        message += "location.href='/finalpro/mypage/shoppingBasket.do';";
        message += "</script>";
        resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.INTERNAL_SERVER_ERROR);
        e.printStackTrace();
    }
    return resEnt;
}

@Override
@RequestMapping("/mypage/orderList.do")
public ModelAndView orderList(MypageDTO mypage, String fromDate, String toDate, HttpServletRequest request, HttpServletResponse response) {
	HttpSession session = request.getSession();
	String loginId = (String) session.getAttribute("loginId");
	
	String viewName = (String) request.getAttribute("viewName");
	mypage.setMemberId(loginId);
	List<MypageDTO> orderList = service.orderList(mypage, fromDate, toDate);		
	ModelAndView mav = new ModelAndView(viewName);
	mav.addObject("member",loginId);
	
	// 리뷰 테이블에 리뷰가 있는 주문번호 리스트로 출력
	List<MypageDTO> orderNoList = service.selectReviewOrderNos();
	
	for(MypageDTO my : orderList) {
		for(MypageDTO orderNo : orderNoList) {
			// 주문 번호와 리뷰에 등록된 주문 번호가 같으면 리뷰 작성 완료
			// checkReview가 1이면 리뷰 작성 완료
			// checkReview가 0이면 리뷰 작성 x
			if(my.getOrderNo() == orderNo.getOrderNo()) {
				my.setCheckReview(1);
			}
		}
	}
	
	mav.addObject("orderList", orderList);
	mav.addObject("orderNoList", orderNoList);
	
	MemberDTO memberInfo = service.selectMemberInfo(loginId);
	mav.addObject("memberInfo", memberInfo);
	
	return mav;
}

@Override
@RequestMapping("/popup/orderInfo.do")
public ModelAndView orderInfoPopup(int orderNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
	String viewName = (String) request.getAttribute("viewName");
	ModelAndView mav = new ModelAndView(viewName);
	
	// 배송 정보에 데이터 받기
	MypageDTO mypage = service.delivery_pay_info(orderNo);
	mav.addObject("mypage", mypage);
	
	return mav;
}

@Override
@RequestMapping("/mypage/changeDeliveryStatus.do")
public ResponseEntity changeDeliveryStatus(String deliveryStatus, int orderNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
    request.setCharacterEncoding("utf-8");
    
    String message;
    ResponseEntity resEnt = null;
	HttpHeaders responseHeaders = new HttpHeaders();
	responseHeaders.add("Content-Type", "text/html;charset=utf-8");
	System.out.println(deliveryStatus);
	System.out.println(orderNo);
    
    try {
        service.updateDeliveryStatus(deliveryStatus, orderNo);
        
        message = "<script>";
        message += "alert('"+ deliveryStatus +"신청 되었습니다.');";
        message += "location.href='/finalpro/mypage/orderList.do?deliveryStatus=" + deliveryStatus +"';";
        message += "</script>";
        resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
        
    } catch (Exception e) {
        message = "<script>";
        message += "alert('"+ deliveryStatus +" 신청되지 않았습니다. 다시 시도해 주세요');";
        message += "location.href='/finalpro/mypage/orderList.do';";
        message += "</script>";
        resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.INTERNAL_SERVER_ERROR);
        e.printStackTrace();
    }
    return resEnt;
}

@Override
@RequestMapping("/mypage/like.do")
public ModelAndView like(HttpServletRequest request, HttpServletResponse response) {
	HttpSession session = request.getSession();
	String loginId = (String) session.getAttribute("loginId");
	
	String viewName = (String)request.getAttribute("viewName");
	
	List<MypageDTO> likeList = new ArrayList<MypageDTO>();
	likeList = service.selectlikeList(loginId);
	System.out.println("여기서 문제");
	
	ModelAndView mav = new ModelAndView(viewName);
	mav.addObject("likeList", likeList);
	
	MemberDTO memberInfo = service.selectMemberInfo(loginId);
	mav.addObject("memberInfo", memberInfo);
	return mav;
}

@Override
@RequestMapping("/mypage/recentProduct.do")
public ModelAndView recentProduct(HttpServletRequest request, HttpServletResponse response) {
	HttpSession session = request.getSession();
	String loginId = (String) session.getAttribute("loginId");
	
	String viewName = (String)request.getAttribute("viewName");
	ModelAndView mav = new ModelAndView(viewName);
	
	List<MypageDTO> recentList1 = service.recentList(loginId);
	List<MypageDTO> recentList = new ArrayList<MypageDTO>();
	
	if(recentList1.size() > 10) {
		for(int i = 0; i < 10; i++) {
			recentList.add(recentList1.get(i));
		}
		mav.addObject("recentList", recentList);
		
		MemberDTO memberInfo = service.selectMemberInfo(loginId);
		mav.addObject("memberInfo", memberInfo);

	}else {
		mav.addObject("recentList", recentList1);
		
		MemberDTO memberInfo = service.selectMemberInfo(loginId);
		mav.addObject("memberInfo", memberInfo);
	}
	return mav;
}


@RequestMapping("/mypage/purchaseOrderList.do")
public ResponseEntity purchaseOrderList(@RequestBody String subcategory, MypageDTO mypage, String fromDate, String toDate, HttpServletRequest request) {
   ResponseEntity resEnt = null;
   HttpSession session = request.getSession();
   String loginId = (String) session.getAttribute("loginId");
   
   mypage.setMemberId(loginId);
   List<MypageDTO> orderList = service.orderList(mypage, fromDate, toDate);
   List<MypageDTO> correctOrderList = new ArrayList<MypageDTO>();
   
   for(MypageDTO myorder:orderList) {
      if(myorder!= null && myorder.getDeliveryStatus().equals("구매확정") &&  myorder.getSubcategory().equals(subcategory) ) {
    	 correctOrderList.add(myorder);
      }
   }
   
   Map<String, Object> responseMap=new HashMap<String, Object>();
   responseMap.put("data", correctOrderList);
     
     return ResponseEntity.ok(responseMap);
}

@RequestMapping("/popup/question_form.do")
public ModelAndView question_form(@RequestParam String productNo, HttpServletRequest request) throws Exception {
   String viewName = (String) request.getAttribute("viewName");
   ModelAndView mav = new ModelAndView(viewName);
   
   // 배송 정보에 데이터 받기
   ProductDTO questionProduct = pservice.detailProduct(productNo);
   mav.addObject("questionProduct", questionProduct);
   
   List<ProductSizeDTO> sizeList=pservice.listSizes(productNo);
   List<ProductSizeDTO> correctSizeList=new ArrayList<ProductSizeDTO>();
   for(ProductSizeDTO size:sizeList) {
      if(size.getProductNo().equals(questionProduct.getProductNo())) {
         correctSizeList.add(size);
      }
   }
    mav.addObject("sizeList", correctSizeList);
   
   return mav;
}

@RequestMapping(value = "/mypage/insertQuestion.do", method=RequestMethod.POST)
public ResponseEntity insertQuestion(MultipartHttpServletRequest mRequest, HttpServletResponse response) throws Exception {
   
   HttpSession session = mRequest.getSession();
   String loginId = (String) session.getAttribute("loginId");

   
   // 받아온 값 넣어주기
   mRequest.setCharacterEncoding("utf-8");
   Map<String, Object> questionMap = new HashMap<String, Object>();
   Enumeration<String> enu = mRequest.getParameterNames();
   
   while(enu.hasMoreElements()) {
      String name = enu.nextElement();
      String value = mRequest.getParameter(name);
      questionMap.put(name, value);
      System.out.println(name + ":" +value);
   }
   
   String imageFileName = common.upload(mRequest, "question");
   questionMap.put("imageFileName", imageFileName);
   questionMap.put("memberId", loginId);
   
   String message;
   ResponseEntity resEnt = null;
   HttpHeaders responseHeaders = new HttpHeaders();
   responseHeaders.add("Content-Type", "text/html;charset=utf-8");      
   
   try {
      int questionNo = service.insertQuestion(questionMap);
      
      if(imageFileName != null && imageFileName.length() != 0) {
         File srcFile = new File(QUESTION_IMAGE_REPO + "\\temp\\" + imageFileName);
         File destDir = new File(QUESTION_IMAGE_REPO + "\\" + questionNo);
         FileUtils.moveToDirectory(srcFile, destDir, true);
      }
   
      message = "<script>";
      message += "alert('질문이 접수되었습니다.');";
      message += "window.close();"; // 현재 팝업창을 닫는 JavaScript 코드
      message += "</script>";
      resEnt = new ResponseEntity<>(message, responseHeaders, HttpStatus.OK);
   }catch(Exception e) {
      File srcFile = new File(QUESTION_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
      srcFile.delete();
      
      message = "<script>";
      message += "alert('오류가 발생했습니다. 다시 등록해 주세요');";
      message += "</script>";
      resEnt = new ResponseEntity<>(message, responseHeaders, HttpStatus.INTERNAL_SERVER_ERROR);
      e.printStackTrace();
   }
   return resEnt;
}

	
}
