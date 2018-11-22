package com.fh.controller.order.order;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.order.Order;
import com.fh.entity.order.Parcel;
import com.fh.service.order.logistics_info.Logistics_InfoMapper;
import com.fh.service.order.order.OrderManager;
import com.fh.service.order.parcel.ParcelManager;
import com.fh.util.AppUtil;
import com.fh.util.DateUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.MakeOrderNum;
import com.fh.util.PageData;

/**
 * 本地仓管理
 * 
 * @author HL0523
 *
 */
@Controller
@RequestMapping(value = "/LocalWareHouse")
public class LocalWareHouseController extends BaseController {

	@Resource(name = "orderService")
	private OrderManager orderService;
	@Resource(name = "parcelService")
	private ParcelManager parcelService;
	@Resource(name = "logistics_infoService")
	private Logistics_InfoMapper logistics_InfoService; // 订单日志

	/**
	 * 
	 * 获取所有包裹列表 3
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {

		logBefore(logger, Jurisdiction.getUsername() + "总仓包裹列表");
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		// 3，待揽收 4，已到货 5 移交物流
		pd.put("APPLY_STATUS", pd.getString("APPLY_STATUS"));
		page.setPd(pd);
		List<PageData> varList = parcelService.list_3(page); // 列出包裹列表
		mv.setViewName("order/LocalWareHouse/parcel_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	// 查看详情
	@RequestMapping("details_2")
	public ModelAndView details_2(@RequestParam(required = true, value = "AviationNo") String AviationNo)
			throws Exception {
		// 根据托盘号获取订单列表
		ModelAndView mv = this.getModelAndView();
		List<Parcel> parcels = parcelService.selectAviationNo(AviationNo);
		for (Parcel parcel : parcels) {
			Order o = parcel.getOrder();
			if (o != null) {
				parcel.setAddressee(JSONObject.parseObject(o.getADDRESSEESTR(), PageData.class));
				parcel.setSender(JSONObject.parseObject(o.getSENDERSTR(), PageData.class));
			}
		}
		// 获取包裹的物品信息
		mv.setViewName("order/HqWarehouse/parcel_details_2");
		mv.addObject("parcels", parcels);
		return mv;
	}

	// 清关
	@RequestMapping(value = "/customsClearance")
	@ResponseBody
	public Object customsClearance() throws Exception {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			//pd.put("APPLY_STATUS", "4"); // 清关
			pd.put("AVIATION_NOS", DATA_IDS);
			// 清关时间
			parcelService.editApplyStatus(pd);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}


	// ****************************************************************************//

}
