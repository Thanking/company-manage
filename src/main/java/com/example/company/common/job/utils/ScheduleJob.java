package com.example.company.common.job.utils;

import com.example.company.common.utils.DataResult;
import com.example.company.common.utils.SpringContextUtils;
import com.example.company.entity.JobEntity;
import com.example.company.entity.JobLog;
import com.example.company.service.JobLogService;
import org.apache.commons.lang.StringUtils;
import org.quartz.JobExecutionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.scheduling.quartz.QuartzJobBean;

import java.lang.reflect.Method;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : ScheduleJob
 * @Description : TODO
 * @date : 2021/9/1 22:43
 **/

public class ScheduleJob extends QuartzJobBean {
    private Logger logger = LoggerFactory.getLogger(getClass());

    final JobLogService jobLogService;

    public ScheduleJob(JobLogService jobLogService) {
        this.jobLogService = jobLogService;
    }


    @Override
    protected void executeInternal(JobExecutionContext context) {
        JobEntity scheduleJob = (JobEntity) context.getMergedJobDataMap()
                .get(JobEntity.JOB_PARAM_KEY);

        //获取spring bean
        JobLogService scheduleJobLogService = (JobLogService) SpringContextUtils.getBean("jobLogService");

        //数据库保存执行记录
        JobLog log = new JobLog();
        log.setJobId(scheduleJob.getId());
        log.setBeanName(scheduleJob.getBeanName());
        log.setParams(scheduleJob.getParams());

        //任务开始时间
        long startTime = System.currentTimeMillis();

        try {
            //执行任务
            logger.debug("任务准备执行，任务ID：" + scheduleJob.getId());

            Object target = SpringContextUtils.getBean(scheduleJob.getBeanName());
            assert target != null;
            Method method = target.getClass().getDeclaredMethod("run", String.class);
            method.invoke(target, scheduleJob.getParams());

            //任务执行总时长
            long times = System.currentTimeMillis() - startTime;
            log.setTimes((int) times);
            //任务状态    0：成功    1：失败
            log.setStatus(0);

            logger.debug("任务执行完毕，任务ID：" + scheduleJob.getId() + "  总共耗时：" + times + "毫秒");
        } catch (Exception e) {
            logger.error("任务执行失败，任务ID：" + scheduleJob.getId(), e);

            //任务执行总时长
            long times = System.currentTimeMillis() - startTime;
            log.setTimes((int) times);

            //任务状态    0：成功    1：失败
            log.setStatus(1);
            log.setError(StringUtils.substring(e.toString(), 0, 2000));
        } finally {
            assert scheduleJobLogService != null;
            scheduleJobLogService.save(log);
        }
    }

    /**
     * 判断bean是否有效
     *
     * @param beanName beanName
     * @return 返回信息
     */
    public static DataResult judgeBean(String beanName) {

        if (org.springframework.util.StringUtils.isEmpty(beanName)) {
            return DataResult.fail("spring bean名称不能为空");
        }

        Object target = SpringContextUtils.getBean(beanName);
        if (target == null) {
            return DataResult.fail("spring bean不存在，请检查");
        }
        Method method;
        try {
            method = target.getClass().getDeclaredMethod("run", String.class);
        } catch (Exception e) {
            return DataResult.fail("spring bean中的run方法不存在，请检查");
        }
        if (method == null) {
            return DataResult.fail("spring bean中的run方法不存在，请检查");
        }

        return DataResult.success();
    }
}

