package com.dj.ssm.pojo;

import lombok.Data;

import java.util.List;

@Data
public class UserQuery {

    private String userName;

    private Integer minAge;

    private Integer maxAge;

    private List<Integer> hobbys;

    private Integer pageNo;

    private Integer pageSize = 2;

    private List<User> list;
}
