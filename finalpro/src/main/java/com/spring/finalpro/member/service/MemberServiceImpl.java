package com.spring.finalpro.member.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.finalpro.member.dao.MemberDAO;
import com.spring.finalpro.member.dto.MemberAddressDTO;
import com.spring.finalpro.member.dto.MemberDTO;
import com.spring.finalpro.member.dto.MemberSizeDTO;
import com.spring.finalpro.product.dto.ProductSizeDTO;

import net.nurigo.java_sdk.api.Message;
import net.nurigo.java_sdk.exceptions.CoolsmsException;



@Service
public class MemberServiceImpl implements MemberService{
	@Autowired
	private MemberDAO dao;
	
	//회원가입
	@Override
	public int addMember(MemberDTO member) {
		// TODO Auto-generated method stub
		return dao.addMember(member);
	}
	
	//로그인
	@Override
	public MemberDTO login(MemberDTO member) {
		// TODO Auto-generated method stub
		return dao.login(member);
	}
	
	//회원삭제
	@Override
	public int delMember(String id) {
		// TODO Auto-generated method stub
		return dao.delMember(id);
	}
	

	// 아이디 찾기
	@Override
	public String searchId(String name, String email) {
		// TODO Auto-generated method stub
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("name", name);
		param.put("email", email);
		return dao.searchId(param);
	}

	// 비밀번호 찾기
	@Override
	public String searchPw(String id, String name, String email) {
		// TODO Auto-generated method stub
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id",id);
		param.put("name", name);
		param.put("email", email);
		return dao.searchPw(param);
	}
	
	// 아이디 중복확인
	@Override
	public boolean ckId(String id) throws Exception{
		// TODO Auto-generated method stub
	Boolean isDuplicate = dao.ckId(id);
		return isDuplicate;
	}
	
	// 이메일 중복확인
	@Override
	public boolean ckEmail(String email) throws Exception {
		// TODO Auto-generated method stub
		Boolean isDuplicate = dao.ckEmail(email);
		return isDuplicate;
	}
	
	// 주소추가
	@Override
	public int addAddress(MemberAddressDTO member) {
		// TODO Auto-generated method stub
		return dao.addAddress(member);
	}

	
	//비밀번호 찾기시 새 비밀번호 입력
	@Override
	public int newModPwd(String id, String pwd) {
		// TODO Auto-generated method stub
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("id", id);
		param.put("pwd", pwd);
		
		return dao.newModPwd(param);
	}
	
	
	//회원정보
	@Override
	public MemberDTO memberDetails(String id, String loginId) { //id
		// TODO Auto-generated method stub
		Map<String, Object>param = new HashMap<String, Object>();
		param.put("id", id);
		param.put("loginId", loginId);
		return dao.memberDetails(param);
	}
	// 기본 회원 정보 수정
	@Override
	public int modMember(MemberDTO member) {
		// TODO Auto-generated method stub
		return dao.modMember(member);
	}


	// 기본정보 수정 창
	@Override
	public MemberDTO memberDetailForm(String id) {
		// TODO Auto-generated method stub
		return dao.memberDetailForm(id);
	}

	// 주소정보 창
	@Override
	public List<MemberAddressDTO> addAddress(String id) {
		// TODO Auto-generated method stub
		return dao.addAddress(id);
	}

	// 주소 3개 이상 일시 저장 x
	@Override
	public int AddressCount(String memberId) {
		// TODO Auto-generated method stub
		return dao.AddressCount(memberId);
	}

	
	// 나의 사이즈 정보
	@Override
	public MemberDTO mySize(String id,String loginId) {
		// TODO Auto-generated method stub
		Map<String, Object>param = new HashMap<String, Object>();
		param.put("id", id);
		param.put("loginId", loginId);
		return dao.mySize(param);
	}


	// 주소 삭제
	@Override
	public int delAddress(String addressName) {
		// TODO Auto-generated method stub
		return dao.delAddress(addressName);
	}
	
	// 주소 추가?
	@Override
	public int updateAddress(MemberAddressDTO mad) {
		// TODO Auto-generated method stub
		return dao.updateAddress(mad);
	}

	// 나의 사이즈 업데이트
	@Override
	public int updateMySize(MemberDTO member) {
		// TODO Auto-generated method stub
		return dao.updateMySize(member);
	}


	// 나의 사이즈 추천 저장 및 업데이트
	@Override
	public void updateRecommend(MemberSizeDTO memberSize) {
		dao.updateRecommend(memberSize);
		
	}
	// 나의 사이즈 추천 정보 
	@Override
	public MemberSizeDTO infoSizeRecommend(String memberId, String sizeCategory) {
		// TODO Auto-generated method stub
		return dao.infoSizeRecommend(memberId, sizeCategory);
	}

	@Override
	public MemberDTO myPage(String id, String loginId) {
		// TODO Auto-generated method stub
		Map<String, Object>param = new HashMap<String, Object>();
		param.put("id", id);
		param.put("loginId", loginId);
		return dao.myPage(param);
	}

	// 본인인증 
	@Override
	public boolean certifiedPhoneNumber(String u_phone, String cerNum) {
		// TODO Auto-generated method stub
		String api_key = "NCS2EMOQ16HRAETH";
        String api_secret = "XAXR0DF7MR7X9H3EAV2REPJFC20Y2HH0";
        Message coolsms = new Message(api_key, api_secret);

        HashMap<String, String> params = new HashMap<String, String>();
        params.put("to", u_phone); // 수신전화번호
        params.put("from", "010-5636-8795"); // 발신전화번호. 테스트시에는 발신,수신 둘다 본인 번호로 하면 됨
        params.put("type", "SMS");
        params.put("text", "[BitMovie] 문자 본인인증 서비스 : 인증번호는 " + "[" + cerNum + "]" + " 입니다.");
        params.put("app_version", "test app 1.2"); // application name and version

        try {
            JSONObject obj = (JSONObject) coolsms.send(params);
            System.out.println(obj.toString());
        } catch (CoolsmsException e) {
            System.out.println(e.getMessage());
            System.out.println(e.getCode());
        }
		return true;
    }
	
	@Override
	   public MemberSizeDTO getProductSize(ProductSizeDTO productSize) {
	      // TODO Auto-generated method stub
	      return dao.getProductSize(productSize);
	   }
		
	}



		






		
	

		








