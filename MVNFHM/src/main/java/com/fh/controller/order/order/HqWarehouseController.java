package com.fh.controller.order.order;

import java.awt.image.BufferedImage;
import java.io.*;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.fh.service.usercenter.mail_addr.Mail_addrManager;
import org.apache.commons.lang.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.xssf.usermodel.XSSFClientAnchor;
import org.apache.poi.xssf.usermodel.XSSFDrawing;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.order.ImportExcel;
import com.fh.entity.order.LogisticsInfo;
import com.fh.entity.order.Order;
import com.fh.entity.order.Parcel;
import com.fh.entity.order.ParcelArticles;
import com.fh.entity.order.PersonInfo;
import com.fh.entity.order.Sender;
import com.fh.entity.order.Task;
import com.fh.entity.system.User;
import com.fh.service.order.customer.CustomerManager;
import com.fh.service.order.logistics_info.Logistics_InfoMapper;
import com.fh.service.order.order.OrderManager;
import com.fh.service.order.parcel.ParcelManager;
import com.fh.service.order.parcelarticles.ParcelArticlesManager;
import com.fh.service.sysmanger.productlib.ProductLibManager;
import com.fh.service.sysmanger.store.StoreManager;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.FileDownload;
import com.fh.util.Jurisdiction;
import com.fh.util.MakeOrderNum;
import com.fh.util.PageData;
import com.fh.util.PathUtil;
import com.fh.util.ReadExcel;
import com.fh.util.Tools;

/**
 * 总店端(仓库)处理
 * 
 * @author HL0523
 *
 */
@Controller
@RequestMapping(value = "/HqWarehouse")
public class HqWarehouseController extends BaseController {

	@Resource(name = "orderService")
	private OrderManager orderService;
	@Resource(name = "parcelService")
	private ParcelManager parcelService;
	@Resource(name = "logistics_infoService")
	private Logistics_InfoMapper logistics_InfoService; // 订单日志
	@Resource(name = "productlibService")
	private ProductLibManager productlibService; // 产品库
	@Resource(name = "parcelarticlesService")
	private ParcelArticlesManager parcelarticlesService;

	@Resource(name = "customerService")
	private CustomerManager customerService; // 大客户列表

	@Resource(name = "storeService")
	private StoreManager storeService;

