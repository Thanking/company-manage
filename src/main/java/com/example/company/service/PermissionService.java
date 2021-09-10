package com.example.company.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.example.company.entity.Permission;
import com.example.company.vo.reponse.PermissionRespNode;
import com.example.company.vo.request.RolePermissionOperation;

import java.util.List;
import java.util.Set;

/**
 * <p>
 * 系统权限 菜单关联
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
public interface PermissionService extends IService<Permission> {
    /**
     * 根据userId获取权限
     *
     * @param userId userId
     * @return 权限
     */
    List<Permission> getPermission(String userId);

    /**
     * 删除权限
     *
     * @param permissionId 权限id
     */
    void deleted(String permissionId);

    /**
     * 获取所有
     *
     * @return List
     */
    List<Permission> selectAll();

    /**
     * 根据userId获取权限标志
     *
     * @param userId userId
     * @return Set
     */
    Set<String> getPermissionsByUserId(String userId);

    /**
     * 根据userId获取权限树
     *
     * @param userId
     * @return List
     */
    List<PermissionRespNode> permissionTreeList(String userId);

    /**
     * 根据权限树
     *
     * @return List
     */
    List<PermissionRespNode> selectAllByTree();

    /**
     * 根据目录树
     *
     * @param permissionId permissionId
     * @return List
     */
    List<PermissionRespNode> selectAllMenuByTree(String permissionId);


    /**
     * 根据权限id获取绑定的userId
     *
     * @param permissionId permissionId
     * @return List
     */
    List<String> getUserIdsById(String permissionId);

    /**
     * 更新
     *
     * @param vo vo
     */
    void updatePermission(Permission vo);
}
