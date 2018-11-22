package com.fh.service.order.order;

import java.util.List;
import com.fh.entity.Page;
import com.fh.entity.order.Order;
import com.fh.entity.order.Parcel;
import com.fh.entity.yhkd.MsgBody;
import com.fh.util.PageData;

/**
 * 说明： 订单模块接口 创建人：FH Q313596790 创建时间：2018-06-13
 * 
 * @version
 */
public interface OrderManager {

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception;

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception;

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception;

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page) throws Exception;

	/**
	 * 列表(全部)
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd) throws Exception;

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception;

	/**
	 * 批量删除
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS) throws Exception;

	/**
	 * 根据订单主键获取 -- 关联数据
	 * 
	 * @param pks
	 * @return
	 * @throws Exception
	 */
	public Order selectByPk(String pks) throws Exception;

	/**
	 * 
	 * @param username
	 * @return
	 * @throws Exception
	 */
	public Double getSUMbyUser(String username) throws Exception;

	/**
	 * 
	 * @param OrderId
	 * @return
	 * @throws Exception
	 */
	public Double getTotalCostBYOrderId(String OrderId) throws Exception;

	/**
	 * 批量修改订单状态
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editState(PageData pd) throws Exception;

	/**
	 * 
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<Order> datalistPage_local(Page page) throws Exception;

	/**
	 * 
	 * @param username
	 * @return
	 * @throws Exception
	 */
	public PageData getCountAndSum(String username) throws Exception;

	public List<Order> selectByApplyStatus() throws Exception;

	public Boolean isExistsNotWeight(String orderId) throws Exception;

	/**
	 * 申请 或 更新单号
	 * 
	 * @param order
	 * @param parcels
	 * @throws Exception
	 */
	public MsgBody req_no(Order order, Parcel parcels) throws Exception;

	public List<String> selectOrderIdbyExisitParcel() throws Exception;

	public List<String> finishOrder() throws Exception;

	public void insert(Order order) throws Exception;

	
	public Order selectByOrderId(String orderId)throws Exception;

}
