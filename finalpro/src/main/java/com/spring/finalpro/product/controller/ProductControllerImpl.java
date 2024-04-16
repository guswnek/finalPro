package com.spring.finalpro.product.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import com.spring.finalpro.mypage.dto.MypageDTO;
import com.spring.finalpro.mypage.service.MyPageService;
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
import com.spring.finalpro.product.service.ProductService;

@Controller

public class ProductControllerImpl implements ProductController {
	@Autowired
	ProductService service;
	@Autowired
	MyPageService myService;
	
	
	private static final String REVIEW_IMAGE_REPO = "C:\\final_image\\review";


	@Override
	@RequestMapping("/product/detailProduct.do")
	public ModelAndView detailProduct(@RequestParam("productNo") String productNo, HttpServletRequest request, 
	        HttpServletResponse response) throws Exception {
	    // TODO Auto-generated method stub
	    String viewName = (String) request.getAttribute("viewName");
	        ModelAndView mav = new ModelAndView(viewName);
	        
	        ObjectMapper mapper = new ObjectMapper();
	        
	        HttpSession session=request.getSession(false);
	        
	        String loginId=null;
	        if(session!=null) {
	        loginId=(String) session.getAttribute("loginId");     
	        }
	        
	        Map<String, Object> params = new HashMap<String, Object>();
	        params.put("productNo", productNo);
	        params.put("loginId", loginId);
	        service.addView(params);

	        ProductDTO dto=service.detailProduct(productNo);
	        mav.addObject("dto", dto);
	        
	        String targetProductNo=productNo;
	        if(dto.getParentProductNo()!=null && !dto.getParentProductNo().equals("null")) {
	               targetProductNo=dto.getParentProductNo();
	            }
	            
	        List<ProductDTO> productList=service.listProducts(targetProductNo);
	        mav.addObject("productList", productList);      
	        String productListJson = mapper.writeValueAsString(productList);
	        mav.addObject("productListJson", productListJson);
	        

	        List<ProductImageDTO> imageList=service.listImages(targetProductNo);
	        mav.addObject("imageList", imageList);
	        
	        List<ProductSizeDTO> sizeList=service.listSizes(targetProductNo);
	        mav.addObject("sizeList", sizeList);
	        String sizeListJson = mapper.writeValueAsString(sizeList);
	        mav.addObject("sizeListJson", sizeListJson);
	        
	        String tags=service.listTags(productNo);
	        List<String> tagList=new ArrayList<String>();
	        if(tags!=null) {
	            String[] tagsArray = tags.split(",");
	            tagList = Arrays.asList(tagsArray);
	        }
	        mav.addObject("tagList", tagList); 

	        int infoImageNumber=service.getInfoImageNumber(productNo);
	        mav.addObject("infoImageNumber", infoImageNumber); 
	        
	        List<ReviewDTO> reviewList=service.listReviews(targetProductNo);
	        mav.addObject("reviewList", reviewList);
	        
	        if(reviewList!=null && reviewList.size()!=0) {
	        Set<Integer> reviewNoSet = reviewList.stream().map(ReviewDTO::getReviewNo).collect(Collectors.toSet());
	        List<Integer> reviewNoList = new ArrayList(reviewNoSet);
	        List<ReviewReplyDTO> replyList=service.listReplies(reviewNoList ,null);
	        
	        mav.addObject("replyList", replyList);
	        }
	        
	        List<QuestionDTO> questionList=service.listQuestions(targetProductNo);
	        mav.addObject("questionList", questionList);
	        
	        if(questionList!=null && questionList.size()!=0) {
	        Set<Integer> questionNoSet = questionList.stream().map(QuestionDTO::getQuestionNo).collect(Collectors.toSet());
	        List<Integer> questionNoList = new ArrayList(questionNoSet);
	        List<AnswerDTO> answerList=service.listAnswers(questionNoList);
	        mav.addObject("answerList", answerList);
	        }
	        
	        int oneMonthSalesTotal=service.getSalesTotal(productNo, 1, null);
	        mav.addObject("oneMonthSalesTotal", oneMonthSalesTotal);

	        int oneYearSalesTotal=service.getSalesTotal(productNo, 12, null);
	        mav.addObject("oneYearSalesTotal", oneYearSalesTotal);

	        int oneYearSalesTotalMale=service.getSalesTotal(productNo, 12, "male");
	        mav.addObject("oneYearSalesTotalMale", oneYearSalesTotalMale);
	        
	        List<Integer> agePurchaseList=service.listAgePurchase(productNo);
	        mav.addObject("agePurchaseList", agePurchaseList);
	        
	        List<Integer> genderViewList=service.getViewCnt(productNo);
	        mav.addObject("genderViewList", genderViewList);
	        
	        List<Integer> ageViewList=service.listAgeView(productNo);
	        mav.addObject("ageViewList", ageViewList);
	        return mav;
		}
	
 
	   @RequestMapping(value = "/product/loadAllComments.do", method = RequestMethod.POST)
	   public ResponseEntity<List<ReviewReplyDTO>> loadAllComments(@RequestBody Map<String, Object> payload) {
	      Integer reviewNo = (Integer) payload.get("reviewNo");
	      List<Integer> reviewNoList = null;
	      List<ReviewReplyDTO> replyList=service.listReplies(reviewNoList, reviewNo);
	       return new ResponseEntity<>(replyList, HttpStatus.OK);
	   }
	   
