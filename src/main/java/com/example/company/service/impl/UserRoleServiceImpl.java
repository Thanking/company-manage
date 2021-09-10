package com.example.company.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.company.entity.UserRole;
import com.example.company.mapper.UserRoleMapper;
import com.example.company.service.UserRoleService;
import com.example.company.vo.request.UserRoleOperation;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 系统用户角色 服务实现类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Service
public class UserRoleServiceImpl extends ServiceImpl<UserRoleMapper, UserRole> implements UserRoleService {

    @Resource
    private UserRoleMapper mapper;

    @Override
    public List getRoleIdsByUserId(String userId) {
        LambdaQueryWrapper<UserRole> queryWrapper =
                Wrappers.<UserRole>lambdaQuery().select(
                        UserRole::getRoleId).eq(UserRole::getUserId, userId);
        return mapper.selectObjs(queryWrapper);
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void addUserRoleInfo(UserRoleOperation vo) {
        if (CollectionUtils.isEmpty(vo.getRoleIds())) {
            return;
        }
        List<UserRole> list = new ArrayList<>();
        for (String roleId : vo.getRoleIds()) {
            UserRole userRole = new UserRole();
            userRole.setUserId(vo.getUserId());
            userRole.setRoleId(roleId);
            list.add(userRole);
        }
        mapper.delete(Wrappers.<UserRole>lambdaQuery().eq(
                UserRole::getUserId, vo.getUserId()));
        //批量插入
        this.saveBatch(list);
    }

    @Override
    public List getUserIdsByRoleId(String roleId) {
        return mapper.selectObjs(Wrappers.<UserRole>lambdaQuery().select(
                UserRole::getUserId).eq(UserRole::getRoleId, roleId));
    }
}
