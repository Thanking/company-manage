package com.example.company.vo.reponse;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : DeptNodeVo
 * @Description : TODO
 * @date : 2021/9/1 22:11
 **/
@Data
public class DeptNodeVo {
    @ApiModelProperty(value = "组织id")
    private String id;

    @ApiModelProperty(value = "组织编码")
    private String deptNo;

    @ApiModelProperty(value = "组织名称")
    private String title;

    @ApiModelProperty(value = "组织名称")
    private String label;

    @ApiModelProperty(value = "组织父级id")
    private String pid;

    @ApiModelProperty(value = "组织状态")
    private Integer status;

    @ApiModelProperty(value = "组织关系id")
    private String relationCode;

    @ApiModelProperty(value = "是否展开 默认不展开(false)")
    private boolean spread = true;

    @ApiModelProperty(value = "是否选中")
    private boolean checked = false;

    private boolean disabled = false;

    @ApiModelProperty(value = "子集")
    private List<?> children;

    public String getLabel() {
        return title;
    }
}
