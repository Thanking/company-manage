package com.example.company.common.exception.code;

/**
 * @author 亚亚
 * @version 1.0
 * @InterfaceName ResponseCodeInterface
 * @Description TODO
 * @date 2021/9/1 22:29
 **/
public interface ResponseCodeInterface {
    /**
     * 获取code
     *
     * @return code
     */
    int getCode();

    /**
     * 获取信息
     *
     * @return msg
     */
    String getMsg();
}
