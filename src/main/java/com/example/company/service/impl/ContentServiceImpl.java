package com.example.company.service.impl;


import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.company.entity.ContentEntity;
import com.example.company.mapper.ContentMapper;
import com.example.company.service.ContentService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 文章管理 服务实现类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Service("contentService")
public class ContentServiceImpl extends ServiceImpl<ContentMapper, ContentEntity> implements ContentService {

}
