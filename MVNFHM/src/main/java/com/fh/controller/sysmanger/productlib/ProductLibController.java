package com.fh.controller.sysmanger.productlib;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.order.ParcelArticles;
import com.fh.util.AppUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.Tools;
import com.fh.service.sysmanger.productlib.ProductLibManager;
import com.fh.service.sysmanger.productmanager.ProductManagerManager;

/** 
 * 说明：产品库管理
 * 创建人：FH Q313596790
 * 创建时间：2018-06-22
 */
@Controller
@RequestMapping(value="/productlib")
public class ProductLibController extends BaseController {
	
	String menuUrl = "productlib/list.do"; //菜单地址(权限用)
	@Resource(name="productlibService")
	private ProductLibManager productlibService;
	@Resource(name="productmanagerService")
	private ProductManagerManager productmanagerService;   //产品类管理
	
	
	
	/**保存
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/save")
	public ModelAndView save() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"新增ProductLib");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "add")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		pd.put("PRODUCTLIB_ID", this.get32UUID());	//主键
		productlibService.save(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**删除
	 * @param out
	 * @throws Exception
	 */
	@RequestMapping(value="/delete")
	public void delete(PrintWriter out) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"删除ProductLib");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
		PageData pd = new PageData();
		pd = this.getPageData();
		productlibService.delete(pd);
		out.write("success");
		out.close();
	}
	
	/**修改
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/edit")
	public ModelAndView edit() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"修改ProductLib");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "edit")){return null;} //校验权限
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		productlibService.edit(pd);
		mv.addObject("msg","success");
		mv.setViewName("save_result");
		return mv;
	}
	
	/**列表
	 * @param page
	 * @throws Exception
	 */
	@RequestMapping(value="/list")
	public ModelAndView list(Page page) throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"列表ProductLib");
		//if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		List<PageData> productType=productmanagerService.listAll(pd);
		pd.put("productType", productType);
		
		String keywords = pd.getString("keywords");				//关键词检索条件
		if(null != keywords && !"".equals(keywords)){
			pd.put("keywords", keywords.trim());
		}
		
		String PRO_TYPE = pd.getString("PRO_TYPE");				//关键词检索条件
		if(null != PRO_TYPE && !"".equals(PRO_TYPE)){
			pd.put("PRO_TYPE", PRO_TYPE.trim());
		}
		
		page.setPd(pd);
		List<PageData>	varList = productlibService.list(page);	//列出ProductLib列表
		mv.setViewName("sysmanger/productlib/productlib_list");
		mv.addObject("varList", varList);
		mv.addObject("pd", pd);
		mv.addObject("QX",Jurisdiction.getHC());	//按钮权限
		return mv;
	}
	
	/**去新增页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goAdd")
	public ModelAndView goAdd()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		List<PageData> productType=productmanagerService.listAll(pd);
		mv.addObject("productType", productType);
		
		
		mv.setViewName("sysmanger/productlib/productlib_edit");
		mv.addObject("msg", "save");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**去修改页面
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/goEdit")
	public ModelAndView goEdit()throws Exception{
		ModelAndView mv = this.getModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		
		List<PageData> productType=productmanagerService.listAll(pd);
		mv.addObject("productType", productType);

		pd = productlibService.findById(pd);	//根据ID读取
		mv.setViewName("sysmanger/productlib/productlib_edit");
		mv.addObject("msg", "edit");
		mv.addObject("pd", pd);
		return mv;
	}	
	
	 /**批量删除
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/deleteAll")
	@ResponseBody
	public Object deleteAll() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"批量删除ProductLib");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return null;} //校验权限
		PageData pd = new PageData();		
		Map<String,Object> map = new HashMap<String,Object>();
		pd = this.getPageData();
		List<PageData> pdList = new ArrayList<PageData>();
		String DATA_IDS = pd.getString("DATA_IDS");
		if(null != DATA_IDS && !"".equals(DATA_IDS)){
			String ArrayDATA_IDS[] = DATA_IDS.split(",");
			productlibService.deleteAll(ArrayDATA_IDS);
			pd.put("msg", "ok");
		}else{
			pd.put("msg", "no");
		}
		pdList.add(pd);
		map.put("list", pdList);
		return AppUtil.returnObject(pd, map);
	}
	
	 /**导出到excel
	 * @param
	 * @throws Exception
	 */
	@RequestMapping(value="/excel")
	public ModelAndView exportExcel() throws Exception{
		logBefore(logger, Jurisdiction.getUsername()+"导出ProductLib到excel");
		if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
		ModelAndView mv = new ModelAndView();
		PageData pd = new PageData();
		pd = this.getPageData();
		Map<String,Object> dataMap = new HashMap<String,Object>();
		List<String> titles = new ArrayList<String>();
		titles.add("产品内部代码");	//1
		titles.add("产品类别");	//2
		titles.add("品牌");	//3
		titles.add("商品名称");	//4
		titles.add("重量");	//5
		titles.add("单价");	//6
		titles.add("生产国");	//7
		titles.add("生产企业");	//8
		titles.add("采购国");	//9
		titles.add("原产国");	//10
		titles.add("条形码");	//11
		titles.add("配料及成分说明");	//12
		dataMap.put("titles", titles);
		List<PageData> varOList = productlibService.listAll(pd);
		List<PageData> varList = new ArrayList<PageData>();
		for(int i=0;i<varOList.size();i++){
			PageData vpd = new PageData();
			vpd.put("var1", varOList.get(i).getString("PL_CODE"));	    //1
			vpd.put("var2", varOList.get(i).getString("PL_TYPE"));	    //2
			vpd.put("var3", varOList.get(i).getString("PL_BRAND"));	    //3
			vpd.put("var4", varOList.get(i).getString("PL_NAME"));	    //4
			vpd.put("var5", varOList.get(i).get("PL_WEIGHT").toString());	//5
			vpd.put("var6", varOList.get(i).get("PL_PRICE").toString());	//6
			vpd.put("var7", varOList.get(i).getString("PL_PRO_COUNTRY"));	    //7
			vpd.put("var8", varOList.get(i).getString("PL_PRO_ENTERPRISES"));	    //8
			vpd.put("var9", varOList.get(i).getString("PL_PUR_COUNTRY"));	    //9
			vpd.put("var10", varOList.get(i).getString("PL_ORIGIN"));	    //10
			vpd.put("var11", varOList.get(i).getString("BAR_CODE "));	    //11
			vpd.put("var12", varOList.get(i).getString("PL_EXPLAIN"));	    //12
			varList.add(vpd);
		}
		dataMap.put("varList", varList);
		ObjectExcelView erv = new ObjectExcelView();
		mv = new ModelAndView(erv,dataMap);
		return mv;
	}
	
	@InitBinder
	public void initBinder(WebDataBinder binder){
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		binder.registerCustomEditor(Date.class, new CustomDateEditor(format,true));
	}
	
	
	
	/**
	 * 获取品牌
	 * @return
	 */
	@RequestMapping(value="/getBrand")
	@ResponseBody
	public Object getBrand(){
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String PL_TYPE = pd.getString("PL_TYPE");
			List<String> varList =  null;
			if(!StringUtils.isEmpty(PL_TYPE)) {
				varList =productlibService.getBrand(PL_TYPE); //用传过来的ID获取此ID下的子列表数据
			}
			map.put("list", varList);	
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	
	
	/**
	 * 获取商品名称
	 * @return
	 */
	@RequestMapping(value="/getPlName")
	@ResponseBody
	public Object getPlName(){
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String PL_TYPE = pd.getString("PL_TYPE");
			String PL_BRAND = pd.getString("PL_BRAND");
			
			List<String> varList =  null;
			if(!StringUtils.isEmpty(PL_TYPE) && !StringUtils.isEmpty(PL_BRAND)) {
				varList =productlibService.getPlName(pd); //用传过来的ID获取此ID下的子列表数据
			}
			map.put("list", varList);	
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	
	/**
	 * 获取商规格型号
	 * @return
	 */
	@RequestMapping(value="/selectPro")
	@ResponseBody
	public Object selectPro(){
		Map<String,Object> map = new HashMap<String,Object>();
		String errInfo = "success";
		PageData pd = new PageData();
		try{
			pd = this.getPageData();
			String PL_TYPE = pd.getString("PL_TYPE");
			String PL_BRAND = pd.getString("PL_BRAND");
			String PL_NAME = pd.getString("PL_NAME");
			
			List<PageData> varList =  null;
			if(!StringUtils.isEmpty(PL_TYPE) && !StringUtils.isEmpty(PL_BRAND) && !StringUtils.isEmpty(PL_NAME)) {
				varList =productlibService.selectPro(pd); //用传过来的ID获取此ID下的子列表数据
			}
			if(varList!=null) {
				for (PageData pageData : varList) {
					pageData.put("p_jsonStr", JSONObject.toJSONString(pageData));	
				}
			}
			map.put("list", varList);	
		} catch(Exception e){
			errInfo = "error";
			logger.error(e.toString(), e);
		}
		map.put("result", errInfo);				//返回结果
		return AppUtil.returnObject(new PageData(), map);
	}
	
	
	
	// 根据条形码 获取产品库 产品
	@RequestMapping("getByBarCode")
	public  ModelAndView getByBarCode(@RequestParam(required=true)String barCode) throws Exception {
		ModelAndView mv=new ModelAndView();
		ParcelArticles p=productlibService.selectByBarCode(barCode);
		mv.addObject("ParcelArticles", p);
		mv.addObject("jsonStr", JSONObject.toJSONString(p));
		mv.setViewName("sysmanger/productlib/product_choose");
		return mv;
	}

	// 根据条形码 获取产品库 产品（待揽收订单）
	@RequestMapping("getByBarCode2")
	public  ModelAndView getByBarCode2(@RequestParam(required=true)String barCode,
									   @RequestParam(required=true)String ORDERID
	) throws Exception {
		ModelAndView mv=new ModelAndView();
		ParcelArticles p=productlibService.selectByBarCode(barCode);
		mv.addObject("ParcelArticles", p);
		mv.addObject("ORDERID", ORDERID);
		mv.addObject("jsonStr", JSONObject.toJSONString(p));
		mv.setViewName("sysmanger/productlib/product_choose2");
		return mv;
	}


}
