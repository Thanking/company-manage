package com.example.company.entity;


import java.io.Serializable;
import java.util.Date;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 系统用户角色
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Data
@EqualsAndHashCode(callSuper = false)
@TableName("sys_user_role")
public class UserRole implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 用户id
     */
    private String id;

    private String userId;

    /**
     * 角色id
     */
    private String roleId;

    /**
     * 创建时间
     */
    private Date createTime;


}