	@Resource(name = "mail_addrService")
	private Mail_addrManager mail_addrService;
	/**
	 * 
	 * 获取所有包裹列表 (参数URL上) 
	 *      APPLY_STATUS  0:待称重包裹 1:待打托包裹
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
		// 0:待称重包裹 1:待打托包裹 2.已打托包裹
		pd.put("APPLY_STATUS", pd.getString("APPLY_STATUS"));
		page.setPd(pd);
		List<PageData> varList = parcelService.list(page); // 列出包裹列表
		mv.setViewName("order/HqWarehouse/parcel_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 
	 * 
	 * 获取已打托的包裹列表
	 * 
	 * 获取所有包裹列表 2
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list_2")
	public ModelAndView list_2(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "总仓包裹列表");
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		// 2.已打托包裹
		pd.put("APPLY_STATUS", "2");
		page.setPd(pd);

		List<PageData> varList = parcelService.list_2(page); // 列出包裹列表
		mv.setViewName("order/HqWarehouse/parcel_list_2");

		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}
    
	/**
	 * 
	 * @param LOGISTICS
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("details_1")
	public ModelAndView details_1(@RequestParam(required = true, value = "LOGISTICS") String LOGISTICS)
			throws Exception {
		// 根据包裹主键 获取包裹信息
		ModelAndView mv = this.getModelAndView();
		Parcel parcel = parcelService.selectByLogistics(LOGISTICS);
		Order o = parcel.getOrder();
		if (o != null) {
			parcel.setAddressee(JSONObject.parseObject(o.getADDRESSEESTR(), PageData.class));
			parcel.setSender(JSONObject.parseObject(o.getSENDERSTR(), PageData.class));
		}
		// 获取包裹的物品信息
		mv.addObject("parcel", parcel);
		mv.setViewName("order/HqWarehouse/parcel_details_1");
		return mv;

	}
    /**
     * 查看详情
     * @param PALLET_NO
     * @return
     * @throws Exception
     */
	@RequestMapping("details_2")
	public ModelAndView details_2(@RequestParam(required = true, value = "PALLET_NO") String PALLET_NO)
			throws Exception {
		// 根据托盘号获取订单列表
		ModelAndView mv = this.getModelAndView();
		List<Parcel> parcels = parcelService.selectByPallet(PALLET_NO);
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
	
    /**
     * 
     * @return
     * @throws Exception
     */
	@RequestMapping(value = "/pallet")
	@ResponseBody
	public Object pallet() throws Exception {
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			pd.put("APPLY_STATUS", "2"); // 打托
			pd.put("PARCEL_IDS", DATA_IDS);

			MakeOrderNum m = new MakeOrderNum();
			String PALLET_NO = m.makeOrderNum();
			pd.put("PALLET_NO", PALLET_NO); // 托盘号
			pd.put("PALLET_TIME", DateUtil.getDay()); // 打托时间

			parcelService.editApplyStatus(pd);
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
	 * 托盘发货
	 * 
	 */
	@RequestMapping(value = "/trayDeliver")
	@ResponseBody
	public JSONObject trayDeliver() throws Exception {
		JSONObject json = new JSONObject();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		try {
			String DATA_IDS = pd.getString("DATA_IDS");
			if (null != DATA_IDS && !"".equals(DATA_IDS)) {
				pd.put("APPLY_STATUS", "3");
				pd.put("PALLET_NOS", DATA_IDS);
				// 根据托盘号修改 状态
				// pd.put("AVIATION_NO", DATA_IDS);
				pd.put("DELIVERY_TIME", DateUtil.getDay());
				parcelService.editApplyStatus(pd);
				pd.put("flag", true);
			}
		} catch (Exception e) {
			pd.put("flag", false);
		}
		return json;
	}

   /**
    * 查询已删除的订单列表
    * 
    * @param page
    * @return
    * @throws Exception
    */
	@RequestMapping(value = "/list_del_order")
	public ModelAndView list_del_order(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "已删除的Order列表");
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		pd.put("ISDELETE", "1"); // 删除的订单
		page.setPd(pd);
		List<PageData> varList = orderService.list(page); // 列出Order列表
		mv.setViewName("order/HqWarehouse/recycle_bin");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 下载模版
	 * 
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/downExcel")
	public void downExcel(HttpServletResponse response) throws Exception {
		FileDownload.fileDownload(response, PathUtil.getClasspath() + Const.FILEPATHFILE + "order_import.xlsx",
				"筋斗云物流订单-模板.xls");
	}

	// ************************************************************************************************************//
	/**
	 * 批量修改订单状态 (废弃)
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
			pd.put("ORDER_IDS", DATA_IDS);
			String STATEA = pd.getString("STATEA");

			String msg = "";
			if ("3".equals(STATEA)) {
				msg = DateUtil.getTime() + "【总仓】" + Jurisdiction.getUsername() + "已确认揽收";
			} else if ("6".equals(STATEA)) {
				msg = DateUtil.getTime() + "【国内仓】" + Jurisdiction.getUsername() + "已确认揽收";
			}

			String[] s = DATA_IDS.split(",");
			List<LogisticsInfo> logisticsInfos = new ArrayList<LogisticsInfo>();
			for (int i = 0; i < s.length; i++) {
				LogisticsInfo l = new LogisticsInfo();
				l.setORDERID(s[i]);
				l.setTIME(DateUtil.getTime());
				l.setSTATUS(msg);
				logisticsInfos.add(l);
			}
			logistics_InfoService.insertBatch(logisticsInfos);

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
	 * 批量打托 --- 批量打托发货 (废弃)
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateSupport")
	@ResponseBody
	public JSONObject updateSupport() throws Exception {
		JSONObject json = new JSONObject();
		PageData pd = this.getPageData();

		String DATA_IDS = pd.getString("DATA_IDS");
		String PALLET_NO = pd.getString("PALLET_NO");
		String AVIATION_NO = pd.getString("AVIATION_NO");
		String LOGISTICS = pd.getString("LOGISTICS"); // 物流单号

		String[] s = DATA_IDS.split(",");
		List<LogisticsInfo> logisticsInfos = new ArrayList<LogisticsInfo>();

		String msg = "";
		if (!StringUtils.isEmpty(PALLET_NO)) {
			MakeOrderNum m = new MakeOrderNum();
			PALLET_NO = m.makeOrderNum();
			pd.put("PALLET_NO", PALLET_NO);
			pd.put("PALLET_TIME", DateUtil.getDay()); // 打托时间
			msg = DateUtil.getTime() + "【总仓】" + Jurisdiction.getUsername() + "确认打托,托盘号码为:" + PALLET_NO;
		}

		if (!StringUtils.isEmpty(AVIATION_NO)) {
			pd.put("DELIVERY_TIME", DateUtil.getDay()); // 发货时间
			msg = DateUtil.getTime() + "【总仓】" + Jurisdiction.getUsername() + "确认托盘发货,航空单号为:" + AVIATION_NO;
		}

		if (!StringUtils.isEmpty(LOGISTICS)) {
			msg = DateUtil.getTime() + "【国内仓】" + Jurisdiction.getUsername() + "确认转交快递,快递单号为:" + LOGISTICS;
		}

		try {
			if (null != DATA_IDS && !"".equals(DATA_IDS)) {
				pd.put("PALLET_NO", PALLET_NO);
				pd.put("ORDER_IDS", DATA_IDS);
				pd.put("AVIATION_NO", AVIATION_NO);
				pd.put("LOGISTICS", LOGISTICS);

				for (int i = 0; i < s.length; i++) {
					LogisticsInfo l = new LogisticsInfo();
					l.setORDERID(s[i]);
					l.setTIME(DateUtil.getTime());
					l.setSTATUS(msg);
					logisticsInfos.add(l);
				}
				logistics_InfoService.insertBatch(logisticsInfos);

				orderService.editState(pd);
				json.put("flag", true);
			} else {
				json.put("flag", false);
			}
		} catch (Exception e) {
			json.put("flag", false);
		}
		return json;
	}

	@RequestMapping(value = "to_export")
	public ModelAndView to_export() throws Exception {
		ModelAndView mv = new ModelAndView();
		// 获取大客户列表
		PageData pd = new PageData();
		List<PageData> pds = customerService.listAll(pd);
		mv.addObject("customer", pds);
		mv.setViewName("order/HqWarehouse/excel_import");
		return mv;
	}

	/**
	 * 导入 excel 订单
	 * 
	 * @param file
	 * @return
	 * @throws Exception
	 * 
	 */
	@RequestMapping("/importExcel")
	@ResponseBody
	@Transactional
	public JSONObject importExcel(@RequestParam(required = true) MultipartFile[] file,
			@RequestParam(required = true) String customer) throws Exception {
		JSONObject json = new JSONObject();
		String filePath = PathUtil.getClasspath() + Const.FILEPATHFILE;
		for (MultipartFile multipartFile : file) {
			// 获取文件名
			String name = multipartFile.getOriginalFilename();
			// 将excel转为list,判断list中字段是否合法
			ReadExcel readExcel = new ReadExcel();
			List<ImportExcel> list = readExcel.getExcelInfo("orderInfo", filePath, name, multipartFile);

			Map<String, Order> orders = new HashMap<String, Order>(); // 订单数据
			// 获取产品库信息 //名称无法确定 唯一的产品信息
			for (ImportExcel importExcel : list) {
				// 根据条形码 数据库获取对应的 商品信息
				Order o;
				if (!orders.containsKey(importExcel.getOrderId())) {
					o = new Order();
					o.setORDER_ID(this.get32UUID());
					o.setORDERNO(importExcel.getOrderId());
					o.setSTATEA("0");
					o.setISDELETE("0");
					o.setAPPLY_STATUS(0); // 订单状态
					o.setCREATEBY(Jurisdiction.getUsername());
					o.setCREATETIME(DateUtil.getTime());

					// 寄件人信息 //获取对应大客户的信息
					PageData params = new PageData();
					params.put("CUSTOMER_ID", customer);
					PageData custor = customerService.findById(params);

					PersonInfo p = new PersonInfo();
					p.setSENDER(custor.getString("NICK_NAME"));
					p.setPHONE(custor.getString("PHONE"));
					p.setCARD_NO(custor.getString("CARD_NO"));
					p.setS_ADDRESS(custor.getString("REGION"));
					p.setD_ADDRESS(custor.getString("ADDRESS"));

					o.setSENDER(p.getSENDER());
					o.setSENDERSTR(JSONObject.toJSONString(p));

					// 收件人信息
					PageData pd = new PageData();
					pd.put("SENDER", importExcel.getConsignee());
					pd.put("S_ADDRESS", importExcel.getConsigneeprovince() + "," + importExcel.getConsigneecity() + ","
							+ importExcel.getConsigneedistrict());
					pd.put("D_ADDRESS", importExcel.getConsigneeaddress());
					pd.put("PHONE", importExcel.getConsigneetelephone());
					pd.put("M_TYPE", "1");
					pd.put("CARD_NO", importExcel.getCardNO()); // 身份证号码TODO

					o.setADDRESSEE(importExcel.getConsignee());
					o.setADDRESSEESTR(JSONObject.toJSONString(pd));

					o.setCUSTOMER_ID(customer);
					orders.put(importExcel.getOrderId(), o); // 存入map
				} else {
					o = orders.get(importExcel.getOrderId());
				}

				// 填充寄件物品信息
				List<ParcelArticles> parcelArticles = o.getParcelArticles();
				if (parcelArticles == null) {
					parcelArticles = new ArrayList<ParcelArticles>();
				}
				// 根据条形码 取数据库 获取商品信息
				ParcelArticles p = productlibService.selectByBarCode(importExcel.getTradename()); // 修改成条形码
				if (p != null) {
					p.setPARCELARTICLES_ID(this.get32UUID()); // 主键
					p.setPA_COUNT(Integer.parseInt(importExcel.getCount())); // 数量
					p.setORDERID(o.getORDER_ID()); // 订单主键
					p.setIS_PACK(0); // 是否已打包
					parcelArticles.add(p);
				}
				o.setParcelArticles(parcelArticles);
			}

			// 迭代MAP 插入对应的数据
			for (Map.Entry<String, Order> entry : orders.entrySet()) {
				Order o = entry.getValue();
				List<ParcelArticles> pa = o.getParcelArticles();
				orderService.insert(o);
				if (pa != null && pa.size() > 0)
					parcelarticlesService.insertBatch(pa);
			}

		}
		json.put("flag", true);
		return json;
	}

	/**
	 * 
	 * 待揽收-已揽收(根据传入的状态判断) 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list_cursor_order")
	public ModelAndView list_3(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "总仓导入Order列表");
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		String keywords = pd.getString("keywords"); // 关键词检索条件
		if (null != keywords && !"".equals(keywords)) {
			pd.put("keywords", keywords.trim());
		}
		pd.put("STATEA", "0"); // 订单状态未待打包
		// 2.设置订单状态为待揽收
		pd.put("CREATEBY", Jurisdiction.getUsername()); // 创建人
		pd.put("ISDELETE", "0"); // 未删除的订单

		page.setPd(pd);
		List<PageData> varList = orderService.list(page); // 列出Order列表
		mv.setViewName("order/HqWarehouse/order_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	@RequestMapping(value = "pushData")
	@ResponseBody
	public Object pushData(@RequestParam(required = true) String weight) throws Exception {
		// 根据包裹主键 获取包裹
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			String[] id = DATA_IDS.split(",");
			for (String parcelId : id) {
				Parcel p = parcelService.selectById(parcelId);
				if (p != null) {
					// 2.更新称重信息
					PageData pds = new PageData();
					pds.put("Reweighting", weight + "");
					pds.put("APPLY_STATUS", "1"); // 已称重
					pds.put("PARCEL_ID", p.getPARCEL_ID());
					pds.put("UPDATETIME", DateUtil.getTime()); // 入库时间
					parcelService.edit(pds);

					boolean f = orderService.isExistsNotWeight(p.getORDER_ID());
					if (!f) {
						// 更新订单状态 3 已入库
						pd.put("STATEA", "3");
						pd.put("ORDER_ID", p.getORDER_ID());
						orderService.edit(pd);

						String msg = DateUtil.getTime() + "【总仓】包裹已入库";
						LogisticsInfo l = new LogisticsInfo();
						l.setORDERID(p.getORDER_ID());
						l.setTIME(DateUtil.getTime());
						l.setSTATUS(msg);
						logistics_InfoService.insert(l);

					}
				}
			}
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
	 * @param parcelIds
	 * @param request
	 * @param output
	 * @throws Exception
	 */
	@RequestMapping(value = "export_excel")
	public void export_excel(@RequestParam(required = true, value = "PALLET_NOS") String PALLET_NOS,
			HttpServletRequest request, HttpServletResponse response, OutputStream output) throws Exception {
		// 获取包裹信息
		List<PageData> parcels = parcelService.selectParcelByExcel(PALLET_NOS);

		XSSFSheet tempSheet = null;

		int rowIndex = 7;
		Row tempRow = null;
		Cell tempCell = null;
		InputStream inputstream = null;
		XSSFWorkbook tempWorkBook = null;
		Date date = new Date();
		String filename = Tools.date2Str(date, "yyyyMMddHHmmss");
		response.setContentType("application/octet-stream");
		response.setHeader("Content-Disposition", "attachment;filename=" + filename + ".xls");

		try {
			inputstream = request.getSession().getServletContext()
					.getResourceAsStream("/uploadFiles/file/parcel_export.xlsx");
			// 获取模板
			tempWorkBook = new XSSFWorkbook(inputstream);
			// tempWorkBook = new HSSFWorkbook(inputstream);
			// WorkbookFactory.create(arg0, arg1)(inputstream);

			// 获取模板sheet页
			tempSheet = tempWorkBook.getSheetAt(0);
			//sheet画图管理工具, 每个sheet维持一个
            XSSFDrawing patriarch = tempSheet.createDrawingPatriarch();
			if (parcels != null && parcels.size() > 0) {

				for (int i = 0; i < parcels.size(); i++) {
					int cellNo = 0;
					// 获取指定行
					tempRow = tempSheet.getRow(rowIndex++);
					// 获取指定行的单元格
					tempCell = tempRow.createCell(cellNo++);
					// 给单元格设值
					Integer index = i + 1;
					tempCell.setCellValue(index);
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(parcels.get(i).getString("LOGISTICS"));
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(parcels.get(i).getString("CREATEBY"));
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue("加拿大");
					String sendStr = parcels.get(i).getString("SENDERSTR"); // 寄件人
					Sender sender = JSONObject.parseObject(sendStr, Sender.class); // 寄件人信息
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(sender.getsENDER()); // 寄件人
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(sender.getpHONE()); // 寄件人电话
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(sender.getS_ADDRESS() + sender.getD_ADDRESS()); // 寄件人地址
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue("中国"); // 收件人
					String addresseeStr = parcels.get(i).getString("ADDRESSEESTR"); // 收件人
					PersonInfo personInfo = JSONObject.parseObject(addresseeStr, PersonInfo.class); // 收件人信息
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(personInfo.getSENDER()); // 收件人
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(personInfo.getPHONE()); // 收件人电话
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(personInfo.getCARD_NO()); // 收件人身份证号码
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(personInfo.getS_ADDRESS().replaceAll(",", "") + personInfo.getD_ADDRESS()); // 收件人详细地址

					// 商品信息
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(parcels.get(i).getString("PL_CODE")); // 商品内部代码
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(parcels.get(i).getString("PA_BRAND")); // 商品品牌
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(parcels.get(i).getString("PA_PM")); // 商品名称
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(parcels.get(i).getString("PA_SPEC")); // 商品规格

					String weight = parcels.get(i).getString("PA_WEIGHT");

					Double PA_WEIGHT = null;

	 				if (!StringUtils.isEmpty(weight)) {
						PA_WEIGHT = Double.valueOf(parcels.get(i).getString("PA_WEIGHT")); // 单位kg
					}

					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(parcels.get(i).get("PA_COUNT") + ""); // 商品数量

					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(parcels.get(i).get("Reweighting") + ""); // 商品毛重Reweighting专程kg //
																					// 1磅(lb)=0.4535924公斤(kg

					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(PA_WEIGHT == null ? "-" : PA_WEIGHT +""); // 商品净重

					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(parcels.get(i).get("PA_PRICE") + ""); // 商品单价
					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue("加拿大"); // 商品单价

					tempCell = tempRow.createCell(cellNo++);
					tempCell.setCellValue(parcels.get(i).get("TOTAL_COST") + ""); // 包裹运费TOTAL_COST
				}

			}
			tempWorkBook.write(output);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (inputstream != null) {
				try {
					inputstream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}

	}

	/**
	 * 将数据保留两位小数
	 */
	private double getTwoDecimal(double num) {
		DecimalFormat dFormat = new DecimalFormat("#.00");
		String yearString = dFormat.format(num);
		Double temp = Double.valueOf(yearString);
		return temp;
	}
}
