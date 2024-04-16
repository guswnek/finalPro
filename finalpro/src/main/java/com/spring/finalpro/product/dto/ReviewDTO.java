package com.spring.finalpro.product.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewDTO {
	private int reviewNo;
	private int orderNo;
	private String memberId;
	private String productNo;
	private String productSize;
	private Integer starScore;
	private Integer sizeAssessment;
	private Integer brightAssessment;
	private Integer colorAssessment;
	private Integer thickAssessment;
	private Integer deliveryAssessment;
	private Integer packAssessment;
	private String content;
	private String imageFileName;
	private Date regDate;
	private String gender;
	private String productName;
	private String memberGender;
	private Integer memberHeight;
	private Integer memberWeight;
	private Integer replyCount;
	private Double height;
	private Double weight;
	private String brand;
	private String name;
	private String productImageFileName;
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getProductNo() {
		return productNo;
	}
	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}
	public String getProductSize() {
		return productSize;
	}
	public void setProductSize(String productSize) {
		this.productSize = productSize;
	}
	public Integer getStarScore() {
		return starScore;
	}
	public void setStarScore(Integer starScore) {
		this.starScore = starScore;
	}
	public Integer getSizeAssessment() {
		return sizeAssessment;
	}
	public void setSizeAssessment(Integer sizeAssessment) {
		this.sizeAssessment = sizeAssessment;
	}
	public Integer getBrightAssessment() {
		return brightAssessment;
	}
	public void setBrightAssessment(Integer brightAssessment) {
		this.brightAssessment = brightAssessment;
	}
	public Integer getColorAssessment() {
		return colorAssessment;
	}
	public void setColorAssessment(Integer colorAssessment) {
		this.colorAssessment = colorAssessment;
	}
	public Integer getThickAssessment() {
		return thickAssessment;
	}
	public void setThickAssessment(Integer thickAssessment) {
		this.thickAssessment = thickAssessment;
	}
	public Integer getDeliveryAssessment() {
		return deliveryAssessment;
	}
	public void setDeliveryAssessment(Integer deliveryAssessment) {
		this.deliveryAssessment = deliveryAssessment;
	}
	public Integer getPackAssessment() {
		return packAssessment;
	}
	public void setPackAssessment(Integer packAssessment) {
		this.packAssessment = packAssessment;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getMemberGender() {
		return memberGender;
	}
	public void setMemberGender(String memberGender) {
		this.memberGender = memberGender;
	}
	public Integer getMemberHeight() {
		return memberHeight;
	}
	public void setMemberHeight(Integer memberHeight) {
		this.memberHeight = memberHeight;
	}
	public Integer getMemberWeight() {
		return memberWeight;
	}
	public void setMemberWeight(Integer memberWeight) {
		this.memberWeight = memberWeight;
	}
	public Integer getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(Integer replyCount) {
		this.replyCount = replyCount;
	}
	public Double getHeight() {
		return height;
	}
	public void setHeight(Double height) {
		this.height = height;
	}
	public Double getWeight() {
		return weight;
	}
	public void setWeight(Double weight) {
		this.weight = weight;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProductImageFileName() {
		return productImageFileName;
	}
	public void setProductImageFileName(String productImageFileName) {
		this.productImageFileName = productImageFileName;
	}
	
}
