package com.spring.finalpro.product.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewReplyDTO {
	private int replyNo;
	private int parentReplyNo;
	private String memberId;
	private int reviewNo;
	private String content;
	private Date regDate;
	private int childReplyCount;
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public int getParentReplyNo() {
		return parentReplyNo;
	}
	public void setParentReplyNo(int parentReplyNo) {
		this.parentReplyNo = parentReplyNo;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getRegDate() {
		return regDate;
	}
	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}
	public int getChildReplyCount() {
		return childReplyCount;
	}
	public void setChildReplyCount(int childReplyCount) {
		this.childReplyCount = childReplyCount;
	}
	
}
