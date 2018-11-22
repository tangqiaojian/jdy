package com.fh.controller.order.order;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.order.LogisticsInfo;
import com.fh.entity.order.Order;
import com.fh.entity.order.Parcel;
import com.fh.entity.order.ParcelArticles;
import com.fh.entity.order.UserLev;
import com.fh.entity.system.User;
import com.fh.entity.yhkd.MsgBody;
import com.fh.service.order.logistics_info.Logistics_InfoMapper;
import com.fh.service.order.order.OrderManager;
import com.fh.service.order.parcel.ParcelManager;
import com.fh.service.order.parcel.impl.ParcelService;
import com.fh.service.order.parcelarticles.ParcelArticlesManager;
import com.fh.service.sysmanger.productmanager.ProductManagerManager;
import com.fh.service.sysmanger.userlev.UserLevManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.FileUpload;
import com.fh.util.Jurisdiction;
import com.fh.util.MD5;
import com.fh.util.PageData;
import com.fh.util.PathUtil;

import net.sf.json.util.JSONBuilder;

/**
 * 
 * 门店端订单处理
 * 
 * @author HL0523
 *
 */
@Controller
@RequestMapping(value = "/storeOrder")
public class StoreOrderController extends BaseController {

	// 待揽收订单列表
	@Resource(name = "orderService")
	private OrderManager orderService;
	@Resource(name = "productmanagerService")
	private ProductManagerManager productmanagerService; // 产品类管理
	@Resource(name = "parcelarticlesService")
	private ParcelArticlesManager parcelarticlesService; // 寄件物品
	@Resource(name = "userlevService")
	private UserLevManager userlevService; // 用户等级
	@Resource(name = "parcelService")
	private ParcelManager parcelService;
	@Resource(name = "logistics_infoService")
	private Logistics_InfoMapper logistics_InfoService; // 订单日志
	/**
	 * 
	 * 待揽收-已揽收(根据传入的状态判断) 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {

		logBefore(logger, Jurisdiction.getUsername() + "门店Order列表");

		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		// 1.获取当前用户 获取门店主键
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		pd.put("STOREID", user.getSTORE());

		// 2.设置订单状态为待揽收
		if ("1".equals(pd.getString("STATEA"))) {
			pd.put("dy", "1");
		}
		pd.put("STATEA", pd.getString("STATEA"));

		pd.put("ISDELETE", "0"); // 未删除的订单

		page.setPd(pd);
		List<PageData> varList = orderService.list(page); // 列出Order列表
		/*通过已揽收订单id获取快递单号*/
		if ("1".equals(pd.getString("STATEA"))) {
			List<PageData> varList2 = new ArrayList<PageData>();
			int i = 0;
			for (PageData pageData : varList) {
				List<Parcel> order = parcelService.selectByOrderId(pageData.getString("ORDER_ID"));
				String msg = "";
				if (order.size() == 1) {
					msg = order.get(0).getLOGISTICS();
				} else {
					if ( order.size() !=0) {
						for (int x = 0; x < order.size(); x++) {
							msg += order.get(x).getLOGISTICS() + ";";
						}
						msg = msg.substring(0, msg.length() - 1);
					}
				}
				varList2.add(pageData);
				varList2.get(i).put("logistics", msg);
				i++;
			}
			varList=varList2;
		}
		mv.setViewName("order/stroeOrder/order_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 待揽收详情
	 * 
	 * order_store_details_0
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("order_store_details_0")
	public ModelAndView order_deatis_0() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		Order order = orderService.selectByPk(pd.getString("ORDER_ID"));// 根据ID读取
		PageData sender = JSONObject.parseObject(order.getSENDERSTR(), PageData.class);
		PageData adderssee = JSONObject.parseObject(order.getADDRESSEESTR(), PageData.class);
		mv.setViewName("order/stroeOrder/order_store_details_0");
		mv.addObject("pd", pd);
		mv.addObject("order", order);
		mv.addObject("sender", sender);
		mv.addObject("adderssee", adderssee);
		return mv;
	}