	   @RequestMapping(value = "/product/loadChildReply.do", method = RequestMethod.POST)
	   public ResponseEntity<List<ReviewReplyDTO>> loadChildReply(@RequestBody Map<String, Object> payload) {
	      Integer parentReplyNo = (Integer) payload.get("parentReplyNo");
	      List<ReviewReplyDTO> replyList=service.listChildReplies(parentReplyNo);
	      return new ResponseEntity<>(replyList, HttpStatus.OK);
	   }
	   
	   @RequestMapping(value = "/product/insertReply.do", method=RequestMethod.POST)
	   public ResponseEntity insertReply(HttpServletRequest request, HttpServletResponse response) throws Exception {
	      
	      HttpSession session = request.getSession();
	      String loginId = (String) session.getAttribute("loginId");
	      
	      // 받아온 값 넣어주기
	      request.setCharacterEncoding("utf-8");
	      Map<String, Object> replyMap = new HashMap<String, Object>();
	      Enumeration<String> enu = request.getParameterNames();
	      
	      while(enu.hasMoreElements()) {
	         String name = enu.nextElement();
	         String value = request.getParameter(name);
	         replyMap.put(name, value);
	         System.out.println(name + ":" +value);
	      }
	      
	      replyMap.put("memberId", loginId);
	      
	      String message="";
	      ResponseEntity resEnt = null;
	      HttpHeaders responseHeaders = new HttpHeaders();
	      responseHeaders.add("Content-Type", "text/html;charset=utf-8");      
	      
	      int replyNo = service.insertReply(replyMap);
	      
	      if(replyNo>=1) {
	         message = "<script>";
	         message += "alert('댓글이 등록되었습니다.');";
	         message += "window.location.href=document.referrer;";
	         message += "</script>";
	         resEnt = new ResponseEntity<>(message, responseHeaders, HttpStatus.OK);
	      }else {
	         message = "<script>";
	         message += "alert('오류가 발생했습니다. 다시 등록해 주세요');";
	         message += "window.location.href=document.referrer;";
	         message += "</script>";
	         resEnt = new ResponseEntity<>(message, responseHeaders, HttpStatus.INTERNAL_SERVER_ERROR);
	      }
	      
	      return resEnt;
	   }
	
	@Override
	public ModelAndView orderForm() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void addshoppingBasket() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addlike() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ModelAndView listBrandProduct() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@RequestMapping("/product/reviewForm.do")
	public ModelAndView reviewForm(ReviewDTO review, HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println(review.getProductSize());
		System.out.println(review.getProductNo());
		
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		String viewName = (String) request.getAttribute("viewName");
		String productNo = review.getProductNo();
		int orderNo = review.getOrderNo();
		String productSize = review.getProductSize();
		ModelAndView mav = new ModelAndView(viewName);
		
		// 상품 정보(브랜드, 상품명, 사진1)
		ReviewDTO re = service.productInfo(productNo);
		
		// 회원 정보(성별, 키, 몸무게)
		review = service.memberInfo(loginId);
		review.setOrderNo(orderNo);
		review.setProductNo(productNo);
		review.setProductSize(productSize);
		review.setBrand(re.getBrand());
		review.setName(re.getName());
		review.setProductImageFileName(re.getImageFileName());
		
		System.out.println(review.getGender());
		
		mav.addObject("review", review);
		return mav;
	}
	
	

