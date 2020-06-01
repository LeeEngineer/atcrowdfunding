package com.atguigu.scw.service.impl;

import com.atguigu.scw.bean.*;
import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.mapper.TAdminRoleMapper;
import com.atguigu.scw.mapper.TMenuMapper;
import com.atguigu.scw.service.AdminService;
import com.atguigu.scw.utils.MD5Util;
import com.atguigu.scw.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Lee_engineer
 * @create 2020-05-17 13:23
 */
@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    TAdminMapper tAdminMapper;


    @Override
    public TAdmin doLogin(String loginacct, String userpswd) {

        TAdminExample tAdminExample = new TAdminExample();
        tAdminExample.createCriteria().andLoginacctEqualTo(loginacct).andUserpswdEqualTo(MD5Util.digest(userpswd));
        //根据输入的账号密码查询数据库中有无此数据
        List<TAdmin> tAdmins = tAdminMapper.selectByExample(tAdminExample);
        if (tAdmins.isEmpty() || tAdmins.size() > 1) {
            return null;
        }
        return tAdmins.get(0);
    }

    @Autowired
    TMenuMapper menuMapper;

    @Override
    public List<TMenu> getMenus() {
        //查询所有菜单
        List<TMenu> menus = menuMapper.selectByExample(null);
        //创建map集合存放所有父菜单
        Map<Integer, TMenu> pMenus = new HashMap<>();
        for (TMenu menu : menus) {
            if (menu.getPid() == 0) {
                //遍历菜单找出所有父菜单并初始化其对应子菜单
                pMenus.put(menu.getId(), menu);
                menu.setChildren(new ArrayList<TMenu>());
            }
        }
        //遍历将父菜单的children属性赋值
        for (TMenu menu : menus) {
            TMenu pmenu = pMenus.get(menu.getPid());
            if (menu.getPid() != 0 && pmenu != null) {
                pmenu.getChildren().add(menu);
            }
        }
        //返回封装完毕的父菜单集合
        //将父菜单集合map的值转为list
        return new ArrayList<>(pMenus.values());
    }

    @Override
    //获取所有管理员信息
    public List<TAdmin> getAdmins(String condition) {
        TAdminExample exam = null;
        if (!StringUtil.isEmpty(condition)) {
            exam = new TAdminExample();
            TAdminExample.Criteria criteria1 = exam.createCriteria();
            criteria1.andLoginacctLike("%" + condition + "%");
            TAdminExample.Criteria criteria2 = exam.createCriteria();
            criteria2.andUsernameLike("%" + condition + "%");
            TAdminExample.Criteria criteria3 = exam.createCriteria();
            criteria3.andEmailLike("%" + condition + "%");
            exam.or(criteria1);
            exam.or(criteria2);
            exam.or(criteria3);
        }
        return tAdminMapper.selectByExample(exam);
    }

    @Override
    public void deleteAdminById(Integer id) {

        tAdminMapper.deleteByPrimaryKey(id);

    }

    @Override
    public void saveAdmin(TAdmin admin) {

        TAdminExample exam = new TAdminExample();
        exam.createCriteria().andLoginacctEqualTo(admin.getLoginacct());
        long count = tAdminMapper.countByExample(exam);
        if (count > 0){//账号已存在
            throw new RuntimeException("您输入的账号已存在");
        }
        exam.clear();//清空条件
        exam.createCriteria().andEmailEqualTo(admin.getEmail());
        count = tAdminMapper.countByExample(exam);
        if (count > 0){//邮箱已存在
            throw new RuntimeException("您输入的邮箱已存在");
        }
        admin.setUserpswd(MD5Util.digest(admin.getUserpswd()));
        tAdminMapper.insertSelective(admin);

    }

    @Override
    public TAdmin getAdminById(Integer id) {
        return tAdminMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateAdmin(TAdmin admin) {
        tAdminMapper.updateByPrimaryKeySelective(admin);
    }

    @Override
    public void batchDelete(List<Integer> ids) {
        TAdminExample exa = new TAdminExample();
        exa.createCriteria().andIdIn(ids);
        tAdminMapper.deleteByExample(exa);
    }

    @Autowired
    TAdminRoleMapper adminRoleMapper;

    @Override
    public void assignRole(List<Integer> ids,Integer adminId) {
        adminRoleMapper.batchAssignRole(ids,adminId);
    }

    @Override
    public void unAssignRole(List<Integer> roleIds, Integer adminId) {
        TAdminRoleExample exa = new TAdminRoleExample();
        exa.createCriteria().andAdminidEqualTo(adminId).andRoleidIn(roleIds);
        adminRoleMapper.deleteByExample(exa);
    }

}
