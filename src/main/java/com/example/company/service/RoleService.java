package com.example.company.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.example.company.entity.Role;

import java.util.List;

/**
 * <p>
 * 系统角色 服务类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
public interface RoleService extends IService<Role> {
    /**
     * 添加角色
     *
     * @param vo SysRole
     */
    void addRole(Role vo);

    /**
     * 更新角色
     *
     * @param vo SysRole
     */
    void updateRole(Role vo);

    /**
     * 根据id获取角色详情
     *
     * @param id id
     * @return SysRole
     */
    Role detailInfo(String id);

    /**
     * 根据id删除
     *
     * @param id id
     */
    void deletedRole(String id);

    /**
     * 根据userId获取绑定的角色
     *
     * @param userId userId
     * @return List
     */
    List<Role> getRoleInfoByUserId(String userId);

    /**
     * 根据userId获取绑定的角色名
     *
     * @param userId userId
     * @return List
     */
    List<String> getRoleNames(String userId);
}

