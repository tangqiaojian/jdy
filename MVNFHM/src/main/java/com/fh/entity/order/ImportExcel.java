package com.fh.entity.order;

public class ImportExcel {

	
	private String orderId;   // 订单号
	private String consignee; // 收货人姓名
	private String consigneetelephone; // 收货人电话
	private String consigneeaddress; // 收货人地址
	private String consigneeprovince = ""; // 收货人所在省份
	private String consigneecity = ""; // 收货人所在市
	private String consigneedistrict = ""; // 收货人所在区县
	private String tradename;  //商品名称
	private String count; //商品数量
	private String cardNO; //证件号码
	
	
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getConsignee() {
		return consignee;
	}
	public void setConsignee(String consignee) {
		this.consignee = consignee;
	}
	public String getConsigneetelephone() {
		return consigneetelephone;
	}
	public void setConsigneetelephone(String consigneetelephone) {
		this.consigneetelephone = consigneetelephone;
	}
	public String getConsigneeaddress() {
		return consigneeaddress;
	}
	public void setConsigneeaddress(String consigneeaddress) {
		this.consigneeaddress = consigneeaddress;
	}
	public String getConsigneeprovince() {
		return consigneeprovince;
	}
	public void setConsigneeprovince(String consigneeprovince) {
		this.consigneeprovince = consigneeprovince;
	}
	public String getConsigneecity() {
		return consigneecity;
	}
	public void setConsigneecity(String consigneecity) {
		this.consigneecity = consigneecity;
	}
	public String getConsigneedistrict() {
		return consigneedistrict;
	}
	public void setConsigneedistrict(String consigneedistrict) {
		this.consigneedistrict = consigneedistrict;
	}
	public String getTradename() {
		return tradename;
	}
	public void setTradename(String tradename) {
		this.tradename = tradename;
	}
	public String getCount() {
		return count;
	}
	public void setCount(String count) {
		this.count = count;
	}
	public String getCardNO() {
		return cardNO;
	}
	public void setCardNO(String cardNO) {
		this.cardNO = cardNO;
	}
	
}
