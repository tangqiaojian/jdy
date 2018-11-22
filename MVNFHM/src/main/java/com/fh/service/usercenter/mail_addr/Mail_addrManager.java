package com.fh.service.usercenter.mail_addr;

import java.util.List;
import com.fh.entity.Page;
import com.fh.util.PageData;

/** 
 * 说明： 寄件/收件人管理接口
 * 创建人：FH Q313596790
 * 创建时间：2018-06-12
 * @version
 */
public interface Mail_addrManager{

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
	 * 更据创建人和类型修改默认
	 * @param pd
	 * @throws Exception
	 */
	public void editDefault(PageData pd)throws Exception;
	
	
	/**
	 * 查询我的默认地址或最新的地址 
	 *
	 * @throws Exception
	 */
	public  PageData  queryMyDefault(PageData pd) throws Exception;
	
	
}

