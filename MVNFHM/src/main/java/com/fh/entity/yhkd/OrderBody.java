package com.fh.entity.yhkd;

public class OrderBody {

	private  String guid;   //企业系统生成 36位唯一序号
	private String apptype;  //企业报送类型 1-新增 2-变更 
	private String apptime;  //企业报送时间
	 
	private String ordertype = "I" ;  //电子订单类型
	private String billno;    // 总运单号/提单号(虚拟总单号-类似批次号) 航空号--随机生成
	private String sourceno ;  // 包裹主键
	
	private  String consignor;  //发货人
	private String consignortelephone;  //发货人电话
	private String consignoraddress; //发货人地址
	private String consignorprovince = ""; //发货人所在省份N
	private String consignorcity = "";  // 发货人所在市N
	private String consignordistrict = "" ;  // 发货人所在区县N
	
	private String consignorcountry = "501";  //发货人所在国 默认加拿大 501 
    private String consignoridnumber;  //发货人证件号码
 	    
    private String consignee;  //收货人姓名
    private String consigneetelephone; // 收货人电话
    private String consigneeaddress;  // 收货人地址
    private String consigneeprovince="";  //收货人所在省份  
    private String consigneecity=""; // 收货人所在市  
    private  String consigneedistrict="";  //收货人所在区县 
    
    private  String  consigneecountry = "142"; //收货人所在国 (设置为中国)
    private  String  consigneeidnumber;  //收货人证件号码
    
    private String goodsvalue;  //商品价值
    private String currency = "CNY";   //币制 
    private String quotedprice = "0"; //保价金额
    private String grossweight; //毛重 填写的重量
    private String netweight;   //净重 商品的重量
    private String goodsqty; //总件数
    
    private String expressway = "jjyunda" ;  //快递公司代码 快递公司代码(jjyunda 晋江韵达）
    private String remark = "" ; //备注
	
    
    public String getGuid() {
		return guid;
	}
	public void setGuid(String guid) {
		this.guid = guid;
	}
	public String getApptype() {
		return apptype;
	}
	public void setApptype(String apptype) {
		this.apptype = apptype;
	}
	public String getApptime() {
		return apptime;
	}
	public void setApptime(String apptime) {
		this.apptime = apptime;
	}
	public String getOrdertype() {
		return ordertype;
	}
	public void setOrdertype(String ordertype) {
		this.ordertype = ordertype;
	}
	public String getBillno() {
		return billno;
	}
	public void setBillno(String billno) {
		this.billno = billno;
	}
	public String getSourceno() {
		return sourceno;
	}
	public void setSourceno(String sourceno) {
		this.sourceno = sourceno;
	}
	public String getConsignor() {
		return consignor;
	}
	public void setConsignor(String consignor) {
		this.consignor = consignor;
	}
	public String getConsignortelephone() {
		return consignortelephone;
	}
	public void setConsignortelephone(String consignortelephone) {
		this.consignortelephone = consignortelephone;
	}
	public String getConsignoraddress() {
		return consignoraddress;
	}
	public void setConsignoraddress(String consignoraddress) {
		this.consignoraddress = consignoraddress;
	}
	public String getConsignorprovince() {
		return consignorprovince;
	}
	public void setConsignorprovince(String consignorprovince) {
		this.consignorprovince = consignorprovince;
	}
	public String getConsignorcity() {
		return consignorcity;
	}
	public void setConsignorcity(String consignorcity) {
		this.consignorcity = consignorcity;
	}
	public String getConsignordistrict() {
		return consignordistrict;
	}
	public void setConsignordistrict(String consignordistrict) {
		this.consignordistrict = consignordistrict;
	}
	public String getConsignorcountry() {
		return consignorcountry;
	}
	public void setConsignorcountry(String consignorcountry) {
		this.consignorcountry = consignorcountry;
	}
	public String getConsignoridnumber() {
		return consignoridnumber;
	}
	public void setConsignoridnumber(String consignoridnumber) {
		this.consignoridnumber = consignoridnumber;
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
	public String getConsigneecountry() {
		return consigneecountry;
	}
	public void setConsigneecountry(String consigneecountry) {
		this.consigneecountry = consigneecountry;
	}
	public String getConsigneeidnumber() {
		return consigneeidnumber;
	}
	public void setConsigneeidnumber(String consigneeidnumber) {
		this.consigneeidnumber = consigneeidnumber;
	}
	public String getGoodsvalue() {
		return goodsvalue;
	}
	public void setGoodsvalue(String goodsvalue) {
		this.goodsvalue = goodsvalue;
	}
	public String getCurrency() {
		return currency;
	}
	public void setCurrency(String currency) {
		this.currency = currency;
	}
	public String getQuotedprice() {
		return quotedprice;
	}
	public void setQuotedprice(String quotedprice) {
		this.quotedprice = quotedprice;
	}
	public String getGrossweight() {
		return grossweight;
	}
	public void setGrossweight(String grossweight) {
		this.grossweight = grossweight;
	}
	public String getNetweight() {
		return netweight;
	}
	public void setNetweight(String netweight) {
		this.netweight = netweight;
	}
	public String getGoodsqty() {
		return goodsqty;
	}
	public void setGoodsqty(String goodsqty) {
		this.goodsqty = goodsqty;
	}
	public String getExpressway() {
		return expressway;
	}
	public void setExpressway(String expressway) {
		this.expressway = expressway;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
}
