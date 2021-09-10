package com.example.company.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.company.common.aop.annotation.DataScope;
import com.example.company.common.utils.DataResult;
import com.example.company.entity.ContentEntity;
import com.example.company.service.ContentService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.util.CollectionUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 文章管理 前端控制器
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Api(tags = "文章管理")
@RestController
@RequestMapping("/sysContent")
public class ContentController {

    @Resource
    private ContentService contentService;


    @ApiOperation(value = "新增")
    @PostMapping("/add")
    @RequiresPermissions("sysContent:add")
    public DataResult add(@RequestBody ContentEntity content) {
        contentService.save(content);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("/delete")
    @RequiresPermissions("content:delete")
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids) {
        contentService.removeByIds(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("/update")
    @RequiresPermissions("sysContent:update")
    public DataResult update(@RequestBody ContentEntity content) {
        contentService.updateById(content);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("/listByPage")
    @RequiresPermissions("sysContent:list")
    @DataScope
    public DataResult findListByPage(@RequestBody ContentEntity content) {
        Page page = new Page(content.getPage(), content.getLimit());
        LambdaQueryWrapper<ContentEntity> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
        if (!StringUtils.isEmpty(content.getTitle())) {
            queryWrapper.like(ContentEntity::getTitle, content.getTitle());
        }
        //数据权限示例， 需手动添加此条件 begin
        if (!CollectionUtils.isEmpty(content.getCreateIds())) {
            queryWrapper.in(ContentEntity::getCreateId, content.getCreateIds());
        }
        //数据权限示例， 需手动添加此条件 end

        IPage<ContentEntity> iPage = contentService.page(page, queryWrapper);
        return DataResult.success(iPage);
    }
}