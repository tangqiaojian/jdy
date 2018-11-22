package com.fh.service.order.logistics_info.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.order.LogisticsInfo;
import com.fh.service.order.logistics_info.Logistics_InfoMapper;

/** 
 * 说明： 物流信息
 * 创建人：FH Q313596790
 * 创建时间：2018-06-20
 * @version
 */
@Service("logistics_infoService")
public class Logistics_InfoService implements Logistics_InfoMapper{

	@Resource(name = "daoSupport")
	private DaoSupport dao;

	public void insert(LogisticsInfo logisticsInfo) throws Exception {
		dao.save("Logistics_InfoMapper.insert", logisticsInfo);
	}

	public List<LogisticsInfo> selectByOrderId(String orderId) throws Exception {
		return (List<LogisticsInfo>) dao.findForList("Logistics_InfoMapper.selectByOrderId", orderId);
	}

	public void insertBatch(List<LogisticsInfo> logisticsInfos) throws Exception {
		dao.save("Logistics_InfoMapper.insertBatch", logisticsInfos);
	}
	
	
	
	
}

