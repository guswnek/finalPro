package com.spring.finalpro.product.dto;

import java.sql.Date;

import lombok.Data;


//product_(base, image, size), review table join
@Data
public class Product_totalDTO {
	private String productNo; //ǰ��
	private String parentProductNo; //
	private String name; //��ǰ��
	private String brand; //�귣�� �ѱ۸�
	private String brandEng; //�귣�� �����
	private String gender;
	private String price; //����(����Ŭ������ number���� ����Ҷ� ���ݿ� , ���̱� ���� ���ڿ� ó���Ǽ� ��µǹǷ� �޴� �� varchar�� ����)
	private String category; //����,����,����,����,�ƿ���,�Ź�
	private String subCategory; //(������,�ĵ�,Ƽ����/����,�ȭ)
	private Date regDate; //��ǰ��� ��¥
	private String color1;
	private String color2;
	private String color3;
	private String material; //����
	
	private String imageFileName;
	
	private String productSize; // ��ǰ������
	private double topTotalLength; //��������
	private double shoulderLength; //����ʺ�
	private double chestCrossLength; //�����ܸ�
	private double sleevelength; //�Ҹű���
	private double waistCrossLength; //�㸮 �ܸ�
	private double hipCrossLength; //������ �ܸ�
	private double thighCrossLength; //����� �ܸ�
	private double riseLength; //����
	private double hemCrossLength; //�ش�
	private double footLength; //�� ����
	private double ballOfFoot; //�� ��
	private double ankleHeight; //�߸�
	private double instepHeight; //�� ����
	
    private float avg_starScore; //����
    private int review_count; //���� ��
	public String getProductNo() {
		return productNo;
	}
	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}
	public String getParentProductNo() {
		return parentProductNo;
	}
	public void setParentProductNo(String parentProductNo) {
		this.parentProductNo = parentProductNo;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
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
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSubCategory() {
		return subCategory;
	}
	public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public String getColor1() {
		return color1;
	}
	public void setColor1(String color1) {
		this.color1 = color1;
	}
	public String getColor2() {
		return color2;
	}
	public void setColor2(String color2) {
		this.color2 = color2;
	}
	public String getColor3() {
		return color3;
	}
	public void setColor3(String color3) {
		this.color3 = color3;
	}
	public String getMaterial() {
		return material;
	}
	public void setMaterial(String material) {
		this.material = material;
	}
	public String getImageFileName() {
		return imageFileName;
	}
	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}
	public String getProductSize() {
		return productSize;
	}
	public void setProductSize(String productSize) {
		this.productSize = productSize;
	}
	public double getTopTotalLength() {
		return topTotalLength;
	}
	public void setTopTotalLength(double topTotalLength) {
		this.topTotalLength = topTotalLength;
	}
	public double getShoulderLength() {
		return shoulderLength;
	}
	public void setShoulderLength(double shoulderLength) {
		this.shoulderLength = shoulderLength;
	}
	public double getChestCrossLength() {
		return chestCrossLength;
	}
	public void setChestCrossLength(double chestCrossLength) {
		this.chestCrossLength = chestCrossLength;
	}
	public double getSleevelength() {
		return sleevelength;
	}
	public void setSleevelength(double sleevelength) {
		this.sleevelength = sleevelength;
	}
	public double getWaistCrossLength() {
		return waistCrossLength;
	}
	public void setWaistCrossLength(double waistCrossLength) {
		this.waistCrossLength = waistCrossLength;
	}
	public double getHipCrossLength() {
		return hipCrossLength;
	}
	public void setHipCrossLength(double hipCrossLength) {
		this.hipCrossLength = hipCrossLength;
	}
	public double getThighCrossLength() {
		return thighCrossLength;
	}
	public void setThighCrossLength(double thighCrossLength) {
		this.thighCrossLength = thighCrossLength;
	}
	public double getRiseLength() {
		return riseLength;
	}
	public void setRiseLength(double riseLength) {
		this.riseLength = riseLength;
	}
	public double getHemCrossLength() {
		return hemCrossLength;
	}
	public void setHemCrossLength(double hemCrossLength) {
		this.hemCrossLength = hemCrossLength;
	}
	public double getFootLength() {
		return footLength;
	}
	public void setFootLength(double footLength) {
		this.footLength = footLength;
	}
	public double getBallOfFoot() {
		return ballOfFoot;
	}
	public void setBallOfFoot(double ballOfFoot) {
		this.ballOfFoot = ballOfFoot;
	}
	public double getAnkleHeight() {
		return ankleHeight;
	}
	public void setAnkleHeight(double ankleHeight) {
		this.ankleHeight = ankleHeight;
	}
	public double getInstepHeight() {
		return instepHeight;
	}
	public void setInstepHeight(double instepHeight) {
		this.instepHeight = instepHeight;
	}
	public float getAvg_starScore() {
		return avg_starScore;
	}
	public void setAvg_starScore(float avg_starScore) {
		this.avg_starScore = avg_starScore;
	}
	public int getReview_count() {
		return review_count;
	}
	public void setReview_count(int review_count) {
		this.review_count = review_count;
	}
    
    

    
    
	


	
}