	/**
	 * 
	 * 跳转到打包界面
	 * 
	 * @return ModelAndView
	 * @throws Exception
	 */
	@RequestMapping("toPack")
	public ModelAndView to_pack() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// 1.产品类列表
		List<PageData> products = productmanagerService.listAll(pd);
		mv.addObject("products", products);
		// 2.根据主键列表获取寄件物品信息
		List<ParcelArticles> parcelArticles = parcelarticlesService.selectByPks(pd.getString("ids"));
		mv.addObject("ids", pd.getString("ids"));
		mv.addObject("parcelArticles", parcelArticles);
		mv.addObject("ORDER_ID", pd.getString("ORDER_ID"));
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		mv.setViewName("order/stroeOrder/order_pack");
		return mv;
	}

	/**
	 * 门店---> 确认揽收
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/confirmCollect")
	@ResponseBody
	public JSONObject confirmCollect(@RequestParam(value = "ORDER_ID", required = true) String ORDER_ID) {
		// @RequestParam(value="LOGISTICS",required=true)String LOGISTICS
		JSONObject json = new JSONObject();
		PageData pd = this.getPageData();
		try {
			// PageData order = orderService.findById(pd);
			Order order = orderService.selectByPk(ORDER_ID);
			double FREIGHT = orderService.getTotalCostBYOrderId(ORDER_ID); // 订单总运费
			
			String STOREID = order.getSTOREID();
			if (!StringUtils.isEmpty(STOREID)) { // 门店订单
				
				/*// 根据订单 判断是门店 还是总仓导入
				double money = orderService.getSUMbyUser(order.getCREATEBY());
				// 根据消费获取等级
				UserLev userLev = userlevService.getLevByMoney(String.valueOf(money));
				if (userLev != null) {
					FREIGHT = FREIGHT * (userLev.getDISCOUNT() / 10);
					pd.put("DISCOUNT", userLev.getDISCOUNT()); // 设置订单折扣信息
				}*/
				// TODO

				pd.put("ORDER_ID", ORDER_ID);
				pd.put("FREIGHT", FREIGHT);
				pd.put("STATEA", "1"); // 订单状态设置为 门店已揽收
				logistics_InfoService.insert(new LogisticsInfo(ORDER_ID, DateUtil.getTime(),DateUtil.getTime() + "【" + order.getSTORENAME() + "】" + Jurisdiction.getUsername() + "已揽收"));

			} else { // 外部导入的订单
				pd.put("ORDER_ID", ORDER_ID);
				pd.put("FREIGHT", FREIGHT);
				pd.put("STATEA", "2"); // 订单状态设置为 门店已揽收

				PageData p = new PageData();
				p.put("APPLY_STATUS", "0");
				p.put("ORDER_ID", ORDER_ID);
				parcelService.editApplyStatus(p);

			}
			// 获取 申请面单 TODO
			List<Parcel> parcels = order.getParcels();
			for (Parcel parcel : parcels) {
				orderService.req_no(order, parcel);
			}

			orderService.edit(pd);
			json.put("flag", true);
		} catch (Exception e) {
			e.printStackTrace();
			json.put("flag", false);
		}
		return json;
	}

	/**
	 * 总仓确认揽收 批量发往总仓
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateMakeState")
	@ResponseBody
	public Object updateMakeState() throws Exception {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			pd.put("STATEA", "2");
			pd.put("ORDER_IDS", DATA_IDS);

			String[] s = DATA_IDS.split(",");
			List<LogisticsInfo> logisticsInfos = new ArrayList<LogisticsInfo>();
			for (int i = 0; i < s.length; i++) {
				LogisticsInfo l = new LogisticsInfo();
				l.setORDERID(s[i]);
				l.setTIME(DateUtil.getTime());
				l.setSTATUS(DateUtil.getTime() + "【门店】" + Jurisdiction.getUsername() + "发往总仓");
				logisticsInfos.add(l);
			}
			logistics_InfoService.insertBatch(logisticsInfos);

			// 更新包裹 为待称重状态
			PageData p = new PageData();
			p.put("APPLY_STATUS", "0");
			p.put("ORDER_ID", DATA_IDS);
			parcelService.editApplyStatus(p);

			orderService.editState(pd);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 
	 * 逻辑删除订单
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/del_order")
	public void del_order(PrintWriter out) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("ISDELETE", "1"); // 未删除的订单
		orderService.edit(pd);
		out.write("success");
		out.close();
	}

	/**
	 * 根据orderid 获取寄件人 收件人信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("to_updateRS")
	public ModelAndView to_update_recipien_sender(@RequestParam(required = true) String ORDER_ID) throws Exception {
		ModelAndView mv = new ModelAndView();
		Order order = orderService.selectByPk(ORDER_ID);// 根据ID读取
		PageData sender = JSONObject.parseObject(order.getSENDERSTR(), PageData.class);
		PageData adderssee = JSONObject.parseObject(order.getADDRESSEESTR(), PageData.class);
		mv.addObject("sender", sender);
		mv.addObject("adderssee", adderssee);
		mv.addObject("order", order);
		mv.setViewName("order/stroeOrder/updatRS");
		return mv;
	}

	@RequestMapping("updateRS")
	@ResponseBody
	public JSONObject updateRS(MultipartHttpServletRequest request) throws Exception {
		JSONObject json = new JSONObject();

		PageData pd = this.getPageData();
		Map<String, String[]> map = request.getParameterMap();
		Iterator<String> it = map.keySet().iterator();
		while (it.hasNext()) {
			String key = it.next();
			String[] ss = (String[]) map.get(key);
			StringBuffer sb = new StringBuffer();
			for (String s : ss) {
				sb.append(s);
			}
			pd.put(key, sb.toString());
		}

		PageData order = new PageData();
		PageData address = new PageData();

		address.put("CARD_NO", pd.getString("CARD_NO"));
		address.put("ZIP_CODE", pd.getString("ZIP_CODE"));
		address.put("SENDER", pd.getString("SENDER"));
		address.put("PHONE", pd.getString("PHONE"));
		address.put("D_ADDRESS", pd.getString("D_ADDRESS"));
		address.put("S_ADDRESS", pd.getString("S_ADDRESS"));
		address.put("FACE", pd.getString("FACE_URL"));
		address.put("OPPOSITE", pd.getString("OPPOSITE_URL"));

		// 文件上传
		this.upLoadFile(request, address);

		order.put("ORDER_ID", pd.getString("ORDER_ID"));
		order.put("ADDRESSEE", pd.getString("SENDER"));
		order.put("ADDRESSEESTR", JSONObject.toJSONString(address));
		try {
			orderService.edit(order);
			json.put("flag", true);
		} catch (Exception e) {
			json.put("flag", false);
		}
		return json;
	}

	// ***********************************************************************//

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit(@RequestParam(required = true) String PARCELARTICLES_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = parcelarticlesService.findById(pd); // 根据ID读取

		// 获取品牌类别
		List<PageData> products = productmanagerService.listAll(pd);

		mv.setViewName("order/stroeOrder/updateArticles");
		mv.addObject("msg", "edit");
		mv.addObject("products", products);
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	@ResponseBody
	public JSONObject edit() {
		JSONObject json = new JSONObject();
		PageData pd = new PageData();
		pd = this.getPageData();

		pd.put("UPDATEBY", Jurisdiction.getUsername()); // 修改人
		pd.put("UPDATETIME", new Date()); // 修改时间
		try {
			parcelarticlesService.edit(pd);
			json.put("flag", true);
		} catch (Exception e) {
			e.printStackTrace();
			json.put("flag", false);
		}
		return json;
	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	@ResponseBody
	public JSONObject delete() {
		JSONObject json = new JSONObject();
		PageData pd = new PageData();
		pd = this.getPageData();
		try {
			parcelarticlesService.delete(pd);
			json.put("flag", true);
		} catch (Exception e) {
			json.put("flag", false);
		}
		return json;
	}

	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd(@RequestParam(required = true) String ORDER_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		// ORDER ID
		// 获取品牌类别
		List<PageData> products = productmanagerService.listAll(pd);
		mv.setViewName("order/stroeOrder/addArticles");
		mv.addObject("msg", "edit");
		pd.put("products", products);
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	@ResponseBody
	public JSONObject save() {
		JSONObject json = new JSONObject();
		PageData pd = this.getPageData();
		pd.put("PARCELARTICLES_ID", this.get32UUID());
		pd.put("CREATEBY", Jurisdiction.getUsername()); // 创建人
		pd.put("CREATETIME", new Date()); // 创建时间
		pd.put("IS_PACK", "0");
		try {
			parcelarticlesService.save(pd);
			json.put("flag", true);
		} catch (Exception e) {
			json.put("flag", false);
			e.printStackTrace();
		}
		return json;
	}

	/**
	 * 
	 * 面单收据
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("receipt_details")
	public ModelAndView order_deatis(@RequestParam(required = true) String ORDER_ID) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		Order order = orderService.selectByPk(ORDER_ID);// 根据ID读取
		PageData sender = JSONObject.parseObject(order.getSENDERSTR(), PageData.class);
		PageData adderssee = JSONObject.parseObject(order.getADDRESSEESTR(), PageData.class);

		mv.setViewName("order/stroeOrder/receipt_details");
		mv.addObject("_username", Jurisdiction.getUsername());
		mv.addObject("pd", pd);
		mv.addObject("order", order);
		mv.addObject("sender", sender);
		mv.addObject("adderssee", adderssee);
		return mv;
	}

	/**
	 * 上传文件
	 * 
	 * @param pd
	 * @param request
	 * @throws Exception
	 */
	public void upLoadFile(MultipartHttpServletRequest request, PageData pd) throws Exception {
		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
				request.getSession().getServletContext());

		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
			Iterator<String> iter = multiRequest.getFileNames();
			while (iter.hasNext()) {
				MultipartFile file = multiRequest.getFile(iter.next());
				if (file != null) {
					String fileName = file.getOriginalFilename();
					if (fileName.trim() != "") {
						String uploadName = file.getName();
						String type = uploadName.substring(uploadName.indexOf("_") + 1, uploadName.length()); // thumbnailFile_1
						String timestamp = new Date().getTime() + "";
						String ffile = DateUtil.getDays();
						String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile; // 文件上传路径
						String filename = FileUpload.fileUp(file, filePath,
								MD5.md5(file.getOriginalFilename() + timestamp));
						// 判断上传图片类型（正面，反面）
						if (type.equals("1")) {
							pd.put("FACE", Const.FILEPATHIMG + ffile + "/" + filename); // 正面
						} else if (type.equals("2")) {
							pd.put("OPPOSITE", Const.FILEPATHIMG + ffile + "/" + filename); // 反面
						}

					}
				}
			}
		}
	}

	/** 
	 * 
	 * 揽收事可能 获取单号失败,根据包裹主键 重新申请单号 
	 * 
	 * @param parcelId
	 * @return
	 */
	@RequestMapping(value = "againGetWaybillNo", produces = "application/json; charset=utf-8")
	@ResponseBody
	public JSONObject againGetWaybillNo(@RequestParam(required = true) String parcelId) {
		JSONObject json = new JSONObject();
		MsgBody msg = null;
		try {
			Parcel parcel = parcelService.selectById(parcelId);
			Order order = orderService.selectByOrderId(parcel.getORDER_ID());
			msg = orderService.req_no(order, parcel);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if (msg != null) {
			json.put("code", msg.getMsgCode());
			json.put("msg", msg.getMessage());
		} else {
			json.put("code", "99");
			json.put("msg", "未知原因");
		}
		return json;
	}

}