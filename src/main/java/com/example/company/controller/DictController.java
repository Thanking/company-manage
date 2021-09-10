package com.example.company.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.company.common.utils.DataResult;
import com.example.company.entity.DictDetailEntity;
import com.example.company.entity.DictEntity;
import com.example.company.service.DictDetailService;
import com.example.company.service.DictService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 数据字典表 前端控制器
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Api(tags = "字典管理")
@RestController
@RequestMapping("/sysDict")
public class DictController {
    @Resource
    private DictService dictService;
    @Resource
    private DictDetailService sysDictDetailService;


    @ApiOperation(value = "新增")
    @PostMapping("/add")
    @RequiresPermissions("sysDict:add")
    public DataResult add(@RequestBody DictEntity sysDict) {
        if (StringUtils.isEmpty(sysDict.getName())) {
            return DataResult.fail("字典名称不能为空");
        }
        DictEntity q = dictService.getOne(Wrappers.<DictEntity>lambdaQuery().eq(DictEntity::getName, sysDict.getName()));
        if (q != null) {
            return DataResult.fail("字典名称已存在");
        }
        dictService.save(sysDict);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("/delete")
    @RequiresPermissions("sysDict:delete")
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids) {
        dictService.removeByIds(ids);
        //删除detail
        sysDictDetailService.remove(Wrappers.<DictDetailEntity>lambdaQuery().in(
                DictDetailEntity::getDictId, ids));
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("/update")
    @RequiresPermissions("sysDict:update")
    public DataResult update(@RequestBody DictEntity sysDict) {
        if (StringUtils.isEmpty(sysDict.getName())) {
            return DataResult.fail("字典名称不能为空");
        }

        DictEntity q = dictService.getOne(Wrappers.<
                DictEntity>lambdaQuery().eq(DictEntity::getName, sysDict.getName()));
        if (q != null && !q.getId().equals(sysDict.getId())) {
            return DataResult.fail("字典名称已存在");
        }

        dictService.updateById(sysDict);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("/listByPage")
    @RequiresPermissions("sysDict:list")
    public DataResult findListByPage(@RequestBody DictEntity sysDict) {
        Page page = new Page(sysDict.getPage(), sysDict.getLimit());
        LambdaQueryWrapper<DictEntity> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
        if (!StringUtils.isEmpty(sysDict.getName())) {
            queryWrapper.like(DictEntity::getName, sysDict.getName());
            queryWrapper.or();
            queryWrapper.like(DictEntity::getRemark, sysDict.getName());
        }
        queryWrapper.orderByAsc(DictEntity::getName);
        IPage<DictEntity> iPage = dictService.page(page, queryWrapper);
        return DataResult.success(iPage);
    }

}
