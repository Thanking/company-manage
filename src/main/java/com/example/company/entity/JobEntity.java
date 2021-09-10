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
 * @author : LSD
 * @version : 1.0
 * @ClassName : JobEntity
 * @Description : TODO
 * @date : 2021/9/1 22:45
 **/
@EqualsAndHashCode(callSuper = true)
@Data
@TableName("sys_job")
public class JobEntity  extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;
    /**
     * 任务调度参数key
     */
    public static final String JOB_PARAM_KEY = "JOB_PARAM_KEY";
    /**
     * 任务id
     */
    @TableId("id")
    private String id;

    /**
     * spring bean名称
     */
    @TableField("bean_name")
    private String beanName;

    /**
     * 参数
     */
    @TableField("params")
    private String params;

    /**
     * cron表达式
     */
    @TableField("cron_expression")
    private String cronExpression;

    /**
     * 任务状态  0：正常  1：暂停
     */
    @TableField("status")
    private Integer status;

    /**
     * 备注
     */
    @TableField("remark")
    private String remark;

    /**
     * 创建时间
     */
    @TableField(value = "create_time", fill = FieldFill.INSERT)
    private Date createTime;


}