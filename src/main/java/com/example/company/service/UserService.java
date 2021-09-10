package com.example.company.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.company.entity.User;
import com.example.company.vo.reponse.LoginVo;
import com.example.company.vo.reponse.UserOwnRoleVo;

/**
 * @author 亚亚
 * @version 1.0
 * @InterfaceName UserService
 * @Description TODO
 * @date 2021/9/1 21:27
 **/

public interface UserService extends IService<User> {
    /**
     * 注册
     *
     * @param vo vo
     */
    void register(User vo);

    /**
     * 登陆
     *
     * @param vo vo
     * @return LoginRespVO
     */
    LoginVo login(User vo);

    /**
     * 更新用户信息
     *
     * @param vo vo
     */
    void updateUserInfo(User vo);

    /**
     * 分页
     *
     * @param vo vo
     * @return IPage
     */
    IPage<User> pageInfo(User vo);

    /**
     * 添加用户
     *
     * @param vo vo
     */
    void addUser(User vo);

    /**
     * 修改密码
     *
     * @param vo vo
     */
    void updatePwd(User vo);

    /**
     * 根据userid获取绑定角色
     *
     * @param userId userId
     * @return UserOwnRoleRespVO
     */
    UserOwnRoleVo getUserOwnRole(String userId);

    /**
     * 修改自己信息
     *
     * @param vo vo
     */
    void updateUserInfoMy(User vo);
}
