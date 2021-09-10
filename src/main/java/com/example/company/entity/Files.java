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
 * 文件上传
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@EqualsAndHashCode(callSuper = true)
@Data
@TableName("sys_files")
public class Files extends BaseEntity
        implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    @TableId("id")
    private String id;

    /**
     * URL地址
     */
    @TableField("url")
    private String url;

    /**
     * 创建时间
     */
    @TableField(value = "create_date", fill = FieldFill.INSERT)
    private Date createDate;

    @TableField("file_name")
    private String fileName;

    @TableField("file_path")
    private String filePath;


}
