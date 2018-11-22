package com.fh.entity.order;

import com.alibaba.fastjson.annotation.JSONField;

public class PersonInfo {

	@JSONField(name = "SENDER")
	private String SENDER;
	
	@JSONField(name = "S_ADDRESS")
	private String S_ADDRESS;
	
	@JSONField(name = "D_ADDRESS")
	private String D_ADDRESS;
	
	@JSONField(name = "PHONE")
	private String PHONE;
	
	@JSONField(name = "M_TYPE")
	private String M_TYPE;
	
	@JSONField(name = "IS_DEFAULT")
	private String IS_DEFAULT;
	
	@JSONField(name = "CREATEBY")
	private String CREATEBY;
	
	@JSONField(name = "CREATETIME")
	private String CREATETIME;
	
	@JSONField(name = "UPDATEBY")
	private String  UPDATEBY;
	
	@JSONField(name = "UPDATETIME")
	private String UPDATETIME;
	
	@JSONField(name = "ISDElETE")
	private String  ISDElETE;
	
	@JSONField(name = "CARD_NO")
	private String  CARD_NO;
	
	@JSONField(name = "ZIP_CODE")
	private String  ZIP_CODE;
	
	@JSONField(name = "MAIL_ADDR_ID")
	private String  MAIL_ADDR_ID;

	@JSONField(name = "FACE")
	private String  FACE;

	@JSONField(name = "OPPOSITE")
	private String  OPPOSITE;

	public String getFACE() {
		return FACE;
	}

	public void setFACE(String FACE) {
		this.FACE = FACE;
	}

	public String getOPPOSITE() {
		return OPPOSITE;
	}

	public void setOPPOSITE(String OPPOSITE) {
		this.OPPOSITE = OPPOSITE;
	}

	public String getSENDER() {
		return SENDER;
	}
	public void setSENDER(String sENDER) {
		SENDER = sENDER;
	}
	public String getS_ADDRESS() {
		return S_ADDRESS;
	}
	public void setS_ADDRESS(String s_ADDRESS) {
		S_ADDRESS = s_ADDRESS;
	}
	public String getD_ADDRESS() {
		return D_ADDRESS;
	}
	public void setD_ADDRESS(String d_ADDRESS) {
		D_ADDRESS = d_ADDRESS;
	}
	public String getPHONE() {
		return PHONE;
	}
	public void setPHONE(String pHONE) {
		PHONE = pHONE;
	}
	public String getM_TYPE() {
		return M_TYPE;
	}
	public void setM_TYPE(String m_TYPE) {
		M_TYPE = m_TYPE;
	}
	public String getIS_DEFAULT() {
		return IS_DEFAULT;
	}
	public void setIS_DEFAULT(String iS_DEFAULT) {
		IS_DEFAULT = iS_DEFAULT;
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
	public String getISDElETE() {
		return ISDElETE;
	}
	public void setISDElETE(String iSDElETE) {
		ISDElETE = iSDElETE;
	}
	public String getCARD_NO() {
		return CARD_NO;
	}
	public void setCARD_NO(String cARD_NO) {
		CARD_NO = cARD_NO;
	}
	public String getZIP_CODE() {
		return ZIP_CODE;
	}
	public void setZIP_CODE(String zIP_CODE) {
		ZIP_CODE = zIP_CODE;
	}
	public String getMAIL_ADDR_ID() {
		return MAIL_ADDR_ID;
	}
	public void setMAIL_ADDR_ID(String mAIL_ADDR_ID) {
		MAIL_ADDR_ID = mAIL_ADDR_ID;
	}
	
}
