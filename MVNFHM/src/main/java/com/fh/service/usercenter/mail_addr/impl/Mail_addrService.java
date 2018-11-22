package com.fh.service.usercenter.mail_addr.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.usercenter.mail_addr.Mail_addrManager;

/** 
 * 说明： 寄件/收件人管理
 * 创建人：FH Q313596790
 * 创建时间：2018-06-12
 * @version
 */
@Service("mail_addrService")
public class Mail_addrService implements Mail_addrManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("Mail_addrMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("Mail_addrMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("Mail_addrMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Mail_addrMapper.datalistAll", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Mail_addrMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Mail_addrMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("Mail_addrMapper.deleteAll", ArrayDATA_IDS);
	}

	public void editDefault(PageData pd) throws Exception {
		 dao.update("Mail_addrMapper.editDefault", pd);	
	}

	public PageData queryMyDefault(PageData pd) throws Exception {
		return (PageData) dao.findForObject("Mail_addrMapper.queryMyDefault", pd);
	}
	
}

