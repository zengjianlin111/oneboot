package com.baizhi.services.impl;

import com.baizhi.dao.StuDao;
import com.baizhi.entity.Stu;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class StuServicesImpl {

    @Autowired
    private StuDao stuDao;

    public List<Stu> select()
    {
        return stuDao.selectall();
    }
}
