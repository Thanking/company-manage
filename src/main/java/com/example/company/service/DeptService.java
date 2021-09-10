package com.example.company.service;

import com.example.company.entity.Dept;
import com.baomidou.mybatisplus.extension.service.IService;
import com.example.company.vo.reponse.DeptNodeVo;

import java.util.List;

/**
 * <p>
 * 系统部门 服务类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
public interface DeptService extends IService<Dept> {


    /**
     * 添加部门
     *
     * @param vo vo
     */
    void addDept(Dept vo);

    /**
     * 更新部门
     *
     * @param vo vo
     */
    void updateDept(Dept vo);

    /**
     * 删除部门
     *
     * @param id id
     */
    void deleted(String id);

    /**
     * 部门树形列表
     *
     * @param deptId   deptId
     * @param disabled 最顶级是否可用
     * @return 树形列表
     */
    List<DeptNodeVo> deptTreeList(String deptId, Boolean disabled);
}
