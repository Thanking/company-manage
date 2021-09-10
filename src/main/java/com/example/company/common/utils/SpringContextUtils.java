package com.example.company.common.utils;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : SpringContextUtils
 * @Description : TODO
 * @date : 2021/9/1 22:39
 **/
@Component
public class SpringContextUtils implements ApplicationContextAware {

    private static ApplicationContext applicationContext;
    @Override
    @SuppressWarnings("static-access" )
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        SpringContextUtils.applicationContext = applicationContext;
    }
    public static Object getBean(String name) {
        try {
            return applicationContext.getBean(name);
        } catch (Exception e) {
            return null;
        }
    }

}
