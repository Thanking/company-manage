package com.example.company.entity;


import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 定时任务日志
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@EqualsAndHashCode(callSuper = true)
@Data
@TableName("sys_job_log")
public class JobLog extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;
    /**
     * 任务日志id
     */
    @TableId("id")
    private String id;

    /**
     * 任务id
     */
    @TableField("job_id")
    private String jobId;

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
     * 任务状态    0：成功    1：失败
     */
    @TableField("status")
    private Integer status;

    /**
     * 失败信息
     */
    @TableField("error")
    private String error;

    /**
     * 耗时(单位：毫秒)
     */
    @TableField("times")
    private Integer times;

    /**
     * 创建时间
     */
    @TableField(value = "create_time", fill = FieldFill.INSERT)
    private Date createTime;

}