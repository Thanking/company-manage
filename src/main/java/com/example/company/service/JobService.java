package com.example.company.service;


import com.baomidou.mybatisplus.extension.service.IService;
import com.example.company.entity.JobEntity;

import java.util.List;

/**
 * <p>
 * 定时任务 服务类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
public interface JobService extends IService<JobEntity> {
    /**
     * 保存job
     *
     * @param sysJob sysJob
     */
    void saveJob(JobEntity sysJob);

    /**
     * 更新job
     *
     * @param sysJob sysJob
     */
    void updateJobById(JobEntity sysJob);

    /**
     * 删除job
     *
     * @param ids ids
     */
    void delete(List<String> ids);

    /**
     * 运行一次job
     *
     * @param ids ids
     */
    void run(List<String> ids);

    /**
     * 暂停job
     *
     * @param ids ids
     */
    void pause(List<String> ids);

    /**
     * 恢复job
     *
     * @param ids ids
     */
    void resume(List<String> ids);

    /**
     * 批量更新状态
     *
     * @param ids    ids
     * @param status status
     */
    void updateBatch(List<String> ids, int status);
}
