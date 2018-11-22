package com.fh.service.order.order.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.UUID;
import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.alibaba.fastjson.JSONObject;
import com.fh.dao.DaoSupport;
import com.fh.entity.Page;
import com.fh.entity.order.Order;
import com.fh.entity.order.Parcel;
import com.fh.entity.order.ParcelArticles;
import com.fh.entity.order.PersonInfo;
import com.fh.entity.yhkd.MsgBody;
import com.fh.entity.yhkd.MsgHead;
import com.fh.entity.yhkd.OrderBody;
import com.fh.entity.yhkd.OrderList;
import com.fh.entity.yhkd.ReqData;
import com.fh.entity.yhkd.RespData;
import com.fh.util.DateUtil;
import com.fh.util.PageData;
import com.fh.util.config.Const;
import com.fh.util.config.HttpReqClient;
import com.fh.service.order.order.OrderManager;
import com.fh.service.order.parcel.ParcelManager;
import com.fh.service.order.parcelarticles.ParcelArticlesManager;
import com.fh.service.sysmanger.productlib.ProductLibManager;

/**
 * 说明： 订单模块 创建人：FH Q313596790 创建时间：2018-06-13
 * 
 * @version
 */
@Service("orderService")
public class OrderService implements OrderManager {

	@Resource(name = "daoSupport")
	private DaoSupport dao;
	@Resource(name = "parcelService")
	private ParcelManager parcelService;
	@Resource(name = "parcelarticlesService")
	private ParcelArticlesManager parcelarticlesService; // 寄件物品
	@Resource(name = "productlibService")
	private ProductLibManager productlibService;

	/**
	 * 新增
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void save(PageData pd) throws Exception {
		dao.save("OrderMapper.save", pd);
	}

	/**
	 * 删除
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void delete(PageData pd) throws Exception {
		dao.delete("OrderMapper.delete", pd);
	}

	/**
	 * 修改
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public void edit(PageData pd) throws Exception {
		dao.update("OrderMapper.edit", pd);
	}

	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> list(Page page) throws Exception {
		return (List<PageData>) dao.findForList("OrderMapper.datalistPage", page);
	}

	/**
	 * 列表(全部)
	 * 
	 * @param pd
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<PageData> listAll(PageData pd) throws Exception {
		return (List<PageData>) dao.findForList("OrderMapper.listAll", pd);
	}

	/**
	 * 通过id获取数据
	 * 
	 * @param pd
	 * @throws Exception
	 */
	public PageData findById(PageData pd) throws Exception {
		return (PageData) dao.findForObject("OrderMapper.findById", pd);
	}

	/**
	 * 批量删除
	 * 
	 * @param ArrayDATA_IDS
	 * @throws Exception
	 */
	public void deleteAll(String[] ArrayDATA_IDS) throws Exception {
		dao.delete("OrderMapper.deleteAll", ArrayDATA_IDS);
	}

	public Order selectByPk(String pks) throws Exception {
		return (Order) dao.findForObject("OrderMapper.selectByPk", pks);
	}

	public Double getSUMbyUser(String username) throws Exception {
		return (Double) dao.findForObject("OrderMapper.getSUMbyUser", username);
	}

	public Double getTotalCostBYOrderId(String OrderId) throws Exception {
		return (Double) dao.findForObject("OrderMapper.getTotalCostBYOrderId", OrderId);
	}

	public void editState(PageData pd) throws Exception {
		dao.update("OrderMapper.editState", pd);
	}

	public List<Order> datalistPage_local(Page page) throws Exception {
		return (List<Order>) dao.findForList("OrderMapper.datalistPage_local", page);
	}

	public PageData getCountAndSum(String username) throws Exception {
		return (PageData) dao.findForObject("OrderMapper.getCountAndSum", username);
	}

	public List<Order> selectByApplyStatus() throws Exception {
		return (List<Order>) dao.findForList("OrderMapper.selectByApplyStatus", null);
	}

	public Boolean isExistsNotWeight(String orderId) throws Exception {
		return (Boolean) dao.findForObject("OrderMapper.isExistsNotWeight", orderId);
	}

