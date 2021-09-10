package com.example.company.service.impl;

import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.company.entity.RolePermission;
import com.example.company.mapper.RolePermissionMapper;
import com.example.company.service.RolePermissionService;
import com.example.company.vo.request.RolePermissionOperation;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * 角色权限关联
 * @author : LSD
 * @version : 1.0
 * @ClassName : RolePermissionServiceImpl
 * @Description : TODO
 * @date : 2021/9/3 18:04
 **/
@Service
public class RolePermissionServiceImpl extends ServiceImpl<RolePermissionMapper, RolePermission> implements RolePermissionService {
    @Override
    public void addRolePermission(RolePermissionOperation vo) {
        List<RolePermission> list = new ArrayList<>();
        for (String permissionId : vo.getPermissionIds()) {
            RolePermission sysRolePermission = new RolePermission();
            sysRolePermission.setPermissionId(permissionId);
            sysRolePermission.setRoleId(vo.getRoleId());
            list.add(sysRolePermission);
        }
        this.remove(Wrappers.<RolePermission>lambdaQuery().eq(
                RolePermission::getRoleId, vo.getRoleId()));
        this.saveBatch(list);
    }

}
