package com.fh.controller.wechatapi;

import com.fh.controller.base.BaseController;
import com.fh.controller.system.login.LoginController;
import com.fh.dao.DaoSupport;
import com.fh.entity.system.User;
import com.fh.service.system.fhlog.FHlogManager;
import com.fh.service.system.user.UserManager;
import com.fh.util.*;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.omg.PortableServer.IdAssignmentPolicyValue.USER_ID;

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
     * 我的信息
     *
     */
    @RequestMapping(value = "/MsgToMe.json", produces = "application/json"/*,method = RequestMethod.GET*/)
    @ResponseBody
    @CrossOrigin(origins = "*", maxAge = 3600)
    public JsonResult MsgToMe(HttpServletRequest request) throws Exception {
        JsonResult json=JsonResult.of();
        //获取用户信息id
        String USER_ID=request.getParameter("USER_ID");
        //查找用户信息
        User user=userService.getUserAndRoleById(USER_ID);
        //   JSONArray j=JSONArray.fromObject(request.getSession().getAttribute(Const.SESSION_USER));
        /*        User user=userService.getUserAndRoleById(USER_ID);*/
        json.put("Msg",user);

        return json;
    }

}


