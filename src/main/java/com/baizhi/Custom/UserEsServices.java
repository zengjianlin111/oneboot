package com.baizhi.Custom;

import com.baizhi.entity.User;

import java.util.List;

public interface UserEsServices {
    //将user表中的数据添加到es中  id name password
    public void inserEsAll();
    //通过名字获取高亮
    public List<User> likeUser(String name);
    //添加数据到es
    public void addUser(User user);
}
