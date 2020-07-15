package com.dj.ssm.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * 用户
 */
@Data // lombok注解
@TableName("user") // 实体类对应数据库表名
public class User {

    @TableId(type = IdType.AUTO)// 主键策略
    private Integer id;

    /**
     * 用户名
     */
    private String userName;

    private String userPwd;

    private Integer userAge;

    private String classRoom;

    private Integer hobbys;

    // Jackson 日期转化主键
//    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", locale = "zh", timezone = "GMT+8")
    //@TableField("create_time") // 字段名与数据库名不一致时使用,等同于Mybatis下划线自动转驼峰，二者取其一即可
//    private Date createTime;

}
