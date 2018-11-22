package com.fh.service.sysmanger.productlib;

import java.util.List;
import com.fh.entity.Page;
import com.fh.entity.order.ParcelArticles;
import com.fh.util.PageData;

/** 
 * 说明： 产品库管理接口
 * 创建人：FH Q313596790
 * 创建时间：2018-06-22
 * @version
 */
public interface ProductLibManager{

	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception;
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception;
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception;
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	public List<PageData> list(Page page)throws Exception;
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	public List<PageData> listAll(PageData pd)throws Exception;
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception;
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception;
	
	/**
	 * 根据类型获取品牌
	 * 
	 * @param type
	 * @return
	 * @throws Exception
	 */
	public List<String> getBrand(String type) throws Exception;
	
	/**
	 * 根据类型 跟品牌获取 商品名称列表 PL_TYPE PL_BRAND
	 * @param pd
	 * @return
	 * @throws Exception
	 */
    public List<String> getPlName(PageData pd) throws Exception;
    
    /**
     * 
     * @param pd
     * @return
     * @throws Exception
     */
    public List<PageData> selectPro(PageData pd) throws Exception;
    
    
    /**
     * 根据条形码  获取产品信息
     * @param barCode
     * @return
     * @throws Exception
     */
	public ParcelArticles selectByBarCode(String barCode) throws Exception;
	
	
	public List<ParcelArticles> selectByBSN(PageData pd) throws Exception;
	
}

