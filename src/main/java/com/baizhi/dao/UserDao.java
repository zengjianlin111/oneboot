package com.baizhi.dao;

import com.baizhi.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface UserDao {
    /*查询所有用户 //分页查询*/
    public List<User> selectUsers(@Param("qishi") int qishi, @Param("count") int count);
    //通过id删除
    public void delete(int id);
    //添加
    public void insert(User user);

    //通过id查询用户
    public User selectid(int id);

    //模糊查询
    public List<User> likeUser(User user);

    //修改用户
    public void update(User user);

    //查询总条数
    public int selectcount();

    //查询所有用户
    public List<User> selectAll();

}
