package com.fh.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fh.entity.order.LogisticsInfo;
import com.fh.entity.order.Parcel;
import com.fh.entity.order.Task;
import com.fh.service.order.logistics_info.Logistics_InfoMapper;
import com.fh.service.order.order.OrderManager;
import com.fh.service.order.parcel.ParcelManager;
import com.fh.service.sysmanger.store.StoreManager;
import com.fh.util.DateUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.PageData;

@Controller
@RequestMapping(value = "/client")
public class QuickHandButt {

	@Resource(name = "parcelService")
	private ParcelManager parcelService;
	@Resource(name = "orderService")
	private OrderManager orderService;
	@Resource(name = "logistics_infoService")
	private Logistics_InfoMapper logistics_InfoService; // 订单日志

	@Resource(name = "storeService")
	private StoreManager storeService;
	
	
	public static final String APP_KEY = "1434511402";
	public static final String APP_SECRET = "6b5dbfb04e6eff96";

	/**
	 * 
	 * 更新包裹二次称重数据
	 * 
	 * @param params
	 * @return
	 */
	@RequestMapping(value = "pushData")
	@ResponseBody
	@Transactional
	public JSONObject pushData(@RequestParam(value = "params", required = true) String params,
			@RequestParam(value = "uuid", required = true) String uuid,
			@RequestParam(value = "timestamp", required = true) String timestamp,
			@RequestParam(value = "Token", required = true) String token) {
		JSONObject json = new JSONObject();
        
		String token2 =getToken(timestamp,uuid);
		if(!token.equals(token2)) {
			json.put("code", "001");
			json.put("result", "token错误");
		    return json;
			
		}
	
		List<Task> tasks = JSONArray.parseArray(params, Task.class);
		List<String> s = new ArrayList<String>();
		try {
			for (Task task : tasks) {
				// TODO 根据配货单号 获取
				List<Parcel> p = parcelService.selectBySourceno(task.getBarCode()); //

				if (p != null && p.size() > 0) {
					// 2.更新称重信息
					PageData pd = new PageData();
					pd.put("Reweighting", task.getWeight());
					pd.put("APPLY_STATUS", "1"); // 已称重
					pd.put("PARCEL_ID", p.get(0).getPARCEL_ID());
					pd.put("UPDATETIME", DateUtil.getTime()); //入库时间
					parcelService.edit(pd);

					s.add(task.getBarCode());
					boolean f = orderService.isExistsNotWeight(p.get(0).getORDER_ID());
					if (!f) {
						// 更新订单状态 // 无称重包裹更新订单状态 --- 待打托
						pd.put("STATEA", "3");
						pd.put("ORDER_ID", p.get(0).getORDER_ID());
						orderService.edit(pd);

						String msg = DateUtil.getTime() + "【总仓】包裹已入库";
						LogisticsInfo l = new LogisticsInfo();
						l.setORDERID(p.get(0).getORDER_ID());
						l.setTIME(DateUtil.getTime());
						l.setSTATUS(msg);
						logistics_InfoService.insert(l);

					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		json.put("code", "00");
		json.put("result", String.join(",", s));
	    return json;

	}

	
	/**
	 * 获取传输的token
	 * 
	 * @return
	 */
	public static String getToken(String timestamp, String uuid) {
		StringBuffer sb = new StringBuffer();
		sb.append(APP_KEY);
		sb.append(APP_SECRET);
		sb.append(timestamp);
		sb.append(uuid);
		return com.fh.util.MD5.md5(sb.toString());
	}
	
	/**
	 * 获取门店列表
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("storeList")
	public @ResponseBody List<PageData> getStoreList() throws Exception {
		PageData pd = new PageData();
		List<PageData> li = storeService.listAll(pd);
		return li;
	}

}
