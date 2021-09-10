package com.example.company.service.impl;


import com.example.company.entity.JobLog;
import com.example.company.mapper.JobLogMapper;
import com.example.company.service.JobLogService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 定时任务日志 服务实现类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Service("jobLogService")
public class JobLogServiceImpl extends ServiceImpl<JobLogMapper, JobLog> implements JobLogService {

}
