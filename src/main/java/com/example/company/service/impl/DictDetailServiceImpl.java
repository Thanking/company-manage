package com.example.company.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.company.common.exception.BusinessException;
import com.example.company.entity.DictDetailEntity;
import com.example.company.entity.DictEntity;
import com.example.company.mapper.DictDetailMapper;
import com.example.company.mapper.DictMapper;
import com.example.company.service.DictDetailService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;

/**
 * <p>
 * 数据字典详情 服务实现类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Service("dictDetailService")
public class DictDetailServiceImpl extends ServiceImpl<DictDetailMapper, DictDetailEntity> implements DictDetailService {
    @Resource
    private DictDetailMapper dictDetailMapper;
    @Resource
    private DictMapper dictMapper;

    @Override
    public IPage<DictDetailEntity> listByPage(Page<DictDetailEntity> page, String dictId) {
        DictEntity sysDictEntity = dictMapper.selectById(dictId);
        if (sysDictEntity == null) {
            throw new BusinessException("获取字典数据失败!");
        }

        LambdaQueryWrapper<DictDetailEntity> wrapper = Wrappers.lambdaQuery();
        wrapper.eq(DictDetailEntity::getDictId, dictId);
        wrapper.orderByAsc(DictDetailEntity::getSort);
        IPage<DictDetailEntity> result = dictDetailMapper.selectPage(page, wrapper);
        if (!CollectionUtils.isEmpty(result.getRecords())) {
            result.getRecords().parallelStream().forEach(entity -> entity.setDictName(sysDictEntity.getName()));
        }
        return result;
    }
}