	/**
	 * 获取待获取运单号的 包裹列表
	 * 
	 * @param order
	 * @param parcels
	 */
	public MsgBody req_no(Order order, Parcel parcels) throws Exception {

		MsgHead msgHead = new MsgHead();
		OrderBody orderBody = new OrderBody();
		List<OrderList> orderLists = new ArrayList<OrderList>();
		try {

			BigDecimal goodsvalue = new BigDecimal(0); // 商品总价值

			Double netweight = 0.0; // 净重
			Integer goodsqty = 0; // 总件数

			// 商品信息
			List<ParcelArticles> parcelArticles = parcelarticlesService.selectByPks(parcels.getGOODS_PK()); // 商品列表
			for (ParcelArticles pa : parcelArticles) {

				BigDecimal price = new BigDecimal(pa.getPA_PRICE()); //
				BigDecimal count = new BigDecimal(pa.getPA_COUNT()); //

				OrderList o = new OrderList();
				o.setItembrand(pa.getPA_BRAND()); // 商品品牌
				o.setItemname(pa.getPA_PM()); // 商品名称
				o.setSpecmodel(pa.getPA_SPEC()); // 规格型号
				o.setPrice(price + ""); // 商品单价
				o.setQuotedprice("0"); // 保价金额，没有填 0
				o.setPackno(count + ""); // 件数
				o.setProducecountry("142"); // 原产国

				// TODO 如果重量为null的话 类别 根据品牌 品名 规格型号 获取物品重量 TODO
				if (StringUtils.isEmpty(pa.getPA_WEIGHT())) {
					// 数据库获取产品信息
					PageData query = new PageData();
					query.put("PL_BRAND", pa.getPA_BRAND());
					query.put("PL_NAME", pa.getPA_PM());
					query.put("PL_SPECMODEL", pa.getPA_SPEC());
					List<ParcelArticles> p = productlibService.selectByBSN(query);
					if (p != null && p.size() > 0) {
						o.setNetweight(p.get(0).getPA_WEIGHT()); // 净重
						pa.setPA_WEIGHT(p.get(0).getPA_WEIGHT());
						parcelarticlesService.updateByPrimaryKeySelective(pa);
					}else
						o.setNetweight("0.01"); // 净重
				} else {
					o.setNetweight(pa.getPA_WEIGHT()); // 净重
				}

				goodsvalue = goodsvalue.add(price.multiply(count));
				netweight += Double.parseDouble(o.getNetweight());
				goodsqty += pa.getPA_COUNT();

				orderLists.add(o);
			}

			Boolean flag = false;
			String guid = parcels.getGuid();
			if (StringUtils.isEmpty(guid)) {
				guid = UUID.randomUUID().toString();
				flag = true;
			}

			String apptime = DateUtil.getSdfTimes();
			msgHead.setSigndigest(Const.getSigndigest(apptime, guid));
			msgHead.setDeptid(Const.deptid);

			// 请求商品主体信息
			orderBody.setGuid(guid);
			orderBody.setApptime(apptime);
			orderBody.setApptype(flag ? "1" : "2");

			orderBody.setBillno(guid.replaceAll("-", ""));

			// 20180625085055538000
			String Sourceno = null;
			if (StringUtils.isEmpty(parcels.getSourceno())) {
				Sourceno = getSourceno();
			} else {
				Sourceno = parcels.getSourceno();
			}

			orderBody.setSourceno(Sourceno); // 配货单号:原单号

			// 发货人信息
			PersonInfo SENDER = JSONObject.parseObject(order.getSENDERSTR(), PersonInfo.class);
			orderBody.setConsignor(SENDER.getSENDER()); // 姓名
			orderBody.setConsignortelephone(SENDER.getPHONE()); // 电话
			orderBody.setConsignoraddress(SENDER.getS_ADDRESS().replaceAll(",", "") + SENDER.getD_ADDRESS()); // 地址

			orderBody.setConsignoridnumber(
					StringUtils.isEmpty(SENDER.getCARD_NO()) ? "000000000000000000" : SENDER.getCARD_NO()); // 证件号码 TODO

			// 收货人信息
			PersonInfo addressee = JSONObject.parseObject(order.getADDRESSEESTR(), PersonInfo.class);
			orderBody.setConsignee(addressee.getSENDER());
			orderBody.setConsigneetelephone(addressee.getPHONE());
			orderBody.setConsigneeaddress(addressee.getS_ADDRESS().replaceAll(",", "") + addressee.getD_ADDRESS());
			String ssq[] = addressee.getS_ADDRESS().split(",");

			orderBody.setConsigneeprovince(ssq[0]);
			orderBody.setConsigneecity(ssq[1]);
			orderBody.setConsigneedistrict(ssq[2]);
			orderBody.setConsigneeidnumber(addressee.getCARD_NO());

			// goodsvalue = new BigDecimal(goodsvalue).setScale(2,
			// BigDecimal.ROUND_HALF_UP).doubleValue();
			orderBody.setGoodsvalue(goodsvalue + ""); // 商品价值

			// * 0.4535924 转kg
			double d = Double.parseDouble(parcels.getXM_WEIGHT());
			BigDecimal b = new BigDecimal(d);
			double df = b.setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();
			orderBody.setGrossweight(df * 0.4535924 + ""); // 包裹毛重 //转换成kg parcels.getWEIGHT()0.4535924

			orderBody.setNetweight(netweight + "");
			orderBody.setGoodsqty(goodsqty + "");

			ReqData reqData = new ReqData();
			reqData.setMsghead(msgHead);
			reqData.setOrderbody(orderBody);
			reqData.setOrderlist(orderLists);

			// System.out.println(JSONObject.toJSONString(reqData));

			String ReqData = JSONObject.toJSONString(reqData);
			// 请求运单 单号
			String respStr = HttpReqClient.httpPostWithJSON(ReqData, Const.req_url);

			RespData respData = JSONObject.parseObject(respStr, RespData.class);
			if (respData != null) {

				// 处理成功
				if ("00".equals(respData.getMsgbody().getMsgCode())) {

					PageData pd = new PageData();
					pd.put("PARCEL_ID", parcels.getPARCEL_ID()); // 包裹主键
					pd.put("LOGISTICS", respData.getMsgbody().getLogisticsno()); // 物流单号
					pd.put("COURIER", "韵达速递"); // 韵达快递
					pd.put("COURIER_BM", "YD"); // 快递编码
					pd.put("Printspec", respData.getMsgbody().getPrintspec());// 大头笔信息
					pd.put("Sourceno", Sourceno); // 配货单号
					pd.put("guid", guid);
					// 包裹主键 PARCEL_ID
					com.fh.entity.order.ReqData re = parcelService.selectByPrimaryKey(parcels.getSourceno());
					if (re == null) {
						re = new com.fh.entity.order.ReqData();
						re.setParcelId(Sourceno);
						re.setReqdata(ReqData);
						parcelService.insertSelective(re);
					} else {
						re.setBarCode("-1");
						re.setParcelId(Sourceno);
						parcelService.updateByPrimaryKeySelective(re);
					}
					// 保存对应的请求数据
					parcelService.edit(pd);
				}
				return respData.getMsgbody();
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	public List<String> selectOrderIdbyExisitParcel() throws Exception {
		return (List<String>) dao.findForList("OrderMapper.selectOrderIdbyExisitParcel", null);
	}

	public List<String> finishOrder() throws Exception {
		return (List<String>) dao.findForList("OrderMapper.finishOrder", null);
	}

	private static synchronized String getSourceno() {
		Calendar calendar = Calendar.getInstance();
		return (calendar.getTime().getTime() + "").substring(1);
	}

	public void insert(Order order) throws Exception {
		dao.save("OrderMapper.insert", order);
	}

	public Order selectByOrderId(String orderId) throws Exception {
		return (Order) dao.findForObject("OrderMapper.selectByOrderId", orderId);
	}

}
