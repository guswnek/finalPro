package com.spring.finalpro.member.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finalpro.member.dto.MemberAddressDTO;
import com.spring.finalpro.member.dto.MemberDTO;
import com.spring.finalpro.member.dto.MemberSizeDTO;
import com.spring.finalpro.product.dto.ProductSizeDTO;

@Repository
public class MemberDAOImpl implements MemberDAO {
	  @Autowired 
	  private SqlSession sqlSession;

	@Override
	public int addMember(MemberDTO member) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.member.addMember", member);
	}


	// 기본정보 수정
	@Override
	public int modMember(MemberDTO member) {
		// TODO Auto-generated method stub
	        return sqlSession.update("mapper.member.modMember", member);
	    }
	// 주소 수정

	@Override
	public int modMemberAddress(MemberAddressDTO address) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.member.modMemberAddress",address);
	}
	//로그인 
	@Override
	public MemberDTO login(MemberDTO member) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.login", member);
	}
	//회원탈퇴
	@Override
	public int delMember(String id) {
		// TODO Auto-generated method stub
		sqlSession.delete("mapper.member.delMemberAddress", id);
		sqlSession.delete("mapper.member.delMemberSize", id);
		
		return sqlSession.delete("mapper.member.delMember", id);
	}


	// 아이디 찾기
	@Override
	public String searchId(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.searchId",param);
	}
	
	//비밀번호 찾기
	@Override
	public String searchPw(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.searchPw",param);
	}
	
	//아이디 중복검사
	@Override
	public boolean ckId(String id) {
		// TODO Auto-generated method stub
		 int count = sqlSession.selectOne("mapper.member.ckId",id);
		 return count > 0;
	}
	
	// 이메일 중복검사
	@Override
	public Boolean ckEmail(String email) {
		 int count = sqlSession.selectOne("mapper.member.ckEmail",email);
		 return count > 0;
	}
	
	// 주소 추가
	@Override
	public int addAddress(MemberAddressDTO member) {
		// TODO Auto-generated method stub
		return sqlSession.insert("mapper.member.addAddress", member);
	}


	
	 @Override 
	 public int newModPwd(Map<String, Object> param) { 
		 // TODOAuto-generated method stub 
		 return sqlSession.update("mapper.member.newModPwd",param); 
		 }


	@Override
	public MemberDTO memberDetails(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.Selectmember",param);
	}


	@Override
	public MemberDTO memberDetailForm(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.memberDetailForm",id);
	}

	// 주소수정 창
	@Override
	public List<MemberAddressDTO> addAddress(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("mapper.member.addressDetailForm",id);
	}

	// 주소 3개이상 일때 찾는 것 
	@Override
	public int AddressCount(String memberId) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.AddressCount",memberId);
	}


	
	// 나의 사이즈 정보
	@Override
	public MemberDTO mySize(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.mySize",param);
	}

	// 주소삭제
	@Override
	public int delAddress(String addressName) {
		// TODO Auto-generated method stub
		return sqlSession.delete("mapper.member.delAddress",addressName);
	}



	// 나의 사이즈 업데이트
	@Override
	public int updateMySize(MemberDTO member) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.member.updateMySize",member);
	}


	@Override
	public int updateAddress(MemberAddressDTO mad) {
		// TODO Auto-generated method stub
		return sqlSession.update("mapper.member.updateAddress",mad);
	}


	// 사이즈 추천 업데이트 및 삽입
	@Override
	public void updateRecommend(MemberSizeDTO memberSize) {
		 //TODO Auto-generated method stub
		System.out.println("Executing checkSize query for memberId: " + memberSize.getMemberId() + " and sizeCategory: " + memberSize.getSizeCategory());
		int count = sqlSession.selectOne("mapper.member.checkSize",memberSize);
		System.out.println("Result of checkSize: " + count);
		if(count==0) {
			sqlSession.insert("mapper.member.insertRecommend",memberSize);
		}else {
			sqlSession.update("mapper.member.updateRecommend",memberSize);
		}
	}


	@Override
	public MemberSizeDTO infoSizeRecommend(String memberId, String sizeCategory) {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<String, Object>();
        params.put("memberId", memberId);
        params.put("sizeCategory", sizeCategory);
        System.out.println(memberId);
        System.out.println(sizeCategory);
        return sqlSession.selectOne("mapper.member.infoSizeRecommend", params);
	}


	@Override
	public MemberDTO myPage(Map<String, Object> param) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("mapper.member.myPage", param);
	}

	
	
	@Override
	   public MemberSizeDTO getProductSize(ProductSizeDTO productSize) {
	      // TODO Auto-generated method stub
	      return sqlSession.selectOne("mapper.member.getProductSize", productSize);
	   }

		
	}













	
