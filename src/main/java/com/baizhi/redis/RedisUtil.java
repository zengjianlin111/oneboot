package com.baizhi.redis;

import com.baizhi.util.AppLocationcontextUtil;
import com.baizhi.util.SerizerUtil;
import org.apache.ibatis.cache.Cache;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.util.ObjectUtils;

import java.util.concurrent.locks.ReadWriteLock;

public class RedisUtil implements Cache {

    //需要一个成员变量用于接收参数
    private String id;   //该参数是dao的权限定名

    //提供一个有参构造 作用是给成员变量赋值
    public RedisUtil(String id) {
        this.id = id;
    }

    @Override   //该方法用于获取权限限定名方便在下面使用
    public String getId() {
        return id;
    }

    /*
    * 该方法用于添加缓存
    * 参数1是唯一标识 每次不同操作的唯一标识是唯一的
    * 参数二是查询的值
    * 这里不能直接将第一个参数作为键，但第二个参数可以作为值直接传入redis
    * 建议使用hash的方式将全限定名作为大键的id 第一个参数作为小键的id
    * 第二个参数作为值
    * 这样清除缓存时只需要清除大键就行
    * */
    @Override
    public void putObject(Object o, Object o1) {
        /*
        * 使用
        * StringRedisTemplate对象操作 该对象支持中文比较好
        * 但是该类是交由mybatis管理的 所有不能直接使用
        * 要使用工具类从容器中获取
        * 如果是spring项目需要手动配置bean
        * */
        StringRedisTemplate stringRedisTemplate= (StringRedisTemplate) AppLocationcontextUtil.getBeanType(StringRedisTemplate.class);
        //获取hash对象
        HashOperations<String, Object, Object> stringObjectObjectHashOperations = stringRedisTemplate.opsForHash();

        //判断数据是否为null
        if(!ObjectUtils.isEmpty(o1))
        {
            //将数据序列化  使用序列化工具
            String serialize = SerizerUtil.serialize(o1);
            //将序列化的值存入redis id作为大键 o作为小键(要调用toString方法) 序列化后的值做为
            // 值存入redis
            stringObjectObjectHashOperations.put(id,o.toString(),serialize);
        }
    }

    //获取缓存中的值 参数是唯一标识
    @Override
    public Object getObject(Object o) {
        //唯一标识

        //获取操作redis的对象
        StringRedisTemplate stringRedisTemplate= (StringRedisTemplate) AppLocationcontextUtil.getBeanType(StringRedisTemplate.class);
        //获取hash对象
        HashOperations<String, Object, Object> stringObjectObjectHashOperations = stringRedisTemplate.opsForHash();

        //将集合中的值取出id是大键 o是小键 都需要转换为字符串
        String o1 = (String)stringObjectObjectHashOperations.get(id.toString(), o.toString());
        //判断数据是否为null
        if(!ObjectUtils.isEmpty(o1))
        {
            //数据不为null将数据通过工具类进行反序列化
            Object o2 = SerizerUtil.serializeToObject(o1);
            //将数据返回
            return o2;
        }

        return null;
    }

    //删除缓存的方法
    @Override
    public Object removeObject(Object o) {
        return null;
    }

    //清除缓存的方法
    @Override
    public void clear() {
        //该方法在指定增删改时调用

        //获取操作redis对象
        StringRedisTemplate stringRedisTemplate= (StringRedisTemplate) AppLocationcontextUtil.getBeanType(StringRedisTemplate.class);
        //直接将大键id删除即可
        stringRedisTemplate.delete(id);
    }

    //获取数据的长度
    @Override
    public int getSize() {
        return 0;
    }

    //读写锁
    @Override
    public ReadWriteLock getReadWriteLock() {
        return null;
    }
}
