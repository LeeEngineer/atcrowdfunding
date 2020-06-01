package com.atguigu.scw.service;

import com.atguigu.scw.bean.TAdmin;
import com.atguigu.scw.bean.TMenu;

import java.util.List;

/**
 * @author Lee_engineer
 * @create 2020-05-17 13:26
 */
public interface AdminService {
    //登陆
    public TAdmin doLogin(String loginacct,String userpswd);
    //获取菜单
    public List<TMenu> getMenus();
    //获取所有管理员信息
    public List<TAdmin> getAdmins(String condition);
    //根据id删除管理员
    public void deleteAdminById(Integer id);
    //新增用户
    public void saveAdmin(TAdmin admin);
    //根据id查询管理员信息
    public TAdmin getAdminById(Integer id);
    //更新管理员信息
    public void updateAdmin(TAdmin admin);
    //批量删除管理员
    public void batchDelete(List<Integer> ids);
    //批量删除用户角色
    void assignRole(List<Integer> ids,Integer adminId);

    void unAssignRole(List<Integer> roleIds, Integer adminId);
}
