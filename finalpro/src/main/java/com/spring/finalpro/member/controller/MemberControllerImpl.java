package com.spring.finalpro.member.controller;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.management.MalformedObjectNameException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.taglibs.standard.lang.jstl.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.spring.finalpro.member.dto.MemberAddressDTO;
import com.spring.finalpro.member.dto.MemberDTO;
import com.spring.finalpro.member.dto.MemberSizeDTO;
import com.spring.finalpro.member.service.MemberService;
import com.spring.finalpro.product.dto.ProductSizeDTO;


@Controller

public class MemberControllerImpl implements MemberController {
   
   
    @Autowired 
    private MemberService service;
    
    
   // 회원정보 화면
      @Override
      @RequestMapping("/member/memberDetail.do")
      public ModelAndView memberDetail(MemberDTO member, HttpServletRequest request, HttpServletResponse response)
            throws Exception {
         // TODO Auto-generated method stub
         ModelAndView mav = new ModelAndView("/member/memberDetail");
         HttpSession session = request.getSession();
         String loginId = (String) session.getAttribute("loginId");
          if (loginId == null || loginId.equals("")) { // 로그인 ID가 없다면
              response.setContentType("text/html; charset=UTF-8");
              PrintWriter out = response.getWriter();
              out.println("<script>alert('로그인이 필요한 서비스입니다.'); location.href='/finalpro/member/loginForm.do';</script>");
              out.flush();
              return null;
          }
         
         MemberDTO memberDetails = service.memberDetails(member.getId(),loginId); 
         mav.addObject("memberDetails",memberDetails);
         mav.addObject("member",member);
         return mav;
      }
      
   
   // 회원삭제 기능
   @Override
   @RequestMapping("member/delMember.do")
   public ModelAndView delMember(
         @RequestParam(value = "id", required = true) String id, 
         HttpServletRequest request, 
         HttpServletResponse response)
         throws Exception {
      // TODO Auto-generated method stub
      int result = service.delMember(id);
      ModelAndView mav = new ModelAndView();
      if(result != 0) {
          HttpSession session = request.getSession(false); // 기존 세션 가져오기
           if (session != null) {
           session.invalidate(); // 세션 무효화
              }
         mav.addObject("msg", "delMember");
         mav.addObject("id", id);
      }else {
         mav.addObject("msg", "delMember");
         mav.addObject("id", null);
      }
         
      mav.setViewName("redirect:/main/");
      
      return mav;
   }
   
   // 회원가입 화면
   @Override
   @RequestMapping("/member/JoinMember.do")
   public ModelAndView joinMember(HttpServletRequest request, HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
      String viewName = (String) request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      return mav;
   }
   
   // 회원가입 기능
   @Override
   @RequestMapping("/member/addMember.do")
   public ModelAndView addMember(MemberDTO member, HttpServletRequest request, HttpServletResponse response)
         throws Exception {
      int result = service.addMember(member);
      // TODO Auto-generated method stub
      ModelAndView mav = new ModelAndView("redirect:/member/loginForm.do");
      mav.addObject("id", member.getId());
      mav.addObject("msg", "addMember");
      
      return mav;
   }
   
   // 회원정보 수정 기능
   @Override
   @RequestMapping("/member/modMember.do")
   public ModelAndView modMember(MemberDTO member, HttpServletRequest request, HttpServletResponse response)
         throws Exception {
      // TODO Auto-generated method stub
      int result = service.modMember(member);
      
      ModelAndView mav = new ModelAndView("redirect:/member/memberDetail.do");
      mav.addObject("id", member.getId());
      
         if (result > 0) {
               mav.addObject("msg", "updateSuccess");
           } else {
               mav.addObject("msg", "updateFailure");
           }
      return mav;
}
   
   
   
