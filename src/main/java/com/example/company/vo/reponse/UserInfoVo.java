package com.example.company.vo.reponse;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : UserInfoVo
 * @Description : TODO
 * @date : 2021/9/1 22:08
 **/
@Data
public class UserInfoVo {
    @ApiModelProperty(value = "用户id")
    private String id;
    @ApiModelProperty(value = "账号")
    private String username;
    @ApiModelProperty(value = "手机号")
    private String phone;
    @ApiModelProperty(value = "昵称")
    private String nickName;
    @ApiModelProperty(value = "真实姓名")
    private String realName;
    @ApiModelProperty(value = "所属机构id")
    private String deptId;
    @ApiModelProperty(value = "所属机构名称")
    private String deptName;
}
