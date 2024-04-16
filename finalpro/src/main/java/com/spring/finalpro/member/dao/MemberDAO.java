package com.spring.finalpro.member.dao;

import java.util.List;
import java.util.Map;

import com.spring.finalpro.member.dto.MemberAddressDTO;
import com.spring.finalpro.member.dto.MemberDTO;
import com.spring.finalpro.member.dto.MemberSizeDTO;
import com.spring.finalpro.product.dto.ProductSizeDTO;

public interface MemberDAO {
	public int addMember(MemberDTO member);

	public int modMember(MemberDTO member);

	public MemberDTO login(MemberDTO member);

	public int delMember(String id);



	public String searchId(Map<String, Object> param);

	public String searchPw(Map<String, Object> param);

	public boolean ckId(String id);
	
	public Boolean ckEmail(String email);	

	public int addAddress(MemberAddressDTO member);

	public int newModPwd(Map<String, Object> param);

	public MemberDTO memberDetailForm(String id);

	public List<MemberAddressDTO> addAddress(String memberId);

	public int modMemberAddress(MemberAddressDTO address);

	public int AddressCount(String memberId);

	public MemberDTO mySize(Map<String, Object> param);


	public int delAddress(String addressName);

	public MemberDTO memberDetails(Map<String, Object> param);

	public int updateMySize(MemberDTO member);

	public int updateAddress(MemberAddressDTO mad);

	public void updateRecommend(MemberSizeDTO memberSize);

	public MemberSizeDTO infoSizeRecommend(String memberId, String sizeCategory);

	public MemberDTO myPage(Map<String, Object> param);


	public MemberSizeDTO getProductSize(ProductSizeDTO productSize);
	

}