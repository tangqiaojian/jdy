package com.fh.entity.order;

import java.util.List;

/**
 * 订单信息
 * @author HL0523
 *
 */
public class Order {

	private String ORDERNO;	
	private String STOREID;	
	private String SENDER;
	private String ADDRESSEE;
	private String SENDERSTR;
	private String ADDRESSEESTR;
	private String CREATEBY;
	private String CREATETIME;	
	private String UPDATEBY;	
	private String UPDATETIME;	
	private String ISDELETE;
	private String STATEA;
	private String ORDER_ID;
	
	private Double FREIGHT; 
	private String LOGISTICS;
	
	private String STORENAME; //门店名称
	private String DISCOUNT; //折扣信息
	
	private String CUSTOMER_ID; //大客户

	private String PALLET_NO;  // 托盘号
	private String PALLET_TIME; //打托时间
	private String AVIATION_NO;  //航空单号
	private String DELIVERY_TIME; //发货时间
	
	

	private List<ParcelArticles> parcelArticles;   //寄件物品信息
	private List<Parcel> parcels;  //包裹信息
	private Integer parcelCount;   //包裹数量
	
	private Integer APPLY_STATUS;  // 运单申请状态
	
	
	
	
	
	
	public String getPALLET_NO() {
		return PALLET_NO;
	}
	
	public void setPALLET_NO(String pALLET_NO) {
		PALLET_NO = pALLET_NO;
	}
	
	public String getPALLET_TIME() {
		return PALLET_TIME;
	}
	
	public void setPALLET_TIME(String pALLET_TIME) {
		PALLET_TIME = pALLET_TIME;
	}
	
	public String getAVIATION_NO() {
		return AVIATION_NO;
	}
	
	public void setAVIATION_NO(String aVIATION_NO) {
		AVIATION_NO = aVIATION_NO;
	}
	public String getDELIVERY_TIME() {
		return DELIVERY_TIME;
	}
	public void setDELIVERY_TIME(String dELIVERY_TIME) {
		DELIVERY_TIME = dELIVERY_TIME;
	}
	public String getDISCOUNT() {
		return DISCOUNT;
	}
	public void setDISCOUNT(String dISCOUNT) {
		DISCOUNT = dISCOUNT;
	}
	public Double getFREIGHT() {
		return FREIGHT;
	}
	public void setFREIGHT(Double fREIGHT) {
		FREIGHT = fREIGHT;
	}
	public String getLOGISTICS() {
		return LOGISTICS;
	}
	public void setLOGISTICS(String lOGISTICS) {
		LOGISTICS = lOGISTICS;
	}
	
	public String getORDERNO() {
		return ORDERNO;
	}
	public void setORDERNO(String oRDERNO) {
		ORDERNO = oRDERNO;
	}
	public String getSTOREID() {
		return STOREID;
	}
	public void setSTOREID(String sTOREID) {
		STOREID = sTOREID;
	}
	public String getSENDER() {
		return SENDER;
	}
	public void setSENDER(String sENDER) {
		SENDER = sENDER;
	}
	public String getADDRESSEE() {
		return ADDRESSEE;
	}
	public void setADDRESSEE(String aDDRESSEE) {
		ADDRESSEE = aDDRESSEE;
	}
	public String getSENDERSTR() {
		return SENDERSTR;
	}
	public void setSENDERSTR(String sENDERSTR) {
		SENDERSTR = sENDERSTR;
	}
	public String getADDRESSEESTR() {
		return ADDRESSEESTR;
	}
	public void setADDRESSEESTR(String aDDRESSEESTR) {
		ADDRESSEESTR = aDDRESSEESTR;
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
	public String getISDELETE() {
		return ISDELETE;
	}
	public void setISDELETE(String iSDELETE) {
		ISDELETE = iSDELETE;
	}
	public String getSTATEA() {
		return STATEA;
	}
	public void setSTATEA(String sTATEA) {
		STATEA = sTATEA;
	}
	public String getORDER_ID() {
		return ORDER_ID;
	}
	public void setORDER_ID(String oRDER_ID) {
		ORDER_ID = oRDER_ID;
	}
	public List<ParcelArticles> getParcelArticles() {
		return parcelArticles;
	}
	public void setParcelArticles(List<ParcelArticles> parcelArticles) {
		this.parcelArticles = parcelArticles;
	}
	public List<Parcel> getParcels() {
		return parcels;
	}
	public void setParcels(List<Parcel> parcels) {
		this.parcels = parcels;
	}
	public String getSTORENAME() {
		return STORENAME;
	}
	public void setSTORENAME(String sTORENAME) {
		STORENAME = sTORENAME;
	}
	public Integer getParcelCount() {
		return parcelCount;
	}
	public void setParcelCount(Integer parcelCount) {
		this.parcelCount = parcelCount;
	}

	public Integer getAPPLY_STATUS() {
		return APPLY_STATUS;
	}

	public void setAPPLY_STATUS(Integer aPPLY_STATUS) {
		APPLY_STATUS = aPPLY_STATUS;
	}

	public String getCUSTOMER_ID() {
		return CUSTOMER_ID;
	}

	public void setCUSTOMER_ID(String cUSTOMER_ID) {
		CUSTOMER_ID = cUSTOMER_ID;
	}
	
}
