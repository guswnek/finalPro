package com.spring.finalpro.member.dto;

import java.sql.Date;

public class MemberAddressDTO {
	 private int no;
	 private String id;
	 private String memberId; 
	 private String addressName;
	 private String recipient;
	 private String addressPhone;
	 private String postCode;
	 private String address;
	 private String detailAddress;
	 private Date regdate;
	 private String loginId;
	 private int addressNO;
	
	 public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
   

	
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getAddressName() {
		return addressName;
	}
	public void setAddressName(String addressName) {
		this.addressName = addressName;
	}
	public String getRecipient() {
		
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public String getAddressPhone() {
		return addressPhone;
	}
	public void setAddressPhone(String addressPhone) {
		this.addressPhone = addressPhone;
	}
	
	

	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getDetailAddress() {
		return detailAddress;
	}
	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public int getAddressNO() {
		return addressNO;
	}
	public void setAddressNO(int addressNO) {
		this.addressNO = addressNO;
	}
}
