package com.example.company.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.company.entity.ContentEntity;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

/**
 * <p>
 * 文章管理 Mapper 接口
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */

public interface ContentMapper extends BaseMapper<ContentEntity> {

}
