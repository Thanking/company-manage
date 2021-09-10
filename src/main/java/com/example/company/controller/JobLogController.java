package com.example.company.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.company.common.aop.annotation.LogAnnotation;
import com.example.company.common.utils.DataResult;
import com.example.company.entity.JobLog;
import com.example.company.service.JobLogService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * <p>
 * 定时任务日志 前端控制器
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Api(tags = "定时任务日志")
@RestController
@RequestMapping("/sysJobLog")
public class JobLogController {

    @Resource
    private JobLogService jobLogService;

    @ApiOperation(value = "查询分页数据")
    @PostMapping("/listByPage")
    @RequiresPermissions("sysJob:list")
    public DataResult findListByPage(@RequestBody JobLog sysJobLog) {
        Page page = new Page(sysJobLog.getPage(), sysJobLog.getLimit());
        LambdaQueryWrapper<JobLog> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
        if (!StringUtils.isEmpty(sysJobLog.getJobId())) {
            queryWrapper.like(JobLog::getJobId, sysJobLog.getJobId());
        }
        queryWrapper.orderByDesc(JobLog::getCreateTime);
        IPage<JobLog> iPage = jobLogService.page(page, queryWrapper);
        return DataResult.success(iPage);
    }

    @ApiOperation(value = "清空定时任务日志")
    @DeleteMapping("/delete")
    @RequiresPermissions("sysJob:delete")
    @LogAnnotation(title = "清空")
    public DataResult delete() {
        jobLogService.remove(Wrappers.emptyWrapper());
        return DataResult.success();
    }

}