   // 로그인 기능 
   @Override
   @RequestMapping(value="/member/login.do", method = RequestMethod.POST)
   public ModelAndView login(MemberDTO member, RedirectAttributes rAttr, HttpServletRequest request,
         HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
      member = service.login(member);
      ModelAndView mav = new ModelAndView();
      HttpSession session = request.getSession();
      if(member != null) {
         mav.setViewName("redirect:/main/");
         session.setAttribute("member", member);
         session.setAttribute("loginId", member.getId());
         session.setAttribute("isLogin", true);
         
         String action= (String)session.getAttribute("action");
         session.removeAttribute("action");
         
         if(action != null) {
            mav.setViewName("redirect:" + action);
         }
      } else {
         mav.setViewName("redirect:/member/loginForm.do");
         rAttr.addAttribute("result", "loginFailed");
      }
      
      return mav;
   }
   
   // 로그아웃 기능 !
   @Override
   @RequestMapping("member/logout.do")
   public ModelAndView logout(RedirectAttributes rAttr, HttpServletRequest request, HttpServletResponse response)
         throws Exception {
      // TODO Auto-generated method stub
      HttpSession session = request.getSession(false);
      
      ModelAndView mav = new ModelAndView();
      Boolean isLogin = (Boolean) session.getAttribute("isLogin");
      
      if(session != null && isLogin != null) {
         session.invalidate();
         rAttr.addAttribute("result", "logout");
      } else {
         rAttr.addAttribute("result", "notLogin");
      }
      mav.setViewName("redirect:/main/");
      return mav;
   }
   
   // 로그인  화면 !
   @Override
   @RequestMapping("/member/loginForm.do")
   public ModelAndView loginForm(
         @RequestParam(value="action", required = false)String action, 
         HttpServletRequest request, 
         HttpServletResponse response)
         throws Exception {
      // TODO Auto-generated method stub
      String viewName = (String) request.getAttribute("viewName");
      HttpSession session = request.getSession();
      session.setAttribute("action", action);
      ModelAndView mav = new ModelAndView(viewName);
      return mav;
   }
   
   //아이디 찾기 화면
   @Override
   @RequestMapping("/member/FindId.do")
   public ModelAndView findIdForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
      String viewName = (String) request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      return mav;
   }
   
   //비밀번호 찾기 화면
   @Override
   @RequestMapping("/member/FindPw.do")
   public ModelAndView findPwForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
      String viewName = (String) request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      return mav;
   }
   



   //id 찾기 기능
   @Override
   @RequestMapping("/member/searchId.do")
   public ModelAndView searchId
   (@RequestParam ("name") String name, 
   @RequestParam ("email") String email,  
         HttpServletRequest request, 
         HttpServletResponse response)
         throws Exception {
      // TODO Auto-generated method stub
      
      String userId = service.searchId(name,email);
      ModelAndView mav = new ModelAndView();
      mav.addObject("userId", userId);
      mav.setViewName("/member/searchId");
      return mav;
   }
   
   //pw 찾기 기능
   @Override
   @RequestMapping("/member/searchPw.do")
   public ModelAndView searchPw(
         @RequestParam ("id") String id, 
         @RequestParam("name") String name, 
         @RequestParam ("email") String email, 
         HttpServletRequest request,
         HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
      String userId = service.searchPw(id,name,email);
      ModelAndView mav = new ModelAndView();
      mav.addObject("userId", userId);
      mav.setViewName("/member/searchPw");
      return mav;
   }
   
   // 새 비밀번호 수정 창
   @Override
   @RequestMapping("/member/newPwd.do")
   public ModelAndView newPwd(HttpServletRequest request, HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
      String viewName = (String) request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      return mav;
   }

   
   //아이디 중복 체크
   @Override
   @RequestMapping(value="/member/dupId.do", method = RequestMethod.GET)
   public ResponseEntity<Map<String, Boolean>> dupId(String id, HttpServletRequest request,
         HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
      boolean dup = service.ckId(id);
      Map<String, Boolean> result = new HashMap();
      result.put("dup", dup);
      return ResponseEntity.ok(result);
   }
   
   //이메일 중복 체크
   @Override
   @RequestMapping(value="/member/dupEmail.do", method = RequestMethod.GET)
   public ResponseEntity<Map<String, Boolean>> dupEmail(String email, HttpServletRequest request,
         HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
      boolean dup = service.ckEmail(email);
      Map<String, Boolean> result = new HashMap();
      result.put("dup", dup);
      return ResponseEntity.ok(result);
   }


   
   


   
   
   // 새 비밀번호 
   @Override
   @RequestMapping("/member/modNewPwd.do")
   public ModelAndView modNewPwd(
         @RequestParam("id") String id,
         @RequestParam("pwd") String pwd,
         HttpServletRequest request, 
         HttpServletResponse response) throws Exception{
         // TODO Auto-generated method stub
      HttpSession session = request.getSession();
      String userId = (String)session.getAttribute("userId");
      session.setAttribute("userId", userId);
      int result = service.newModPwd(id,pwd);
      ModelAndView mav = new ModelAndView("redirect:/member/loginForm.do");
//      mav.addObject("result", id);
       if(result > 0) {
              mav.addObject("msg", "newPwdSuccess");
          } else {
              mav.addObject("msg", "비밀번호 변경에 실패하였습니다.");
          }

         return mav;
   }



   // 기본정보 수정 창
   @Override
   @RequestMapping("/member/memberDetailForm.do")
   public ModelAndView memberDetailForm(MemberDTO member, HttpServletRequest request, HttpServletResponse response)
         throws Exception {
      // TODO Auto-generated method stub
      ModelAndView mav = new ModelAndView("/member/memberDetailForm");
      HttpSession session = request.getSession();
      String loginId = (String)session.getAttribute("loginId");
       if (loginId == null || loginId.equals("")) { // 로그인 ID가 없다면
           response.setContentType("text/html; charset=UTF-8");
           PrintWriter out = response.getWriter();
           out.println("<script>alert('로그인이 필요한 서비스입니다.'); location.href='/finalpro/member/loginForm.do';</script>");
           out.flush();
           return null;
       }
      
      MemberDTO memberDetails = service.memberDetailForm(member.getId());
      
      mav.addObject("mdf",memberDetails);
      mav.addObject("member",member);
      return mav;
   }


