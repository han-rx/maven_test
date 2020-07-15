package com.dj.ssm.controller.page;

import com.dj.ssm.pojo.User;
import com.dj.ssm.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user/")
@Controller
public class UserPageController {

    @Autowired
    private UserService userService;

    @RequestMapping("toShow")
    public String toShow() {
        return "user/show";
    }

    @RequestMapping("toUpdate")
    public String toUpdate(Integer id, Model model) {
        User user = userService.getById(id);
        model.addAttribute("user", user);
        return "user/update";
    }

    @RequestMapping("toAdd")
    public String toAdd() {
        return "user/add";
    }
}