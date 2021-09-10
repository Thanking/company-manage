package com.example.company.common.aop.annotation;

import java.lang.annotation.*;

/**
 * @author 亚亚
 * @version 1.0
 * @InterfaceName DataSoucp
 * @Description TODO
 * @date 2021/9/2 11:14
 **/
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface DataScope {
}
