package com.fh.service.order.logistics_info;

import java.util.List;
import com.fh.entity.Page;
import com.fh.entity.order.LogisticsInfo;
import com.fh.util.PageData;

/** 
 * 说明： 物流信息接口
 * 创建人：FH Q313596790
 * 创建时间：2018-06-20
 * @version
 */
public interface Logistics_InfoMapper{

	
	public  void  insert(LogisticsInfo logisticsInfo ) throws Exception;
	
	public void insertBatch(List<LogisticsInfo> logisticsInfos) throws Exception;
	
	public List<LogisticsInfo> selectByOrderId(String orderId) throws Exception;

	
	
}

