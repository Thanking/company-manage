package com.example.company.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.company.common.exception.BusinessException;
import com.example.company.common.job.utils.ScheduleJob;
import com.example.company.common.job.utils.ScheduleUtils;
import com.example.company.common.utils.Constant;
import com.example.company.entity.JobEntity;
import com.example.company.mapper.JobMapper;
import com.example.company.service.JobService;
import com.example.company.vo.reponse.PermissionRespNode;
import org.quartz.CronTrigger;
import org.quartz.Scheduler;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.PostConstruct;
import javax.annotation.Resource;
import java.util.List;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : JobServiceImpl
 * @Description : TODO
 * @date : 2021/9/3 16:40
 **/
@Service("jobService")
public class JobServiceImpl extends ServiceImpl<JobMapper, JobEntity> implements JobService {

    @Resource
    private JobMapper mapper;
    @Resource
    private Scheduler scheduler;

    /**
     * 项目启动时，初始化定时器
     */
    @PostConstruct
    public void init() {
        List<JobEntity> scheduleJobList = this.list();
        for (JobEntity scheduleJob : scheduleJobList) {
            CronTrigger cronTrigger = ScheduleUtils.getCronTrigger(scheduler, scheduleJob.getId());
            //如果不存在，则创建
            if (cronTrigger == null) {
                ScheduleUtils.createScheduleJob(scheduler, scheduleJob);
            } else {
                ScheduleUtils.updateScheduleJob(scheduler, scheduleJob);
            }
        }
    }

    @Override
    public void saveJob(JobEntity sysJob) {
        sysJob.setStatus(Constant.SCHEDULER_STATUS_NORMAL);
        this.save(sysJob);

        ScheduleUtils.createScheduleJob(scheduler, sysJob);
    }

    @Override
    public void updateJobById(JobEntity sysJob) {
        JobEntity sysJobEntity = this.getById(sysJob.getId());
        if (sysJobEntity == null) {
            throw new BusinessException("获取定时任务异常");
        }
        sysJob.setStatus(sysJobEntity.getStatus());
        ScheduleUtils.updateScheduleJob(scheduler, sysJob);

        this.updateById(sysJob);
    }

    @Override
    public void delete(List<String> ids) {
        for (String jobId : ids) {
            ScheduleUtils.deleteScheduleJob(scheduler, jobId);
        }
        mapper.deleteBatchIds(ids);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void run(List<String> ids) {
        for (String jobId : ids) {
            ScheduleUtils.run(scheduler, this.getById(jobId));
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void pause(List<String> ids) {
        for (String jobId : ids) {
            ScheduleUtils.pauseJob(scheduler, jobId);
        }

        updateBatch(ids, Constant.SCHEDULER_STATUS_PAUSE);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void resume(List<String> ids) {
        for (String jobId : ids) {
            ScheduleUtils.resumeJob(scheduler, jobId);
        }

        updateBatch(ids, Constant.SCHEDULER_STATUS_NORMAL);
    }

    @Override
    public void updateBatch(List<String> ids, int status) {
        ids.parallelStream().forEach(id -> {
            JobEntity jobEntity = new JobEntity();
            jobEntity.setId(id);
            jobEntity.setStatus(status);
            baseMapper.updateById(jobEntity);
        });
    }
}