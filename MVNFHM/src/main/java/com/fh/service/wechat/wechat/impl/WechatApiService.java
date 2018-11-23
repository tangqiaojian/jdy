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


    public List edit(PageData pd) throws Exception {
        return (List) dao.findForList("WechatLoginMapper.edit",pd);
    }

}
