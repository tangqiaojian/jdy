package com.fh.util.config;

import com.fh.util.MD5;

public class Const {

	//*******沙箱环境*************//
	/*public static final String req_url = "http://36.251.249.3:8899/cross/business/ztoPrint.do?reqCode=addOrUpdateOrder";
	public static final String md5_key = "a733c7473c4b1d72ecc8f2b4a1279b49";
	public static final String deptid = "999999";*/
	/*public static final String req_url = "http://36.251.249.3:8899/cross/business/ztoPrint.do?reqCode=addOrUpdateOrder";
	public static final String md5_key = "F88F986B8DB557357D60F91E09459775";
	public static final String deptid = "001003006";*/
	//*******生产环境*************//
	public static final String req_url = "http://36.251.249.3:8899/cross/business/ztoPrint.do?reqCode=addOrUpdateOrder";
	public static final String md5_key = "a733c7473c4b1d72ecc8f2b4a1279b49";
	public static final String deptid = "001003006";


	public static String getSigndigest(String apptime, String guid) {
		StringBuffer sb = new StringBuffer();
		sb.append(md5_key);
		sb.append(deptid);
		sb.append(apptime);
		sb.append(guid);
		return MD5.md5(sb.toString()).toUpperCase();
	}
    
	
}
