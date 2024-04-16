package com.spring.finalpro.product.dto;

import lombok.Data;

@Data
public class ProductSizeDTO {
	private String productNo;
	private String productSize;
	private String subCategory;
	private Integer stock;
	private Integer topTotalLength;
	private Integer shoulderLength;
	private Integer chestCrossLength;
	private Integer sleevelength;
	private Integer waistCrossLength;
	private Integer hipCrossLength;
	private Integer thighCrossLength;
	private Integer riseLength;
	private Integer hemCrossLength;
	private Integer footLength;
	private Integer ballOfFoot;
	private Integer ankleHeight;
	private Integer instepHeight;
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
	public String getSubCategory() {
		return subCategory;
	}
	public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}
	public Integer getStock() {
		return stock;
	}
	public void setStock(Integer stock) {
		this.stock = stock;
	}
	public Integer getTopTotalLength() {
		return topTotalLength;
	}
	public void setTopTotalLength(Integer topTotalLength) {
		this.topTotalLength = topTotalLength;
	}
	public Integer getShoulderLength() {
		return shoulderLength;
	}
	public void setShoulderLength(Integer shoulderLength) {
		this.shoulderLength = shoulderLength;
	}
	public Integer getChestCrossLength() {
		return chestCrossLength;
	}
	public void setChestCrossLength(Integer chestCrossLength) {
		this.chestCrossLength = chestCrossLength;
	}
	public Integer getSleevelength() {
		return sleevelength;
	}
	public void setSleevelength(Integer sleevelength) {
		this.sleevelength = sleevelength;
	}
	public Integer getWaistCrossLength() {
		return waistCrossLength;
	}
	public void setWaistCrossLength(Integer waistCrossLength) {
		this.waistCrossLength = waistCrossLength;
	}
	public Integer getHipCrossLength() {
		return hipCrossLength;
	}
	public void setHipCrossLength(Integer hipCrossLength) {
		this.hipCrossLength = hipCrossLength;
	}
	public Integer getThighCrossLength() {
		return thighCrossLength;
	}
	public void setThighCrossLength(Integer thighCrossLength) {
		this.thighCrossLength = thighCrossLength;
	}
	public Integer getRiseLength() {
		return riseLength;
	}
	public void setRiseLength(Integer riseLength) {
		this.riseLength = riseLength;
	}
	public Integer getHemCrossLength() {
		return hemCrossLength;
	}
	public void setHemCrossLength(Integer hemCrossLength) {
		this.hemCrossLength = hemCrossLength;
	}
	public Integer getFootLength() {
		return footLength;
	}
	public void setFootLength(Integer footLength) {
		this.footLength = footLength;
	}
	public Integer getBallOfFoot() {
		return ballOfFoot;
	}
	public void setBallOfFoot(Integer ballOfFoot) {
		this.ballOfFoot = ballOfFoot;
	}
	public Integer getAnkleHeight() {
		return ankleHeight;
	}
	public void setAnkleHeight(Integer ankleHeight) {
		this.ankleHeight = ankleHeight;
	}
	public Integer getInstepHeight() {
		return instepHeight;
	}
	public void setInstepHeight(Integer instepHeight) {
		this.instepHeight = instepHeight;
	}
	
}
