package com.baizhi.services.impl;

import com.baizhi.dao.UserDao;
import com.baizhi.entity.User;
import com.baizhi.services.UserServices;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service("userServices")
@Transactional //添加事务控制
public class UserServicesImpl implements UserServices {
    //依赖userdao
    @Resource
    private UserDao userDao;

    //分页查询
    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public Map<String,Object> selectUser(int page, int count) {

        /*
        * jqGrid要求必须要这样返回
        * page:当前页
        * rows:数据
        *   total：总页数
        *   records:总条数
        * */

        //计算起始条数 (当前页-1)*显示条数
        int qishi=(page-1)*count;
        //调用业务查询数据
        List<User> rows=userDao.selectUsers(qishi,count);

        //查询总条数
        int records=userDao.selectcount();
        //计算总页数 (三元表达式)
        int total= records%count==0 ? records/count : records/count+1;

        //创建一个map集合
        Map<String,Object> map=new HashMap<String,Object>();
        //将数据添加到集合中
        map.put("rows",rows);
        map.put("records",records);
        map.put("total",total);
        map.put("page",page);
        return map;
    }

    @Override
    public void delete(int id) {
        //通过id删除
        //调用业务
        userDao.delete(id);
    }

    @Override
    public void insert(User user) {
        //添加用户
        userDao.insert(user);
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public User selectid(int id) {
        //通过id查询用户
        return userDao.selectid(id);
    }

    @Transactional(propagation = Propagation.SUPPORTS)
    @Override
    public List<User> selectUser(User user) {
        //模糊查询
        return userDao.likeUser(user);
    }

    @Override
    public void update(User user) {
        //修改用户
        userDao.update(user);
    }
}
