package com.fh.controller.order.parcel;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.commons.codec.binary.Base64;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.order.LogisticsInfo;
import com.fh.entity.order.Order;
import com.fh.entity.order.Parcel;
import com.fh.entity.order.ParcelArticles;
import com.fh.entity.order.ProductManager;
import com.fh.entity.order.ReqData;
import com.fh.util.AppUtil;
import com.fh.util.BarcodeUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.FileUpload;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.PathUtil;
import com.fh.util.StringUtil;
import com.fh.util.Jurisdiction;
import com.fh.util.MD5;
import com.fh.util.Tools;
import com.fh.util.express.GetExpressMsg;
import com.fh.service.order.order.OrderManager;
import com.fh.service.order.parcel.ParcelManager;
import com.fh.service.order.parcelarticles.ParcelArticlesManager;
import com.fh.service.sysmanger.productmanager.ProductManagerManager;

/**
 * 说明：包裹管理 创建人：FH Q313596790 创建时间：2018-06-17
 */
@Controller
@RequestMapping(value = "/parcel")
public class ParcelController extends BaseController {

    String menuUrl = "parcel/list.do"; // 菜单地址(权限用)
    @Resource(name = "parcelService")
    private ParcelManager parcelService;
    @Resource(name = "productmanagerService")
    private ProductManagerManager productmanagerService; // 产品类管理
    @Resource(name = "parcelarticlesService")
    private ParcelArticlesManager parcelarticlesService;
    @Resource(name = "orderService")
    private OrderManager orderService;

