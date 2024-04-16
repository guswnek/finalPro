package com.spring.finalpro.member.dto;

import java.sql.Date;

public class MemberSizeDTO {
	private int sizeNO; 
	private String memberId;
	private String sizeCategory;
	private int topTotalLength;
	private int shoulderLength;
	private int chestCrossLength;
	private int sleevelength;
	private int pantsTotalLength;
	private int  waistCrossLength;
	private int  hipCrossLength; 
	private int thighCrossLength;
	private int riseLength;
	private int hemCrossLength;
	private int footLength;
	private int ballOfFoot;
	private int ankleHeight;
	private int instepHeight;
	private Date regDate ;
	public int getSizeNO() {
		return sizeNO;
	}
	public void setSizeNO(int sizeNO) {
		this.sizeNO = sizeNO;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getSizeCategory() {
		return sizeCategory;
	}
	public void setSizeCategory(String sizeCategory) {
		this.sizeCategory = sizeCategory;
	}
	public int getTopTotalLength() {
		return topTotalLength;
	}
	public void setTopTotalLength(int topTotalLength) {
		this.topTotalLength = topTotalLength;
	}
	public int getShoulderLength() {
		return shoulderLength;
	}
	public void setShoulderLength(int shoulderLength) {
		this.shoulderLength = shoulderLength;
	}
	public int getChestCrossLength() {
		return chestCrossLength;
	}
	public void setChestCrossLength(int chestCrossLength) {
		this.chestCrossLength = chestCrossLength;
	}
	public int getSleevelength() {
		return sleevelength;
	}
	public void setSleevelength(int sleevelength) {
		this.sleevelength = sleevelength;
	}
	public int getPantsTotalLength() {
		return pantsTotalLength;
	}
	public void setPantsTotalLength(int pantsTotalLength) {
		this.pantsTotalLength = pantsTotalLength;
	}
	public int getWaistCrossLength() {
		return waistCrossLength;
	}
	public void setWaistCrossLength(int waistCrossLength) {
		this.waistCrossLength = waistCrossLength;
	}
	public int getHipCrossLength() {
		return hipCrossLength;
	}
	public void setHipCrossLength(int hipCrossLength) {
		this.hipCrossLength = hipCrossLength;
	}
	public int getThighCrossLength() {
		return thighCrossLength;
	}
	public void setThighCrossLength(int thighCrossLength) {
		this.thighCrossLength = thighCrossLength;
	}
	public int getRiseLength() {
		return riseLength;
	}
	public void setRiseLength(int riseLength) {
		this.riseLength = riseLength;
	}
	public int getHemCrossLength() {
		return hemCrossLength;
	}
	public void setHemCrossLength(int hemCrossLength) {
		this.hemCrossLength = hemCrossLength;
	}
	public int getFootLength() {
		return footLength;
	}
	public void setFootLength(int footLength) {
		this.footLength = footLength;
	}
	public int getBallOfFoot() {
		return ballOfFoot;
	}
	public void setBallOfFoot(int ballOfFoot) {
		this.ballOfFoot = ballOfFoot;
	}
	public int getAnkleHeight() {
		return ankleHeight;
	}
	public void setAnkleHeight(int ankleHeight) {
		this.ankleHeight = ankleHeight;
	}
	public int getInstepHeight() {
		return instepHeight;
	}
	public void setInstepHeight(int instepHeight) {
		this.instepHeight = instepHeight;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	
	@Override
	public String toString() {
	    return "MemberSizeDTO{" +
	           ", memberId='" + memberId + '\'' +
	           ", sizeCategory='" + sizeCategory + '\'' +
	           ", topTotalLength='" + topTotalLength + '\'' +
	           ", shoulderLength='" + shoulderLength + '\'' +
	           ", chestCrossLength='" + chestCrossLength + '\'' +
	           ", sleevelength='" + sleevelength + '\'' +
	           '}';
	}

}
