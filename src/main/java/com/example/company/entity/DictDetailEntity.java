package com.example.company.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.io.Serializable;
import java.util.Date;

/**
 * 数据字典明细
 * @author : LSD
 * @version : 1.0
 * @ClassName : DictDetailEntity
 * @Description : TODO
 * @date : 2021/9/2 11:27
 **/
@EqualsAndHashCode(callSuper = true)
@Data
@TableName("sys_dict_detail")
public class DictDetailEntity extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId("id")
    private String id;

    /**
     * 字典标签
     */
    @TableField("label")
    private String label;

    /**
     * 字典值
     */
    @TableField("value")
    private String value;

    /**
     * 排序
     */
    @TableField("sort")
    private Integer sort;

    /**
     * 字典id
     */
    @TableField("dict_id")
    private String dictId;

    /**
     * 创建日期
     */
    @TableField(value = "create_time", fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 字典name
     */
    @TableField(exist = false)
    private String dictName;

}