    /**
     * 保存
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/save")
    @Transactional
    public ModelAndView save() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String PARCEL_ID = this.get32UUID();

        pd.put("PARCEL_ID", PARCEL_ID); // 主键
        pd.put("GOODS_PK", pd.getString("paPks")); // 寄件物品列表

        // 确定包裹的名称
        Integer value = parcelService.selectMaxValue(pd.getString("orderId"));
        if (value == null) {
            value = 0;
        } else {
            value++;
        }
        pd.put("CODEVALUE", value);
        pd.put("PACK_NAME", "包裹" + MD5.letters[value]);

        // 包材费用
        Double PACK_COST = 0.0;
        String packInfoArray = pd.getString("packInfoArray");
        if (!StringUtils.isEmpty(packInfoArray)) {
            List<PageData> pageDatas = JSONArray.parseArray(packInfoArray, PageData.class);
            for (PageData pageData : pageDatas) {
                PACK_COST += Integer.parseInt(pageData.get("COUNT") + "")
                        * Double.parseDouble(pageData.get("PM_PRICE") + "");
            }
        }
        pd.put("PACK_COST", PACK_COST); // 包材总费用
        pd.put("PACKJSONARR", packInfoArray);

        ProductManager productManager = productmanagerService.selectByPk(pd.getString("PACK_TYPE"));
        pd.put("FEE_SCALE", productManager.getPRO_PRICE()); // 收费标准
        pd.put("PACK_TYPE_NAME", productManager.getPRO_TYPE()); //
        Double total = Double.parseDouble(pd.get("WEIGHT") + "") * productManager.getPRO_PRICE() + PACK_COST;
        pd.put("TOTAL_COST", total);

        pd.put("ORDER_ID", pd.getString("orderId")); // 关联的订单ID
        pd.put("CREATEBY", Jurisdiction.getUsername());// 创建人
        pd.put("CREATETIME", DateUtil.getTime()); // 创建时间

        // 批量修改 物品的打包状态
        PageData params = new PageData();
        params.put("IS_PACK", "1");
        params.put("PARCELARTICLES_IDS", pd.getString("paPks"));
        parcelarticlesService.updateIsPack(params);
        parcelService.save(pd);

        // pd.put("APPLY_STATUS", "0"); // 运单申请状态 0:刚创建

        // 更具PARCEL_ID获取记录 获取订单 pd.getString("orderId") PARCEL_ID
        //Parcel parcel = parcelService.selectById(PARCEL_ID);
        //Order order = orderService.selectByPk(pd.getString("orderId"));
        //orderService.req_no(order, parcel);

        mv.addObject("msg", "success");
        mv.setViewName("save_result");
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
        pd = parcelService.findById(pd); // 根据ID读取

        // 1.产品类列表
        List<PageData> products = productmanagerService.listAll(pd);
        mv.addObject("products", products);

        // 2.根据主键列表获取寄件物品信息
        List<ParcelArticles> parcelArticles = parcelarticlesService.selectByPks(pd.getString("GOODS_PK"));
        mv.addObject("ids", pd.getString("GOODS_PK"));
        mv.addObject("parcelArticles", parcelArticles);
        mv.addObject("ORDER_ID", pd.getString("ORDER_ID"));

        mv.setViewName("order/stroeOrder/order_pack");
        mv.addObject("msg", "edit");
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
    public ModelAndView edit() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();
        PageData oldData = parcelService.findById(pd); // 根据ID读取数据库的原数据
        // 包材费用
        Double PACK_COST = 0.0;
        String packInfoArray = pd.getString("packInfoArray");
        if (!StringUtils.isEmpty(packInfoArray)) {
            List<PageData> pageDatas = JSONArray.parseArray(packInfoArray, PageData.class);
            for (PageData pageData : pageDatas) {
                PACK_COST += Integer.parseInt(pageData.get("COUNT") + "")
                        * Double.parseDouble(pageData.get("PM_PRICE") + "");
            }
        }
        pd.put("PACK_COST", PACK_COST); // 包材总费用
        pd.put("PACKJSONARR", packInfoArray);

        pd.put("PACK_COST", PACK_COST); // 包材总费用
        pd.put("PACKJSONARR", packInfoArray);

        ProductManager productManager = productmanagerService.selectByPk(pd.getString("PACK_TYPE"));
        pd.put("FEE_SCALE", productManager.getPRO_PRICE()); // 收费标准
        pd.put("PACK_TYPE_NAME", productManager.getPRO_TYPE()); //
        Double total = Double.parseDouble(pd.get("WEIGHT") + "") * productManager.getPRO_PRICE() + PACK_COST;
        pd.put("TOTAL_COST", total);
        pd.put("GOODS_PK", pd.getString("paPks")); // 寄件物品列表

        pd.put("UPDATEBY", Jurisdiction.getUsername());// 创建人
        pd.put("UPDATETIME", DateUtil.getTime()); // 创建时间

        // 批量修改 物品的打包状态
        PageData params_old = new PageData();
        params_old.put("IS_PACK", "0");
        params_old.put("PARCELARTICLES_IDS", oldData.getString("GOODS_PK"));
        parcelarticlesService.updateIsPack(params_old);

        // 批量修改 物品的打包状态
        PageData params_new = new PageData();
        params_new.put("IS_PACK", "1");
        params_new.put("PARCELARTICLES_IDS", pd.getString("paPks"));
        parcelarticlesService.updateIsPack(params_new);
        parcelService.edit(pd);

        // 更具PARCEL_ID获取记录 获取订单 pd.getString("orderId") PARCEL_ID
        //Parcel parcel = parcelService.selectById(pd.getString("PARCEL_ID"));
        //Order order = orderService.selectByPk(pd.getString("orderId"));
        //orderService.req_no(order, parcel);

        mv.addObject("msg", "success");
        mv.setViewName("save_result");
        return mv;
    }

    /**
     * 删除
     *
     * @param out
     * @throws Exception
     */
    @RequestMapping(value = "/delete")
    public void delete(PrintWriter out) throws Exception {
        PageData pd = this.getPageData();
        PageData oldData = parcelService.findById(pd); // 根据ID读取数据库的原数据
        // 批量修改 物品的打包状态
        PageData params_old = new PageData();
        params_old.put("IS_PACK", "0");
        params_old.put("PARCELARTICLES_IDS", oldData.getString("GOODS_PK"));
        parcelarticlesService.updateIsPack(params_old);
        parcelService.delete(pd);
        out.write("success");
        out.close();
    }

    // *******************************************************************************************************//
    // **************************************以下无用到*******************************************************//
    // *******************************************************************************************************//

