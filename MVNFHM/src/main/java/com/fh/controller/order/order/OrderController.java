package com.fh.controller.order.order;

import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.shiro.session.Session;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.fh.controller.base.BaseController;
import com.fh.entity.Page;
import com.fh.entity.order.LogisticsInfo;
import com.fh.entity.order.Order;
import com.fh.entity.order.ParcelArticles;
import com.fh.entity.order.PersonInfo;
import com.fh.entity.system.User;
import com.fh.util.AppUtil;
import com.fh.util.Const;
import com.fh.util.DateUtil;
import com.fh.util.ObjectExcelView;
import com.fh.util.PageData;
import com.fh.util.Jurisdiction;
import com.fh.util.MakeOrderNum;
import com.fh.util.Tools;
import com.fh.util.express.GetExpressMsg;
import com.hazelcast.spi.impl.eventservice.impl.TrueEventFilter;
import com.fh.service.order.logistics_info.Logistics_InfoMapper;
import com.fh.service.order.msg_board.Msg_BoardManager;
import com.fh.service.order.order.OrderManager;
import com.fh.service.order.parcelarticles.ParcelArticlesManager;
import com.fh.service.sysmanger.productmanager.ProductManagerManager;
import com.fh.service.sysmanger.store.StoreManager;
import com.fh.service.usercenter.mail_addr.Mail_addrManager;

/**
 * 说明：订单模块
 * 创建人：FH Q313596790
 * 创建时间：2018-06-13
 */
@Controller
@RequestMapping(value = "/order")
public class OrderController extends BaseController {

    String menuUrl = "order/list.do"; //菜单地址(权限用)
    @Resource(name = "orderService")
    private OrderManager orderService;
    @Resource(name = "parcelarticlesService")
    private ParcelArticlesManager parcelarticlesService;
    @Resource(name = "mail_addrService")
    private Mail_addrManager mail_addrService; //收件/寄件人信息
    @Resource(name = "storeService")
    private StoreManager storeService;   //门店
    @Resource(name = "productmanagerService")
    private ProductManagerManager productmanagerService;   //产品类管理
    @Resource(name = "logistics_infoService")
    private Logistics_InfoMapper logistics_InfoService;   //订单日志
    @Resource(name = "msg_boardService")
    private Msg_BoardManager msg_boardService;


