package com.spring.finalpro.product.dto;

import java.sql.Date;

public class SearchDTO {

	private String brand;
	private String bannerImageFileName;	// 브랜드 이미지 이름
	private int count;
	
	// 상품
	private String productNo;
	private String name;	// 상품명
	private String price;
	private String imageFileName;	// 상품 이미지 이름
	private int reviewCount;
	private Double starScore;
	
	// 스냅
	private String snapNo;
	private String modelName;
	private String snapImageFileName;
	private Date snapRegDate;
	
	// 매거진
	private int magazineNo;
	private String category;
	private String title;
	private Date magRegdate;
	
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getBannerImageFileName() {
		return bannerImageFileName;
	}
	public void setBannerImageFileName(String bannerImageFileName) {
		this.bannerImageFileName = bannerImageFileName;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProductNo() {
		return productNo;
	}
	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public int getReviewCount() {
		return reviewCount;
	}
	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}
	public Double getStarScore() {
		return starScore;
	}
	public void setStarScore(Double starScore) {
		this.starScore = starScore;
	}
	public String getSnapNo() {
		return snapNo;
	}
	public void setSnapNo(String snapNo) {
		this.snapNo = snapNo;
	}
	public String getModelName() {
		return modelName;
	}
	public void setModelName(String modelName) {
		this.modelName = modelName;
	}
	public String getSnapImageFileName() {
		return snapImageFileName;
	}
	public void setSnapImageFileName(String snapImageFileName) {
		this.snapImageFileName = snapImageFileName;
	}
	public Date getSnapRegDate() {
		return snapRegDate;
	}
	public void setSnapRegDate(Date snapRegDate) {
		this.snapRegDate = snapRegDate;
	}
	public int getMagazineNo() {
		return magazineNo;
	}
	public void setMagazineNo(int magazineNo) {
		this.magazineNo = magazineNo;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getMagRegdate() {
		return magRegdate;
	}
	public void setMagRegdate(Date magRegdate) {
		this.magRegdate = magRegdate;
	}
	
	
	
}
