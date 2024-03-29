package com.example.company.common.utils;

/**
 * @author : LSD
 * @version : 1.0
 * @ClassName : Constant
 * @Description : TODO
 * @date : 2021/9/1 22:21
 **/
public class Constant {
    /**
     * redis的token相关
     */
    public static final String ACCESS_TOKEN = "authorization";
    public static final String PERMISSIONS_KEY = "permissions-key";
    public static final String USERID_KEY = "userid-key";
    public static final String USERNAME_KEY = "username-key";
    public static final String ROLES_KEY = "roles-key";

    /**
     * 未删除值
     */
    public static final Integer DATA_NOT_DELETED = 1;

    /**
     * 数据库类型
     */
    public static final String DB_TYPE_MYSQL = "mysql";

    /**
     * 定时任务状态
     */
    public static final Integer SCHEDULER_STATUS_NORMAL = 0;
    public static final Integer SCHEDULER_STATUS_PAUSE = 1;

    /**
     * 数据范围类型 1:所有/2:自定义/3:本部门及一下/4:仅本部门/5:自己
     */
    public static final Integer DATA_SCOPE_ALL = 1;
    public static final Integer DATA_SCOPE_CUSTOM = 2;
    public static final Integer DATA_SCOPE_DEPT_AND_CHILD = 3;
    public static final Integer DATA_SCOPE_DEPT = 4;
    public static final Integer DATA_SCOPE_DEPT_SELF = 5;
}
