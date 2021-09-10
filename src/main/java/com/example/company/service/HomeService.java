package com.example.company.service;

import com.example.company.vo.reponse.HomeVo;

/**
 * 首页
 * @author 亚亚
 * @version 1.0
 * @InterfaceName HomeService
 * @Description TODO
 * @date 2021/9/3 16:24
 **/
public interface HomeService {
    /**
     * 获取首页信息
     *
     * @param userId userId
     * @return HomeRespVO
     */
    HomeVo getHomeInfo(String userId);
}

