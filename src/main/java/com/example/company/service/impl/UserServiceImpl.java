package com.example.company.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.company.common.config.HttpSessionService;
import com.example.company.common.exception.BusinessException;
import com.example.company.common.exception.code.BaseResponseCode;
import com.example.company.common.utils.PasswordUtils;
import com.example.company.entity.Dept;
import com.example.company.entity.Role;
import com.example.company.entity.User;
import com.example.company.mapper.DeptMapper;
import com.example.company.mapper.UserMapper;
import com.example.company.service.PermissionService;
import com.example.company.service.RoleService;
import com.example.company.service.UserRoleService;
import com.example.company.service.UserService;
import com.example.company.vo.reponse.LoginVo;
import com.example.company.vo.reponse.UserOwnRoleVo;
import com.example.company.vo.request.UserRoleOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 系统用户 服务实现类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Service
@Slf4j
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Resource
    private UserMapper mapper;
    @Resource
    private RoleService roleService;
    @Resource
    private PermissionService permissionService;
    @Resource
    private UserRoleService userRoleService;
    @Resource
    private DeptMapper deptMapper;
    @Resource
    private HttpSessionService httpSessionService;

    @Value("${spring.redis.allowMultipleLogin}")
    private Boolean allowMultipleLogin;
    @Value("${spring.profiles.active}")
    private String env;

    @Override
    public void register(User user) {
        User userOne = mapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, user.getUsername()));
        if (userOne != null) {
            throw new BusinessException("用户名已存在！");
        }
        user.setSalt(PasswordUtils.getSalt());
        String encode = PasswordUtils.encode(user.getPassword(), user.getSalt());
        user.setPassword(encode);
        mapper.insert(user);
    }

    @Override
    public LoginVo login(User vo) {
        User user = mapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, vo.getUsername()));
        if (null == user) {
            throw new BusinessException(BaseResponseCode.NOT_ACCOUNT);
        }
        if (user.getStatus() == 2) {
            throw new BusinessException(BaseResponseCode.USER_LOCK);
        }
        if (!PasswordUtils.matches(user.getSalt(), vo.getPassword(), user.getPassword())) {
            throw new BusinessException(BaseResponseCode.PASSWORD_ERROR);
        }
        LoginVo respVO = new LoginVo();
        BeanUtils.copyProperties(user, respVO);

        //是否删除之前token， 此处控制是否支持多登陆端；
        // true:允许多处登陆; false:只能单处登陆，顶掉之前登陆
        if (!allowMultipleLogin) {
            httpSessionService.abortUserById(user.getId());
        }
        if (StringUtils.isNotBlank(user.getDeptId())) {
            Dept dept = deptMapper.selectById(user.getDeptId());
            if (dept != null) {
                user.setDeptNo(dept.getDeptNo());
            }
        }
        String token = httpSessionService.createTokenAndUser(user,
                roleService.getRoleNames(user.getId()),
                permissionService.getPermissionsByUserId(user.getId()));
        respVO.setAccessToken(token);

        return respVO;
    }

    @Override
    public void updateUserInfo(User vo) {

        User user = mapper.selectById(vo.getId());
        if (null == user) {
            throw new BusinessException(BaseResponseCode.DATA_ERROR);
        }

        //如果用户名变更
        if (!user.getUsername().equals(vo.getUsername())) {
            User userOne = mapper.selectOne(Wrappers.<User>lambdaQuery().eq(
                    User::getUsername, vo.getUsername()));
            if (userOne != null) {
                throw new BusinessException("用户名已存在！");
            }
        }

        //如果用户名、密码、状态 变更，删除redis中用户绑定的角色跟权限
        if (!user.getUsername().equals(vo.getUsername())
                || (!StringUtils.isEmpty(vo.getPassword())
                && !user.getPassword().equals(PasswordUtils.encode(vo.getPassword(), user.getSalt())))
                || !user.getStatus().equals(vo.getStatus())) {
            httpSessionService.abortUserById(vo.getId());
        }

        if (!StringUtils.isEmpty(vo.getPassword())) {
            String newPassword = PasswordUtils.encode(vo.getPassword(),
                    user.getSalt());
            vo.setPassword(newPassword);
        } else {
            vo.setPassword(null);
        }
        vo.setUpdateId(httpSessionService.getCurrentUserId());
        mapper.updateById(vo);
    }

    @Override
    public IPage<User> pageInfo(User vo) {
        Page page = new Page(vo.getPage(), vo.getLimit());
        LambdaQueryWrapper<User> queryWrapper = Wrappers.lambdaQuery();
        if (!StringUtils.isEmpty(vo.getUsername())) {
            queryWrapper.like(User::getUsername, vo.getUsername());
        }
        if (!StringUtils.isEmpty(vo.getStartTime())) {
            queryWrapper.gt(User::getCreateTime, vo.getStartTime());
        }
        if (!StringUtils.isEmpty(vo.getEndTime())) {
            queryWrapper.lt(User::getCreateTime, vo.getEndTime());
        }
        if (!StringUtils.isEmpty(vo.getNickName())) {
            queryWrapper.like(User::getNickName, vo.getNickName());
        }
        if (null != vo.getStatus()) {
            queryWrapper.eq(User::getStatus, vo.getStatus());
        }
        if (!StringUtils.isEmpty(vo.getDeptNo())) {
            LambdaQueryWrapper<Dept> queryWrapperDept = Wrappers.lambdaQuery();
            queryWrapperDept.select(Dept::getId).like(Dept::getRelationCode, vo.getDeptNo());
            List<Object> list = deptMapper.selectObjs(queryWrapperDept);
            queryWrapper.in(User::getDeptId, list);
        }
        queryWrapper.orderByDesc(User::getCreateTime);
        IPage<User> iPage = mapper.selectPage(page, queryWrapper);
        if (!CollectionUtils.isEmpty(iPage.getRecords())) {
            for (User user : iPage.getRecords()) {
                Dept dept = deptMapper.selectById(user.getDeptId());
                if (dept != null) {
                    user.setDeptName(dept.getName());
                }
            }
        }
        return iPage;
    }

    @Override
    public void addUser(User vo) {

        User userOne = mapper.selectOne(Wrappers.<User>lambdaQuery().eq(User::getUsername, vo.getUsername()));
        if (userOne != null) {
            throw new BusinessException("用户已存在，请勿重复添加！");
        }
        vo.setSalt(PasswordUtils.getSalt());
        String encode = PasswordUtils.encode(vo.getPassword(), vo.getSalt());
        vo.setPassword(encode);
        vo.setStatus(1);
        vo.setCreateWhere(1);
        mapper.insert(vo);
        if (!CollectionUtils.isEmpty(vo.getRoleIds())) {
            UserRoleOperation reqVO = new UserRoleOperation();
            reqVO.setUserId(vo.getId());
            reqVO.setRoleIds(vo.getRoleIds());
            userRoleService.addUserRoleInfo(reqVO);
        }
    }

    @Override
    public void updatePwd(User vo) {
        User user = mapper.selectById(vo.getId());
        if (user == null) {
            throw new BusinessException(BaseResponseCode.DATA_ERROR);
        }
        if ("test".equals(env) && "guest".equals(user.getUsername())) {
            throw new BusinessException("演示环境禁止修改演示账号密码");
        }

        if (!PasswordUtils.matches(user.getSalt(), vo.getOldPwd(),
                user.getPassword())) {
            throw new BusinessException(BaseResponseCode.OLD_PASSWORD_ERROR);
        }
        if (user.getPassword().equals(PasswordUtils.encode(vo.getNewPwd(),
                user.getSalt()))) {
            throw new BusinessException("新密码不能与旧密码相同");
        }
        user.setPassword(PasswordUtils.encode(vo.getNewPwd(), user.getSalt()));
        mapper.updateById(user);
        //退出用户
        httpSessionService.abortAllUserByToken();
    }

    @Override
    public UserOwnRoleVo getUserOwnRole(String userId) {
        List<String> roleIdsByUserId = userRoleService.getRoleIdsByUserId(userId);
        List<Role> list = roleService.list();
        UserOwnRoleVo vo = new UserOwnRoleVo();
        vo.setAllRole(list);
        vo.setOwnRoles(roleIdsByUserId);
        return vo;
    }

    @Override
    public void updateUserInfoMy(User vo) {

        User user = mapper.selectById(httpSessionService.getCurrentUserId());
        if (null == user) {
            throw new BusinessException(BaseResponseCode.DATA_ERROR);
        }
        if (!StringUtils.isEmpty(vo.getPassword())) {
            String newPassword = PasswordUtils.encode(vo.getPassword(), user.getSalt());
            vo.setPassword(newPassword);
        } else {
            vo.setPassword(null);
        }
        vo.setUpdateId(httpSessionService.getCurrentUserId());
        mapper.updateById(vo);
    }
}
