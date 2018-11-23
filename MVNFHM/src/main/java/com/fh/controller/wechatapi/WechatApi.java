package com.fh.controller.wechatapi;

import com.fh.controller.base.BaseController;
import com.fh.controller.system.login.LoginController;
import com.fh.dao.DaoSupport;
import com.fh.entity.system.User;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.user.UserManager;
import com.fh.service.wechat.wechat.WechatApiManager;
import com.fh.util.*;
import net.sf.json.JSONArray;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.omg.CORBA.Object;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * @Author: Cdl Q765371590
 * @Date: 2018/11/12 8:50
 * @Description:
 */
@Controller
@RequestMapping(value = "/api/wechat")
public class WechatApi {
    @Resource(name = "userService")
    private UserManager userService;
    @Resource(name = "fhlogService")
    private FHlogManager FHLOG;
    @Resource(name ="WechatApiService" )
    private WechatApiManager wechatApiManager;

    /**
     * 登录验证
     *
     * @throws Exception
     */
    //@ApiOperation(value="新增协助办理出院",method = RequestMethod.POST)
    @RequestMapping(value = "/login.json", produces = "application/json"/*,method = RequestMethod.GET*//*,method = RequestMethod.POST*/,method = RequestMethod.POST)
    @ResponseBody
    @CrossOrigin(origins = "*", maxAge = 3600)
    public JsonResult login(
            @RequestParam(required = false, value = "user") String user,//用户名
            @RequestParam(required = false, value = "password") String password//密码
            ,HttpServletRequest request
    ) throws Exception {
        PageData pd = new PageData();
        JsonResult json = JsonResult.of();
        String errInfo = "";
        boolean result = false;
        Session session = Jurisdiction.getSession();
        pd.put("USERNAME", user);
        String passwd = new SimpleHash("SHA-1", user, password).toString();    //密码加密
        pd.put("PASSWORD", passwd);
        pd = userService.getUserByNameAndPwd(pd);    //根据用户名和密码去读取用户信息

        if (pd != null) {

            new LoginController().removeSession(user);//清缓存
            //把用户信息放session中
            JSONArray j=JSONArray.fromObject(pd);
            json.put("msgall",j);
            request.getSession().setAttribute(Const.SESSION_USER, j);
            pd.put("LAST_LOGIN", DateUtil.getTime().toString());
            userService.updateLastLogin(pd);//更新登录时间
            User u = new User();
            u.setUSER_ID(pd.getString("USER_ID"));
            u.setUSERNAME(pd.getString("USERNAME"));
            u.setPASSWORD(pd.getString("PASSWORD"));
            u.setNAME(pd.getString("NAME"));
            u.setRIGHTS(pd.getString("RIGHTS"));
            u.setROLE_ID(pd.getString("ROLE_ID"));
            u.setLAST_LOGIN(pd.getString("LAST_LOGIN"));
            u.setIP(pd.getString("IP"));
            u.setSTATUS(pd.getString("STATUS"));
            u.setSTORE(pd.getString("STORE"));
            u.setCITY(pd.getString("CITY"));

            /* session.removeAttribute(Const.SESSION_SECURITY_CODE);*/    //清除登录验证码的session
            //shiro加入身份验证
            Subject subject = SecurityUtils.getSubject();
            UsernamePasswordToken token = new UsernamePasswordToken(user, password);
            try {
                subject.login(token);
                errInfo = "验证成功";                    //验证成功
                result = true;
                FHLOG.save(user, "登录公众号");
            } catch (AuthenticationException e) {
                errInfo = "身份验证失败！";
            }
        } else {
            errInfo = "用户名或密码有误";                //用户名或密码有误
            FHLOG.save(user, "登录公众号密码或用户名错误");
        }
        json.put("result", result);
        json.put("errInfo", errInfo);
        return json;
    }

    /**
     * 注册
     * @param user
     * @param password
     * @return
     * @throws Exception
     */

    private BaseController bb ;

