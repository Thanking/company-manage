package com.example.company.vo.reponse;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : HomeVo
 * @Description : TODO
 * @date : 2021/9/1 22:07
 **/
@Data
public class HomeVo {
    @ApiModelProperty(value = "用户信息")
    private UserInfoVo userInfo;
    @ApiModelProperty(value = "目录菜单")
    private List<PermissionRespNode> menus;
}
