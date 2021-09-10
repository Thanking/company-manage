package com.example.company.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import java.io.Serializable;
import java.util.Date;

/**
 * 部门
 * @author : LSD
 * @version : 1.0
 * @ClassName : Dept
 * @Description : TODO
 * @date : 2021/9/2 11:26
 **/
@Data
@TableName("sys_dept")
public class Dept implements Serializable {
    @TableId
    private String id;

    private String deptNo;

    @NotBlank(message = "机构名称不能为空")
    private String name;

    @NotBlank(message = "父级不能为空")
    private String pid;

    @TableField(exist = false)
    private String pidName;

    private Integer status;

    private String relationCode;

    private String deptManagerId;

    private String managerName;

    private String phone;

    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    @TableField(fill = FieldFill.INSERT_UPDATE)
    private Date updateTime;

    @TableField(fill = FieldFill.INSERT)
    private Integer deleted;

}
