package com.baizhi.colltro;

import com.baizhi.Custom.UserEsServices;
import com.baizhi.entity.User;
import com.baizhi.services.UserServices;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Controller  //声明这是一个controller
@RequestMapping("user")  //对外访问包名
public class UserConteroller {
    //依赖注入
    @Resource
    private UserServices userServices;

    //依赖注入esservices
    @Resource
    private UserEsServices userEsServices;

    //分页查询
    @ResponseBody
    @RequestMapping("/select")
    public Map<String,Object>  select(Integer page,Integer rows)
    {
        /*
        * page:当前的页数
        * meiye:每页显示的条数
        * */
        //调用业务
        return userServices.selectUser(page,rows);
    }


    //添加用户
    @ResponseBody
    @RequestMapping("/cdp")
    public void cdp(User user,String oper)
    {

        /*
            user:数据
            oper:状态
                add:添加
                del:删除
                edit:修改
        */
        if("add".equals(oper))
        {
            //添加
            //设置用户id
            user.setId(0);
            //调用方法
            userServices.insert(user);
        }
        if("del".equals(oper))
        {
            //删除
            //调用方法
            userServices.delete(user.getId());
        }

        if("edit".equals(oper))
        {
            //修改
            //调用方法
            userServices.update(user);
        }

        //将用户添加到索引库
        userEsServices.addUser(user);

    }


    //添加用户
    @ResponseBody
    @RequestMapping("insert")
    public void insert(User user)
    {
        //设置用户id
        user.setId(0);
        //调用方法
        userServices.insert(user);

    }

    //模糊查询
    @ResponseBody
    @RequestMapping("likeselect")
    public List<User> likeSelect(User user)
    {
        return userServices.selectUser(user);
    }

    //删除
    @ResponseBody
    @RequestMapping("delete")
    public void delete(int id)
    {
        //调用业务
        userServices.delete(id);
    }

    //修改回显
    @ResponseBody
    @RequestMapping("selectid")
    public User selectid(int id)
    {
        //调用业务
        return userServices.selectid(id);
    }

    //修改
    @ResponseBody
    @RequestMapping("update")
    public void update(User user)
    {
        System.out.println(user+"-----修改进入------");
        //调用业务
         userServices.update(user);
    }


    //高亮查询

    @ResponseBody
    @RequestMapping("gaoliang")
    public List<User> gaoliang(String name)
    {
        List<User> list =new ArrayList<>();
        list.addAll(userEsServices.likeUser(name));
        if("".equals(name)|| name == null || list.size()==0)
        {
            User user=new User();
            user.setId(-1);
            user.setPassword("未找到数据");
            user.setState("未找到数据");
            user.setName("未找到数据");
            user.setBirthday("未找到数据");
            user.setCellphone("未找到数据");
            System.out.println("集合是的具体类型:"+(list.getClass()));
            System.out.println("user的值:"+user);
            list.add(user);
        }
        return list;
    }
}
