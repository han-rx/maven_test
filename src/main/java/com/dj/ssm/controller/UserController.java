package com.dj.ssm.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dj.ssm.pojo.ResultModel;
import com.dj.ssm.pojo.User;
import com.dj.ssm.pojo.UserQuery;
import com.dj.ssm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@CrossOrigin
@RestController
@RequestMapping("/user/")
public class UserController {

    @Autowired
    private UserService userService;

    Integer bb = 223;
    String aa = "zss";

    int s;

    String str;

    int v;
    double c;

    @RequestMapping("show")
    public ResultModel show(UserQuery userQuery) {
        try {
            Map<String, Object> m = new HashMap<>();
            IPage<User> page =new Page<> (userQuery.getPageNo(),userQuery.getPageSize());
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            if(userQuery.getUserName() != null && userQuery.getUserName() != "" ){
                queryWrapper.like("user_name",userQuery.getUserName());
            }
            if(null != userQuery.getHobbys() && !userQuery.getHobbys().isEmpty()) {
                queryWrapper.in("hobbys",userQuery.getHobbys());
            }
            if(userQuery.getMinAge() != null){
                queryWrapper.or().ge("user_age",userQuery.getMinAge());
            }
            if(userQuery.getMaxAge() != null){
                queryWrapper.or().le("user_age",userQuery.getMaxAge());
            }
            IPage<User> pageInfo = userService.page(page,queryWrapper);
            List<Map<String, Object>> list = new ArrayList<>();
            for (User u : pageInfo.getRecords()) {
                Map<String, Object> map = new HashMap<>();
                map.put("id", u.getId());
                map.put("userName", u.getUserName());
                map.put("userPwd", u.getUserPwd());
                map.put("userAge", u.getUserAge());
                String a = "";
                if (u.getHobbys() == 0) {
                    a = "游戏";
                }
                if (u.getHobbys() == 1) {
                    a = "羽毛球";
                }
                if (u.getHobbys() == 2) {
                    a = "足球";
                }
                if (u.getHobbys() == 3) {
                    a = "篮球";
                }
                if (u.getHobbys() == 4) {
                    a = "跑步";
                }
                map.put("hobby", a);
                map.put("classRoom", u.getClassRoom());
                list.add(map);
            }
//            m.put("userList", pageInfo.getRecords());
            m.put("pages", pageInfo.getPages());
            m.put("m",list);
            return new ResultModel().success(m);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error("服务器异常,请稍后重试");
        }
    }

    @RequestMapping("userUpdate")
    public ResultModel userUpdate(User user) {
        try {
            userService.updateById(user);
            return new ResultModel().success();
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error("服务器异常,请稍后重试");
        }
    }

    @RequestMapping("del")
    public ResultModel del(@RequestParam("ids[]") Integer[] ids) {
        try {
            List<Integer> list = Arrays.asList(ids);
            userService.removeByIds(list);
            return new ResultModel().success();
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error("服务器异常,请稍后重试");
        }
    }

    @RequestMapping("add")
    public ResultModel add(UserQuery userQuery) {
        try {
            List<User> list = new ArrayList<>();
            for (User u: userQuery.getList()) {
                if (null == u.getUserName() || u.getUserName().equals("")) {
                    continue;
                }
                list.add(u);
            }
            userService.saveBatch(list);
            return new ResultModel().success();
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error("服务器异常,请稍后重试");
        }
    }

    @GetMapping("get")
    public ResultModel get(Integer id) {
        try {
            User user = userService.getById(id);
            return new ResultModel().success(user);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error(e.getMessage());
        }
    }

    @RequestMapping("list")
    public ResultModel list() {
        try {
            QueryWrapper<User> queryWrapper = new QueryWrapper<>();
            List<User> userList = userService.list(queryWrapper);
            return new ResultModel().success(userList);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResultModel().error("服务器异常,请稍后重试");
        }
    }
}
