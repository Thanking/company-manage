package com.example.company.common.job.task;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : TestTask
 * @Description : TODO
 * @date : 2021/9/1 22:42
 **/
@Component("testTask")
public class TestTask {
    private Logger logger = LoggerFactory.getLogger(getClass());

    public void run(String params){
        logger.debug("TestTask定时任务正在执行，参数为：{}", params);
    }
}