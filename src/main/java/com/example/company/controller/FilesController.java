package com.example.company.controller;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.company.common.utils.DataResult;
import com.example.company.entity.Files;
import com.example.company.service.FilesService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 * 文件上传 前端控制器
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@RestController
@RequestMapping("/sysFiles")
@Api(tags = "文件管理")
public class FilesController {
    @Resource
    private FilesService filesService;

    @ApiOperation(value = "新增")
    @PostMapping("/upload")
    @RequiresPermissions(value = {"sysFiles:add", "sysContent:update", "sysContent:add"}, logical = Logical.OR)
    public DataResult add(@RequestParam(value = "file") MultipartFile file) {
        //判断文件是否空
        if (file == null || file.getOriginalFilename() == null || "".equalsIgnoreCase(file.getOriginalFilename().trim())) {
            return DataResult.fail("文件为空");
        }
        return filesService.saveFile(file);
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("/delete")
    @RequiresPermissions("sysFiles:delete")
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids) {
        filesService.removeByIdsAndFiles(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("/listByPage")
    @RequiresPermissions("sysFiles:list")
    public DataResult findListByPage(@RequestBody Files sysFiles) {
        Page page = new Page(sysFiles.getPage(), sysFiles.getLimit());
        IPage<Files> iPage = filesService.page(
                page, Wrappers.<Files>lambdaQuery().orderByDesc(Files::getCreateDate));
        return DataResult.success(iPage);
    }


}