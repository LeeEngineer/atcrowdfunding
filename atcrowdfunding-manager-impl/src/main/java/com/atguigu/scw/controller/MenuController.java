package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author Lee_engineer
 * @create 2020-05-21 13:58
 */
@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    MenuService menuService;

    @GetMapping("/index")
    public String toMenuPage(){
        return "menus/menu";
    }

    @ResponseBody
    @GetMapping("/getMenus")
    public List<TMenu> getMenus(){
        return menuService.getMenus();
    }

    @ResponseBody
    @PostMapping("/addMenu")
    public String addMenu(TMenu menu){
        menuService.addMenu(menu);
        return "ok";
    }

    @ResponseBody
    @PostMapping("/deleteMenu")
    public String deleteMenu(Integer id){
        menuService.deleteMenu(id);
        return "ok";
    }

    @ResponseBody
    @PostMapping("/getMenu")
    public TMenu getMenu(Integer id){
        return menuService.getMenu(id);
    }

    @ResponseBody
    @PostMapping("/updateMenu")
    public String updateMenu(TMenu menu){
        menuService.updateMenu(menu);
        return "ok";
    }
}
