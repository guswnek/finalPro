package com.spring.finalpro.post.dto;

import lombok.Data;

@Data
public class MagazineBrandDTO {
	private String brand;
	private String brandEng;	
	private int magazineCount;
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getBrandEng() {
		return brandEng;
	}
	public void setBrandEng(String brandEng) {
		this.brandEng = brandEng;
	}
	public int getMagazineCount() {
		return magazineCount;
	}
	public void setMagazineCount(int magazineCount) {
		this.magazineCount = magazineCount;
	}	
	
	
}
