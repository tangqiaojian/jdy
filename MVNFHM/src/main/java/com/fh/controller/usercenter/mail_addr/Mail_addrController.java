package com.fh.controller.usercenter.mail_addr;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.annotation.Transient;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
import com.fh.entity.order.UserLev;
import com.fh.entity.system.User;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.FileUpload;
import com.fh.util.FileUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.PathUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.MD5;
import com.fh.util.Tools;
import com.fh.service.order.order.OrderManager;
import com.fh.service.sysmanger.store.StoreManager;
import com.fh.service.sysmanger.userlev.UserLevManager;
import com.fh.service.system.user.UserManager;
import com.fh.service.system.user.impl.UserService;
import com.fh.service.usercenter.mail_addr.Mail_addrManager;

/**
 * 说明：寄件/收件人管理 创建人：FH Q313596790 创建时间：2018-06-12
 */
@Controller
@RequestMapping(value = "/mail_addr")
public class Mail_addrController extends BaseController {

	String menuUrl = "mail_addr/list.do"; // 菜单地址(权限用)
	@Resource(name = "mail_addrService")
	private Mail_addrManager mail_addrService;
	@Resource(name = "orderService")
	private OrderManager orderService;
	@Resource(name = "userlevService")
	private UserLevManager userlevService;
	@Resource(name = "userService")
	private UserManager userService;
	@Resource(name = "storeService")
	private StoreManager storeService; // 门店

	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public ModelAndView save(MultipartHttpServletRequest request) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "新增Mail_addr");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
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
		
		this.upLoadFile(request, pd);
		// 处理文件
		pd.put("MAIL_ADDR_ID", this.get32UUID()); // 主键
		pd.put("IS_DEFAULT", "0"); // 默认为否
		pd.put("ISDElETE", "0");
		pd.put("CREATEBY", Jurisdiction.getUsername()); // 创建人
		pd.put("CREATETIME", new Date()); // 创建时间
		mail_addrService.save(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**
	 * 修改
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/edit")
	public ModelAndView edit(MultipartHttpServletRequest request) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "修改Mail_addr");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
			return null;
		} // 校验权限
		ModelAndView mv = this.getModelAndView();
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
		
		this.upLoadFile(request, pd);

		pd.put("UPDATEBY", Jurisdiction.getUsername()); // 修改人
		pd.put("UPDATETIME", new Date()); // 修改时间

		mail_addrService.edit(pd);
		mv.addObject("msg", "success");
		mv.setViewName("save_result");
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
						String type = uploadName.substring(uploadName.indexOf("_")+1,uploadName.length()); // thumbnailFile_1
						String timestamp = new Date().getTime() + "";
						String ffile = DateUtil.getDays();
						String filePath = PathUtil.getClasspath() + Const.FILEPATHIMG + ffile; // 文件上传路径
						String filename = FileUpload.fileUp(file, filePath,MD5.md5(file.getOriginalFilename() + timestamp));
						// 判断上传图片类型（正面，反面）
						if (type.equals("1")) {
							pd.put("FACE", Const.FILEPATHIMG+ffile+"/"+filename); // 正面
						} else if (type.equals("2")) {
							pd.put("OPPOSITE",Const.FILEPATHIMG+ffile+"/"+ filename); // 反面
						}

					}
				}
			}
		}
	}

	/**
	 * 删除
	 * 
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete")
	public void delete(PrintWriter out) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "删除Mail_addr");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return;
		} // 校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		mail_addrService.delete(pd);
		out.write("success");
		out.close();
	}



	/**
	 * 列表
	 * 
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value = "/list")
	public ModelAndView list(Page page) throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "列表Mail_addr");
		ModelAndView mv = this.getModelAndView();
		PageData pd = this.getPageData();
		pd.put("CREATEBY", Jurisdiction.getUsername()); // 获取创建人
		pd.put("M_TYPE", "0");
		page.setPd(pd);
		List<PageData> varList = mail_addrService.list(page); // 列出Mail_addr列表
		mv.addObject("varList", varList);

		pd.put("M_TYPE", "1");
		page.setPd(pd);
		List<PageData> varList2 = mail_addrService.list(page); // 列出Mail_addr列表
		mv.addObject("varList_2", varList2);

		mv.setViewName("usercenter/mail_addr/mail_addr_list");
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	/**
	 * 去新增页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goAdd")
	public ModelAndView goAdd() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("usercenter/mail_addr/mail_addr_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 去修改页面
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/goEdit")
	public ModelAndView goEdit() throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd = mail_addrService.findById(pd); // 根据ID读取
		mv.setViewName("usercenter/mail_addr/mail_addr_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}

	/**
	 * 批量删除
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "批量删除Mail_addr");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
			return null;
		} // 校验权限
		PageData pd = new PageData();
		Map<String, Object> map = new HashMap<String, Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if (null != DATA_IDS && !"".equals(DATA_IDS)) {
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			mail_addrService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		} else {
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}

	/**
	 * 导出到excel
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/excel")
	public ModelAndView exportExcel() throws Exception {
		logBefore(logger, Jurisdiction.getUsername() + "导出Mail_addr到excel");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
			return null;
		}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String, Object> dataMap = new HashMap<String, Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("寄件人/收货人"); // 1
		titles.add("寄件/收件地址"); // 2
		titles.add("详细地址"); // 3
		titles.add("联系电话"); // 4
		titles.add("类型(0:寄件 1:收件)"); // 5
		titles.add("是否为默认（0:否 1：是）"); // 6
		titles.add("创建人"); // 7
		titles.add("创建时间"); // 8
		titles.add("修改者"); // 9
		titles.add("修改时间"); // 10
		dataMap.put("titles", titles);
		List<PageData> varOList = mail_addrService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for (int i = 0; i < varOList.size(); i++) {
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("SENDER")); // 1
			vpd.put("var2", varOList.get(i).getString("S_ADDRESS")); // 2
			vpd.put("var3", varOList.get(i).getString("D_ADDRESS")); // 3
			vpd.put("var4", varOList.get(i).getString("PHONE")); // 4
			vpd.put("var5", varOList.get(i).get("M_TYPE").toString()); // 5
			vpd.put("var6", varOList.get(i).get("IS_DEFAULT").toString()); // 6
			vpd.put("var7", varOList.get(i).getString("CREATEBY")); // 7
			vpd.put("var8", varOList.get(i).getString("CREATETIME")); // 8
			vpd.put("var9", varOList.get(i).getString("UPDATEBY")); // 9
			vpd.put("var10", varOList.get(i).getString("UPDATETIME")); // 10
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv, dataMap);
		return mv;
	}

	@InitBinder
	public void initBinder(WebDataBinder binder) {
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format, true));
	}

	/**
	 * 修改默认(收件人 寄件人)
	 */
	@RequestMapping(value = "/editDefault")
	@ResponseBody
	@Transactional
	public void editDefault(PrintWriter out) throws Exception {
		PageData pd = new PageData();
		pd = this.getPageData();

		PageData pdAll = new PageData();
		pdAll.put("IS_DEFAULT", "0");
		pdAll.put("M_TYPE", pd.getString("M_TYPE"));
		pdAll.put("CREATEBY", Jurisdiction.getUsername());
		mail_addrService.editDefault(pdAll);

		PageData newdefault = new PageData();
		newdefault.put("IS_DEFAULT", "1");
		newdefault.put("MAIL_ADDR_ID", pd.getString("MAIL_ADDR_ID"));
		mail_addrService.editDefault(newdefault);

		out.write("success");
		out.close();
	}

	@RequestMapping(value = "/toChoose")
	public ModelAndView tocChoose(Page page) throws Exception {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();

		String mType = pd.getString("M_TYPE"); // 类型检索
		if (null != mType && !"".equals(mType)) {
			pd.put("M_TYPE", mType.trim());
		} else {
			pd.put("M_TYPE", "0"); // 默认为0寄件人
		}
		// 默认寄件人(获取创建人为)我的名字的
		pd.put("CREATEBY", Jurisdiction.getUsername()); // 获取创建人
		
		//添加检索条件
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
			
		page.setPd(pd);
		List<PageData> varList = mail_addrService.list(page); // 列出Mail_addr列表

		// 将数据转换成JSON串
		for (PageData pageData : varList) {
			String jsonStr = JSONObject.toJSONString(pageData);
			pageData.put("jsonStr", jsonStr);
		}

		mv.setViewName("usercenter/mail_addr/mail_addr_choose");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX", Jurisdiction.getHC()); // 按钮权限
		return mv;
	}

	// *********************************************************************************************************************//
	// ****************************************************账号信息***********************************************************//
	// *********************************************************************************************************************//

	/**
	 * 获取账号的基本信息
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("accountInfo")
	public ModelAndView info_() throws Exception {
		ModelAndView mv = new ModelAndView();
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		user = userService.getUserAndRoleById(user.getUSER_ID());

		// 1.获取当前用户的下单数 和下单总额
		PageData p = orderService.getCountAndSum(user.getUSERNAME());
		UserLev userLev = userlevService.getLevByMoney(String.valueOf(p.get("_sum") + ""));

		// 获取默认门店
		PageData params = new PageData();
		params.put("STORE_ID", user.getCITY());
		PageData stores = storeService.findById(params);

		mv.addObject("stores", stores);
		mv.addObject("user", user);
		mv.addObject("userLev", userLev);
		mv.addObject("_count_sum", p);
		mv.setViewName("usercenter/mail_addr/account_info");
		return mv;
	}

	/**
	 * 修改账号密码
	 * 
	 * @param old_pwd
	 * @param new_pwd
	 * @param again_pwd
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("changePwd")
	@ResponseBody
	public JSONObject changePwd(@RequestParam(required = true, name = "old_pwd") String old_pwd,
			@RequestParam(required = true, name = "new_pwd") String new_pwd,
			@RequestParam(required = true, name = "again_pwd") String again_pwd) {
		JSONObject json = new JSONObject();
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		try {
			user = userService.getUserAndRoleById(user.getUSER_ID());
		} catch (Exception e1) {
			e1.printStackTrace();
		}

		if (!new_pwd.equals(again_pwd)) {
			json.put("flag", false);
			json.put("msg", "两次密码不一致");
			return json;

		}

		String u_pwd = new SimpleHash("SHA-1", user.getUSERNAME(), old_pwd).toString();
		if (!u_pwd.equals(user.getPASSWORD())) {
			json.put("flag", false);
			json.put("msg", "原始密码错误");
			return json;
		}

		PageData pd = new PageData();
		pd.put("USER_ID", user.getUSER_ID());
		pd.put("PASSWORD", new SimpleHash("SHA-1", user.getUSERNAME(), new_pwd).toString());
		try {
			userService.editU(pd);
			json.put("flag", true);
			json.put("msg", "修改成功");
		} catch (Exception e) {
			e.printStackTrace();
			json.put("flag", false);
			json.put("msg", e.toString());
		}
		return json;
	}

	/**
	 * 修改发货城市
	 * 
	 * @param city
	 * @return
	 */
	@RequestMapping("changeCity")
	@ResponseBody
	public JSONObject changeCity(@RequestParam(name = "city", required = true) String city) {
		JSONObject json = new JSONObject();
		User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
		PageData pd = new PageData();
		pd.put("USER_ID", user.getUSER_ID());
		pd.put("CITY", city);
		try {
			userService.editU(pd);
			json.put("flag", true);
			json.put("msg", "修改成功");
		} catch (Exception e) {
			json.put("flag", false);
			json.put("msg", e.toString());
		}
		return json;
	}
	
	
	@RequestMapping(value="to_choose_add")
	public  ModelAndView to_choose_add(@RequestParam(value="M_TYPE",required=true)String M_TYPE) {
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		mv.setViewName("usercenter/mail_addr/mail_addr_add");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
		
	}
	
	
	/**
	 * 保存
	 * 
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value = "/choose_save")
	@ResponseBody
	public JSONObject choose_save(MultipartHttpServletRequest request) {
		logBefore(logger, Jurisdiction.getUsername() + "新增Mail_addr");
		if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
			return null;
		} // 校验权限
		JSONObject json=new JSONObject();
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
		try {
			// 处理文件
			this.upLoadFile(request, pd);
			pd.put("MAIL_ADDR_ID", this.get32UUID()); // 主键
			pd.put("IS_DEFAULT", "0"); // 默认为否
			pd.put("ISDElETE", "0");
			pd.put("CREATEBY", Jurisdiction.getUsername()); // 创建人
			pd.put("CREATETIME", new Date()); // 创建时间
			mail_addrService.save(pd);
			json.put("flag", true);
		} catch (Exception e) {
			json.put("flag", false);
		}
		return json;
	}
	

}
