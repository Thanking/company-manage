package com.example.company.vo.reponse;

import com.example.company.entity.Role;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : UserOwnRoleVo
 * @Description : TODO
 * @date : 2021/9/1 22:09
 **/
@Data
public class UserOwnRoleVo {
    @ApiModelProperty("所有角色集合")
    private List<Role> allRole;
    @ApiModelProperty(value = "用户所拥有角色集合")
    private List<String> ownRoles;
}