	@Override
	@RequestMapping(value = "/product/insertReview.do", method=RequestMethod.POST)
	public ResponseEntity insertReview(MultipartHttpServletRequest mRequest, HttpServletResponse response) throws Exception {

		HttpSession session = mRequest.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		// 받아온 값 넣어주기
		mRequest.setCharacterEncoding("utf-8");
		Map<String, Object> reviewMap = new HashMap<String, Object>();
		Enumeration<String> enu = mRequest.getParameterNames();
		
		while(enu.hasMoreElements()) {
			String name = enu.nextElement();
			String value = mRequest.getParameter(name);
			reviewMap.put(name, value);
			System.out.println(name + ":" +value);
		}
		
		int orderNo = Integer.parseInt(mRequest.getParameter("orderNo"));
		
		String imageFileName = upload(mRequest);
		reviewMap.put("imageFileName", imageFileName);
		reviewMap.put("memberId", loginId);
		
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html;charset=utf-8");		
		
		try {
			int reviewNo = service.insertReview(reviewMap);
			
			if(imageFileName != null && imageFileName.length() != 0) {
				File srcFile = new File(REVIEW_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
				File destDir = new File(REVIEW_IMAGE_REPO + "\\" + reviewNo);
				FileUtils.moveToDirectory(srcFile, destDir, true);
			}
		
			message = "<script>";
			message += "alert('리뷰가 등록되었습니다.');";
			message += "location.href='/finalpro/mypage/orderList.do';";
			message += "</script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}catch(Exception e) {
			File srcFile = new File(REVIEW_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
			srcFile.delete();
			
			message = "<script>";
			message += "alert('오류가 발생했습니다. 다시 등록해 주세요');";
			message += "location.href='/finalpro/mypage/orderList.do';";
			message += "</script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}
	
	private String upload(MultipartHttpServletRequest mRequest) throws IOException {
		String imageFileName = null;
		Map<String, String> reviewMap = new HashMap<String, String>();
		Iterator<String> fileNames = mRequest.getFileNames();
		
		while(fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = mRequest.getFile(fileName);
			imageFileName = mFile.getOriginalFilename();
			File file = new File(REVIEW_IMAGE_REPO + "\\" + fileName);
			
			if(mFile.getSize()!=0) {
				if(!file.exists()) {
					if(file.getParentFile().mkdirs()) {
						file.createNewFile();
					}
				}
				mFile.transferTo(new File(REVIEW_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName));
			}
		}
		return imageFileName;
	}

	@Override
	@RequestMapping("/product/modifyReviewForm.do")
	public ModelAndView modifyReviewForm(int orderNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		System.out.println(orderNo);
		ReviewDTO review = service.selectReviewList(orderNo);
		ReviewDTO review1 = service.memberInfo(loginId);
		review.setGender(review1.getGender());
		review.setHeight(review1.getHeight());
		review.setWeight(review1.getWeight());
		mav.addObject("review", review);
		return mav;
	}

	@Override
	@RequestMapping("/product/modifyReview.do")
	public ResponseEntity updateReview(MultipartHttpServletRequest mRequest, HttpServletResponse response) throws Exception {
		HttpSession session = mRequest.getSession();
		String loginId = (String) session.getAttribute("loginId");
		
		mRequest.setCharacterEncoding("utf-8");
		Map<String, Object> reviewMap = new HashMap<String, Object>();
		Enumeration<String> enu = mRequest.getParameterNames();
		
		while(enu.hasMoreElements()) {
			String name = enu.nextElement();
			String value = mRequest.getParameter(name);
			reviewMap.put(name, value);
			System.out.println(name + ":" +value);
		}
		
		int orderNo = Integer.parseInt(mRequest.getParameter("orderNo"));
		int reviewNo = Integer.parseInt(mRequest.getParameter("reviewNo"));
		
		String imageFileName = upload(mRequest);
		reviewMap.put("imageFileName", imageFileName);
		reviewMap.put("memberId", loginId);
		System.out.println(imageFileName);
		
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html;charset=utf-8");		
		
		try {
			service.updateReview(reviewMap);
			
			File destDir = new File(REVIEW_IMAGE_REPO + "\\" + reviewNo);
			FileUtils.deleteDirectory(destDir);
			
			if(imageFileName != null && imageFileName.length() != 0) {
				File srcFile = new File(REVIEW_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
				File destDir1 = new File(REVIEW_IMAGE_REPO + "\\" + reviewNo);
				FileUtils.moveToDirectory(srcFile, destDir1, true);
			}
			message = "<script>";
			message += "alert('리뷰가 수정되었습니다.');";
			message += "location.href='/finalpro/mypage/orderList.do';";
			message += "</script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}catch(Exception e) {
			File srcFile = new File(REVIEW_IMAGE_REPO + "\\" + "temp" + "\\" + imageFileName);
			srcFile.delete();
			message = "<script>";
			message += "alert('오류가 발생했습니다. 다시 수정해 주세요');";
			message += "location.href='/finalpro/mypage/orderList.do';";
			message += "</script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}

	@Override
	@RequestMapping("/product/deleteReview.do")
	public ResponseEntity deleteReview(int orderNo, HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		
		String message;
	    ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html;charset=utf-8");
		
		
		try {
			ReviewDTO dto = service.deletReview(orderNo);
			int reviewNo = dto.getReviewNo();
			
			File destDir = new File(REVIEW_IMAGE_REPO + "\\" + reviewNo);
			FileUtils.deleteDirectory(destDir);
			
			message = "<script>";
	        message += "alert('리뷰를 삭제했습니다.');";
	        message += "location.href='/finalpro/mypage/orderList.do';";
	        message += "</script>";
	        resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.OK);
			
	    } catch (Exception e) {
	        message = "<script>";
	        message += "alert('리뷰가 삭제되지 않았습니다. 다시 시도해 주세요.');";
	        message += "location.href='/finalpro/mypage/orderList.do';";
	        message += "</script>";
	        resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.INTERNAL_SERVER_ERROR);
	        e.printStackTrace();
	    }
	    return resEnt;
	}


	@Override
	public void insertreply() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public ResponseEntity updateReply() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity deleteReply() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity insertQNA() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity updateQNA() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ResponseEntity deleteQNA() {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	@RequestMapping("/product/searchList.do")
	public ModelAndView searchList(String keyword, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);

		System.out.println(keyword);

		mav.addObject("keyword", keyword);

		// 브랜드 리스트 출력
		System.out.println(keyword);
		List<SearchDTO> searchBrandList = service.searchBrand(keyword);

		mav.addObject("searchBrandList", searchBrandList);

		keyword = changeKeyword(keyword);

		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);

		// 상품 출력
		List<SearchDTO> searchProductList = service.searchProductList(map);
		mav.addObject("searchProductList", searchProductList);

		// 스냅 출력
		List<SearchDTO> searchSnapList = service.searchSnapList(map);
		if(searchSnapList != null && !searchSnapList.isEmpty()) {
			mav.addObject("searchSnapList", searchSnapList);
		}

		// 매거진 출력
		List<SearchDTO> searchMagazineList = service.searchMagazineList(map);
		if(searchMagazineList != null && !searchMagazineList.isEmpty()) {
			mav.addObject("searchMagazineList", searchMagazineList);
		}
		return mav;
	}

	@Override
	@RequestMapping("/product/searchDetailList.do")
	public ModelAndView searchDetailList(String keyword, String category, String orderBy, HttpServletRequest request,
			HttpServletResponse response) throws Exception {

		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		mav.addObject("keyword", keyword);

		// 한국어 영어로 변경
		keyword = changeKeyword(keyword);

		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		if (orderBy != null) {
			map.put("orderBy", orderBy);
		} else {
			map.put("orderBy", "");
		}

		if (category.equals("product")) {
			List<SearchDTO> searchProductList = service.searchProductList(map);
			mav.addObject("searchProductList", searchProductList);
		} else if (category.equals("snap")) {
			// 스냅 출력
			List<SearchDTO> searchSnapList = service.searchSnapList(map);
			mav.addObject("searchSnapList", searchSnapList);
		} else if (category.equals("magazine")) {
			List<SearchDTO> searchMagazineList = service.searchMagazineList(map);
			mav.addObject("searchMagazineList", searchMagazineList);
		}

		mav.addObject("category", category);

		return mav;
	}


	private String changeKeyword(String keyword) {
		if(keyword.equals("스트릿") || keyword.equals("스트릿 스냅")) {
			keyword = "s_";
		}else if(keyword.equals("브랜드") || keyword.equals("브랜드 스냅")) {
			keyword = "b_";
		}else if(keyword.equals("상의")) {
			keyword = "top";
		}else if(keyword.equals("맨투맨")) {
			keyword = "mtom";
		}else if(keyword.equals("후드티") || keyword.equals("후디")) {
			keyword = "hood";
		}else if(keyword.equals("티셔츠")) {
			keyword = "t-shirt";
		}else if(keyword.equals("니트")) {
			keyword = "knit";
		}else if(keyword.equals("셔츠")) {
			keyword = "shirt";
		}else if(keyword.equals("아우터")) {
			keyword = "outer";
		}else if(keyword.equals("코트")) {
			keyword = "coat";
		}else if(keyword.equals("패딩")) {
			keyword = "heavyOuter";
		}else if(keyword.equals("가디건")) {
			keyword = "cardigan";
		}else if(keyword.equals("후리스")) {
			keyword = "fleece";
		}else if(keyword.equals("자켓")) {
			keyword = "jumper";
		}else if(keyword.equals("하의")) {
			keyword = "pants";
		}else if(keyword.equals("청바지")) {
			keyword = "jeans";
		}else if(keyword.equals("슬랙스")) {
			keyword = "slacks";
		}else if(keyword.equals("치마")) {
			keyword = "skirt";
		}else if(keyword.equals("츄리닝")) {
			keyword = "trackPants";
		}else if(keyword.equals("반바지")) {
			keyword = "shorts";
		}else if(keyword.equals("신발")) {
			keyword = "shoes";
		}else if(keyword.equals("구두")) {
			keyword = "dressShoes";
		}else if(keyword.equals("슬리퍼")) {
			keyword = "slippers";
		}else if(keyword.equals("스니커즈")) {
			keyword = "sneakers";
		}else if(keyword.equals("운동화")) {
			keyword = "athleticShoes";
		}else if(keyword.equals("룩북")) {
			keyword = "lookbook";
		}else if(keyword.equals("화보")) {
			keyword = "pictorial";
		}else if(keyword.equals("")) {
			keyword = "";
		}
		return keyword;
	}
	
	
	
	// 유진 상품리스트
	
	
	@Override
	@RequestMapping("/product/listProducts.do")
	public ModelAndView listProducts(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);

	// subCategory url    ó  
		String subCategory = request.getParameter("subCategory");
	      if( subCategory == null || subCategory.isEmpty()) {
	         mav.addObject("script", "<script>alert('상품 종류가 선택되지 않았습니다.');</script>");
	         return mav;
	      }
		
		

		
		
	//                   (   ڿ            ݴ     ڷ   ٲٱ )
		String pMin = request.getParameter("priceMin");
		String pMax = request.getParameter("priceMax");
		int priceMin = 0;
		int priceMax = 0;
 		if(pMin != null && pMin!= "") {
 			priceMin = Integer.parseInt(pMin);
 		}
 		if(pMax != null && pMax!="") {
 			priceMax = Integer.parseInt(pMax);
 		}
		
	// align bar(    )    ó  
 		String align = "";
 		if(request.getParameter("align")=="") {
 			align = request.getParameter("align");
 		}else {
 			align = request.getParameter("align");
 		}
 		
	//        ó  (int       ȯ)
		String topMin2 = request.getParameter("topMin");
		int topMin = 0;
		if(topMin2!=null && topMin2!="") {
			topMin = Integer.parseInt(topMin2);
		}
		String topMax2 = request.getParameter("topMax");
		int topMax = 0;
		if(topMax2!=null && topMax2!="") {
			topMax = Integer.parseInt(topMax2);
		}
		
		String shoulderMin2 = request.getParameter("shoulderMin");
		int shoulderMin = 0;
		if(shoulderMin2!=null && shoulderMin2!="") {
			shoulderMin = Integer.parseInt(shoulderMin2);
		}
		String shoulderMax2 = request.getParameter("shoulderMax");
		int shoulderMax = 0;
		if(shoulderMax2!=null && shoulderMax2!="") {
			shoulderMax = Integer.parseInt(shoulderMax2);
		}
		
		String chestMin2 = request.getParameter("chestMin");
		int chestMin = 0;
		if(chestMin2!=null && chestMin2!="") {
			chestMin = Integer.parseInt(chestMin2);
		}
		String chestMax2 = request.getParameter("chestMax");
		int chestMax = 0;
		if(chestMax2!=null && chestMax2!="") {
			chestMax = Integer.parseInt(chestMax2);
		}
		
		String sleeveMin2 = request.getParameter("sleeveMin");
		int sleeveMin = 0;
		if(sleeveMin2!=null && sleeveMin2!="") {
			sleeveMin = Integer.parseInt(sleeveMin2);
		}
		String sleeveMax2 = request.getParameter("sleeveMax");
		int sleeveMax = 0;
		if(sleeveMax2!=null && sleeveMax2!="") {
			sleeveMax = Integer.parseInt(sleeveMax2);
		}
		
		String waistMin2 = request.getParameter("waistMin");
		int waistMin = 0;
		if(waistMin2!=null && waistMin2!="") {
			waistMin = Integer.parseInt(waistMin2);
		}
		String waistMax2 = request.getParameter("waistMax");
		int waistMax = 0;
		if(waistMax2!=null && waistMax2!="") {
			waistMax = Integer.parseInt(waistMax2);
		}
		
		String hipMin2 = request.getParameter("hipMin");
		int hipMin = 0;
		if(hipMin2!=null && hipMin2!="") {
			hipMin = Integer.parseInt(hipMin2);
		}
		String hipMax2 = request.getParameter("hipMax");
		int hipMax = 0;
		if(hipMax2!=null && hipMax2!="") {
			hipMax = Integer.parseInt(hipMax2);
		}
		
		String thighMin2 = request.getParameter("thighMin");
		int thighMin = 0;
		if(thighMin2!=null && thighMin2!="") {
			thighMin = Integer.parseInt(thighMin2);
		}
		String thighMax2 = request.getParameter("thighMax");
		int thighMax = 0;
		if(thighMax2!=null && thighMax2!="") {
			thighMax = Integer.parseInt(thighMax2);
		}
		
		String riseMin2 = request.getParameter("riseMin");
		int riseMin = 0;
		if(riseMin2!=null && riseMin2!="") {
			riseMin = Integer.parseInt(riseMin2);
		}
		String riseMax2 = request.getParameter("riseMax");
		int riseMax = 0;
		if(riseMax2!=null && riseMax2!="") {
			riseMax = Integer.parseInt(riseMax2);
		}
		
		String hemCrossMin2 = request.getParameter("hemCrossMin");
		int hemCrossMin = 0;
		if(hemCrossMin2!=null && hemCrossMin2!="") {
			hemCrossMin = Integer.parseInt(hemCrossMin2);
		}
		String hemCrossMax2 = request.getParameter("hemCrossMax");
		int hemCrossMax = 0;
		if(hemCrossMax2!=null && hemCrossMax2!="") {
			hemCrossMax = Integer.parseInt(hemCrossMax2);
		}
		
		String footMin2 = request.getParameter("footMin");
		int footMin = 0;
		if(footMin2!=null && footMin2!="") {
			footMin = Integer.parseInt(footMin2);
		}
		String footMax2 = request.getParameter("footMax");
		int footMax = 0;
		if(footMax2!=null && footMax2!="") {
			footMax = Integer.parseInt(footMax2);
		}
		
		String ballMin2 = request.getParameter("ballMin");
		int ballMin = 0;
		if(ballMin2!=null && ballMin2!="") {
			ballMin = Integer.parseInt(ballMin2);
		}
		String ballMax2 = request.getParameter("ballMax");
		int ballMax = 0;
		if(ballMax2!=null && ballMax2!="") {
			ballMax = Integer.parseInt(ballMax2);
		}
		
		String ankleMin2 = request.getParameter("ankleMin");
		int ankleMin = 0;
		if(ankleMin2!=null && ankleMin2!="") {
			ankleMin = Integer.parseInt(ankleMin2);
		}
		String ankleMax2 = request.getParameter("ankleMax");
		int ankleMax = 0;
		if(ankleMax2!=null && ankleMax2!="") {
			ankleMax = Integer.parseInt(ankleMax2);
		}
		
		String instepMin2 = request.getParameter("instepMin");
		int instepMin = 0;
		if(instepMin2!=null && instepMin2!="") {
			instepMin = Integer.parseInt(instepMin2);
		}
		String instepMax2 = request.getParameter("instepMax");
		int instepMax = 0;
		if(instepMax2!=null && instepMax2!="") {
			instepMax = Integer.parseInt(instepMax2);
		}
		
		String search = request.getParameter("search");
		
		if(search == null || search == "") {
			search = "0";
		}
		
	// ÷  ڽ          ޾ƿͼ      ȭ
		String colors = "";
		String[] colorsArr;
		List<String> colorList = new ArrayList<String>();
		
		if(request.getParameter("colors")!=null && !request.getParameter("colors").equals("")) {
			colors= request.getParameter("colors");
			System.out.println("      ÷  ڵ : "+colors);
				colorsArr = colors.split(",");
				if(colorsArr.length != 0) {
					for(int i=0; i<colorsArr.length; i++) {
						colorList.add(colorsArr[i]);
					}
				}
		}
		
		
		List<Integer> redList = new ArrayList<Integer>();
		List<Integer> greenList = new ArrayList<Integer>();
		List<Integer> blueList = new ArrayList<Integer>();
		
		//rgb     ȯ ؼ         Ʈ    ֱ 
		if(colorList != null && !colorList.isEmpty()) {
			for(int i=0; i<colorList.size(); i++) {
				String colorCode = colorList.get(i); //            ڵ 
				// RGB          ȯ
				int red = Integer.parseInt(colorCode.substring(0, 2), 16);
				int green = Integer.parseInt(colorCode.substring(2, 4), 16);
				int blue = Integer.parseInt(colorCode.substring(4, 6), 16);
				
				System.out.println("red  : "+red);
				System.out.println("green  : "+green);
				System.out.println("blue  : "+blue);
				
				redList.add(red);
				greenList.add(green);
				blueList.add(blue);
			}
		}
		

	// mybatis selectProductList sql       ó          Ͱ    Map   set
		Map<String, Object>total = new HashMap<String, Object>();
		total.put("subCategory", subCategory);
			//    ݴ           
		total.put("priceMin", priceMin);
		total.put("priceMax", priceMax);
			//          
		total.put("align", align);
			
			//         
		total.put("topMin", topMin);
		total.put("topMax", topMax);
		
		total.put("shoulderMin", shoulderMin);
		total.put("shoulderMax", shoulderMax);
		
		total.put("chestMin", chestMin);
		total.put("chestMax", chestMax);
		
		total.put("sleeveMin", sleeveMin);
		total.put("sleeveMax", sleeveMax);
		
		total.put("waistMin", waistMin);
		total.put("waistMax", waistMax);
		
		total.put("hipMin", hipMin);
		total.put("hipMax", hipMax);
		
		total.put("thighMin", thighMin);
		total.put("thighMax", thighMax);
		
		total.put("riseMin", riseMin);
		total.put("riseMax", riseMax);
		
		total.put("hemCrossMin", hemCrossMin);
		total.put("hemCrossMax", hemCrossMax);
		
		total.put("footMin", footMin);
		total.put("footMax", footMax);
		
		total.put("ballMin", ballMin);
		total.put("ballMax", ballMax);
		
		total.put("ankleMin", ankleMin);
		total.put("ankleMax", ankleMax);
		
		total.put("instepMin", instepMin);
		total.put("instepMax", instepMax);
		
		total.put("search", search);
		
		//       ÷            ó    ϱ      
		for(int i=0; i<redList.size(); i++) {
			total.put("red" + i ,redList.get(i));
		}
		for(int i=0; i<greenList.size(); i++) {
			total.put("green" + i ,greenList.get(i));
		}
		for(int i=0; i<blueList.size(); i++) {
			total.put("blue" + i ,blueList.get(i));
		}
		
		 
		System.out.println(total.keySet());
		for(Integer r : redList) {
			System.out.println("r: "+ r);
		}
		
		//              ü      db jsp         ϱ           
		List<Product_totalDTO> totalList = new ArrayList<Product_totalDTO>();
		totalList = service.selectProductList(total);
		mav.addObject("totalList", totalList);
		
		return mav;
		
	}


	
	

}
