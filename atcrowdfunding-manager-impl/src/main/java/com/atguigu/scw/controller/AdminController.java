package com.atguigu.scw.controller;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.service.AdminService;
import com.atguigu.scw.service.RoleService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Lee_engineer
 * @create 2020-05-17 13:20
 */
@Controller
@RequestMapping("/admin")
public class AdminController {

    @Autowired
    AdminService adminService;

    //注销
/*    @GetMapping("/logout")
    public String doLogout(HttpSession session) {
        session.invalidate();
        return "redirect:/index";
    }*/

    //登陆(使用SpringSecurity管理登陆)
/*    @PostMapping("/login")
    public String doLogin(Mrodel model, HttpSession httpSession, String loginacct, String userpswd) {
        //查询账户是否存在
        TAdmin admin = adminService.doLogin(loginacct, userpswd);
        if (admin == null) {
            //保存登陆失败在页面回显
            model.addAttribute("errorMsg", "您输入的账号或密码错误");
            model.addAttribute("loginacct", loginacct);
            //登陆失败
            return "login";
        }
        //登录成功
        //将管理员对象存到session
        httpSession.setAttribute("admin", admin);
        return "redirect:/admin/main.html";
    }*/

    //跳转至管理页面
    @PostMapping("/main.html")
    public String toMainPage(HttpSession session) {
        //查询菜单集合并存入session域中
        List<TMenu> pmenus = adminService.getMenus();
        session.setAttribute("pmenus", pmenus);
        return "admin/main";
    }

    //获取所有管理员信息
    @GetMapping("/index")
    public String getAdmins(HttpSession session, Model model, String condition, @RequestParam(required = false, defaultValue = "1") Integer pageNum) {
        //开启分页查询，使用mybatis的interceptor拦截器自动分页查询
        //参数1：pageNum 需要查询分页数据的页码
        //参数2： pageSize 每一页分页要显示几条记录
        PageHelper.startPage(pageNum, 2);
        List<TAdmin> admins = adminService.getAdmins(condition);
        //pageInfo包含分页数据集合和分页导航栏需要使用的页码信息
        PageInfo<TAdmin> pageInfo = new PageInfo<>(admins, 3);
        model.addAttribute("pageInfo", pageInfo);
        session.setAttribute("totalPage", pageInfo.getPages());
        return "admin/user";
    }

    //删除单个管理员信息
    @GetMapping("/deleteAdmin")
    public String deleteAdminById(Integer id, Integer pageNum) {
        adminService.deleteAdminById(id);
        return "redirect:/admin/user?pageNum=" + pageNum;
    }

    //跳转到添加用户页面
    @GetMapping("/add.html")
    public String toAddPage() {
        return "admin/add";
    }

    //添加用户
    @PostMapping("/addAdmin")
    public String addAdmin(HttpSession session, TAdmin admin, Model model) {
        try {
            adminService.saveAdmin(admin);
        } catch (Exception e) {
//            e.printStackTrace();
            //添加用户失败，返回添加页面并回显错误信息
            model.addAttribute("errorMsg", e.getMessage());
            return "admin/add";
        }
        //添加成功，跳转至用户显示页面
        Integer totalPage = (Integer) session.getAttribute("totalPage");
        return "redirect:/admin/user?pageNum=" + (totalPage + 1);
    }

    //跳转至用户信息编辑页面
    @GetMapping("/edit.html")
    public String toEditPage(Integer id,Model model, @RequestHeader("referer") String ref,HttpSession session){
        //查询要修改的管理员信息
        TAdmin admin = adminService.getAdminById(id);
        //将查到的管理员信息放入request域中
        model.addAttribute("admin",admin);
        //将进入编辑页面前的地址存入session域，方便信息更新完后跳回之前页面
        session.setAttribute("ref",ref);
        //转发到edit页面
        return "admin/edit";
    }

    @PostMapping("/updateAdmin")
    public String updateAdmin(TAdmin admin,HttpSession session){
        adminService.updateAdmin(admin);
        String ref = (String) session.getAttribute("ref");
        //跳转回之前页面
        return "redirect:" + ref;
    }

    @GetMapping("/batchDelete")
    public String batchDelete(@RequestParam("ids") List<Integer> ids){
        adminService.batchDelete(ids);
        return "redirect:/admin/user";
    }

    @Autowired
    RoleService roleService;

    @GetMapping("/assignRole")
    public String toAssignRolePage(Model model,Integer id){
        //查询所有角色
        List<TRole> allRoles= roleService.queryRoles(null);
        List<Integer> assignedRoleIds = roleService.getAssignedRoles(id);
        List<TRole> assignedRoles = new ArrayList<>();
        List<TRole> unAssignedRoles = new ArrayList<>();
        //遍历将已分配角色和未分配角色分别放入对应集合
        if (!CollectionUtils.isEmpty(assignedRoleIds)) {
            for (TRole role : allRoles) {
               if (assignedRoleIds.contains(role.getId())){
                   assignedRoles.add(role);
               }else {
                   unAssignedRoles.add(role);
               }
            }
        }
        //将查询到的数据放入域中
        model.addAttribute("assignedRoles",assignedRoles);
        model.addAttribute("unAssignedRoles",unAssignedRoles);
        return "admin/assignRole";
    }

    @ResponseBody
    @PostMapping("/assignRole")
    public String assignRole(@RequestParam("ids") List<Integer> ids,Integer adminId){
        adminService.assignRole(ids,adminId);
        return "ok";
    }

    @ResponseBody
    @PostMapping("/unAssignRole")
    public String unAssignRole(@RequestParam("roleIds") List<Integer> roleIds,Integer adminId){
        adminService.unAssignRole(roleIds,adminId);
        return "ok";
    }
}