    /**
     * 保存
     *
     * @param
     * @throws Exception
     */
    @RequestMapping(value = "/save")
    @ResponseBody
    public JSONObject save() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "新增Order");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "add")) {
            return null;
        } //校验权限

        JSONObject json = new JSONObject();
        PageData pd = new PageData();
        pd = this.getPageData();

        String orderId = this.get32UUID();
        pd.put("ORDER_ID", orderId);    //主键
        pd.put("ISDELETE", "0");    //是否删除
        pd.put("CREATEBY", Jurisdiction.getUsername());
        pd.put("CREATETIME", DateUtil.getTime());

        MakeOrderNum m = new MakeOrderNum();
        pd.put("ORDERNO", m.makeOrderNum()); //分配订单号
        pd.put("STATEA", 0); //订单状态设置为未揽收 TODO


        // 获取当前用户的默认门店
        User user = (User) Jurisdiction.getSession().getAttribute(Const.SESSION_USER);
        pd.put("STOREID", user.getCITY());

        // 获取当前用户门店
        PageData params = new PageData();
        params.put("STORE_ID", user.getCITY());
        PageData store = storeService.findById(params);

        // 设置默认门店地址
        PersonInfo p = JSONObject.parseObject(pd.getString("SENDERSTR"), PersonInfo.class);
        p.setD_ADDRESS(store.getString("S_ADDRESSS"));
        p.setS_ADDRESS(store.getString("S_REGION"));
        pd.put("SENDERSTR", JSONObject.toJSONString(p));

        try {
            //处理寄件物品
            String jsonStr = pd.getString("jsonStr");
            if (!StringUtils.isEmpty(jsonStr)) {
                List<ParcelArticles> li = JSONArray.parseArray(jsonStr, ParcelArticles.class);
                for (ParcelArticles parcelArticles : li) {
                    parcelArticles.setPARCELARTICLES_ID(this.get32UUID()); //主键
                    parcelArticles.setORDERID(orderId);  //关联的订单
                    parcelArticles.setCREATEBY(Jurisdiction.getUsername());
                    parcelArticles.setCREATETIME(DateUtil.getTime());
                    parcelArticles.setIS_PACK(0);
                }
                parcelarticlesService.insertBatch(li);
            }

            //日志处理
            logistics_InfoService.insert(new LogisticsInfo(orderId, DateUtil.getTime(), DateUtil.getTime() + "【用户】" + Jurisdiction.getUsername() + "提交订单"));

            orderService.save(pd);
            json.put("flag", true);
        } catch (Exception e) {
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
    public void delete(PrintWriter out) throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "删除Order");
        //if(!Jurisdiction.buttonJurisdiction(menuUrl, "del")){return;} //校验权限
        PageData pd = new PageData();
        pd = this.getPageData();
        orderService.delete(pd);
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
        logBefore(logger, Jurisdiction.getUsername() + "列表Order");
        //if(!Jurisdiction.buttonJurisdiction(menuUrl, "cha")){return null;} //校验权限(无权查看时页面会有提示,如果不注释掉这句代码就无法进入列表页面,所以根据情况是否加入本句代码)
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        String keywords = pd.getString("keywords");                //关键词检索条件
        if (null != keywords && !"".equals(keywords)) {
            pd.put("keywords", keywords.trim());
        }
        String order_type = pd.getString("order_type");

        pd.put("order_type_select", order_type);
        if (null != order_type && !"".equals(order_type)) {
            if ("0".equals(order_type)) {
                pd.put("order_type", "0");
            } else if ("1".equals(order_type)) {
                pd.put("order_type", "1,2");
            } else if ("2".equals(order_type)) {
                pd.put("order_type", "3");
            } else if ("3".equals(order_type)) {
                pd.put("order_type", "4");
            } else {
                pd.put("order_type", "5");
            }
        }

        pd.put("CREATEBY", Jurisdiction.getUsername()); //创建人
        pd.put("ISDELETE", "0");   //未删除的订单

        page.setPd(pd);
        List<PageData> varList = orderService.list(page);    //列出Order列表
        mv.setViewName("order/order/order_list");
        mv.addObject("varList", varList);
        mv.addObject("pd", pd);
        mv.addObject("QX", Jurisdiction.getHC());    //按钮权限
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

        //获取寄件人 默认信息
        pd.put("M_TYPE", "0");
        pd.put("CREATEBY", Jurisdiction.getUsername());
        PageData sender = mail_addrService.queryMyDefault(pd);
        if (sender != null) {
            pd.put("SENDER", sender.getString("SENDER"));
            String senderStr = JSONObject.toJSONString(sender);
            pd.put("SENDERSTR", senderStr);
        }

        //获取收件人 默认信息
        pd.put("M_TYPE", "1");
        PageData addressee = mail_addrService.queryMyDefault(pd);
        if (addressee != null) {
            pd.put("ADDRESSEE", addressee.getString("SENDER"));
            String addresseeStr = JSONObject.toJSONString(addressee);
            pd.put("ADDRESSEESTR", addresseeStr);
        }

        //默认门店
        List<PageData> stores = storeService.listAll(pd);
        pd.put("stores", stores);

        //产品类列表
        List<PageData> products = productmanagerService.listAll(pd);
        pd.put("products", products);

        mv.setViewName("order/order/order_add");
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
        pd = orderService.findById(pd);    //根据ID读取

        //读取关联的物品信息 转化json串
        List<ParcelArticles> parcelArticles = parcelarticlesService.selectByOrderId(pd.getString("ORDER_ID"));
        if (parcelArticles != null && parcelArticles.size() > 0) {
            String str = JSONArray.toJSONString(parcelArticles);
            pd.put("PaStr", str);
        }

        //默认门店
        List<PageData> stores = storeService.listAll(pd);
        pd.put("stores", stores);

        //产品类列表
        List<PageData> products = productmanagerService.listAll(pd);
        pd.put("products", products);


        mv.setViewName("order/order/order_edit");
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
    @ResponseBody
    public JSONObject edit() throws Exception {
        logBefore(logger, Jurisdiction.getUsername() + "修改Order");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "edit")) {
            return null;
        } //校验权限
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();

        JSONObject json = new JSONObject();
        String orderId = pd.getString("ORDER_ID");
        try {
            //根据订单id删除物品信息
            parcelarticlesService.delByOrderId(orderId);

            //处理寄件物品
            String jsonStr = pd.getString("jsonStr");
            if (!StringUtils.isEmpty(jsonStr)) {
                List<ParcelArticles> li = JSONArray.parseArray(jsonStr, ParcelArticles.class);
                for (ParcelArticles parcelArticles : li) {
                    parcelArticles.setPARCELARTICLES_ID(this.get32UUID()); // 主键
                    parcelArticles.setORDERID(orderId); // 关联的订单
                    parcelArticles.setCREATEBY(Jurisdiction.getUsername());
                    parcelArticles.setCREATETIME(DateUtil.getTime());
                    parcelArticles.setIS_PACK(0);
                }
                parcelarticlesService.insertBatch(li);
            }

            // 获取当前用户门店
            PageData params = new PageData();
            params.put("STORE_ID", pd.getString("STOREID"));
            PageData store = storeService.findById(params);

            // 设置默认门店地址
            PersonInfo p = JSONObject.parseObject(pd.getString("SENDERSTR"), PersonInfo.class);
            p.setD_ADDRESS(store.getString("S_ADDRESSS"));
            p.setS_ADDRESS(store.getString("S_REGION"));
            pd.put("SENDERSTR", JSONObject.toJSONString(p));


            pd.put("UPDATEBY", Jurisdiction.getUsername());
            pd.put("UPDATETIME", DateUtil.getTime());
            orderService.edit(pd);

            logistics_InfoService.insert(new LogisticsInfo(orderId, DateUtil.getTime(), DateUtil.getTime() + "【用户】" + Jurisdiction.getUsername() + "修改订单信息"));

            json.put("flag", true);
        } catch (Exception e) {
            json.put("flag", true);
        }
        return json;
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
        logBefore(logger, Jurisdiction.getUsername() + "批量删除Order");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "del")) {
            return null;
        } //校验权限
        PageData pd = new PageData();
        Map<String, Object> map = new HashMap<String, Object>();
        pd = this.getPageData();
        List<PageData> pdList = new ArrayList<PageData>();
        String DATA_IDS = pd.getString("DATA_IDS");
        if (null != DATA_IDS && !"".equals(DATA_IDS)) {
            String ArrayDATA_IDS[] = DATA_IDS.split(",");
            orderService.deleteAll(ArrayDATA_IDS);
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
        logBefore(logger, Jurisdiction.getUsername() + "导出Order到excel");
        if (!Jurisdiction.buttonJurisdiction(menuUrl, "cha")) {
            return null;
        }
        ModelAndView mv = new ModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        Map<String, Object> dataMap = new HashMap<String, Object>();
        List<String> titles = new ArrayList<String>();
        titles.add("订单号");    //1
        titles.add("默认门店");    //2
        titles.add("寄件人");    //3
        titles.add("收件人");    //4
        titles.add("创建人");    //5
        titles.add("创建时间");    //6
        titles.add("修改人");    //7
        titles.add("修改时间");    //8
        titles.add("是否删除");    //9
        dataMap.put("titles", titles);
        List<PageData> varOList = orderService.listAll(pd);
        List<PageData> varList = new ArrayList<PageData>();
        for (int i = 0; i < varOList.size(); i++) {
            PageData vpd = new PageData();
            vpd.put("var1", varOList.get(i).getString("ORDERNO"));        //1
            vpd.put("var2", varOList.get(i).getString("STOREID"));        //2
            vpd.put("var3", varOList.get(i).getString("SENDER"));        //3
            vpd.put("var4", varOList.get(i).getString("ADDRESSEE"));        //4
            vpd.put("var5", varOList.get(i).getString("CREATEBY"));        //5
            vpd.put("var6", varOList.get(i).getString("CREATETIME"));        //6
            vpd.put("var7", varOList.get(i).getString("UPDATEBY"));        //7
            vpd.put("var8", varOList.get(i).getString("UPDATETIME"));        //8
            vpd.put("var9", varOList.get(i).get("ISDELETE").toString());    //9
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
     * 普通用户-待揽收-查看详情
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("order_1_details")
    public ModelAndView order_deatis() throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = new PageData();
        pd = this.getPageData();
        Order order = orderService.selectByPk(pd.getString("ORDER_ID"));//根据ID读取

        PageData sender = JSONObject.parseObject(order.getSENDERSTR(), PageData.class);
        ;
        PageData adderssee = JSONObject.parseObject(order.getADDRESSEESTR(), PageData.class);
        ;

        String flag = pd.getString("flag");
        if ("0".equals(order.getSTATEA()) || !StringUtils.isEmpty(flag)) {
            mv.setViewName("order/userorder/order_a_details");
        } else {
            //获取异常申报信息
            //List<PageData> pds = msg_boardService.selectByOrderId(order.getORDER_ID());
            //mv.addObject("msg_boards", pds);
            mv.addObject("_username", Jurisdiction.getUsername());
            mv.setViewName("order/userorder/order_b_details");
        }

        mv.addObject("pd", pd);
        mv.addObject("order", order);
        mv.addObject("sender", sender);
        mv.addObject("adderssee", adderssee);
        return mv;
    }


    /**
     * 查询订单物流信息
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("logistics_information")
    public ModelAndView logistics_information(@RequestParam(value = "ORDER_ID", required = true) String ORDER_ID) throws Exception {
        ModelAndView mv = this.getModelAndView();
        PageData pd = this.getPageData();

        // PageData order=orderService.findById(pd);
     /*	String STATEA=order.get("STATEA")+"";
		if("7".equals(STATEA)) {
			// 调用物流接口获取数据
			String LOGISTICS=order.getString("LOGISTICS");	 //运单号
			if(!StringUtils.isEmpty(LOGISTICS)) {
			
			   String  str =GetExpressMsg.get(LOGISTICS);
			   org.json.JSONObject json= new org.json.JSONObject(str);
	           mv.addObject("logisticsStr", json.get("body"));
			}
		}*/

        List<LogisticsInfo> logisticsInfos = logistics_InfoService.selectByOrderId(ORDER_ID);
        mv.addObject("logisticsInfos", logisticsInfos);
        mv.setViewName("order/userorder/logistics_information");
        return mv;
    }


}
