package com.example.company.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.company.entity.RolePermission;
import com.example.company.vo.request.RolePermissionOperation;

/**
 * 角色权限绑定
 * @author 亚亚
 * @version 1.0
 * @InterfaceName RolePermissionService
 * @Description TODO
 * @date 2021/9/2 14:38
 **/
public interface RolePermissionService extends IService<RolePermission> {
    /**
     * 角色绑定权限
     *
     * @param vo vo
     */
    void addRolePermission(RolePermissionOperation vo);
}
