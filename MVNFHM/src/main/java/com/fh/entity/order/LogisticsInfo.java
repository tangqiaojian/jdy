package com.fh.entity.order;

public class LogisticsInfo {

	private Integer LOGISTICS_INFO_ID;

	private String ORDERID;

	private String TIME;

	private String STATUS;

	public LogisticsInfo() {

	}

	public LogisticsInfo(String oRDERID, String tIME, String sTATUS) {
		ORDERID = oRDERID;
		TIME = tIME;
		STATUS = sTATUS;
	}

	public Integer getLOGISTICS_INFO_ID() {
		return LOGISTICS_INFO_ID;
	}

	public void setLOGISTICS_INFO_ID(Integer lOGISTICS_INFO_ID) {
		LOGISTICS_INFO_ID = lOGISTICS_INFO_ID;
	}

	public String getORDERID() {
		return ORDERID;
	}

	public void setORDERID(String oRDERID) {
		ORDERID = oRDERID;
	}

	public String getTIME() {
		return TIME;
	}

	public void setTIME(String tIME) {
		TIME = tIME;
	}

	public String getSTATUS() {
		return STATUS;
	}

	public void setSTATUS(String sTATUS) {
		STATUS = sTATUS;
	}

}