// --------------------------주소 관련------------------------------------   
   
   // 주소 창 
   @Override
   @RequestMapping("/member/addressDetailForm.do")
   public ModelAndView addressDetailForm(
         @RequestParam (value = "id", required = false) String id, HttpServletRequest request, HttpServletResponse response)
         throws Exception {
      // TODO Auto-generated method stub
      ModelAndView mav = new ModelAndView("/member/addressDetailForm");
      HttpSession session = request.getSession();
      String loginId = (String)session.getAttribute("loginId");
      if (loginId == null || loginId.equals("")) { // 로그인 ID가 없다면
           response.setContentType("text/html; charset=UTF-8");
           PrintWriter out = response.getWriter();
           out.println("<script>alert('로그인이 필요한 서비스입니다.'); location.href='/finalpro/member/loginForm.do';</script>");
           out.flush();
           return null;
       }
      session.setAttribute("id", id);
      
      List<MemberAddressDTO> addressList = service.addAddress(id);
      mav.addObject("addressList",addressList);
      return mav;
   }
   
   
   // 주소지 추가 화면
   @Override
   @RequestMapping("/member/addAddressForm.do")
   public ModelAndView addAddressForm(HttpServletRequest request, HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
       HttpSession session = request.getSession();
          String loginId = (String)session.getAttribute("loginId");
          if (loginId == null || loginId.equals("")) { // 로그인 ID가 없다면
              response.setContentType("text/html; charset=UTF-8");
              PrintWriter out = response.getWriter();
              out.println("<script>alert('로그인이 필요한 서비스입니다.'); location.href='/finalpro/member/loginForm.do';</script>");
              out.flush();
              return null;
          }
          
      String viewName = (String) request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      mav.addObject("loginId", loginId);
      return mav;
   }
   
   // 주소삭제 (코드 이름만 좀 수정)
   @Override
   @RequestMapping("/member/delAddress.do")
   public ModelAndView deleteAddress(
         @RequestParam("no")String addressName, 
         HttpServletRequest request, 
         HttpServletResponse response)
         throws Exception {
      // TODO Auto-generated method stub
      HttpSession session = request.getSession();
      String loginId = (String) session.getAttribute("loginId");
      int result = service.delAddress(addressName);
      ModelAndView mav = new ModelAndView("/member/addressDetailForm");
      
      if(loginId == null) {
            response.setContentType("text/html; charset=UTF-8");
              PrintWriter out = response.getWriter();
              out.println("<script>alert('로그인이 필요한 서비스입니다.'); location.href='/finalpro/member/loginForm.do';</script>");
              out.flush();
              return null;
          }
      if(result > 0) {
         mav.addObject("msg", "주소삭제 성공");
         mav.setViewName("redirect:/member/addressDetailForm.do?id=" + loginId);
         
      }else {
         mav.addObject("msg", "주소삭제실패");
         mav.setViewName("redirect:/member/addressDetailForm.do?id=" + loginId);
      }
   
      return mav;
   }
   
   
   @Override
	@RequestMapping("/member/delAddress1.do")
	public ModelAndView deleteAddress1(
		@RequestParam("no")String addressName, 
		HttpServletRequest request, 
		HttpServletResponse response)
		throws Exception {
		
		HttpSession session = request.getSession();
		String loginId = (String) session.getAttribute("loginId");
		int result = service.delAddress(addressName);
		
		 String referer = request.getHeader("referer");
	        if (referer != null && !referer.isEmpty()) {
	            response.sendRedirect(referer);
	        } else {
	            // 이전 페이지가 없는 경우 기본적으로 설정할 페이지로 리다이렉션하거나 예외 처리
	            response.sendRedirect("/default/page"); // 원하는 페이지로 변경
	        }
	        return null;
	}

   
   

   @Override
   @RequestMapping("/member/addAddress.do")
   public ModelAndView addAddress(
         @RequestParam(value = "addressName[]", required = false) String[] addressNames,
            @RequestParam(value ="recipient[]", required = false) String[] recipients,
            @RequestParam(value ="addressPhone[]", required = false) String[] addressPhones,
            @RequestParam(value ="postCode[]", required = false) String[]  postCodes,
            @RequestParam(value ="address[]", required = false) String[] addresses,
            @RequestParam(value ="detailAddress[]", required = false) String[] detailAddresses,
         HttpServletRequest request,
         HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
        HttpSession session = request.getSession();
          String loginId = (String)session.getAttribute("loginId");
          if (loginId == null || loginId.equals("")) { // 로그인 ID가 없다면
              response.setContentType("text/html; charset=UTF-8");
              PrintWriter out = response.getWriter();
              out.println("<script>alert('로그인이 필요한 서비스입니다.'); location.href='/finalpro/member/loginForm.do';</script>");
              out.flush();
              return null;
          }
          int AddressCount = service.AddressCount(loginId);
          ModelAndView mav = new ModelAndView(loginId);
          if(AddressCount>=3) {
             mav.addObject("msg", "최대 3개의 주소만 저장 가능");
             mav.setViewName("redirect:/member/addressDetailForm.do?id=" + loginId);
             return mav;
          }
      
          
          
          int addressCount = Math.min(addressNames != null ? addressNames.length : 0, 3);
          
          // 주소 정보 저장 시도
          for (int i = 0; i < addressCount; i++) {
             if(addressNames[i] == null || addressNames[i].isEmpty()) {
                continue;
             }
              MemberAddressDTO member = new MemberAddressDTO();
              member.setMemberId(loginId);
              member.setAddressName(addressNames[i]);
              member.setRecipient(i < recipients.length ? recipients[i] : "");
              member.setAddressPhone(i< addressPhones.length ? addressPhones[i] : "");
              member.setPostCode(i < postCodes.length ? postCodes[i] : "");
              member.setAddress(i < addresses.length ? addresses[i] : "");
              member.setDetailAddress(i < detailAddresses.length ? detailAddresses[i] : "");
              
              int result = service.addAddress(member);
              
              if (result <= 0) {
                  mav.addObject("msg", "주소 추가 실패.");
                  mav.setViewName("redirect:/member/addressDetailForm.do?id=" + loginId);
                  return mav;
              }
          }
          
          // 주소 완료시 넘어감
          mav.addObject("msg", "addAddress.");
          mav.setViewName("redirect:/member/addressDetailForm.do?id=" + loginId);
          return mav;
      }
   
