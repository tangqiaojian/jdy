package com.fh.service.wechat.wechat.impl;

import com.fh.controller.wechatapi.WechatApi;
import com.fh.dao.DaoSupport;
import com.fh.service.wechat.wechat.WechatApiManager;
import com.fh.util.PageData;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("WechatApiService")
public class WechatApiService implements WechatApiManager {

    @Resource(name = "daoSupport")
    private DaoSupport dao;

    /**
     * 修改密码
     * @param pd
     * @return
     * @throws Exception
     */

    public List edit(PageData pd) throws Exception {
        return (List) dao.findForList("WechatLoginMapper.edit",pd);
    }

    /**
     * 修改门店id
     * @param pd
     * @return
     * @throws Exception
     */
    public List editStore(PageData pd) throws Exception {
        return (List) dao.findForList("WechatLoginMapper.editStore",pd);
    }
    /**
     * 所有类别信息
     */
    public List allProduct(PageData pd) throws Exception {
        return (List) dao.findForList("WechatLoginMapper.allProduct",pd);
    }

    /**
     * 获取所有品牌
     * @param pd
     * @return
     * @throws Exception
     */
    public List allProductBand(PageData pd)throws Exception{
        return (List) dao.findForList("WechatLoginMapper.allProductBand",pd);
    }
    /**
     * 获取所有品名
     * @param pd
     * @return
     * @throws Exception
     */
    public List allProductName(PageData pd)throws Exception{
        return (List) dao.findForList("WechatLoginMapper.allProductName",pd);
    }
    /**
     * 获取产品规格
     */
    public List allProductSize(PageData pd)throws Exception{
        return (List) dao.findForList("WechatLoginMapper.allProductSize",pd);
    }

}

