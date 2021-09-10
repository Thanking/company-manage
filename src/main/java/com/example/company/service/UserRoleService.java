package com.example.company.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.example.company.entity.UserRole;
import com.example.company.vo.request.UserRoleOperation;

import java.util.List;

/**
 * <p>
 * 系统用户角色 服务类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
public interface UserRoleService extends IService<UserRole> {
    /**
     * 根据userId获取绑定的角色id
     *
     * @param userId userId
     * @return List
     */
    List<String> getRoleIdsByUserId(String userId);

    /**
     * 用户绑定角色
     *
     * @param vo vo
     */
    void addUserRoleInfo(UserRoleOperation vo);

    /**
     * 根据角色id获取绑定的人
     *
     * @param roleId roleId
     * @return List
     */
    List<String> getUserIdsByRoleId(String roleId);
}

