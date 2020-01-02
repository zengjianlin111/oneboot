package com.baizhi.entity;

import org.springframework.data.annotation.Id;
import org.springframework.data.elasticsearch.annotations.Document;
import org.springframework.data.elasticsearch.annotations.Field;
import org.springframework.data.elasticsearch.annotations.FieldType;

import java.io.Serializable;
import java.lang.annotation.Documented;

/*
    用户表
     create table User(
	id int  PRIMARY key auto_increment, //id自增长
	name VARCHAR(20),                   //姓名
	password VARCHAR(20),               //密码
	birthday varchar(20),               //生日
	cellphone varchar(20),              //电话
	state varchar(20)                   //状态
)
*/
//声明该对应可以应用es  indexName值是所有名   type  映射名
@Document(indexName = "users",type = "user")
public class User implements Serializable {
    @Id
    private int id;   //id
    @Field(type = FieldType.Text,analyzer = "ik_max_word",searchAnalyzer = "ik_max_word")
    private String name;  //姓名
    @Field(type = FieldType.Text,analyzer = "ik_max_word",searchAnalyzer = "ik_max_word")
    private String password;  //密码
    @Field(type = FieldType.Text,analyzer = "ik_max_word",searchAnalyzer = "ik_max_word")
    private String birthday;  //生日
    @Field(type = FieldType.Text,analyzer = "ik_max_word",searchAnalyzer = "ik_max_word")
    private String cellphone; //电话
    @Field(type = FieldType.Text,analyzer = "ik_max_word",searchAnalyzer = "ik_max_word")
    private String state;     //状态

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", password='" + password + '\'' +
                ", birthday='" + birthday + '\'' +
                ", cellphone='" + cellphone + '\'' +
                ", state='" + state + '\'' +
                '}';
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getCellphone() {
        return cellphone;
    }

    public void setCellphone(String cellphone) {
        this.cellphone = cellphone;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public User() {
    }

    public User(int id, String name, String password, String birthday, String cellphone, String state) {
        this.id = id;
        this.name = name;
        this.password = password;
        this.birthday = birthday;
        this.cellphone = cellphone;
        this.state = state;
    }
}
