package com.baizhi.services;

import com.baizhi.entity.User;

import java.util.List;
import java.util.Map;

public interface UserServices {
    /*查询所有用户*/
    public Map<String,Object> selectUser(int page, int count);
    //通过id删除
    public void delete(int id);
    //添加
    public void insert(User user);

    //通过id查询用户
    public User selectid(int id);

    //模糊查询
    public List<User> selectUser(User user);

    //修改用户
    public void update(User user);
}
