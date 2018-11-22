//package com.fh.controller.sysmanger.productlibrary;
//
//import java.io.PrintWriter;
//import java.text.DateFormat;
//import java.text.SimpleDateFormat;
//import java.util.ArrayList;
//import java.util.Date;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//import javax.annotation.Resource;
//import org.springframework.beans.propertyeditors.CustomDateEditor;
//import org.springframework.stereotype.Controller;
//import org.springframework.util.StringUtils;
//import org.springframework.web.bind.WebDataBinder;
//import org.springframework.web.bind.annotation.InitBinder;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//import org.springframework.web.servlet.ModelAndView;
//import com.fh.controller.base.BaseController;
//import com.fh.entity.Page;
//import com.fh.entity.system.Dictionaries;
//import com.fh.service.sysmanger.productlibrary.ProductLibraryManager;
//import com.fh.util.AppUtil;
//import com.fh.util.ObjectExcelView;
//import com.fh.util.PageData;
//import com.fh.util.Jurisdiction;
//import com.fh.util.Tools;
//
//
///** 
// * 说明：产品库管理(废弃)
// * 创建人：FH Q313596790
// * 创建时间：2018-06-14
// */
//@Controller
//@RequestMapping(value="/productlibrary")
//public class ProductLibraryController extends BaseController {
//	
//	String menuUrl = "productlibrary/list.do"; //菜单地址(权限用)
//	@Resource(name="productlibraryService")
//	private ProductLibraryManager productlibraryService;
//	
//	/**保存
//	 * @param
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/save")
//	public ModelAndView save() throws Exception{
//		logBefore(logger, Jurisdiction.getUsername()+"新增ProductLibrary");
//		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		pd.put("PRODUCTLIBRARY_ID", this.get32UUID());	//主键
//		
//		//保存上级信息
//		String PARENTID = pd.getString("PARENT_ID");
//		if (null != PARENTID && !"".equals(PARENTID)) {
//			pd.put("PARENT_ID", PARENTID.trim());
//		} else {
//			pd.put("PARENT_ID", "0");
//		}
//	
//		productlibraryService.save(pd);
//		mv.addObject("msg","success");
//		mv.setViewName("save_result");
//		return mv;
//	}
//	
//	/**删除
//	 * @param out
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/delete")
//	public void delete(PrintWriter out) throws Exception{
//		logBefore(logger, Jurisdiction.getUsername()+"删除ProductLibrary");
//		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		productlibraryService.delete(pd);
//		out.write("success");
//		out.close();
//	}
//	
//	/**修改
//	 * @param
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/edit")
//	public ModelAndView edit() throws Exception{
//		logBefore(logger, Jurisdiction.getUsername()+"修改ProductLibrary");
//		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		productlibraryService.edit(pd);
//		mv.addObject("msg","success");
//		mv.setViewName("save_result");
//		return mv;
//	}
//	
//	/**列表
//	 * @param page
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/list")
//	public ModelAndView list(Page page) throws Exception{
//		logBefore(logger, Jurisdiction.getUsername()+"列表ProductLibrary");
//		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		String keywords = pd.getString("keywords");				//关键词检索条件
//		if(null != keywords && !"".equals(keywords)){
//			pd.put("keywords", keywords.trim());
//		}
//		//保存上级信息
//		String PARENTID = pd.getString("PARENT_ID");
//		if (null != PARENTID && !"".equals(PARENTID)) {
//			pd.put("PARENT_ID", PARENTID.trim());
//		} else {
//			pd.put("PARENT_ID", "0");
//		}
//		
//		//页面标志
//		String Hierarchy = pd.getString("Hierarchy");
//		if (null == Hierarchy || "".equals(Hierarchy)) {
//			pd.put("Hierarchy", 0);
//		} else {
//			pd.put("Hierarchy", Hierarchy);
//		}
//		
//		
//		page.setPd(pd);
//		List<PageData>	varList = productlibraryService.list(page);	//列出ProductLibrary列表
//		mv.setViewName("sysmanger/productlibrary/productlibrary_list");
//		mv.addObject("varList", varList);
//		mv.addObject("pd", pd);
//		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
//		return mv;
//	}
//	
//	/**去新增页面
//	 * @param
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/goAdd")
//	public ModelAndView goAdd()throws Exception{
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		
//		
//		
//		
//		mv.setViewName("sysmanger/productlibrary/productlibrary_edit");
//		mv.addObject("msg", "save");
//		mv.addObject("pd", pd);
//		return mv;
//	}	
//	
//	 /**去修改页面
//	 * @param
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/goEdit")
//	public ModelAndView goEdit()throws Exception{
//		ModelAndView mv = this.getModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		pd = productlibraryService.findById(pd);	//根据ID读取
//		mv.setViewName("sysmanger/productlibrary/productlibrary_edit");
//		mv.addObject("msg", "edit");
//		mv.addObject("pd", pd);
//		return mv;
//	}	
//	
//	 /**批量删除
//	 * @param
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/deleteAll")
//	@ResponseBody
//	public Object deleteAll() throws Exception{
//		logBefore(logger, Jurisdiction.getUsername()+"批量删除ProductLibrary");
//		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
//		PageData pd = new PageData();		
//		Map<String,Object> map = new HashMap<String,Object>();
//		pd = this.getPageData();
//		List<PageData> pdList = new ArrayList<PageData>();
//		String DATA_IDS = pd.getString("DATA_IDS");
//		if(null != DATA_IDS && !"".equals(DATA_IDS)){
//			String ArrayDATA_IDS[] = DATA_IDS.split(",");
//			productlibraryService.deleteAll(ArrayDATA_IDS);
//			pd.put("msg", "ok");
//		}else{
//			pd.put("msg", "no");
//		}
//		pdList.add(pd);
//		map.put("list", pdList);
//		return AppUtil.returnObject(pd, map);
//	}
//	
//	 /**导出到excel
//	 * @param
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/excel")
//	public ModelAndView exportExcel() throws Exception{
//		logBefore(logger, Jurisdiction.getUsername()+"导出ProductLibrary到excel");
//		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
//		ModelAndView mv = new ModelAndView();
//		PageData pd = new PageData();
//		pd = this.getPageData();
//		Map<String,Object> dataMap = new HashMap<String,Object>();
//		List<String> titles = new ArrayList<String>();
//		titles.add("品牌/品名");	//1
//		titles.add("上级主键");	//2
//		titles.add("排序");	//3
//		dataMap.put("titles", titles);
//		List<PageData> varOList = productlibraryService.listAll(pd);
//		List<PageData> varList = new ArrayList<PageData>();
//		for(int i=0;i<varOList.size();i++){
//			PageData vpd = new PageData();
//			vpd.put("var1", varOList.get(i).getString("BP_NAME"));	    //1
//			vpd.put("var2", varOList.get(i).getString("PARENT_ID"));	    //2
//			vpd.put("var3", varOList.get(i).get("ORDER_BY").toString());	//3
//			varList.add(vpd);
//		}
//		dataMap.put("varList", varList);
//		ObjectExcelView erv = new ObjectExcelView();
//		mv = new ModelAndView(erv,dataMap);
//		return mv;
//	}
//	
//	@InitBinder
//	public void initBinder(WebDataBinder binder){
//		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
//		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
//	}
//	
//	
//	
//	/**
//	 * 获取品牌/品名数据
//	 * @return
//	 */
//	@RequestMapping(value="/getLevels")
//	@ResponseBody
//	public Object getLevels(){
//		Map<String,Object> map = new HashMap<String,Object>();
//		String errInfo = "success";
//		PageData pd = new PageData();
//		try{
//			pd = this.getPageData();
//			String PRODUCTLIBRARY_ID = pd.getString("PRODUCTLIBRARY_ID");
//			PRODUCTLIBRARY_ID = Tools.isEmpty(PRODUCTLIBRARY_ID)?"0":PRODUCTLIBRARY_ID;
//			
//			List<PageData> varList = productlibraryService.listSubPbByParentId(PRODUCTLIBRARY_ID); //用传过来的ID获取此ID下的子列表数据
//			map.put("list", varList);	
//		} catch(Exception e){
//			errInfo = "error";
//			logger.error(e.toString(), e);
//		}
//		map.put("result", errInfo);				//返回结果
//		return AppUtil.returnObject(new PageData(), map);
//	}
//	
//	
//	
//	
//	
//	
//	
//}
