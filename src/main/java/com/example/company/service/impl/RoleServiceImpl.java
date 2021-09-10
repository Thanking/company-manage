package com.example.company.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.example.company.common.config.HttpSessionService;
import com.example.company.common.exception.BusinessException;
import com.example.company.common.exception.code.BaseResponseCode;
import com.example.company.entity.Role;
import com.example.company.entity.RoleDept;
import com.example.company.entity.RolePermission;
import com.example.company.entity.UserRole;
import com.example.company.mapper.RoleMapper;
import com.example.company.service.*;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.company.vo.reponse.DeptNodeVo;
import com.example.company.vo.reponse.PermissionRespNode;
import com.example.company.vo.request.RolePermissionOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.stream.Collectors;

/**
 * <p>
 * 系统角色 服务实现类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Service
@Slf4j
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {
    @Resource
    private RoleMapper roleMapper;
    @Resource
    private UserRoleService userRoleService;
    @Resource
    private RolePermissionService rolePermissionService;
    @Resource
    private PermissionService permissionService;
    @Resource
    private HttpSessionService httpSessionService;
    @Resource
    private DeptService deptService;
    @Resource
    private RoleDeptService roleDeptService;

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void addRole(Role vo) {

        vo.setStatus(1);
        roleMapper.insert(vo);
        if (!CollectionUtils.isEmpty(vo.getPermissions())) {
            RolePermissionOperation reqVO = new RolePermissionOperation();
            reqVO.setRoleId(vo.getId());
            reqVO.setPermissionIds(vo.getPermissions());
            rolePermissionService.addRolePermission(reqVO);
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateRole(Role vo) {
        Role role = roleMapper.selectById(vo.getId());
        if (null == role) {
            log.error("传入 的 id:{}不合法", vo.getId());
            throw new BusinessException(BaseResponseCode.DATA_ERROR);
        }
        roleMapper.updateById(vo);
        //删除角色权限关联
        rolePermissionService.remove(Wrappers.<RolePermission>lambdaQuery().eq(
                RolePermission::getRoleId, role.getId()));
        if (!CollectionUtils.isEmpty(vo.getPermissions())) {
            RolePermissionOperation reqVO = new RolePermissionOperation();
            reqVO.setRoleId(role.getId());
            reqVO.setPermissionIds(vo.getPermissions());
            rolePermissionService.addRolePermission(reqVO);
            // 刷新权限
            httpSessionService.refreshRolePermission(role.getId());
        }
    }

    @Override
    public Role detailInfo(String id) {
        Role role = roleMapper.selectById(id);
        if (role == null) {
            log.error("传入 的 id:{}不合法", id);
            throw new BusinessException(BaseResponseCode.DATA_ERROR);
        }
        List<PermissionRespNode> permissionRespNodes = permissionService.selectAllByTree();
        LambdaQueryWrapper<RolePermission> queryWrapper = Wrappers.<RolePermission>lambdaQuery().select(
                RolePermission::getPermissionId).eq(
                        RolePermission::getRoleId, role.getId());
        Set<Object> checkList =
                new HashSet<>(rolePermissionService.listObjs(queryWrapper));
        setChecked(permissionRespNodes, checkList);
        role.setPermissionRespNodes(permissionRespNodes);

        LambdaQueryWrapper<RoleDept> queryWrapperDept = Wrappers.<RoleDept>lambdaQuery().select(
                RoleDept::getDeptId).eq(RoleDept::getRoleId, role.getId());
        List<DeptNodeVo> deptRespNodes = deptService.deptTreeList(null, true);
        Set<Object> checkDeptList =
                new HashSet<>(roleDeptService.listObjs(queryWrapperDept));
        setCheckedDept(deptRespNodes, checkDeptList);
        role.setDeptRespNodes(deptRespNodes);
        return role;
    }

    private void setCheckedDept(List<DeptNodeVo> deptRespNodes, Set<Object> checkDeptList) {
        for (DeptNodeVo node : deptRespNodes) {
            if (checkDeptList.contains(node.getId())) {
                node.setChecked(true);
            }
            setCheckedDept((List<DeptNodeVo>) node.getChildren(), checkDeptList);
        }
    }


    private void setChecked(List<PermissionRespNode> list, Set<Object> checkList) {
        for (PermissionRespNode node : list) {
            if (checkList.contains(node.getId())
                    && CollectionUtils.isEmpty(node.getChildren())) {
                node.setChecked(true);
            }
            setChecked((List<PermissionRespNode>) node.getChildren(), checkList);
        }
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void deletedRole(String id) {
        //获取关联userId
        List<String> userIds = userRoleService.getUserIdsByRoleId(id);
        //删除角色
        roleMapper.deleteById(id);
        //删除角色权限关联
        rolePermissionService.remove(Wrappers.<RolePermission>lambdaQuery().eq(
                RolePermission::getRoleId, id));
        //删除角色用户关联
        userRoleService.remove(Wrappers.<UserRole>lambdaQuery().eq(UserRole::getRoleId, id));
        if (!CollectionUtils.isEmpty(userIds)) {
            // 刷新权限
            userIds.parallelStream().forEach(httpSessionService::refreshUerId);
        }
    }

    @Override
    public List<Role> getRoleInfoByUserId(String userId) {

        List<String> roleIds = userRoleService.getRoleIdsByUserId(userId);
        if (CollectionUtils.isEmpty(roleIds)) {
            return null;
        }
        return roleMapper.selectBatchIds(roleIds);
    }

    @Override
    public List<String> getRoleNames(String userId) {
        List<Role> roles = getRoleInfoByUserId(userId);
        if (CollectionUtils.isEmpty(roles)) {
            return null;
        }
        return roles.stream().map(Role::getName).collect(Collectors.toList());
    }
}