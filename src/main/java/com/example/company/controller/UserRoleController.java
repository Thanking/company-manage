package com.example.company.controller;


import com.example.company.common.aop.annotation.LogAnnotation;
import com.example.company.common.utils.DataResult;
import com.example.company.service.UserRoleService;
import com.example.company.vo.request.UserRoleOperation;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import javax.validation.Valid;

/**
 * <p>
 * 系统用户角色 前端控制器
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@RestController
@RequestMapping("/sys")
@Api(tags = "组织管理-用户和角色关联接口")
public class UserRoleController {

    @Resource
    private UserRoleService userRoleService;

    @PostMapping("/user/role")
    @ApiOperation(value = "修改或者新增用户角色接口")
    @LogAnnotation(title = "用户和角色关联接口", action = "修改或者新增用户角色")
    public DataResult operationUserRole(@RequestBody @Valid UserRoleOperation vo) {
        userRoleService.addUserRoleInfo(vo);
        return DataResult.success();
    }
}
