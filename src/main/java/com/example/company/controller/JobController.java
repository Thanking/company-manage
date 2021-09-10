package com.example.company.controller;


import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.company.common.aop.annotation.LogAnnotation;
import com.example.company.common.exception.code.BaseResponseCode;
import com.example.company.common.job.utils.ScheduleJob;
import com.example.company.common.utils.DataResult;
import com.example.company.entity.JobEntity;
import com.example.company.service.JobService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.quartz.TriggerUtils;
import org.quartz.impl.triggers.CronTriggerImpl;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * <p>
 * 定时任务 前端控制器
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Api(tags = "定时任务")
@RestController
@RequestMapping("/sysJob")
public class JobController {
    @Resource
    private JobService jobService;

    @ApiOperation(value = "新增")
    @LogAnnotation(title = "新增")
    @PostMapping("/add")
    @RequiresPermissions("sysJob:add")
    public DataResult add(@RequestBody JobEntity sysJob) {
        if (isValidExpression(sysJob.getCronExpression())) {
            return DataResult.fail("cron表达式有误");
        }
        DataResult dataResult = ScheduleJob.judgeBean(sysJob.getBeanName());
        if (BaseResponseCode.SUCCESS.getCode() != dataResult.getCode()) {
            return dataResult;
        }

        jobService.saveJob(sysJob);
        return DataResult.success();
    }

    @ApiOperation(value = "删除")
    @DeleteMapping("/delete")
    @RequiresPermissions("sysJob:delete")
    @LogAnnotation(title = "删除")
    public DataResult delete(@RequestBody @ApiParam(value = "id集合") List<String> ids) {
        jobService.delete(ids);
        return DataResult.success();
    }

    @ApiOperation(value = "更新")
    @PutMapping("/update")
    @RequiresPermissions("sysJob:update")
    @LogAnnotation(title = "更新")
    public DataResult update(@RequestBody JobEntity sysJob) {
        if (isValidExpression(sysJob.getCronExpression())) {
            return DataResult.fail("cron表达式有误");
        }
        DataResult dataResult = ScheduleJob.judgeBean(sysJob.getBeanName());
        if (BaseResponseCode.SUCCESS.getCode() != dataResult.getCode()) {
            return dataResult;
        }

        jobService.updateJobById(sysJob);
        return DataResult.success();
    }

    @ApiOperation(value = "查询分页数据")
    @PostMapping("/listByPage")
    @RequiresPermissions("sysJob:list")
    public DataResult findListByPage(@RequestBody JobEntity sysJob) {
        Page page = new Page(sysJob.getPage(), sysJob.getLimit());
        LambdaQueryWrapper<JobEntity> queryWrapper = Wrappers.lambdaQuery();
        //查询条件示例
        if (!StringUtils.isEmpty(sysJob.getBeanName())) {
            queryWrapper.like(JobEntity::getBeanName, sysJob.getBeanName());
        }
        IPage<JobEntity> iPage = jobService.page(page, queryWrapper);
        return DataResult.success(iPage);
    }


    /**
     * 立即执行任务
     */
    @ApiOperation(value = "立即执行任务")
    @LogAnnotation(title = "立即执行任务")
    @PostMapping("/run")
    @RequiresPermissions("sysJob:run")
    public DataResult run(@RequestBody List<String> ids) {
        jobService.run(ids);

        return DataResult.success();
    }

    /**
     * 暂停定时任务
     */
    @ApiOperation(value = "暂停定时任务")
    @LogAnnotation(title = "暂停定时任务")
    @PostMapping("/pause")
    @RequiresPermissions("sysJob:pause")
    public DataResult pause(@RequestBody List<String> ids) {
        jobService.pause(ids);

        return DataResult.success();
    }

    /**
     * 恢复定时任务
     */
    @ApiOperation(value = "恢复定时任务")
    @LogAnnotation(title = "恢复定时任务")
    @PostMapping("/resume")
    @RequiresPermissions("sysJob:resume")
    public DataResult resume(@RequestBody List<String> ids) {
        jobService.resume(ids);
        return DataResult.success();
    }

    /**
     * 判断cron表达式
     *
     * @param cronExpression cron表达式
     * @return 是否有误
     */
    public static boolean isValidExpression(String cronExpression) {
        CronTriggerImpl trigger = new CronTriggerImpl();
        try {
            trigger.setCronExpression(cronExpression);
            Date date = trigger.computeFirstFireTime(null);
            return date == null || !date.after(new Date());
        } catch (Exception e) {
            return true;
        }
    }


    @ApiOperation(value = "获取运行时间")
    @LogAnnotation(title = "获取运行时间")
    @PostMapping("/getRecentTriggerTime")
    @RequiresPermissions("sysJob:add")
    public DataResult getRecentTriggerTime(String cron) {
        List<String> list = new ArrayList<>();
        try {
            CronTriggerImpl cronTriggerImpl = new CronTriggerImpl();
            cronTriggerImpl.setCronExpression(cron);
            // 这个是重点，一行代码搞定
            List<Date> dates = TriggerUtils.computeFireTimes(cronTriggerImpl, null, 5);
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            for (Date date : dates) {
                list.add(dateFormat.format(date));
            }

        } catch (ParseException e) {
            e.printStackTrace();
        }
        return DataResult.success(list);
    }


}