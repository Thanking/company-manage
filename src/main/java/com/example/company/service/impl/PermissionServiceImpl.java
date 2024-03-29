package com.example.company.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.example.company.common.config.HttpSessionService;
import com.example.company.common.exception.BusinessException;
import com.example.company.common.exception.code.BaseResponseCode;
import com.example.company.entity.Permission;
import com.example.company.entity.RolePermission;
import com.example.company.entity.UserRole;
import com.example.company.mapper.PermissionMapper;
import com.example.company.service.PermissionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.company.service.RolePermissionService;
import com.example.company.service.UserRoleService;
import com.example.company.vo.reponse.PermissionRespNode;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * <p>
 * 系统权限 服务实现类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Service
@Slf4j
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements PermissionService {

    @Resource
    private PermissionMapper mapper;
    @Resource
    private UserRoleService userRoleService;
    @Resource
    private RolePermissionService rolePermissionService;
    @Resource
    private HttpSessionService httpSessionService;

    /**
     * 根据用户查询拥有的权限
     * 先查出用户拥有的角色
     * 再去差用户拥有的权限
     * 也可以多表关联查询
     */
    @Override
    public List<Permission> getPermission(String userId) {
        List<String> roleIds = userRoleService.getRoleIdsByUserId(userId);
        if (CollectionUtils.isEmpty(roleIds)) {
            return null;
        }
        List<Object> permissionIds = rolePermissionService.listObjs(
                Wrappers.<RolePermission>lambdaQuery().select(
                        RolePermission::getPermissionId).in(
                                RolePermission::getRoleId, roleIds));
        if (CollectionUtils.isEmpty(permissionIds)) {
            return null;
        }

        LambdaQueryWrapper<Permission> queryWrapper =
                Wrappers.<Permission>lambdaQuery().in(
                        Permission::getId, permissionIds).orderByAsc(
                                Permission::getOrderNum);
        return mapper.selectList(queryWrapper);
    }

    /**
     * 删除菜单权限
     * 判断是否 有角色关联
     * 判断是否有子集
     */
    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deleted(String permissionId) {
        //获取关联userId
        List<String> userIds = getUserIdsById(permissionId);
        Permission sysPermission = mapper.selectById(permissionId);
        if (null == sysPermission) {
            log.error("传入 的 id:{}不合法", permissionId);
            throw new BusinessException(BaseResponseCode.DATA_ERROR);
        }
        //获取下一级
        List<Permission> childs = mapper.selectList(
                Wrappers.<Permission>lambdaQuery().eq(
                        Permission::getPid, permissionId));
        if (!CollectionUtils.isEmpty(childs)) {
            throw new BusinessException(BaseResponseCode.ROLE_PERMISSION_RELATION);
        }
        mapper.deleteById(permissionId);
        //删除和角色关联
        rolePermissionService.remove(
                Wrappers.<RolePermission>lambdaQuery().eq(
                        RolePermission::getPermissionId, permissionId));

        if (!CollectionUtils.isEmpty(userIds)) {
            //刷新权限
            userIds.parallelStream().forEach(httpSessionService::refreshUerId);
        }

    }

    /**
     * 获取所有菜单权限
     */
    @Override
    public List<Permission> selectAll() {
        List<Permission> result = mapper.selectList(
                Wrappers.<Permission>lambdaQuery().orderByAsc(
                        Permission::getOrderNum));
        if (!CollectionUtils.isEmpty(result)) {
            for (Permission sysPermission : result) {
                Permission parent = mapper.selectById(sysPermission.getPid());
                if (parent != null) {
                    sysPermission.setPidName(parent.getName());
                }
            }
        }
        return result;
    }

    /**
     * 获取权限标识
     */
    @Override
    public Set<String> getPermissionsByUserId(String userId) {

        List<Permission> list = getPermission(userId);
        Set<String> permissions = new HashSet<>();
        if (CollectionUtils.isEmpty(list)) {
            return null;
        }
        for (Permission sysPermission : list) {
            if (!StringUtils.isEmpty(sysPermission.getPerms())) {
                permissions.add(sysPermission.getPerms());
            }

        }
        return permissions;
    }

    /**
     * 以树型的形式把用户拥有的菜单权限返回给客户端
     */
    @Override
    public List<PermissionRespNode> permissionTreeList(String userId) {
        List<Permission> list = getPermission(userId);
        return getTree(list, true);
    }

    /**
     * 递归获取菜单树
     */
    private List<PermissionRespNode> getTree(List<Permission> all, boolean type) {

        List<PermissionRespNode> list = new ArrayList<>();
        if (CollectionUtils.isEmpty(all)) {
            return list;
        }
        for (Permission sysPermission : all) {
            if ("0".equals(sysPermission.getPid())) {
                PermissionRespNode permissionRespNode = new PermissionRespNode();
                BeanUtils.copyProperties(sysPermission, permissionRespNode);
                permissionRespNode.setTitle(sysPermission.getName());

                if (type) {
                    permissionRespNode.setChildren(getChildExcBtn(sysPermission.getId(), all));
                } else {
                    permissionRespNode.setChildren(getChildAll(sysPermission.getId(), all));
                }
                list.add(permissionRespNode);
            }
        }
        return list;
    }

    /**
     * 递归遍历所有
     */
    private List<PermissionRespNode> getChildAll(String id, List<Permission> all) {

        List<PermissionRespNode> list = new ArrayList<>();
        for (Permission sysPermission : all) {
            if (sysPermission.getPid().equals(id)) {
                PermissionRespNode permissionRespNode = new PermissionRespNode();
                BeanUtils.copyProperties(sysPermission, permissionRespNode);
                permissionRespNode.setTitle(sysPermission.getName());
                permissionRespNode.setChildren(getChildAll(sysPermission.getId(), all));
                list.add(permissionRespNode);
            }
        }
        return list;
    }

    /**
     * 只递归获取目录和菜单
     */
    private List<PermissionRespNode> getChildExcBtn(String id, List<Permission> all) {

        List<PermissionRespNode> list = new ArrayList<>();
        for (Permission sysPermission : all) {
            if (sysPermission.getPid().equals(id) && sysPermission.getType() != 3) {
                PermissionRespNode permissionRespNode = new PermissionRespNode();
                BeanUtils.copyProperties(sysPermission, permissionRespNode);
                permissionRespNode.setTitle(sysPermission.getName());
                permissionRespNode.setChildren(getChildExcBtn(sysPermission.getId(), all));
                list.add(permissionRespNode);
            }
        }
        return list;
    }

    /**
     * 获取所有菜单权限按钮
     */
    @Override
    public List<PermissionRespNode> selectAllByTree() {

        List<Permission> list = selectAll();
        return getTree(list, false);
    }

    /**
     * 获取所有的目录菜单树排除按钮
     * 因为不管是新增或者修改
     * 选择所属菜单目录的时候
     * 都不可能选择到按钮
     * 而且编辑的时候 所属目录不能
     * 选择自己和它的子类
     */
    @Override
    public List<PermissionRespNode> selectAllMenuByTree(String permissionId) {

        List<Permission> list = selectAll();
        if (!CollectionUtils.isEmpty(list) && !StringUtils.isEmpty(permissionId)) {
            for (Permission sysPermission : list) {
                if (sysPermission.getId().equals(permissionId)) {
                    list.remove(sysPermission);
                    break;
                }
            }
        }
        List<PermissionRespNode> result = new ArrayList<>();
        //新增顶级目录是为了方便添加一级目录
        PermissionRespNode respNode = new PermissionRespNode();
        respNode.setId("0");
        respNode.setTitle("默认顶级菜单");
        respNode.setSpread(true);
        respNode.setChildren(getTree(list, true));
        result.add(respNode);
        return result;
    }

    @Override
    public List getUserIdsById(String id) {
        //根据权限id，获取所有角色id
        //根据权限id，获取所有角色id
        List<Object> roleIds = rolePermissionService.listObjs(
                Wrappers.<RolePermission>lambdaQuery().select(
                        RolePermission::getRoleId).eq(
                                RolePermission::getPermissionId, id));
        if (!CollectionUtils.isEmpty(roleIds)) {
            //根据角色id， 获取关联用户
            return userRoleService.listObjs(
                    Wrappers.<UserRole>lambdaQuery().select(
                            UserRole::getUserId).in(UserRole::getRoleId, roleIds));
        }
        return null;
    }

    @Override
    public void updatePermission(Permission vo) {
        mapper.updateById(vo);
        httpSessionService.refreshPermission(vo.getId());
    }


}