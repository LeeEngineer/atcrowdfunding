package com.atguigu.scw.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Lee_engineer
 * @create 2020-05-17 10:04
 */
@Controller
public class DIspatcherController {
    //转发到主页
    @GetMapping(value = {"/","/index","index.html"})
    public String toIndex(){
        return "index";
    }

    @GetMapping("/login.html")
    public String toLoginPage(){
        return "login";
    }
}
