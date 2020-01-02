package com.baizhi.EsUtil;

import com.baizhi.entity.User;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;

//User类想es操作
//该类用于操作es泛型第一个参数是
public interface UserEsUtil extends ElasticsearchRepository<User,Integer> {
}
