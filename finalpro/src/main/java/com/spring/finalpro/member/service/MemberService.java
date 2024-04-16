package com.spring.finalpro.member.service;

import java.util.ArrayList;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.spring.finalpro.member.dto.MemberAddressDTO;
import com.spring.finalpro.member.dto.MemberDTO;
import com.spring.finalpro.member.dto.MemberSizeDTO;
import com.spring.finalpro.product.dto.ProductSizeDTO;
import com.spring.finalpro.member.dao.MemberDAO;

public interface MemberService {
	
	// 회원가입
	int addMember(MemberDTO member);

	// 로그인
	MemberDTO login(MemberDTO member);
	
	// 회원삭제
	int delMember(String id);


	// 아이디 찾기
	String searchId(String name, String email);
	
	// 비밀번호 찾기
	String searchPw(String id, String name, String email);

	// 아이디 중복체크
	boolean ckId(String id) throws Exception;
	
	// 이메일 중복체크
	boolean ckEmail(String email) throws Exception;

	// 주소 추기
	int addAddress(MemberAddressDTO memberId);

	// 새 비밀번호
	int newModPwd(String id, String pwd);

	// 회원정보 창
	MemberDTO memberDetails(String id,String loginId); //id
	
	//기본 회원 정보 수정
	int modMember(MemberDTO member);
	
	//기본 회원 정보 수정 창
	MemberDTO memberDetailForm(String id);
	
	// 주소 추가
	List<MemberAddressDTO> addAddress(String id);
	
	// 주소 추가시 3개 이상 금지 
	int AddressCount(String memberId);

	// 주소 수정
	int updateAddress(MemberAddressDTO mad);

	// 나의 사이즈
	MemberDTO mySize(String id,String loginId);

	// 주소 삭제
	int delAddress(String addressName);


	// 나의 사이즈 업데이트 및 저장
	int updateMySize(MemberDTO member);


	// 나의 사이즈 추천 업데이트 및 저장
	void updateRecommend(MemberSizeDTO memberSize);
	
	// 나의 사이즈 추천 정보
	MemberSizeDTO infoSizeRecommend(String memberId, String sizeCategory);

	MemberDTO myPage(String id, String loginId);

	boolean certifiedPhoneNumber(String u_phone, String cerNum);

	
	
	MemberSizeDTO getProductSize(ProductSizeDTO productSize);


	}
