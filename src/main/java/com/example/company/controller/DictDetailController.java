package com.example.company.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.company.common.utils.DataResult;
import com.example.company.entity.DictDetailEntity;
import com.example.company.service.DictDetailService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 数据字典详情 前端控制器
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Api(tags = "字典明细管理")
@RestController
@RequestMapping("/sysDictDetail")
public class DictDetailController {
    @Resource
    private DictDetailService dictDetailService;

    @ApiOperation(value = "新增")
    @PostMapping("/add")
    @RequiresPermissions("sysDict:add")
    public DataResult add(@RequestBody DictDetailEntity sysDictDetail) {
        if (StringUtils.isEmpty(sysDictDetail.getValue())) {
            return DataResult.fail("字典值不能为空");
        }
        LambdaQueryWrapper<DictDetailEntity> queryWrapper = Wrappers.lambdaQuery();
        queryWrapper.eq(DictDetailEntity::getValue, sysDictDetail.getValue());
        queryWrapper.eq(DictDetailEntity::getDictId, sysDictDetail.getDictId());
        DictDetailEntity q = dictDetailService.getOne(queryWrapper);
        if (q != null) {
            return DataResult.fail("字典名称-字典值已存在");
        }
        dictDetailService.save(sysDictDetail);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("/delete")
    @RequiresPermissions("sysDict:delete")
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids) {
        dictDetailService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("/update")
    @RequiresPermissions("sysDict:update")
    public DataResult update(@RequestBody DictDetailEntity sysDictDetail) {
        if (StringUtils.isEmpty(sysDictDetail.getValue())) {
            return DataResult.fail("字典值不能为空");
        }
        LambdaQueryWrapper<DictDetailEntity> queryWrapper = Wrappers.lambdaQuery();
        queryWrapper.eq(DictDetailEntity::getValue, sysDictDetail.getValue());
        queryWrapper.eq(DictDetailEntity::getDictId, sysDictDetail.getDictId());
        DictDetailEntity q = dictDetailService.getOne(queryWrapper);
        if (q != null && !q.getId().equals(sysDictDetail.getId())) {
            return DataResult.fail("字典名称-字典值已存在");
        }

        dictDetailService.updateById(sysDictDetail);
        return DataResult.success();
    }


    @ApiOperation(value = "查询列表数据")
    @PostMapping("/listByPage")
    @RequiresPermissions("sysDict:list")
    public DataResult findListByPage(@RequestBody DictDetailEntity sysDictDetail) {
        Page page = new Page(sysDictDetail.getPage(), sysDictDetail.getLimit());
        if (StringUtils.isEmpty(sysDictDetail.getDictId())) {
            return DataResult.success();
        }
        IPage<DictDetailEntity> iPage = dictDetailService.listByPage(page, sysDictDetail.getDictId());
        return DataResult.success(iPage);
    }

}
