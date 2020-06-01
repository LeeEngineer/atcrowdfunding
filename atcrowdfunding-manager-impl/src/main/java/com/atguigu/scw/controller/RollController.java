package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author Lee_engineer
 * @create 2020-05-19 21:03
 */
@Controller
@RequestMapping("/role")
public class RollController {

    @Autowired
    RoleService roleService;

    //跳转至role页面
    @GetMapping("/index")
    public String toRolePage(){
        return "role/role";
    }

    //根据页码及条件查询角色
    @ResponseBody
    @GetMapping("/getRoles")
    public PageInfo<TRole> getRoles(@RequestParam(defaultValue = "1",required = false) Integer pageNum, String condition){
        //开始分页查询
        PageHelper.startPage(pageNum,3);
        //根据条件查询角色
        List<TRole> roles = roleService.queryRoles(condition);
        PageInfo<TRole> pageInfo = new PageInfo<>(roles,3);
        //返回分页对象
        return pageInfo;
    }

    @ResponseBody
    @PostMapping("/addRole")
    public String addRole(TRole role){
        try {
            roleService.addRole(role);
        } catch (Exception e) {
//            e.printStackTrace();
            return "add role fail";
        }
        return "ok";
    }

    @ResponseBody
    @PostMapping("/deleteRole")
    public String deleteRole(Integer id){
        roleService.deleteRole(id);
        return "ok";
    }

    @ResponseBody
    @PostMapping("/deleteRoles")
    public String deleteRoles(@RequestParam("ids") List<Integer> ids){
        roleService.batchDeleteRoles(ids);
        return "ok";

    }

    @ResponseBody
    @PostMapping("/updateRole")
    public String updateRole(TRole role){
        roleService.updateRole(role);
        return "ok";
    }

    @GetMapping("/assignPermission")
    public String toRolePermissionPage(Integer id){
        return "role/assignPermission";
    }
}
