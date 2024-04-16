package com.spring.finalpro.common.dto;

import java.sql.Date;

import lombok.Data;

@Data 
public class ImageDTO {
	private int no;
	private String imageFileName;
	private Date regDate;
	private String productNo;
	private String brand;
	private String introduce;
	private String bannerImageFileName;
	private String magazineNo;
	private String title;
	private String subTitle;
	private String content;
	private int imageNumber;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
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
	public String getProductNo() {
		return productNo;
	}
	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getIntroduce() {
		return introduce;
	}
	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}
	public String getBannerImageFileName() {
		return bannerImageFileName;
	}
	public void setBannerImageFileName(String bannerImageFileName) {
		this.bannerImageFileName = bannerImageFileName;
	}
	public String getMagazineNo() {
		return magazineNo;
	}
	public void setMagazineNo(String magazineNo) {
		this.magazineNo = magazineNo;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSubTitle() {
		return subTitle;
	}
	public void setSubTitle(String subTitle) {
		this.subTitle = subTitle;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getImageNumber() {
		return imageNumber;
	}
	public void setImageNumber(int imageNumber) {
		this.imageNumber = imageNumber;
	}
	
	
}
