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
 * 内容
 * @author : LSD
 * @version : 1.0
 * @ClassName : ContentEntity
 * @Description : TODO
 * @date : 2021/9/2 11:24
 **/
@EqualsAndHashCode(callSuper = true)
@Data
@TableName("sys_content")
public class ContentEntity extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
    @TableId("id")
    private String id;

    /**
     * 主题
     */
    @TableField("title")
    private String title;

    /**
     * 内容
     */
    @TableField("content")
    private String content;

    /**
     * 类型（数据字典）
     */
    @TableField("type")
    private String type;

    /**
     * 创建人
     */
    @TableField(value = "create_id", fill = FieldFill.INSERT)
    private String createId;

    /**
     * 创建时间
     */
    @TableField(value = "create_time", fill = FieldFill.INSERT)
    private Date createTime;


}
