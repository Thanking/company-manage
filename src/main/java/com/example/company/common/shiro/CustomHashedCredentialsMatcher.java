package com.example.company.common.shiro;

import com.example.company.common.config.RedisService;
import com.example.company.common.exception.BusinessException;
import com.example.company.common.exception.code.BaseResponseCode;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.credential.SimpleCredentialsMatcher;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Lazy;

/**
 * 登录认证
 * @author : LSD
 * @version : 1.0
 * @ClassName : CustomHashedCredentialsMatcher
 * @Description : TODO
 * @date : 2021/9/3 17:41
 **/
public class CustomHashedCredentialsMatcher extends SimpleCredentialsMatcher {

    @Lazy
    @Autowired
    private RedisService redisDb;
    @Value("${spring.redis.key.prefix.userToken}")
    private String userTokenPrefix;

    @Override
    public boolean doCredentialsMatch(AuthenticationToken token, AuthenticationInfo info) {
        String accessToken = (String) token.getPrincipal();
        if (!redisDb.exists(userTokenPrefix + accessToken)) {
            SecurityUtils.getSubject().logout();
            throw new BusinessException(BaseResponseCode.TOKEN_ERROR);
        }
        return true;
    }
}
