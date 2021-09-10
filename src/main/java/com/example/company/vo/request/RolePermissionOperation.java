package com.example.company.vo.request;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.List;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : RolePermissionOperation
 * @Description : TODO
 * @date : 2021/9/1 22:05
 **/
@Data
public class RolePermissionOperation {
    @ApiModelProperty(value = "角色id")
    @NotBlank(message = "角色id不能为空")
    private String roleId;
    @ApiModelProperty(value = "菜单权限集合")
    @NotEmpty(message = "菜单权限集合不能为空")
    private List<String> permissionIds;
}
