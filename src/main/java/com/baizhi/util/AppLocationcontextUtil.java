package com.baizhi.util;

import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

@Component   //将该类交由容器管理
public class AppLocationcontextUtil implements ApplicationContextAware {
    //该成员变量用于在下面的方法中使用
    private static  ApplicationContext applicationContext;

    //获得当前工厂类的对象
    //获得当前的spring工厂
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        //给成员变量赋值
        this.applicationContext=applicationContext;
    }

    //通过名字获取对象
    public static Object getBeanName(String name)
    {
        return applicationContext.getBean(name);
    }

    //通过类型获取对象
    public static Object getBeanType(Class clasz)
    {
        return applicationContext.getBean(clasz);
    }

    //通过类型和名字获取对象
    public static Object getBeanType(Class clasz,String name)
    {
        return applicationContext.getBean(name,clasz);
    }
}
