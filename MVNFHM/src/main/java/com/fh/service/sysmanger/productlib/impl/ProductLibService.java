package com.fh.service.sysmanger.productlib.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.order.ParcelArticles;
import com.fh.util.PageData;
import com.fh.service.sysmanger.productlib.ProductLibManager;

/** 
 * 说明： 产品库管理
 * 创建人：FH Q313596790
 * 创建时间：2018-06-22
 * @version
 */
@Service("productlibService")
public class ProductLibService implements ProductLibManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ProductLibMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ProductLibMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ProductLibMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ProductLibMapper.datalistPage", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ProductLibMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ProductLibMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ProductLibMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<String> getBrand(String type) throws Exception {
		return (List<String>) dao.findForList("ProductLibMapper.getBrand", type);
	}

	
	public List<String> getPlName(PageData pd) throws Exception {
		return (List<String>) dao.findForList("ProductLibMapper.getPlName", pd);
	}

	public List<PageData> selectPro(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("ProductLibMapper.selectPro", pd);
	}

	public ParcelArticles selectByBarCode(String barCode) throws Exception {
		return (ParcelArticles) dao.findForObject("ProductLibMapper.selectByBarCode", barCode);
	}

	public List<ParcelArticles> selectByBSN(PageData pd) throws Exception {
		return (List<ParcelArticles>) dao.findForList("ProductLibMapper.selectByBSN", pd);
	}
	
}

