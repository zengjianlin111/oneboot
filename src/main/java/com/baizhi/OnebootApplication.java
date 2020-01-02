package com.baizhi;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.baizhi.dao")  //开启dao扫描
public class OnebootApplication {

    public static void main(String[] args) {
        SpringApplication.run(OnebootApplication.class, args);
    }

}
