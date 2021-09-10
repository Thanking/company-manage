package com.example.company.vo.request;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.List;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : UserRoleOperation
 * @Description : TODO
 * @date : 2021/9/1 22:06
 **/
@Data
public class UserRoleOperation {
    @ApiModelProperty(value = "用户id")
    @NotBlank(message = "用户id不能为空")
    private String userId;
    @ApiModelProperty(value = "角色id集合")
    @NotEmpty(message = "角色id集合不能为空")
    private List<String> roleIds;
}