//------------------------------나의 사이즈-----------------------------------------
   
   // 나의 사이즈
   @Override
   @RequestMapping("/member/mySize.do")
   public ModelAndView mySize(
         @ModelAttribute("dto") MemberDTO member,
         HttpServletRequest request, HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
      String viewName = (String) request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      HttpSession session = request.getSession();
      String loginId = (String) session.getAttribute("loginId");
       if (loginId == null || loginId.equals("")) { // 로그인 ID가 없다면
           response.setContentType("text/html; charset=UTF-8");
           PrintWriter out = response.getWriter();
           out.println("<script>alert('로그인이 필요한 서비스입니다.'); location.href='/finalpro/member/loginForm.do';</script>");
           out.flush();
           return null;
       }
      
      
      
      member.setId(loginId);
      member=service.mySize(member.getId(),loginId);
      mav.addObject("member",member);
      mav.addObject("loginId", loginId);
      mav.addObject("msg", "success");
      mav.addObject("msg", "fail");
      return mav;
   }
   
   // 나의 신체 사이즈정보 저장 기능
      @Override
      @RequestMapping("/member/updateMySize.do")
      public ModelAndView updateMySize(MemberDTO member, 
            HttpServletRequest request, 
            HttpServletResponse response)
            throws Exception {
         // TODO Auto-generated method stub
         HttpSession session = request.getSession();
         String loginId = (String) session.getAttribute("loginId");
          if (loginId == null || loginId.equals("")) { // 로그인 ID가 없다면
              response.setContentType("text/html; charset=UTF-8");
              PrintWriter out = response.getWriter();
              out.println("<script>alert('로그인이 필요한 서비스입니다.'); location.href='/finalpro/member/loginForm.do';</script>");
              out.flush();
              return null;
          }
         member.setId(loginId);
         int result = service.updateMySize(member);
         
         ModelAndView mav = new ModelAndView("redirect:/member/mySize.do");
         
            if (result > 0) {
                  mav.addObject("msg", "updateSuccess");
              } else {
                  mav.addObject("msg", "updateFailure");
              }
         return mav;
   }

      
