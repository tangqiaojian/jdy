package com.fh.service.order.msg_board.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.util.PageData;
import com.fh.service.order.msg_board.Msg_BoardManager;

/** 
 * 说明： 订单留言板
 * 创建人：FH Q313596790
 * 创建时间：2018-06-21
 * @version
 */
@Service("msg_boardService")
public class Msg_BoardService implements Msg_BoardManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("Msg_BoardMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("Msg_BoardMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("Msg_BoardMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Msg_BoardMapper.datalistPage", page);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<PageData> list_1(Page page)throws Exception{
		return (List<PageData>)dao.findForList("Msg_BoardMapper.datalistPage_1", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("Msg_BoardMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("Msg_BoardMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("Msg_BoardMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<PageData> selectByOrderId(String orderId) throws Exception {
		return (List<PageData>) dao.findForList("Msg_BoardMapper.selectByOrderId", orderId);
	}
	
}

