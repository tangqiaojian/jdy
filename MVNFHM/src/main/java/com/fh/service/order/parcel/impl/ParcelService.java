package com.fh.service.order.parcel.impl;

import java.util.List;
import javax.annotation.Resource;
import org.springframework.stereotype.Service;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.order.Parcel;
import com.fh.entity.order.ReqData;
import com.fh.util.PageData;
import com.fh.service.order.parcel.ParcelManager;

/** 
 * 说明： 包裹管理
 * 创建人：FH Q313596790
 * 创建时间：2018-06-17
 * @version
 */
@Service("parcelService")
public class ParcelService implements ParcelManager{

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	
	/**新增
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd)throws Exception{
		dao.save("ParcelMapper.save", pd);
	}
	
	/**删除
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd)throws Exception{
		dao.delete("ParcelMapper.delete", pd);
	}
	
	/**修改
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd)throws Exception{
		dao.update("ParcelMapper.edit", pd);
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ParcelMapper.datalistPage", page);
	}
	
	
	@SuppressWarnings("unchecked")
	public List<PageData> list_2(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ParcelMapper.datalistPage_2", page);
	}
	
	@SuppressWarnings("unchecked")
	public List<PageData> list_3(Page page)throws Exception{
		return (List<PageData>)dao.findForList("ParcelMapper.datalistPage_3", page);
	}
	
	/**列表(全部)
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd)throws Exception{
		return (List<PageData>)dao.findForList("ParcelMapper.listAll", pd);
	}
	
	/**通过id获取数据
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd)throws Exception{
		return (PageData)dao.findForObject("ParcelMapper.findById", pd);
	}
	
	/**批量删除
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS)throws Exception{
		dao.delete("ParcelMapper.deleteAll", ArrayDATA_IDS);
	}

	public List<Parcel> selectByOrderId(String orderId) throws Exception {
		return (List<Parcel>) dao.findForList("ParcelMapper.selectByOrderId",  orderId);
	}

	public void editApplyStatus(PageData pd) throws Exception {
		dao.update("ParcelMapper.editApplyStatus", pd);
		
	}

	public Integer selectMaxValue(String orderId) throws Exception {
		return (Integer) dao.findForObject("ParcelMapper.selectMaxValue", orderId);
	}

	public Parcel selectByLogistics(String Logistics) throws Exception {
		return (Parcel) dao.findForObject("ParcelMapper.selectByLogistics", Logistics);
	}

	public Parcel selectById(String pk) throws Exception {
		return (Parcel) dao.findForObject("ParcelMapper.selectById", pk);
	}

	public List<Parcel> selectByPallet(String palletNos) throws Exception{
		return (List<Parcel>) dao.findForList("ParcelMapper.selectByPallet", palletNos);
		
	}
	
	public List<Parcel> selectAviationNo(String selectAviationNo) throws Exception {
		return (List<Parcel>) dao.findForList("ParcelMapper.selectAviationNo", selectAviationNo);
	}
	
	public List<Parcel> selectBySourceno(String selectBySourceno) throws Exception {
		return (List<Parcel>) dao.findForList("ParcelMapper.selectBySourceno", selectBySourceno);
	}
	

	public List<PageData> selectParcelByExcel(String pks) throws Exception {
		return (List<PageData>) dao.findForList("ParcelMapper.selectParcelByExcel", pks);
	}

	
	//*******************************************************************************//
	
	
	public void insertSelective(ReqData reqData) throws Exception {
		dao.save("req_dataMapper.insertSelective", reqData);
	}

	public void updateByPrimaryKeySelective(ReqData reqData) throws Exception {
		dao.update("req_dataMapper.updateByPrimaryKeySelective", reqData);
	}

	public ReqData selectByPrimaryKey(String parcelId) throws Exception {
		return (ReqData) dao.findForObject("req_dataMapper.selectByPrimaryKey", parcelId);
	}


}

