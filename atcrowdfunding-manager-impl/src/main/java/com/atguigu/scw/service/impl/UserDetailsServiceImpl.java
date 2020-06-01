package com.atguigu.scw.service.impl;

import com.atguigu.scw.bean.*;
import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.mapper.TPermissionMapper;
import com.atguigu.scw.mapper.TRoleMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Lee_engineer
 * @create 2020-05-24 15:05
 */
@Service
public class UserDetailsServiceImpl implements UserDetailsService {
    @Autowired
    TAdminMapper adminMapper;
    @Autowired
    TRoleMapper roleMapper;
    @Autowired
    TPermissionMapper permissionMapper;

    @Override
    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {
        //1、根据账号查询登录的用户信息
        TAdminExample exa = new TAdminExample();
        exa.createCriteria().andLoginacctEqualTo(s);
        List<TAdmin> admins = adminMapper.selectByExample(exa);
        if (CollectionUtils.isEmpty(admins)) {
            //账号不存在
            return null;
        }
        //获取加载成功的用户对象
        TAdmin admin = admins.get(0);
        //2、根据登录成功的用户的id查询该用户的角色和权限的列表
        //查询adminid对应的role的name的列表
        List<TRole> roles = roleMapper.selectRolesByAdminId(admin.getId());
        //查询adminid对应的role的permission的name的列表
        //存储权限和角色信息
        ArrayList<GrantedAuthority> authorities = new ArrayList<>();
        for (TRole role : roles) {
            authorities.add(new SimpleGrantedAuthority("ROLE_" + role.getName()));
        }
        //查询权限的name列表并且设置到权限集合中
        List<String> permissionNames = permissionMapper.selectPermissionsByAdminId(admin.getId());
        for (String permissionName : permissionNames) {
            authorities.add(new SimpleGrantedAuthority(permissionName));
        }
        //3、将以上信息创建主体对象返回
        return new User(admin.getLoginacct(),admin.getUserpswd(),authorities);
    }
}
