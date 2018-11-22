package com.fh.entity.yhkd;

public class MsgHead {

	private String deptid;    //申请机构编号
	
	private String signdigest;  //报文安全传输签
	
	private String version = "V1.0" ;  //默认填写 V1.0

	
	public String getDeptid() {
		return deptid;
	}

	public void setDeptid(String deptid) {
		this.deptid = deptid;
	}

	public String getSigndigest() {
		return signdigest;
	}

	public void setSigndigest(String signdigest) {
		this.signdigest = signdigest;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}
	
}
