package com.example.company.vo.reponse;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : LoginVo
 * @Description : TODO
 * @date : 2021/9/1 21:35
 **/
@Data
public class LoginVo {
    @ApiModelProperty(value = "token")
    private String accessToken;
    @ApiModelProperty(value = "用户名")
    private String username;
    @ApiModelProperty(value = "用户id")
    private String id;
    @ApiModelProperty(value = "电话")
    private String phone;
    @ApiModelProperty(value = "用户所拥有的菜单权限(前后端分离返回给前端控制菜单和按钮的显示和隐藏)")
    private List<PermissionRespNode> list;
}
