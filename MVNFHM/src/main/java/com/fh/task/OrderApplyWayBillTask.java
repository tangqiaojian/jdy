package com.fh.task;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;

import org.apache.ibatis.javassist.expr.NewArray;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.alibaba.fastjson.JSONObject;
import com.fh.entity.order.LogisticsInfo;
import com.fh.entity.order.Order;
import com.fh.entity.order.Parcel;
import com.fh.entity.order.ParcelArticles;
import com.fh.entity.order.PersonInfo;
import com.fh.entity.yhkd.MsgHead;
import com.fh.entity.yhkd.OrderBody;
import com.fh.entity.yhkd.OrderList;
import com.fh.entity.yhkd.ReqData;
import com.fh.entity.yhkd.RespData;
import com.fh.service.order.logistics_info.Logistics_InfoMapper;
import com.fh.service.order.order.OrderManager;
import com.fh.service.order.parcel.ParcelManager;
import com.fh.service.order.parcelarticles.ParcelArticlesManager;
import com.fh.util.DateUtil;
import com.fh.util.PageData;
import com.fh.util.config.Const;
import com.fh.util.config.HttpReqClient;

@Component
public class OrderApplyWayBillTask {

	@Resource(name = "orderService")
	private OrderManager orderService;
	@Resource(name = "parcelarticlesService")
	private ParcelArticlesManager parcelarticlesService; // 寄件物品
	@Resource(name = "parcelService")
	private ParcelManager parcelService;
	@Resource(name = "logistics_infoService")
	private Logistics_InfoMapper logistics_InfoService; // 订单日志


	@Scheduled(cron = "0/10 * * * * ? ")
	public void updateOrderState() {
		try {
			List<String> orderIds = orderService.selectOrderIdbyExisitParcel();
			if (orderIds!=null && orderIds.size()>0) {
				PageData pd = new PageData();
				pd.put("STATEA", "4");
				pd.put("ORDER_IDS", String.join(",", orderIds));
			    orderService.editState(pd);
                
				for (int i = 0; i < orderIds.size(); i++) {
					String msg = DateUtil.getTime() + "【国内仓】包裹已全部清关";
					LogisticsInfo l = new LogisticsInfo();
					l.setORDERID(orderIds.get(i));
					l.setTIME(DateUtil.getTime());
					l.setSTATUS(msg);
					logistics_InfoService.insert(l);	
				}
				
			}

			List<String> orderIds_2 = orderService.finishOrder();
			if (orderIds_2 !=null && orderIds_2.size()>0) {
				PageData pd2 = new PageData();
				pd2.put("STATEA", "5");
				pd2.put("ORDER_IDS", String.join(",", orderIds_2));
				orderService.editState(pd2);
				
				for (int i = 0; i < orderIds_2.size(); i++) {
					String msg = DateUtil.getTime() + "【国内仓】包裹已转交国内物流";
					LogisticsInfo l = new LogisticsInfo();
					l.setORDERID( orderIds_2.get(i));
					l.setTIME(DateUtil.getTime());
					l.setSTATUS(msg);
					logistics_InfoService.insert(l);
				}

			}

		} catch (Exception e) {
             e.printStackTrace();
		}

	}

	
	
	
	
	
	// @Scheduled(cron = "0/10 * * * * ? ") // 间隔5秒执行 //正式环境 每1个小时执行一次
	public void taskCycle() {
		List<Order> orders = null;
		try {
			orders = orderService.selectByApplyStatus();
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (orders != null && orders.size() > 0) {
			for (Order order : orders) {
				List<Parcel> parcels = order.getParcels();
				for (Parcel parcel : parcels) {
					// 申请单号并更新状态
					req_no(order, parcel);
				}
			}
		}
	}

	/**
	 * 获取待获取运单号的 包裹列表
	 * 
	 * @param order
	 * @param parcels
	 */
	@Transactional
	public void req_no(Order order, Parcel parcels) {
		MsgHead msgHead = new MsgHead();
		OrderBody orderBody = new OrderBody();
		List<OrderList> orderLists = new ArrayList<OrderList>();
		try {

			Double goodsvalue = 0.0; // 商品总价值
			Double netweight = 0.0; // 净重
			Integer goodsqty = 0; // 总件数

			// 商品信息
			List<ParcelArticles> parcelArticles = parcelarticlesService.selectByPks(parcels.getGOODS_PK()); // 商品列表
			for (ParcelArticles pa : parcelArticles) {
				OrderList o = new OrderList();
				o.setItembrand(pa.getPA_BRAND()); // 商品品牌
				o.setItemname(pa.getPA_PM()); // 商品名称
				o.setSpecmodel(pa.getPA_SPEC()); // 规格型号
				o.setPrice(pa.getPA_PRICE() + ""); // 商品单价
				o.setQuotedprice("0"); // 保价金额，没有填 0
				o.setNetweight(pa.getPA_WEIGHT()); // 净重
				o.setPackno(pa.getPA_COUNT() + ""); // 件数
				o.setProducecountry("142"); // 原产国

				// o.setItemno(pa.getPARCELARTICLES_ID());

				goodsvalue += pa.getPA_PRICE() * pa.getPA_COUNT();
				netweight += Double.parseDouble(pa.getPA_WEIGHT());
				goodsqty += pa.getPA_COUNT();

				orderLists.add(o);
			}

			// 头部信息
			String guid = UUID.randomUUID().toString();
			String apptime = DateUtil.getSdfTimes();
			msgHead.setSigndigest(Const.getSigndigest(apptime, guid));
			msgHead.setDeptid(Const.deptid);

			// 请求商品主体信息
			orderBody.setGuid(guid);
			orderBody.setApptime(apptime);
			orderBody.setApptype("1");

			orderBody.setBillno(guid.replaceAll("-", ""));
			// 20180625085055538000
			orderBody.setSourceno(parcels.getPARCEL_ID()); // 配货单号:原单号

			// 发货人信息
			PersonInfo SENDER = JSONObject.parseObject(order.getSENDERSTR(), PersonInfo.class);
			orderBody.setConsignor(SENDER.getSENDER()); // 姓名
			orderBody.setConsignortelephone(SENDER.getPHONE()); // 电话
			orderBody.setConsignoraddress(SENDER.getS_ADDRESS().replaceAll(",", "") + SENDER.getD_ADDRESS()); // 地址
			orderBody.setConsignoridnumber(SENDER.getCARD_NO()); // 证件号码

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

			orderBody.setGoodsvalue(goodsvalue + ""); // 商品价值
			orderBody.setGrossweight(parcels.getWEIGHT()); // 包裹毛重
			orderBody.setNetweight(netweight + "");
			orderBody.setGoodsqty(goodsqty + "");

			ReqData reqData = new ReqData();
			reqData.setMsghead(msgHead);
			reqData.setOrderbody(orderBody);
			reqData.setOrderlist(orderLists);

			// System.out.println(JSONObject.toJSONString(reqData));

			// 请求运单 单号
			String respStr = HttpReqClient.httpPostWithJSON(JSONObject.toJSONString(reqData), Const.req_url);

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
					pd.put("APPLY_STATUS", "2");
					parcelService.edit(pd);
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public static void main(String[] args) {
		String guid = UUID.randomUUID().toString();
		String apptime = DateUtil.getSdfTimes();
		System.out.println(apptime);

	}

}
