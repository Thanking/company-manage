package com.example.company.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.company.entity.DictDetailEntity;
import com.baomidou.mybatisplus.extension.service.IService;

/**
 * <p>
 * 数据字典详情 服务类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
public interface DictDetailService extends IService<DictDetailEntity> {

    /**
     * 分页
     *
     * @param page   page
     * @param dictId dictId
     * @return IPage
     */
    IPage<DictDetailEntity> listByPage(Page<DictDetailEntity> page, String dictId);
}