//---------------------------------나의 사이즈 추천---------------------------------------------
   
   //사이즈 추천 화면
   @Override
   @RequestMapping("/member/sizeRecommend.do")
   public ModelAndView sizeRecommend(
         HttpServletRequest request, 
         HttpServletResponse response)
         throws Exception {
      // TODO Auto-generated method stub
      HttpSession session = request.getSession();
      String loginId = (String) session.getAttribute("loginId");
      if(loginId == null) {
         response.setContentType("text/html; charset=UTF-8");
         PrintWriter out = response.getWriter();
         out.println("<script>alert('로그인이 필요한 서비스입니다.'); location.href='/finalpro/member/loginForm.do';</script>");
          out.flush();
              return null; // 컨트롤러에서 더 이상 처리하지 않도록 null 반환
          } else {
              String viewName = (String) request.getAttribute("viewName");
              ModelAndView  mav = new ModelAndView(viewName);
              return mav; // 로그인이 된 경우에는 정상적으로 view를 반환
          }
      }
   // 나의 사이즈 정보 업데이트 및 저장
   @RequestMapping("/member/updateRecommend.do")
   public ResponseEntity<?> updateSize(
         @RequestBody MemberSizeDTO memberSize, 
         HttpSession session) {
       String loginId = (String) session.getAttribute("loginId");
       if (loginId == null || loginId.trim().isEmpty()) {
           // 로그인 ID가 없다면 클라이언트에게 로그인이 필요함을 알림
           return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login required");
       }
       memberSize.setMemberId(loginId); // 로그인된 사용자 ID 설명ㄴ 
       
       System.out.println("memberSize =" + memberSize);
       try {
           service.updateRecommend(memberSize);
           return ResponseEntity.ok().body("Update successful");
       } catch (Exception e) {
            e.printStackTrace(); // 서버 측 로그에 예외 스택 트레이스를 출력
           return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error message");
           
       }
   }
   
   @RequestMapping("/member/mysizeChangeOrderSize.do")
      public ResponseEntity<?> mysizeChangeOrderSize(
            @RequestBody ProductSizeDTO productSize, 
            HttpSession session) {
         String loginId = (String) session.getAttribute("loginId");
         if (loginId == null || loginId.trim().isEmpty()) {
            // 로그인 ID가 없다면 클라이언트에게 로그인이 필요함을 알림
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login required");
         }
         
         MemberSizeDTO memberSize=service.getProductSize(productSize);
         memberSize.setMemberId(loginId); // 로그인된 사용자 ID 설명ㄴ 
         
         if(productSize.getSubCategory().equals("t-shirt")) {
            memberSize.setSizeCategory("shortT");         
         }else if(productSize.getSubCategory().equals("mtom")) {
            memberSize.setSizeCategory("LongslT");      
         }else if(productSize.getSubCategory().equals("hood")) {
            memberSize.setSizeCategory("LongslT");         
         }else if(productSize.getSubCategory().equals("knit")) {
            memberSize.setSizeCategory("LongslT");      
         }else if(productSize.getSubCategory().equals("shirt")) {
            memberSize.setSizeCategory("shirt");      
         }else if(productSize.getSubCategory().equals("coat")) {
            memberSize.setSizeCategory("coat");      
         }else if(productSize.getSubCategory().equals("heavyOuter")) {
            memberSize.setSizeCategory("heavyOuter");      
         }else if(productSize.getSubCategory().equals("cardigan")) {
            memberSize.setSizeCategory("jumper");      
         }else if(productSize.getSubCategory().equals("fleece")) {
            memberSize.setSizeCategory("jumper");         
         }else if(productSize.getSubCategory().equals("jumper")) {
            memberSize.setSizeCategory("jumper");      
         }else if(productSize.getSubCategory().equals("jeans")) {
            memberSize.setSizeCategory("pants");         
         }else if(productSize.getSubCategory().equals("slacks")) {
            memberSize.setSizeCategory("pants");      
         }else if(productSize.getSubCategory().equals("skirt")) {
            memberSize.setSizeCategory("skirt");      
         }else if(productSize.getSubCategory().equals("trackPants")) {
            memberSize.setSizeCategory("pants");      
         }else if(productSize.getSubCategory().equals("shorts")) {
            memberSize.setSizeCategory("shorts");         
         }else if(productSize.getSubCategory().equals("dressShoes")) {
            memberSize.setSizeCategory("shoes");         
         }else if(productSize.getSubCategory().equals("sneakers")) {
            memberSize.setSizeCategory("sneakers");         
         }else if(productSize.getSubCategory().equals("athleticShoes")) {
            memberSize.setSizeCategory("sneakers");      
         }
         
         memberSize.setMemberId(loginId); // 로그인된 사용자 ID 설명ㄴ 
         
         System.out.println("update : " +memberSize);

         Map<String, Object> responseMap = new HashMap<String, Object>();
         
         try {
            service.updateRecommend(memberSize);
            responseMap.put("success", true);
            return ResponseEntity.ok(responseMap);
         } catch (Exception e) {
            e.printStackTrace(); // 서버 측 로그에 예외 스택 트레이스를 출력
            responseMap.put("success", false);
            return ResponseEntity.ok(responseMap);
         }
      }
   
   
   

   // 나의 사이즈 정보 조회
   @Override
   @RequestMapping(value="/member/infoSizeRecommend.do", method=RequestMethod.GET)
    public ResponseEntity<MemberSizeDTO> infoSizeRecommend(
            @RequestParam(value = "memberId", required = false) String memberId, 
            @RequestParam("sizeCategory") String sizeCategory,
            HttpSession session) {
      if(memberId==null || memberId=="") memberId=(String) session.getAttribute("loginId");
         
        try {
            MemberSizeDTO memberSize = service.infoSizeRecommend(memberId, sizeCategory);
            System.out.println("download : " +memberSize);
            if(memberSize != null) {
                return new ResponseEntity<MemberSizeDTO>(memberSize, HttpStatus.OK);
            } else {
                return new ResponseEntity<MemberSizeDTO>(HttpStatus.NOT_FOUND);
            }
        } catch (Exception e) {
            return new ResponseEntity<MemberSizeDTO>(HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }



   // 마이페이지 
   @Override
   @RequestMapping("/member/myPage.do")
   public ModelAndView myPage(
         @ModelAttribute("dto") MemberDTO member,
         HttpServletRequest request, HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
      String viewName = (String) request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      HttpSession session = request.getSession();
      String loginId = (String) session.getAttribute("loginId");
       if (loginId == null || loginId.equals("")) { // 로그인 ID가 없다면
              response.setContentType("text/html; charset=UTF-8");
              PrintWriter out = response.getWriter();
              out.println("<script>alert('로그인이 필요한 서비스입니다.'); location.href='/finalpro/member/loginForm.do';</script>");
              out.flush();
              return null;
          }
      MemberDTO myPage = service.myPage(member.getId(),loginId); 
      mav.addObject("myPage",myPage);
      mav.addObject("member",member);
      return mav;
   }
   
   
   
// 본인인증-----------------------------------------------------------
   // 본인인증 창
   @Override
   @RequestMapping("/member/identity.do")
   public ModelAndView identity(HttpServletRequest request, HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
      String viewName = (String) request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      return mav;
   }
   
   // 인증번호 받기
   @RequestMapping(value = "/member/sendTest2.do", method = RequestMethod.POST)
   @ResponseBody 
    public String sendSMS(@RequestParam String u_phone, HttpSession session) {

        Random rnd = new Random();
        StringBuilder buffer = new StringBuilder();
        for (int i = 0; i < 4; i++) {
            buffer.append(rnd.nextInt(10));
        }
        String cerNum = buffer.toString();

     
        boolean result = service.certifiedPhoneNumber(u_phone, cerNum);
        
        System.out.println("cerNum = " + cerNum);
        System.out.println("저장된 인증번호: " + session.getAttribute("cerNum"));

        if (result) {
           
            session.setAttribute("cerNum", cerNum);
    
           
            return "인증번호 발송 성공";
        } else {
         
            return "인증번호 발송 실패";
        }
    }
   // 본인인증 
   @RequestMapping(value = "/member/verifyCertNum.do", method = RequestMethod.POST)
   @ResponseBody
   public Map<String, Object> verifyCertNum(@RequestParam String inputCertNum, HttpSession session) {
       Map<String, Object> response = new HashMap<String, Object>();
       String sessionCertNum = (String) session.getAttribute("cerNum");
       System.out.println("sessionCertNum" + sessionCertNum);

       if (inputCertNum.equals(sessionCertNum)) {
           response.put("success", true);
           response.put("message", "인증에 성공했습니다.");
           session.removeAttribute("cerNum"); 
       } else {
           response.put("success", false);
           response.put("message", "인증에 실패했습니다. 다시 시도해주세요.");
           System.out.println("sessionCertNum" + sessionCertNum);
       }
       return response; 
   }


   @Override
   @RequestMapping("/member/agree.do")
   public ModelAndView agree(HttpServletRequest request, HttpServletResponse response) throws Exception {
      // TODO Auto-generated method stub
      String viewName = (String) request.getAttribute("viewName");
      ModelAndView mav = new ModelAndView(viewName);
      return mav;
   }

}




