package com.example.company.entity;

import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : RolePermission
 * @Description : TODO
 * @date : 2021/9/2 14:39
 **/
@Data
@TableName("sys_role_permission")
public class RolePermission implements Serializable {
    @TableId
    private String id;

    private String roleId;

    private String permissionId;

    @TableField(fill = FieldFill.INSERT)
    private Date createTime;
}
