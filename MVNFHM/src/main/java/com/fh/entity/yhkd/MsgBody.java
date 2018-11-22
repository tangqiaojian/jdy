package com.fh.entity.yhkd;

public class MsgBody {

	private String guid; // 企业系统生成 36位唯一序号

	private String resptime; // 响应时间

	private String logisticsno; // 物流单号

	private String printspec; // 大头笔信息

	private String msgCode; // 回执代码

	private String message=""; // 回执内容

	public String getGuid() {
		return guid;
	}

	public void setGuid(String guid) {
		this.guid = guid;
	}

	public String getResptime() {
		return resptime;
	}

	public void setResptime(String resptime) {
		this.resptime = resptime;
	}

	public String getLogisticsno() {
		return logisticsno;
	}

	public void setLogisticsno(String logisticsno) {
		this.logisticsno = logisticsno;
	}

	public String getPrintspec() {
		return printspec;
	}

	public void setPrintspec(String printspec) {
		this.printspec = printspec;
	}

	public String getMsgCode() {
		return msgCode;
	}

	public void setMsgCode(String msgCode) {
		this.msgCode = msgCode;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

}
