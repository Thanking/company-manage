package com.example.company;

import com.alibaba.druid.spring.boot.autoconfigure.DruidDataSourceAutoConfigure;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.core.env.Environment;

import java.net.InetAddress;
import java.net.UnknownHostException;


@SpringBootApplication(exclude = DruidDataSourceAutoConfigure.class)
@MapperScan("com.example.company.mapper")
@Slf4j
public class CompanyApplication {

    public static void main(String[] args) {
        ConfigurableApplicationContext application = SpringApplication.run(CompanyApplication.class, args);

        Environment env = application.getEnvironment();
        try {
            log.info("\n----------------------------------------------------------\n\t" +
                            "Application '{}' is running! Access URLs:\n\t" +
                            "Login: \thttp://{}:{}/login\n\t" +
                            "Doc: \thttp://{}:{}/doc.html\n" +
                            "----------------------------------------------------------",
                    env.getProperty("spring.application.name"),
                    InetAddress.getLocalHost().getHostAddress(),
                    env.getProperty("server.port"),
                    InetAddress.getLocalHost().getHostAddress(),
                    env.getProperty("server.port"));
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }
    }

}
