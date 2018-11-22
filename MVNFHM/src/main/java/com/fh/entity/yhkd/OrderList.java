package com.fh.entity.yhkd;

public class OrderList {

	private String itemno = "";
	
	private String itemname; // 商品名称
	
	private String itembrand; // 商品品牌
	
	private String specmodel; // 规格型号
	
	private String price;  //单价
	
	private String quotedprice; //保价金额，没有填 0

	private String netweight;  // 净重
	
	private String packno; //件数
	
	private String producecountry;  //原厂国

	public String getItemno() {
		return itemno;
	}

	public void setItemno(String itemno) {
		this.itemno = itemno;
	}

	public String getItemname() {
		return itemname;
	}

	public void setItemname(String itemname) {
		this.itemname = itemname;
	}

	public String getItembrand() {
		return itembrand;
	}

	public void setItembrand(String itembrand) {
		this.itembrand = itembrand;
	}

	public String getSpecmodel() {
		return specmodel;
	}

	public void setSpecmodel(String specmodel) {
		this.specmodel = specmodel;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getQuotedprice() {
		return quotedprice;
	}

	public void setQuotedprice(String quotedprice) {
		this.quotedprice = quotedprice;
	}

	public String getNetweight() {
		return netweight;
	}

	public void setNetweight(String netweight) {
		this.netweight = netweight;
	}

	public String getPackno() {
		return packno;
	}

	public void setPackno(String packno) {
		this.packno = packno;
	}

	public String getProducecountry() {
		return producecountry;
	}

	public void setProducecountry(String producecountry) {
		this.producecountry = producecountry;
	}
	
}
