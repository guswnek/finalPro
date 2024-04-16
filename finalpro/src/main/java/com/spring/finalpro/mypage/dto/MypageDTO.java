package com.spring.finalpro.mypage.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MypageDTO {
   
   private int no;
   private String memberId;
   private String imageFileName;
   private String brand;
   private String name;
   private String subcategory;
   private String productSize;
   private Date orderDate;
   private int orderNo;
   private String orderPrice;      // 상품 가격 * 수량
   private String deliveryStatus;
   private int quantity;
   private int likeCount;
   private int inlike;
   private int inbascket;
   private String price;   // 상품 가격
   private String productNo;
   private String color1;
   private int count;
   private int stock;   
   private int checkReview;   // 리뷰 작성 확인
   
   // 배송
   private int deliveryRequest;      // 요청사항
   private String receiverName;
   private String receiverPhone;
   private String receiverAdress;
   private int payment;
   private int paymentCard;
   private int paymentMonth;
   private int paymentBank;
public int getNo() {
	return no;
}
public void setNo(int no) {
	this.no = no;
}
public String getMemberId() {
	return memberId;
}
public void setMemberId(String memberId) {
	this.memberId = memberId;
}
public String getImageFileName() {
	return imageFileName;
}
public void setImageFileName(String imageFileName) {
	this.imageFileName = imageFileName;
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
public String getSubcategory() {
	return subcategory;
}
public void setSubcategory(String subcategory) {
	this.subcategory = subcategory;
}
public String getProductSize() {
	return productSize;
}
public void setProductSize(String productSize) {
	this.productSize = productSize;
}
public Date getOrderDate() {
	return orderDate;
}
public void setOrderDate(Date orderDate) {
	this.orderDate = orderDate;
}
public int getOrderNo() {
	return orderNo;
}
public void setOrderNo(int orderNo) {
	this.orderNo = orderNo;
}
public String getOrderPrice() {
	return orderPrice;
}
public void setOrderPrice(String orderPrice) {
	this.orderPrice = orderPrice;
}
public String getDeliveryStatus() {
	return deliveryStatus;
}
public void setDeliveryStatus(String deliveryStatus) {
	this.deliveryStatus = deliveryStatus;
}
public int getQuantity() {
	return quantity;
}
public void setQuantity(int quantity) {
	this.quantity = quantity;
}
public int getLikeCount() {
	return likeCount;
}
public void setLikeCount(int likeCount) {
	this.likeCount = likeCount;
}
public int getInlike() {
	return inlike;
}
public void setInlike(int inlike) {
	this.inlike = inlike;
}
public int getInbascket() {
	return inbascket;
}
public void setInbascket(int inbascket) {
	this.inbascket = inbascket;
}
public String getPrice() {
	return price;
}
public void setPrice(String price) {
	this.price = price;
}
public String getProductNo() {
	return productNo;
}
public void setProductNo(String productNo) {
	this.productNo = productNo;
}
public String getColor1() {
	return color1;
}
public void setColor1(String color1) {
	this.color1 = color1;
}
public int getCount() {
	return count;
}
public void setCount(int count) {
	this.count = count;
}
public int getStock() {
	return stock;
}
public void setStock(int stock) {
	this.stock = stock;
}
public int getCheckReview() {
	return checkReview;
}
public void setCheckReview(int checkReview) {
	this.checkReview = checkReview;
}
public int getDeliveryRequest() {
	return deliveryRequest;
}
public void setDeliveryRequest(int deliveryRequest) {
	this.deliveryRequest = deliveryRequest;
}
public String getReceiverName() {
	return receiverName;
}
public void setReceiverName(String receiverName) {
	this.receiverName = receiverName;
}
public String getReceiverPhone() {
	return receiverPhone;
}
public void setReceiverPhone(String receiverPhone) {
	this.receiverPhone = receiverPhone;
}
public String getReceiverAdress() {
	return receiverAdress;
}
public void setReceiverAdress(String receiverAdress) {
	this.receiverAdress = receiverAdress;
}
public int getPayment() {
	return payment;
}
public void setPayment(int payment) {
	this.payment = payment;
}
public int getPaymentCard() {
	return paymentCard;
}
public void setPaymentCard(int paymentCard) {
	this.paymentCard = paymentCard;
}
public int getPaymentMonth() {
	return paymentMonth;
}
public void setPaymentMonth(int paymentMonth) {
	this.paymentMonth = paymentMonth;
}
public int getPaymentBank() {
	return paymentBank;
}
public void setPaymentBank(int paymentBank) {
	this.paymentBank = paymentBank;
}


   
}