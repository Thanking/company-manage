package com.example.company.entity;

import com.alibaba.fastjson.annotation.JSONField;
import com.baomidou.mybatisplus.annotation.TableField;
import lombok.Data;

import java.util.List;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : BaseEnetiy
 * @Description : TODO
 * @date : 2021/9/1 21:29
 **/
@Data
public class BaseEntity {
    @JSONField(serialize = false)
    @TableField(exist = false)
    private int page = 1;

    @JSONField(serialize = false)
    @TableField(exist = false)
    private int limit = 10;

    /**
     * 数据权限：用户id
     */
    @TableField(exist = false)
    private List<String> createIds;
}
