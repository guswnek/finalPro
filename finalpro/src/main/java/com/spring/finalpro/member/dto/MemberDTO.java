package com.spring.finalpro.member.dto;

import java.sql.Date;
import java.util.List;

public class MemberDTO {
	 private String id;
	 private String pwd;
	 private String name;
	 private int birthdate; 
	 private String email;
	 private String phone;
	 private String gender;
	 private int height;
	 private int weight;
	 private String personalColor;
	 private String memberId; 
	 private String loginId;
	 private List<MemberAddressDTO> addresses;
	 private Date regdate;
	
	


	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public int getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(int birthdate) {
		this.birthdate = birthdate;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public int getHeight() {
		return height;
	}
	public void setHeight(int height) {
		this.height = height;
	}
	public int getWeight() {
		return weight;
	}
	public void setWeight(int weight) {
		this.weight = weight;
	}
	public String getPersonalColor() {
		return personalColor;
	}
	public void setPersonalColor(String personalColor) {
		this.personalColor = personalColor;
	}
	
public List<MemberAddressDTO> getAddresses() {
		return addresses;
	}
	public void setAddresses(List<MemberAddressDTO> addresses) {
		this.addresses = addresses;
	}

	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	
	
	
}
