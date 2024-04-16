package com.spring.finalpro.common.controller;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Base64;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.spring.finalpro.common.dto.ProductDTO2;
import com.spring.finalpro.common.service.CommonService;
import com.spring.finalpro.post.dto.MagazineBrandDTO;

import smile.clustering.KMeans;

@Controller
@EnableAspectJAutoProxy
public class CommonControllerImpl implements CommonController {
	
	private static final String BOARD_REPO="C:\\final_image";
	
	
	@Autowired
	private CommonService service;

	// 메인페이지 여는 것
	@RequestMapping(value= {"/", "/main"})
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) {
		// int productNo = 111111;
		Map productMap = service.viewProduct();
		Map brandSnapMap = service.viewBrandSnap();
		Map streetSnapMap = service.viewStreetSnap();
		Map pictorialMap = service.viewPictorialMap();
		Map lookbookMap = service.viewLookbookMap();
		
		ModelAndView mav = new ModelAndView("main");
		
		mav.addObject("productMap", productMap);
		mav.addObject("brandSnapMap", brandSnapMap);
		mav.addObject("streetSnapMap", streetSnapMap);
		mav.addObject("pictorialMap", pictorialMap);
		mav.addObject("lookbookMap", lookbookMap );
		return mav;
	}
	
	
	@Override
	@RequestMapping("/download.do")
	public void download(@RequestParam("imageFileName") String imageFileName, 
	         @RequestParam(value = "productNo", required = false) String productNo, @RequestParam(value = "magazineNo", required = false) Integer magazineNo, 
	         @RequestParam(value="path", required = false) String path, HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String downFile;

		if(path.equals("productInfo")) {
			downFile = BOARD_REPO + "\\productInfo\\" + productNo + "\\" + imageFileName;
		}else if(path.equals("brand")) {
			downFile = BOARD_REPO + "\\brand\\" + productNo + "\\" + imageFileName;
		}else if(path.equals("search")) {
			downFile = BOARD_REPO + "\\search\\" + imageFileName;
		}else if(path.equals("magazine")) {
			downFile = BOARD_REPO + "\\magazine\\" + productNo + "\\" + imageFileName;
		}else if(path.equals("snap")) {
			downFile = BOARD_REPO + "\\snap\\" + productNo + "\\" + imageFileName;
		}else if(path.equals("pictorial")) {
	        downFile = BOARD_REPO + "\\magazine\\pictorial\\" + magazineNo + "\\" + imageFileName;
	    }else if(path.equals("lookbook")) {
	       downFile = BOARD_REPO + "\\magazine\\lookbook\\" + magazineNo + "\\" + imageFileName;
	    }else if(path.equals("review")) {
	    	downFile = BOARD_REPO + "\\review\\" + productNo + "\\" + imageFileName;
	    }else {
			downFile = BOARD_REPO + "\\product\\" + productNo + "\\" + imageFileName;
		}
		
		
		// downFile은 다운로드 할 파일의 다운로드 경로
		File file = new File(downFile);
  
		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment;fileName="+imageFileName);
		FileInputStream in = new FileInputStream(file);
		byte[] buffer = new byte[1024 * 8];
		while(true) {
			int count = in.read(buffer);
			// count == -1이면 파일값이 없다는 것임.
			if (count == -1) {
				break;
			}
			out.write(buffer, 0, count);   
		}
		in.close();
		out.close();
	}
	
	
	
	@Override
	   public String upload(MultipartHttpServletRequest mRequest, String path) throws IOException {
	      String imageFileName = null;
	      Iterator<String> fileNames = mRequest.getFileNames();
	      String uploadPath="";
	      if(path.equals("review")) {
	         uploadPath=BOARD_REPO+"\\review";
	      }else if(path.equals("question")) {
	         uploadPath=BOARD_REPO+"\\question";
	      }
	      
	      while(fileNames.hasNext()) {
	         String fileName = fileNames.next();
	         MultipartFile mFile = mRequest.getFile(fileName);
	         imageFileName = mFile.getOriginalFilename();
	         File file = new File(uploadPath + "\\" + fileName);
	         
	         if(mFile.getSize()!=0) {
	            if(!file.exists()) {
	               if(file.getParentFile().mkdirs()) {
	                  file.createNewFile();
	               }
	            }
	            mFile.transferTo(new File(uploadPath + "\\temp\\" + imageFileName));
	         }
	      }
	      return imageFileName;
	   }

	
	
	
	// 하단의 고객센터로 이동버튼 클릭시 고객센터 페이지로 이동
	@Override
	@RequestMapping("/member/customerService.do")
	public ModelAndView complaint(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		
		HttpSession session=request.getSession(false);
		
		String loginId=(String) session.getAttribute("loginId");
		boolean isLoggedIn = (loginId != null); // Assuming loginId is null when not logged in
		mav.addObject("isLoggedIn", isLoggedIn);
		return mav;
	}
	

	
	

	
	
	@Override
	@RequestMapping("*/*Form.do")
	public ModelAndView Form(HttpServletRequest request, HttpServletResponse response) {
		// TODO Auto-generated method stub
		String viewName = (String) request.getAttribute("viewName");
		ModelAndView mav = new ModelAndView(viewName);
		return mav;
	}
	

	
	@Override
	@RequestMapping("/brand/brandList.do")
	public ModelAndView brandList(@RequestParam("brand") String brand,
	                              HttpServletRequest request, HttpServletResponse response) {

	    String viewName = (String) request.getAttribute("viewName");
	    ModelAndView mav = new ModelAndView(viewName);
	    Map brandListMap = service.brandList(brand);
	    
	   
	    mav.addObject("brandListMap", brandListMap);

	    return mav;
	}
	
	// 브랜드 사이드 만들기
	@RequestMapping("/common/listBrand2.do")
	public ResponseEntity listBrand2(@RequestBody Map<String, Object> requestData, 
			HttpServletRequest request) {
		
		List<ProductDTO2> brandList=service.listBrand2(requestData);
		
		Map<String, Object> responseMap = new HashMap<>();
        responseMap.put("brandList", brandList);

        return ResponseEntity.ok(responseMap);
	}
	
	@RequestMapping("/analyzeImage.do")
	   public ModelAndView analyzeImage(MultipartFile image) throws IOException {
	       ModelAndView mav = new ModelAndView("analyzeImage");
	       String base64Image = "";

	       if (!image.isEmpty()) {
	           byte[] bytes = image.getBytes();
	           base64Image = Base64.getEncoder().encodeToString(bytes);

	           BufferedImage bufferedImage = ImageIO.read(new ByteArrayInputStream(bytes));
	           if (bufferedImage != null) {
	               Map<String, Long> colorFrequencyMap = extractColors(bufferedImage);
	               mav.addObject("colorFrequencyMap", colorFrequencyMap);
	           } else {
	               // BufferedImage가 null인 경우 처리 로직
	               mav.addObject("error", "Unable to load image for color analysis.");
	           }
	       }

	       mav.addObject("imageSrc", "data:image/jpeg;base64," + base64Image);
	       return mav;
	   }
	   
	   private Map<String, Long> extractColors(BufferedImage image) throws IOException {
	       List<double[]> pixels = new ArrayList();
	       for (int x = 0; x < image.getWidth(); x++) {
	           for (int y = 0; y < image.getHeight(); y++) {
	               int rgb = image.getRGB(x, y);
	               double red = (rgb >> 16) & 0xFF;
	               double green = (rgb >> 8) & 0xFF;
	               double blue = (rgb & 0xFF);
	               pixels.add(new double[]{red, green, blue});
	           }
	       }

	       // SMILE 라이브러리의 KMeans 클러스터링을 사용하여 색상 클러스터링
	       double[][] pixelArray = pixels.toArray(new double[pixels.size()][]);
	       KMeans kMeans = KMeans.fit(pixelArray, 10); // 예를 들어, 10개의 클러스터를 생성

	       // 클러스터별로 픽셀 수를 계산
	       Map<Integer, Long> clusterFrequencyMap = Arrays.stream(kMeans.y).boxed()
	               .collect(Collectors.groupingBy(c -> c, Collectors.counting()));

	       // 클러스터 대표 색상을 추출하고 빈도수와 함께 Map으로 변환
	       Map<String, Long> colorFrequencyMap = new LinkedHashMap<>();
	       clusterFrequencyMap.forEach((cluster, count) -> {
	           double[] centroid = kMeans.centroids[cluster];
	           String hexColor = String.format("#%02X%02X%02X", (int)centroid[0], (int)centroid[1], (int)centroid[2]);
	           colorFrequencyMap.put(hexColor, count);
	       });

	       return colorFrequencyMap.entrySet().stream()
	               .sorted(Map.Entry.<String, Long>comparingByValue().reversed())
	               .collect(Collectors.toMap(
	                       Map.Entry::getKey,
	                       Map.Entry::getValue,
	                       (oldValue, newValue) -> oldValue, LinkedHashMap::new));
	   }





	
	
	
	
	
	
	
	
	


	
	

	 
}
