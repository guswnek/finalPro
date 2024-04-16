package com.spring.finalpro.post.dto;

import lombok.Data;

@Data
public class BrandSnapDTO {
	private String snapNo;
	private String street;
	private String brand;
	private String color;
	private String name;
	private String job;
	private String price;
	private int height;
	private int weight;
	private int viewCount;
	private String productNo;
	private String productName;
	private int likeCount;
	private float averageStarScore;
	private String tag;
	
	private String snapImageFileName;
	private String productImageFileName;
	public String getSnapNo() {
		return snapNo;
	}
	public void setSnapNo(String snapNo) {
		this.snapNo = snapNo;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getJob() {
		return job;
	}
	public void setJob(String job) {
		this.job = job;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
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
	public int getViewCount() {
		return viewCount;
	}
	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}
	public String getProductNo() {
		return productNo;
	}
	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	public float getAverageStarScore() {
		return averageStarScore;
	}
	public void setAverageStarScore(float averageStarScore) {
		this.averageStarScore = averageStarScore;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getSnapImageFileName() {
		return snapImageFileName;
	}
	public void setSnapImageFileName(String snapImageFileName) {
		this.snapImageFileName = snapImageFileName;
	}
	public String getProductImageFileName() {
		return productImageFileName;
	}
	public void setProductImageFileName(String productImageFileName) {
		this.productImageFileName = productImageFileName;
	}
	
	

}
