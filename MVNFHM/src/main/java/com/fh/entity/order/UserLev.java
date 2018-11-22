package com.fh.entity.order;

/**
 * 用户等级
 * 
 * @author HL0523
 *
 */
public class UserLev {

	private String LEV_NAME;	
	private String LEV_PRICE_MIN;	
	private String LEV_PRICE_MAX;	
	private Double DISCOUNT;
	private String USERLEV_ID;
	
	private String CREATEBY;
	private String CREATETIME;	
	private String UPDATEBY;
	private String UPDATETIME;
	
	
	public String getLEV_NAME() {
		return LEV_NAME;
	}
	public void setLEV_NAME(String lEV_NAME) {
		LEV_NAME = lEV_NAME;
	}
	public String getLEV_PRICE_MIN() {
		return LEV_PRICE_MIN;
	}
	public void setLEV_PRICE_MIN(String lEV_PRICE_MIN) {
		LEV_PRICE_MIN = lEV_PRICE_MIN;
	}
	public String getLEV_PRICE_MAX() {
		return LEV_PRICE_MAX;
	}
	public void setLEV_PRICE_MAX(String lEV_PRICE_MAX) {
		LEV_PRICE_MAX = lEV_PRICE_MAX;
	}
	public Double getDISCOUNT() {
		return DISCOUNT;
	}
	public void setDISCOUNT(Double dISCOUNT) {
		DISCOUNT = dISCOUNT;
	}
	public String getUSERLEV_ID() {
		return USERLEV_ID;
	}
	public void setUSERLEV_ID(String uSERLEV_ID) {
		USERLEV_ID = uSERLEV_ID;
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
	
}
