package com.baizhi.Custom.impl;

import com.baizhi.Custom.UserEsServices;
import com.baizhi.EsUtil.UserEsUtil;
import com.baizhi.dao.UserDao;
import com.baizhi.entity.User;
import com.baizhi.services.UserServices;
import com.baizhi.services.impl.UserServicesImpl;
import org.elasticsearch.action.search.SearchResponse;
import org.elasticsearch.index.query.QueryBuilders;
import org.elasticsearch.search.SearchHit;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightBuilder;
import org.elasticsearch.search.fetch.subphase.highlight.HighlightField;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.core.ElasticsearchTemplate;
import org.springframework.data.elasticsearch.core.SearchResultMapper;
import org.springframework.data.elasticsearch.core.aggregation.AggregatedPage;
import org.springframework.data.elasticsearch.core.aggregation.impl.AggregatedPageImpl;
import org.springframework.data.elasticsearch.core.query.NativeSearchQuery;
import org.springframework.data.elasticsearch.core.query.NativeSearchQueryBuilder;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Repository
public class UserEsServicesImpl implements UserEsServices {

    //自动注入工具类型对象
    @Autowired
    private UserEsUtil  userEsUtil;

    //注入自定义查询对象
    @Autowired
    private ElasticsearchTemplate elasticsearchTemplate;

    //自动注入services
    @Autowired
    private UserDao userDao;

    //将user表中的数据添加到es中  id name password
    @Override
    public void inserEsAll() {
        //调用数据的service中的方法将所有的数据
        //调用查询所有的方法
        List<User> list = userDao.selectAll();
        //遍历集合将集合中的数据存入es中
        for (User user : list) {
            //调用操作对象的方法
            userEsUtil.save(user);
        }
    }

    //通过指定内容高亮查询
    @Override
    public List<User> likeUser(String name) {
        //高亮查询对象
        HighlightBuilder.Field field = new HighlightBuilder.Field("*")  //所有字段都高亮
                            .preTags("<font color='red'>")  //高亮前缀
                            .postTags("</font>")      //高亮后缀
                            .requireFieldMatch(false);  //关闭默认只查询一个
        //查询条件对象
        NativeSearchQuery build = new NativeSearchQueryBuilder().withIndices("users")  //指定索引
                .withTypes("user")  //指定映射
                .withQuery(QueryBuilders.termQuery("name", name)) //关键字查询
                .withHighlightFields(field)   //高亮
                .build();//结束
//通过高级查询对象 参数1是查询的添加包装对象 参数二是实体类的类对象 最后一个参数的 高亮后面的结果操作
        AggregatedPage<User> users = elasticsearchTemplate.queryForPage(build, User.class, new SearchResultMapper() {
            //第一个参数是 查询返回的结果  第二个参数实体类类对象
            @Override
            public <T> AggregatedPage<T> mapResults(SearchResponse searchResponse, Class<T> aClass, Pageable pageable) {
                //定义一个集合用于返回数据
                ArrayList<User> arrayList = new ArrayList<>();
                //将数据取出
                SearchHit[] hits = searchResponse.getHits().getHits();
                //遍历数据
                for (SearchHit hit : hits) {
                    //创建一个实体类对象用于临时存储数据
                    User user = new User();
                    //将元数据区的东西取出 前面键是字段名 后面的 值是对应的没有高亮之前的值
                    Map<String, Object> sourceAsMap = hit.getSourceAsMap();
                    //将高亮区的数据取出 前面的键是字段名 后面的值是高亮后的数据
                    Map<String, HighlightField> highlightFields = hit.getHighlightFields();


                    //判断元数据区是否有name字段
                    if (sourceAsMap.get("name") != null) {
                        //判断高亮数据是否不为null
                        if (highlightFields.get("name") != null) {
                            //数据不为null将数据存入
                            user.setName(highlightFields.get("name").getFragments()[0].toString());
                        }
                    }

                    //设置其他字段判断
                    //id
                    if (sourceAsMap.get("id") != null) {
                        //设置id
                        user.setId((Integer) sourceAsMap.get("id"));
                    }

                    //pwssword
                    if (sourceAsMap.get("pwssword") != null) {
                        //设置pwssword
                        user.setPassword((String) sourceAsMap.get("pwssword"));
                    }//birthday
                    if (sourceAsMap.get("birthday") != null) {
                        //设置birthday
                        user.setBirthday((String) sourceAsMap.get("birthday"));
                    }//cellphone
                    if (sourceAsMap.get("cellphone") != null) {
                        //设置cellphone
                        user.setCellphone((String) sourceAsMap.get("cellphone"));
                    }//id
                    if (sourceAsMap.get("id") != null) {
                        //设置id
                        user.setId((Integer) sourceAsMap.get("id"));
                    }
                    //state
                    if (sourceAsMap.get("state") != null) {
                        //设置id
                        user.setState((String) sourceAsMap.get("state"));
                    }
                    //将数据添加到集合
                    arrayList.add(user);
                }
                //需要创建一个AggregatedPageImpl<T>对象
                return new AggregatedPageImpl<>((List<T>) arrayList);
            }

            @Override
            public <T> T mapSearchHit(SearchHit searchHit, Class<T> aClass) {
                return null;
            }
        });
        //返回结果
        return users.getContent();
    }

    //添加到索引库
    @Override
    public void addUser(User user) {
        userEsUtil.save(user);
    }
}
