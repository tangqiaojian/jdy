package com.fh.entity.order;

public class ReqData {
    
	private String parcelId;

    private String reqdata;
    
    private String barCode; //条形码

    public String getParcelId() {
        return parcelId;
    }

    public void setParcelId(String parcelId) {
        this.parcelId = parcelId == null ? null : parcelId.trim();
    }

    public String getReqdata() {
        return reqdata;
    }

    public void setReqdata(String reqdata) {
        this.reqdata = reqdata == null ? null : reqdata.trim();
    }

	public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}
}