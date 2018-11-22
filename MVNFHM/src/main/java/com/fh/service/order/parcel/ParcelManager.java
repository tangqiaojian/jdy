package com.fh.service.order.parcel;

import java.util.List;
import com.fh.entity.Page;
import com.fh.entity.order.Parcel;
import com.fh.entity.order.ReqData;
import com.fh.util.PageData;

/**
 * 说明： 包裹管理接口 创建人：FH Q313596790 创建时间：2018-06-17
 * 
 * @version
 */
public interface ParcelManager {

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
	 * 待称重 待打托
	 * 
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page) throws Exception;
	
	/**
	 * 已打托的列表
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> list_2(Page page)throws Exception;
	
	/**
	 * 总仓待揽收  已揽收 移交物流 包裹
	 * @param page
	 * @return
	 * @throws Exception
	 */
	public List<PageData> list_3(Page page)throws Exception;

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
	 * 根据订单id 获取对应的包裹
	 * 
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public List<Parcel> selectByOrderId(String orderId) throws Exception;
	
	
	public Parcel selectById(String pk) throws Exception;
	
	

	/**
	 * 根据订单主键更新 运单获取情况
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void editApplyStatus(PageData pd) throws Exception;

	public Integer selectMaxValue(String orderId) throws Exception;

	
	/**
	 * 根据运单号获取包裹
	 * 
	 * @throws Exception
	 */
	public Parcel selectByLogistics(String Logistics) throws Exception;
    
	/**
	 * 根据托盘号获取包裹
	 * 
	 * @param palletNos
	 * @return
	 * @throws Exception
	 */
	public List<Parcel> selectByPallet(String palletNos) throws Exception;
	
	
	public List<Parcel> selectAviationNo(String selectAviationNo) throws Exception;
	
	public List<Parcel> selectBySourceno(String selectBySourceno) throws Exception;
	
	/**
	 * 获取要导出的包裹数据
	 * 
	 * @param pks
	 * @return
	 * @throws Exception
	 */
	public  List<PageData> selectParcelByExcel(String pks) throws Exception;
	

	//**************************************************************************//
	
	public void insertSelective(ReqData reqData) throws Exception;
	
	public  void updateByPrimaryKeySelective(ReqData reqData ) throws Exception;
	
	public ReqData selectByPrimaryKey(String parcelId) throws Exception;
	
	

}
