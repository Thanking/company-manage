package com.example.company.entity;


import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/**
 * <p>
 * 系统权限
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_permission")
public class Permission extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
    private String id;

    /**
     * 菜单权限名称
     */
    @NotBlank(message = "不能为空")
    private String name;

    /**
     * 授权(多个用逗号分隔，如：sys:user:add,sys:user:edit)
     */
    private String perms;

    /**
     * 图标
     */
    private String icon;

    /**
     * 访问地址URL
     */
    private String url;

    /**
     * a target属性:_self _blank
     */
    private String target;

    /**
     * 父级菜单权限名称
     */
    @NotBlank(message = "不能为空")
    private String pid;

    /**
     * 排序
     */
    private Integer orderNum;

    /**
     * 菜单权限类型(1:目录;2:菜单;3:按钮)
     */
    @NotNull(message = "菜单权限类型不能为空")
    private Integer type;

    /**
     * 状态1:正常 0：禁用
     */
    private Integer status;

    /**
     * 创建时间
     */
    @TableField(fill = FieldFill.INSERT)
    private Date createTime;

    /**
     * 更新时间
     */
    @TableField(fill = FieldFill.UPDATE)
    private Date updateTime;

    /**
     * 是否删除(1未删除；0已删除)
     */
    @TableField(fill = FieldFill.INSERT)
    private Integer deleted;

    @TableField(exist = false)
    private String pidName;


}
