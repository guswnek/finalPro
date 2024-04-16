package com.spring.finalpro.member.controller;

import java.util.List;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;


import com.spring.finalpro.member.dto.MemberAddressDTO;
import com.spring.finalpro.member.dto.MemberDTO;
import com.spring.finalpro.member.dto.MemberSizeDTO;

@Controller
public interface MemberController {
	

	// 회원정보 화면 출력 !
		public ModelAndView memberDetail(
				@ModelAttribute("dto") MemberDTO member,
				HttpServletRequest request, 
				HttpServletResponse response) throws Exception;
	// 기본회원수정 화면 출력
	public ModelAndView memberDetailForm(
			@ModelAttribute("dto") MemberDTO member,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	// 주소 정보 출력
	public ModelAndView addressDetailForm(
			@RequestParam("id") String memberId,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;

	// 회원삭제 버튼
	public ModelAndView delMember(
			@RequestParam(value = "id", required = true) String id,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	// 회원가입 화면 !
	public ModelAndView joinMember(HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	// 회원가입 정보 DB 입력 
	public ModelAndView addMember(
			@ModelAttribute("dto") MemberDTO member,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	// 기본 회원정보 수정하기 (기본회원정보 DB 업데이트) 
	public ModelAndView modMember(
			@ModelAttribute("dto") MemberDTO member,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	
	// 나의 사이즈 수정하기 (기본회원정보 DB 업데이트) 
	public ModelAndView updateMySize(
			@ModelAttribute("dto") MemberDTO member,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	// 로그인 화면
	public ModelAndView loginForm(
			@RequestParam(value="action", required = false)String action,
					HttpServletRequest request, 
					HttpServletResponse response) throws Exception;
	// 입력정보 DB 대조
	public ModelAndView login(
			@ModelAttribute("dto") MemberDTO member,
			RedirectAttributes rAttr,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	
	// 아이디 찾기 화면 !
	public ModelAndView findIdForm(
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	
	// 비밀번호 찾기 화면 !
	public ModelAndView findPwForm(
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	
	// 아이디 찾기 기능
	public ModelAndView searchId(
			@RequestParam("name") String name,
			@RequestParam("email") String email,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	
	// 비밀번호 찾기 기능
	public ModelAndView searchPw(
			@RequestParam("id") String id,
			@RequestParam("name") String name,
			@RequestParam("email") String email,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	
	// 로그아웃 !
	public ModelAndView logout(
			RedirectAttributes rAttr,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	
	// 아이디 중복체크
	public ResponseEntity<Map<String, Boolean>> dupId(
			@RequestParam("id") String id,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	
	// 이메일 중복체크
	public ResponseEntity<Map<String, Boolean>> dupEmail(
			@RequestParam("email") String email,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	

	// 주소 입력창
	public ModelAndView addAddressForm(
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	
	// 새 비밀번호 입력 창
	public ModelAndView newPwd(
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	
	 //새비밀번호 수정
	public ModelAndView modNewPwd(
			@RequestParam("id") String id,
			@RequestParam("pwd") String pwd,
			HttpServletRequest request, 
			HttpServletResponse response) throws Exception;
	
	// 주소 입력 기능
	public ModelAndView addAddress(
	@RequestParam("addressName[]") String[] addressNames,
            @RequestParam("recipient[]") String[] recipients,
            @RequestParam("addressPhone[]") String[] addressPhones,
            @RequestParam("postCode[]") String[] postCodes,
            @RequestParam("address[]") String[] addresses,
            @RequestParam("detailAddress[]") String[] detailAddresses,
	HttpServletRequest request, 
	HttpServletResponse response) throws Exception;
	
		// 나의 사이즈
		public ModelAndView mySize(
				@ModelAttribute("dto") MemberDTO member,
				HttpServletRequest request, 
				HttpServletResponse response) throws Exception;
		
		//사이즈 추천
		public ModelAndView sizeRecommend(
				HttpServletRequest request, 
				HttpServletResponse response) throws Exception;
		
		
		// 주소 삭제
		public ModelAndView deleteAddress(
				@RequestParam("no")String addressName,
				HttpServletRequest request, 
				HttpServletResponse response) throws Exception;
		
		
		// 주소 삭제2
		public ModelAndView deleteAddress1(
				@RequestParam("no")String addressName,
				HttpServletRequest request, 
				HttpServletResponse response) throws Exception;
		
		// 사이즈 추천 정보 
		public ResponseEntity<MemberSizeDTO> infoSizeRecommend
		 (String memberId, String sizeCategory, HttpSession session);
		
		public ModelAndView myPage(
				@ModelAttribute("dto") MemberDTO member,
				HttpServletRequest request, 
				HttpServletResponse response) throws Exception;
		
		//본인인증 화면
		public ModelAndView identity(
				HttpServletRequest request, 
				HttpServletResponse response) throws Exception;
		
		//약관동의 화면
		public ModelAndView agree(
				HttpServletRequest request, 
				HttpServletResponse response) throws Exception;
		
		
		
				
}
	