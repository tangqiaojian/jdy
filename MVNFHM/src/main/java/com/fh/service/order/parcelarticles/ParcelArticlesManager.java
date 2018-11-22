package com.fh.service.order.parcelarticles;

import java.util.List;
import com.fh.entity.Page;
import com.fh.entity.order.ParcelArticles;
import com.fh.util.PageData;

/**
 * 说明： 寄件物品接口 创建人：FH Q313596790 创建时间：2018-06-13
 * 
 * @version
 */
public interface ParcelArticlesManager {

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
	 * 批量添加
	 * 
	 * @param items
	 * @throws Exception
	 */
	public void insertBatch(List<ParcelArticles> items) throws Exception;

	/**
	 * 根据订单id 获取寄件物品
	 * 
	 * @param orderId
	 * @return
	 * @throws Exception
	 */
	public List<ParcelArticles> selectByOrderId(String orderId) throws Exception;

	/**
	 * 根据订单id 删除寄件物品
	 * 
	 * @param orderId
	 * @throws Exception
	 */
	public void delByOrderId(String orderId) throws Exception;
	
	
	/**
	 * 根据主键id （逗号分割多个） 查找数据
	 * @param pks
	 * @return
	 * @throws Exception
	 */
	public List<ParcelArticles> selectByPks(String pks) throws Exception;
	
	
	/**
	 * 修改是否打包的状态
	 * 
	 * @param pd(IS_PACK  0:未打包  1: 已打包)
	 *          (PARCELARTICLES_IDS 物品主键字符串)
	 * @throws Exception
	 */
	public void updateIsPack(PageData pd) throws Exception;
	
	
    public void updateByPrimaryKeySelective(ParcelArticles articles) throws Exception;
	
	

}