    @RequestMapping(value = "/register.json", produces = "application/json"/*,method = RequestMethod.GET*/,method = RequestMethod.POST)
    @ResponseBody
    @CrossOrigin(origins = "*", maxAge = 3600)
    public JsonResult register(HttpServletRequest request) throws Exception {
        JsonResult json=JsonResult.of();
        PageData pd = new PageData(request);
        String result = "00";
        try {
            // 检验请求key值是否合法
            // 检查参数
            Session session = Jurisdiction.getSession();
            // ID 主键
            pd.put("USER_ID", UuidUtil.get32UUID());
            // 角色ID fhadminzhuche 为注册用户
            pd.put("ROLE_ID", "fhadminzhuche");
            // 编号
            pd.put("NUMBER", "");
            // pd.put("PHONE", ""); //手机号
            // 备注
            pd.put("BZ", "注册用户");
            // 最后登录时间
            pd.put("LAST_LOGIN", "");
            // IP
            pd.put("IP", "");
            // 状态
            pd.put("STATUS", "0");
            pd.put("SKIN", "default");
            // 默认名称
            pd.put("NAME", "普通用户");
            // 默认邮箱
            pd.put("EMAIL", "XXXXXXXX@163.com");

            pd.put("RIGHTS", "");
            // 密码加密
            pd.put("PASSWORD",
                    new SimpleHash("SHA-1", pd.getString("USERNAME"), pd.getString("PASSWORD")).toString());
            // 判断用户名是否存在
            if (null == userService.findByUsername(pd)) {
                // 执行保存
                userService.saveU(pd);
                FHLOG.save(pd.getString("USERNAME"), "新注册");
                result="注册成功";
                json.put("result", result);
            } else {
                // 用户名已存在
                result = "用户名已存在";
                json.put("result", result);
            }


        } catch (Exception e) {

        }




        return json;
    }

    /**
     *密码修改
     */
    @RequestMapping(value = "/updatePwd.json", produces = "application/json"/*,method = RequestMethod.GET*/,method = RequestMethod.POST)
    @ResponseBody

    @CrossOrigin(origins = "*", maxAge = 3600)
    public JsonResult updatePwd(
            @RequestParam(required = false, value = "USER_ID") String USER_ID,//用户名
            @RequestParam(required = false, value = "PASSWORD") String PASSWORD ,//密码
            @RequestParam(required = false, value = "ORIGINAL_PASSWORD") String ORIGINAL_PASSWORD ,//原密码
            HttpServletRequest request
    ) throws Exception {
        JsonResult j=JsonResult.of();
        String result;
        //获取当前用户所有信息
        User user=userService.getUserAndRoleById(USER_ID);
        //原密码加密比较
        String passwd = new SimpleHash("SHA-1", user.getUSERNAME(), ORIGINAL_PASSWORD).toString();
        //判断密码是否与原密码一致
        if (user.getPASSWORD().equals(passwd)){
            PageData pd=new PageData();
            String password = new SimpleHash("SHA-1", user.getUSERNAME(), PASSWORD).toString();
            pd.put("PASSWORD",password);
            pd.put("USERID",USER_ID);
            //修改密码
            wechatApiManager.edit(pd);
            result="密码修改成功";
            j.put("result",result);
        }else {
            result="原密码输入错误";
            j.put("result",result);
        }

        return j;
    }

    /**
     *
     * 门店信息
     */
    private DaoSupport dao;
    @RequestMapping(value = "/storesMsg.json", produces = "application/json"/*,method = RequestMethod.GET*/,method = RequestMethod.POST)
    @ResponseBody
    @CrossOrigin(origins = "*", maxAge = 3600)
    public JsonResult storesMsg(HttpServletRequest request) throws Exception {
        JsonResult json=JsonResult.of();
        //获取所有门店信息
        List s=userService.getStore();
        json.put("all", s);
        return json;
    }

    /**
     * 门店修改
     */
    @RequestMapping(value = "/updateStore.json", produces = "application/json"/*,method = RequestMethod.GET*/,method = RequestMethod.POST)
    @ResponseBody

    @CrossOrigin(origins = "*", maxAge = 3600)
    public JsonResult updateStore(
            @RequestParam(required = false, value = "USER_ID") String USER_ID,//用户名
            @RequestParam(required = false, value = "STORE_ID") String STORE_ID ,//门店id
            HttpServletRequest request
    ) throws Exception {
        JsonResult j=JsonResult.of();
        String result;
        //获取当前用户所有信息
        User user=userService.getUserAndRoleById(USER_ID);
        //获取更换门店id
            PageData pd=new PageData();
            pd.put("STORE",STORE_ID);
            pd.put("USERID",USER_ID);
            try {
                //修改门店信息
                wechatApiManager.editStore(pd);
                result = "门店修改成功";
                j.put("result", result);
            }catch (Exception e){
                result="门店修改失败";
                j.put("result", result);
            }
        return j;
    }

