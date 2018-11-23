package com.fh.service.wechat.wechat;

import com.fh.util.PageData;

import java.util.List;

public interface WechatApiManager {

    /**
     * 修改密码
     * @param pd
     * @return
     * @throws Exception
     */
    public List edit(PageData pd) throws Exception;

    /**
     * 修改门店id
     * @param pd
     * @return
     * @throws Exception
     */
    public List editStore(PageData pd) throws Exception;

    /**
     * 所有类别信息
     */
    public List allProduct(PageData pd) throws Exception;

    /**
     * 获取所有品牌
     * @param pd
     * @return
     * @throws Exception
     */
    public List allProductBand(PageData pd)throws Exception;

    /**
     * 获取所有品名
     * @param pd
     * @return
     * @throws Exception
     */
    public List allProductName(PageData pd)throws Exception;


    /**
     * 获取产品规格
     */
    public List allProductSize(PageData pd)throws Exception;
}
