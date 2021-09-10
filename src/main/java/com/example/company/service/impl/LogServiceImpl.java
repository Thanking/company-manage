package com.example.company.service.impl;

import com.example.company.entity.SysLog;
import com.example.company.mapper.LogMapper;
import com.example.company.service.LogService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 系统日志 服务实现类
 * </p>
 *
 * @author LSD
 * @since 2021-09-02
 */
@Service
public class LogServiceImpl extends ServiceImpl<LogMapper, SysLog> implements LogService {

}