    /**
     * 我的信息
     *
     */
    @RequestMapping(value = "/MsgToMe.json", produces = "application/json"/*,method = RequestMethod.GET*/,method = RequestMethod.POST)
    @ResponseBody
    @CrossOrigin(origins = "*", maxAge = 3600)
    public JsonResult MsgToMe(HttpServletRequest request) throws Exception {
        JsonResult json=JsonResult.of();
        //获取用户信息id
        String USER_ID=request.getParameter("USER_ID");
        //查找用户信息
        User user=userService.getUserAndRoleById(USER_ID);
        //获取所有门店
        List<Map<String, Object>> s=userService.getStore();
        //将id转为门店名称
        for(int i=0;i<s.size();i++) {
            String  a= String.valueOf(s.get(i).get("STORE_ID"));
            if (user.getSTORE().equals(a)){
                json.put("Store_allMsg",s.get(i).get("S_NAME"));
            }
        }
        json.put("Msg",user);
        return json;
    }
    /**
     * 所有类别
     */
    @RequestMapping(value = "/allProduct.json", produces = "application/json"/*,method = RequestMethod.GET*/,method = RequestMethod.POST)
    @ResponseBody
    @CrossOrigin(origins = "*", maxAge = 3600)
    public JsonResult allProduct(HttpServletRequest request) throws Exception {
        String result;
        JsonResult json=new JsonResult();
        try {
        //获取所有类别
        List all=wechatApiManager.allProduct(null);
        json.put("all",all);
            result="获取成功";
            json.put("result",result);
        }catch (Exception e){
            result="获取失败";
            json.put("result",result);
        }
        return json;
    }
    /**
     *所有品牌
     */
    @RequestMapping(value = "/allProductBand.json", produces = "application/json"/*,method = RequestMethod.GET*/,method = RequestMethod.POST)
    @ResponseBody
    @CrossOrigin(origins = "*", maxAge = 3600)
    public JsonResult allProductBand(
            @RequestParam(required = false,value = "PL_TYPE")String PL_TYPE
    ) throws Exception {
        String result;
        JsonResult json=new JsonResult();
        PageData pd=new PageData();
        pd.put("PRODUCTID",PL_TYPE);
        try {

        //获取所有品牌
        List all=wechatApiManager.allProductBand(pd);
        json.put("all",all);
            result="获取成功";
            json.put("result",result);
        }catch (Exception e){
            result="获取失败";
            json.put("result",result);
        }
        return json;
    }

    /**
     * 所有品名
     */
    @RequestMapping(value = "/allProductName.json", produces = "application/json"/*,method = RequestMethod.GET*/,method = RequestMethod.POST)
    @ResponseBody
    @CrossOrigin(origins = "*", maxAge = 3600)
    public JsonResult allProductName(
            @RequestParam(required = false,value = "PL_BRAND")String PL_BRAND
    ) throws Exception {
        String result;
        JsonResult json=new JsonResult();
        PageData pd=new PageData();
        pd.put("PL_BRAND",PL_BRAND);
       try {
        //获取所有品名
        List all=wechatApiManager.allProductName(pd);
        json.put("all",all);
        result="获取成功";
        json.put("result",result);
        }catch (Exception e){
        result="获取失败";
        json.put("result",result);
    }

        return json;
    }

    /**
     * 产品规格
     */
    @RequestMapping(value = "/allProductSize.json", produces = "application/json"/*,method = RequestMethod.GET*/,method = RequestMethod.POST)
    @ResponseBody
    @CrossOrigin(origins = "*", maxAge = 3600)
    public JsonResult allProductSize(
            @RequestParam(required = false,value = "PL_NAME")String PL_NAME
    ) throws Exception {
        String result;
        JsonResult json=new JsonResult();
        PageData pd=new PageData();
        pd.put("PL_NAME",PL_NAME);
        try {
            //获取规格
            List all=wechatApiManager.allProductSize(pd);
            json.put("all",all);
            result="获取成功";
            json.put("result",result);
        }catch (Exception e){
            result="获取失败";
            json.put("result",result);
        }
        return json;
    }
}


