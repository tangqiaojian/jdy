package com.fh.entity.order;

import java.util.List;

import com.fh.util.PageData;

/**
 * 包裹信息
 * @author HL0523
 *
 */
public class Parcel {

	private String PACK_NAME;	
	private String PACK_TYPE;
	private String PACK_TYPE_NAME;	
	private String FEE_SCALE;	
	private String WEIGHT;	  //门店称重重量 (磅)
	private String PACK_COST;	
	private String GOODS_PK;
	private String TOTAL_COST;	
	private String CREATEBY;
	private String CREATETIME;	
	private String UPDATEBY;
	private String UPDATETIME;
	private String PACKJSONARR;
	private String ORDER_ID;	
	private String PARCEL_ID;
	
	private String COURIER;
	private String COURIER_BM;
	private String LOGISTICS;
	private Integer APPLY_STATUS;
	private String Sourceno;  //配件单号
	private String reweighting;  //二次称重重量 (磅)
	private String XM_WEIGHT; //推送给厦门的毛重
	
	
	private String guid;
	private Integer parcelArticlesCount;
	
	private Order order;   //包裹对应的订单信息	
	//包裹列表
	private List<ParcelArticles> parcelArticles;
	//留言板信息
	private List<MsgBoard> msgBoards;
	//寄件人
	private PageData sender;
	//收件人
	private PageData addressee;
	
	

	public String getCOURIER() {
		return COURIER;
	}
	public void setCOURIER(String cOURIER) {
		COURIER = cOURIER;
	}
	public String getCOURIER_BM() {
		return COURIER_BM;
	}
	public void setCOURIER_BM(String cOURIER_BM) {
		COURIER_BM = cOURIER_BM;
	}
	public String getLOGISTICS() {
		return LOGISTICS;
	}
	public void setLOGISTICS(String lOGISTICS) {
		LOGISTICS = lOGISTICS;
	}
	public Integer getAPPLY_STATUS() {
		return APPLY_STATUS;
	}
	public void setAPPLY_STATUS(Integer aPPLY_STATUS) {
		APPLY_STATUS = aPPLY_STATUS;
	}
	public String getPACK_NAME() {
		return PACK_NAME;
	}
	public void setPACK_NAME(String pACK_NAME) {
		PACK_NAME = pACK_NAME;
	}
	public String getPACK_TYPE() {
		return PACK_TYPE;
	}
	public void setPACK_TYPE(String pACK_TYPE) {
		PACK_TYPE = pACK_TYPE;
	}
	public String getPACK_TYPE_NAME() {
		return PACK_TYPE_NAME;
	}
	public void setPACK_TYPE_NAME(String pACK_TYPE_NAME) {
		PACK_TYPE_NAME = pACK_TYPE_NAME;
	}
	public String getFEE_SCALE() {
		return FEE_SCALE;
	}
	public void setFEE_SCALE(String fEE_SCALE) {
		FEE_SCALE = fEE_SCALE;
	}
	public String getWEIGHT() {
		return WEIGHT;
	}
	public void setWEIGHT(String wEIGHT) {
		WEIGHT = wEIGHT;
	}
	public String getPACK_COST() {
		return PACK_COST;
	}
	public void setPACK_COST(String pACK_COST) {
		PACK_COST = pACK_COST;
	}
	public String getGOODS_PK() {
		return GOODS_PK;
	}
	public void setGOODS_PK(String gOODS_PK) {
		GOODS_PK = gOODS_PK;
	}
	public String getTOTAL_COST() {
		return TOTAL_COST;
	}
	public void setTOTAL_COST(String tOTAL_COST) {
		TOTAL_COST = tOTAL_COST;
	}
	public String getCREATEBY() {
		return CREATEBY;
	}
	public void setCREATEBY(String cREATEBY) {
		CREATEBY = cREATEBY;
	}
	public String getCREATETIME() {
		return CREATETIME;
	}
	public void setCREATETIME(String cREATETIME) {
		CREATETIME = cREATETIME;
	}
	public String getUPDATEBY() {
		return UPDATEBY;
	}
	public void setUPDATEBY(String uPDATEBY) {
		UPDATEBY = uPDATEBY;
	}
	public String getUPDATETIME() {
		return UPDATETIME;
	}
	public void setUPDATETIME(String uPDATETIME) {
		UPDATETIME = uPDATETIME;
	}
	public String getPACKJSONARR() {
		return PACKJSONARR;
	}
	public void setPACKJSONARR(String pACKJSONARR) {
		PACKJSONARR = pACKJSONARR;
	}
	public String getORDER_ID() {
		return ORDER_ID;
	}
	public void setORDER_ID(String oRDER_ID) {
		ORDER_ID = oRDER_ID;
	}
	public String getPARCEL_ID() {
		return PARCEL_ID;
	}
	public void setPARCEL_ID(String pARCEL_ID) {
		PARCEL_ID = pARCEL_ID;
	}
	public String getGuid() {
		return guid;
	}
	public void setGuid(String guid) {
		this.guid = guid;
	}
	public Integer getParcelArticlesCount() {
		return parcelArticlesCount;
	}
	public void setParcelArticlesCount(Integer parcelArticlesCount) {
		this.parcelArticlesCount = parcelArticlesCount;
	}
	public List<ParcelArticles> getParcelArticles() {
		return parcelArticles;
	}
	public void setParcelArticles(List<ParcelArticles> parcelArticles) {
		this.parcelArticles = parcelArticles;
	}
	public List<MsgBoard> getMsgBoards() {
		return msgBoards;
	}
	public void setMsgBoards(List<MsgBoard> msgBoards) {
		this.msgBoards = msgBoards;
	}
	public String getSourceno() {
		return Sourceno;
	}
	public void setSourceno(String sourceno) {
		Sourceno = sourceno;
	}
	public String getReweighting() {
		return reweighting;
	}
	public void setReweighting(String reweighting) {
		this.reweighting = reweighting;
	}
	public Order getOrder() {
		return order;
	}
	public void setOrder(Order order) {
		this.order = order;
	}
	public PageData getSender() {
		return sender;
	}
	public void setSender(PageData sender) {
		this.sender = sender;
	}
	public PageData getAddressee() {
		return addressee;
	}
	public void setAddressee(PageData addressee) {
		this.addressee = addressee;
	}
	public String getXM_WEIGHT() {
		return XM_WEIGHT;
	}
	public void setXM_WEIGHT(String xM_WEIGHT) {
		XM_WEIGHT = xM_WEIGHT;
	}

	
}
