package com.baizhi.services;

import com.baizhi.entity.Stu;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public interface StuServices {
    //查询所有
    public List<Stu> servlte();
}
