package com.baizhi;

import com.baizhi.Custom.UserEsServices;
import com.baizhi.dao.StuDao;
import com.baizhi.dao.UserDao;
import com.baizhi.entity.Stu;
import com.baizhi.entity.User;
import com.baizhi.services.UserServices;
import org.junit.jupiter.api.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;
import java.util.Map;

@SpringBootTest(classes = OnebootApplication.class)
@RunWith(SpringRunner.class)
class OnebootApplicationTests {

    @Autowired
    private StuDao stuDao;

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserServices userServices;  //userdao

    @Test
    void contextLoads() {
        List<Stu> selectall = stuDao.selectall();
        for (Stu stu : selectall) {
            System.out.println(stu);
        }
    }

    @Test
    void userdaoselect() {
        Map<String, Object> map = userServices.selectUser(1, 2);
        for(Map.Entry<String, Object> entry:map.entrySet())
        {
            System.out.println("健:"+entry.getKey());
            System.out.println("值:"+entry.getValue());
        }

    }

    @Test
    void selectUser()
    {
        List<User> list = userDao.selectUsers(1, 10);
        for (User user : list) {
            System.out.println(user);
        }
    }


    //自动注入Es服务对象
    @Autowired
    private UserEsServices userEsServices;


    //将数据库中user的数据存入es中
    @Test
    public void addUserEsAll()
    {
        userEsServices.inserEsAll();
    }

    //高亮查询
    @Test
    public void gaoliang()
    {
        List<User> list = userEsServices.likeUser("四");
        for (User user : list) {
            System.out.println("数据:"+user);
        }
    }

}