    /**
     * 列表
     *
     * @param page
     * @throws Exception
     */
    @RequestMapping(value = "/list")
    public ModelAndView list(Page page) throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "列表Parcel");
        // if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;}
        // //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("keywords"); // 关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        page.setPd(pd);
        List<PageData> varList = parcelService.list(page); // 列出Parcel列表
        mv.setViewName("order/parcel/parcel_list");
        mv.addObject("varList", varList);
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
        mv.setViewName("order/parcel/parcel_edit");
        mv.addObject("msg", "save");
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
        logBefore(logger, Jurisdiction.getUsername() + "批量删除Parcel");
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
            parcelService.deleteAll(ArrayDATA_IDS);
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
        logBefore(logger, Jurisdiction.getUsername() + "导出Parcel到excel");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
            return null;
        }
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String, Object> dataMap = new HashMap<String, Object>();
        List<String> titles = new ArrayList<String>();
        titles.add("包裹名称"); // 1
        titles.add("包裹类型"); // 2
        titles.add("包裹类型名称"); // 3
        titles.add("收费标准"); // 4
        titles.add("重量"); // 5
        titles.add("包材费用"); // 6
        titles.add("寄件物品"); // 7
        titles.add("包裹总费用"); // 8
        titles.add("创建人"); // 9
        titles.add("创建时间"); // 10
        titles.add("修改人"); // 11
        titles.add("修改时间"); // 12
        dataMap.put("titles", titles);
        List<PageData> varOList = parcelService.listAll(pd);
        List<PageData> varList = new ArrayList<PageData>();
        for (int i = 0; i < varOList.size(); i++) {
            PageData vpd = new PageData();
            vpd.put("var1", varOList.get(i).getString("PACK_NAME")); // 1
            vpd.put("var2", varOList.get(i).getString("PACK_TYPE")); // 2
            vpd.put("var3", varOList.get(i).getString("PACK_TYPE_NAME")); // 3
            vpd.put("var4", varOList.get(i).get("FEE_SCALE").toString()); // 4
            vpd.put("var5", varOList.get(i).get("WEIGHT").toString()); // 5
            vpd.put("var6", varOList.get(i).get("PACK_COST").toString()); // 6
            vpd.put("var7", varOList.get(i).getString("GOODS_PK")); // 7
            vpd.put("var8", varOList.get(i).get("TOTAL_COST").toString()); // 8
            vpd.put("var9", varOList.get(i).getString("CREATEBY")); // 9
            vpd.put("var10", varOList.get(i).getString("CREATETIME")); // 10
            vpd.put("var11", varOList.get(i).getString("UPDATEBY")); // 11
            vpd.put("var12", varOList.get(i).getString("UPDATETIME")); // 12
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

    // ***********************************************************************************************//

    /**
     * 根据包裹id查询物流信息
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("logistics_information")
    public ModelAndView logistics_information(@RequestParam(value = "PARCEL_ID", required = true) String PARCEL_ID)
            throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();

        PageData parcel = parcelService.findById(pd);
        String LOGISTICS = parcel.getString("LOGISTICS");
        if (!StringUtils.isEmpty(LOGISTICS)) {
            String str = GetExpressMsg.get(LOGISTICS);
            org.json.JSONObject json = new org.json.JSONObject(str);
            mv.addObject("logisticsStr", json.get("body"));
        }
        mv.addObject("parcel", parcel);
        mv.setViewName("order/order/logistics_information");
        return mv;
    }

    /**
     * 根据包裹id获取面单数据
     *
     * @param PARCEL_ID
     * @return
     * @throws Exception
     */
    @RequestMapping("printFaceSheet")
    public ModelAndView print(@RequestParam(value = "PARCEL_ID", required = true) String PARCEL_ID) throws Exception {
        ModelAndView mv = this.getModelAndView();
        // 获取包裹信息
        PageData pd = this.getPageData();
        PageData parcel = parcelService.findById(pd);

        ReqData reqData = parcelService.selectByPrimaryKey(parcel.getString("Sourceno"));
        com.fh.entity.yhkd.ReqData r = JSONObject.parseObject(reqData.getReqdata(), com.fh.entity.yhkd.ReqData.class);

        // 判断条形码是否存在 , 不存在就创建
        if (org.springframework.util.StringUtils.isEmpty(reqData.getBarCode()) || "-1".equals(reqData.getBarCode())) {
            byte[] data = BarcodeUtil.generate(parcel.getString("LOGISTICS"));
            reqData.setBarCode(new String(Base64.encodeBase64(data)));
            parcelService.updateByPrimaryKeySelective(reqData);
        }
        String[] sss = parcel.getString("Printspec").split("  ");
        mv.addObject("Printspec", sss);
        mv.addObject("barCode", reqData);
        mv.addObject("parcel", parcel);
        mv.addObject("ReqData", r);
        mv.setViewName("order/electSurface/electSurface");
        return mv;
    }

}
