package com.example.company.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.company.entity.DictDetailEntity;
import com.example.company.entity.DictEntity;
import com.example.company.mapper.DictDetailMapper;
import com.example.company.mapper.DictMapper;
import com.example.company.service.DictService;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.List;

/**
 * 数据字典服务类
 * @author : LSD
 * @version : 1.0
 * @ClassName : DictServiceImpl
 * @Description : TODO
 * @date : 2021/9/2 14:34
 **/
@Service("dictService")
public class DictServiceImpl extends ServiceImpl<DictMapper, DictEntity> implements DictService {

    @Resource
    private DictDetailMapper mapper;

    /**
     * 根据字典类型查询字典数据信息
     *
     * @param name 字典名称
     * @return 参数键值
     **/
    public JSONArray getType(String name) {
        if (StringUtils.isEmpty(name)) {
            return new JSONArray();
        }
        //根据名称获取字典
        DictEntity dict = this.getOne(Wrappers.<DictEntity>lambdaQuery().eq(
                DictEntity::getName, name));
        if (dict == null || dict.getId() == null) {
            return new JSONArray();
        }
        //获取明细
        List<DictDetailEntity> list = mapper.selectList(
                Wrappers.<DictDetailEntity>lambdaQuery().eq(
                        DictDetailEntity::getDictId, dict.getId()));
        return JSONArray.parseArray(JSON.toJSONString(list));
    }
}



