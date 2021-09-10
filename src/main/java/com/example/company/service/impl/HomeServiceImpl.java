package com.example.company.service.impl;

import com.example.company.entity.Dept;
import com.example.company.entity.User;
import com.example.company.service.DeptService;
import com.example.company.service.HomeService;
import com.example.company.service.PermissionService;
import com.example.company.service.UserService;
import com.example.company.vo.reponse.HomeVo;
import com.example.company.vo.reponse.PermissionRespNode;
import com.example.company.vo.reponse.UserInfoVo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * 主页
 * @author : LSD
 * @version : 1.0
 * @ClassName : HomeServiceImpl
 * @Description : TODO
 * @date : 2021/9/3 16:25
 **/
@Service
public class HomeServiceImpl implements HomeService {
    @Resource
    private UserService userService;
    @Resource
    private DeptService deptService;
    @Resource
    private PermissionService permissionService;

    @Override
    public HomeVo getHomeInfo(String userId) {


        User user = userService.getById(userId);
        UserInfoVo vo = new UserInfoVo();

        if (user != null) {
            BeanUtils.copyProperties(user, vo);
            Dept dept = deptService.getById(user.getDeptId());
            if (dept != null) {
                vo.setDeptId(dept.getId());
                vo.setDeptName(dept.getName());
            }
        }

        List<PermissionRespNode> menus = permissionService.permissionTreeList(userId);

        HomeVo respVO = new HomeVo();
        respVO.setMenus(menus);
        respVO.setUserInfo(vo);

        return respVO;
    }
}
