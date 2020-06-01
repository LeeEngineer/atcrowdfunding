package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TPermission;
import com.atguigu.scw.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author Lee_engineer
 * @create 2020-05-22 22:40
 */
@Controller
@RequestMapping("/permission")
public class PermissionController {

    @Autowired
    PermissionService permissionService;

    @GetMapping("/index")
    public String toPermissionPage(){
        return "permission/permission";
    }

    @PostMapping("/getPermissions")
    @ResponseBody
    public List<TPermission> getPermissions(){
        return permissionService.getPermissions();
    }

    @PostMapping("/addPermission")
    @ResponseBody
    public String addPermission(TPermission permission){
        permissionService.addPermission(permission);
        return "ok";
    }

    @ResponseBody
    @PostMapping("/deletePermission")
    public String deletePermission(Integer id){
        permissionService.deletePermission(id);
        return "ok";
    }

    @ResponseBody
    @PostMapping("/getPermission")
    public TPermission getPermission(Integer id){
        return permissionService.getPermissionById(id);
    }

    @ResponseBody
    @PostMapping("/updatePermission")
    public String updatePermission(TPermission permission){
        permissionService.updatePermission(permission);
        return "ok";
    }

    @ResponseBody
    @PostMapping("/getPermissionIdsByRoleId")
    public List<Integer> getPermissionByRoleId(Integer roleId){

        return permissionService.getPermissionIdsByRoleId(roleId);
    }

    @ResponseBody
    @PostMapping("/assignPermission")
    public String assignPermission(Integer roleId,@RequestParam(value = "ids") List<Integer> ids){

        permissionService.assignPermission(roleId,ids);
        return "ok";

    }

}
