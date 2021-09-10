package com.example.company.service.impl;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.example.company.common.exception.BusinessException;
import com.example.company.common.exception.code.BaseResponseCode;
import com.example.company.entity.Dept;
import com.example.company.entity.User;
import com.example.company.mapper.DeptMapper;
import com.example.company.mapper.UserMapper;
import com.example.company.service.DeptService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.company.vo.reponse.DeptNodeVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicReference;

/**
 * <p>
 * 系统部门 服务实现类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Service
@Slf4j
public class DeptServiceImpl extends ServiceImpl<DeptMapper, Dept> implements DeptService {

    @Resource
    private DeptMapper mapper;
    @Resource
    private UserMapper userMapper;


    @Override
    public void addDept(Dept vo) {
        String relationCode;
        String deptCode = this.getNewDeptCode();
        Dept parent = mapper.selectById(vo.getPid());
        if ("0".equals(vo.getPid())) {
            relationCode = deptCode;
        } else if (null == parent) {
            throw new BusinessException(BaseResponseCode.DATA_ERROR);
        } else {
            relationCode = parent.getRelationCode() + deptCode;
        }
        vo.setDeptNo(deptCode);
        vo.setRelationCode(relationCode);
        vo.setStatus(1);
        mapper.insert(vo);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateDept(Dept vo) {
        Dept dept = mapper.selectById(vo.getId());
        if (null == dept) {
            throw new BusinessException(BaseResponseCode.DATA_ERROR);
        }
        mapper.updateById(vo);
        //说明层级发生了变化
        if (!StringUtils.isEmpty(vo.getPid()) && !vo.getPid().equals(dept.getPid())) {
            Dept parent = mapper.selectById(vo.getPid());
            if (!"0".equals(vo.getPid()) && null == parent) {
                throw new BusinessException(BaseResponseCode.DATA_ERROR);
            }
            Dept oldParent = mapper.selectById(dept.getPid());
            String oldRelationCode;
            String newRelationCode;
            //根目录降到其他目录
            if ("0".equals(dept.getPid())) {
                oldRelationCode = dept.getDeptNo();
                newRelationCode = parent.getRelationCode() + dept.getDeptNo();
            } else if ("0".equals(vo.getPid())) { // 其他目录升级到跟目录
                oldRelationCode = dept.getRelationCode();
                newRelationCode = dept.getDeptNo();
            } else {
                oldRelationCode = oldParent.getRelationCode();
                newRelationCode = parent.getRelationCode();
            }
            LambdaQueryWrapper<Dept> wrapper = Wrappers.lambdaQuery();
            wrapper.likeLeft(Dept::getDeptNo, dept.getDeptNo());
            List<Dept> list = mapper.selectList(wrapper);
            list.parallelStream().forEach(entity -> {
                String relationCode = entity.getRelationCode().replace(oldRelationCode, newRelationCode);
                entity.setRelationCode(relationCode);
                mapper.updateById(entity);
            });
        }
    }

    @Override
    public void deleted(String id) {
        Dept dept = mapper.selectById(id);
        if (null == dept) {
            throw new BusinessException(BaseResponseCode.DATA_ERROR);
        }
        List<Object> deptIds = mapper.selectObjs(Wrappers.<Dept>lambdaQuery().select(
                Dept::getId).likeRight(Dept::getRelationCode, dept.getRelationCode()));
        List<User> list = userMapper.selectList(
                Wrappers.<User>lambdaQuery().in(User::getDeptId, deptIds));
        if (!CollectionUtils.isEmpty(list)) {
            throw new BusinessException(BaseResponseCode.NOT_PERMISSION_DELETED_DEPT);
        }
        mapper.deleteById(id);
    }


    @Override
    public List<DeptNodeVo> deptTreeList(String deptId, Boolean disabled) {
        List<Dept> list;
        if (StringUtils.isEmpty(deptId)) {
            list = mapper.selectList(Wrappers.emptyWrapper());
        } else {
            Dept dept = mapper.selectById(deptId);
            if (dept == null) {
                throw new BusinessException(BaseResponseCode.DATA_ERROR);
            }
            LambdaQueryWrapper<Dept> queryWrapper =
                    Wrappers.<Dept>lambdaQuery().likeRight(
                            Dept::getRelationCode, dept.getRelationCode());
            List<Object> childIds = mapper.selectObjs(queryWrapper);
            list = mapper.selectList(Wrappers.<Dept>lambdaQuery().notIn(
                    Dept::getId, childIds));
        }
        // 默认加一个顶级方便新增顶级部门
        DeptNodeVo nodeVO = new DeptNodeVo();
        nodeVO.setTitle("默认顶级部门");
        nodeVO.setId("0");
        nodeVO.setSpread(true);
        nodeVO.setDisabled(disabled);
        nodeVO.setChildren(getTree(list));
        List<DeptNodeVo> result = new ArrayList<>();
        result.add(nodeVO);
        return result;
    }

    private List<DeptNodeVo> getTree(List<Dept> all) {
        List<DeptNodeVo> list = new ArrayList<>();
        for (Dept Dept : all) {
            if ("0".equals(Dept.getPid())) {
                DeptNodeVo deptTree = new DeptNodeVo();
                BeanUtils.copyProperties(Dept, deptTree);
                deptTree.setTitle(Dept.getName());
                deptTree.setSpread(true);
                deptTree.setChildren(getChild(Dept.getId(), all));
                list.add(deptTree);
            }
        }
        return list;
    }

    private List<DeptNodeVo> getChild(String id, List<Dept> all) {
        List<DeptNodeVo> list = new ArrayList<>();
        for (Dept dept : all) {
            if (dept.getPid().equals(id)) {
                DeptNodeVo deptTree = new DeptNodeVo();
                BeanUtils.copyProperties(dept, deptTree);
                deptTree.setTitle(dept.getName());
                deptTree.setChildren(getChild(dept.getId(), all));
                list.add(deptTree);
            }
        }
        return list;
    }

    //获取新的部门编码
    public String getNewDeptCode() {
        LambdaQueryWrapper<Dept> lambdaQueryWrapper = Wrappers.lambdaQuery();
        lambdaQueryWrapper.select(Dept::getDeptNo);
        //获取所有的deptCode
        List<Object> deptCodes = mapper.selectObjs(lambdaQueryWrapper);
        AtomicReference<Integer> maxDeptCode = new AtomicReference<>(0);

        //遍历获取最大的DeptCode
        deptCodes.forEach(o -> {
            String str = String.valueOf(o);
            if (str.length() >= 7) {
                Integer one = Integer.parseInt(str.substring(str.length() - 5));
                if (one > maxDeptCode.get()) {
                    maxDeptCode.set(one);
                }
            }
        });

        return padRight(maxDeptCode.get() + 1, 6, "0");
    }


    /**
     * 右补位，左对齐
     *
     * @param len    目标字符串长度
     * @param alexi  补位字符
     * @param oriStr 原字符串
     * @return 目标字符串
     * 以alexin 做为补位
     */
    public static String padRight(int oriStr, int len, String alexi) {
        StringBuilder str = new StringBuilder();
        int strlen = String.valueOf(oriStr).length();
        if (strlen < len) {
            for (int i = 0; i < len - strlen; i++) {
                str.append(alexi);
            }
        }
        str.append(oriStr);
        return "D" + str.toString();
    }
}