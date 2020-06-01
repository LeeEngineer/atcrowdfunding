package com.atguigu.scw.service.impl;

import com.atguigu.scw.bean.TAdminRole;
import com.atguigu.scw.bean.TAdminRoleExample;
import com.atguigu.scw.bean.TRole;
import com.atguigu.scw.bean.TRoleExample;
import com.atguigu.scw.mapper.TAdminRoleMapper;
import com.atguigu.scw.mapper.TRoleMapper;
import com.atguigu.scw.service.RoleService;
import com.atguigu.scw.utils.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;

/**
 * @author Lee_engineer
 * @create 2020-05-19 21:30
 */
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    TRoleMapper roleMapper;

    @Override
    public List<TRole> queryRoles(String condition) {
        TRoleExample exam = null;
        if (!StringUtil.isEmpty(condition)) {
            System.out.println(1);
            exam = new TRoleExample();
            exam.createCriteria().andNameLike("%" + condition + "%");
        }
        return roleMapper.selectByExample(exam);
    }

    @Override
    public void addRole(TRole role) {
        TRoleExample exam = new TRoleExample();
        exam.createCriteria().andNameEqualTo(role.getName());
        long count = roleMapper.countByExample(exam);
        if (count > 0){
            throw new RuntimeException("用户名已存在");
        }else {
            roleMapper.insertSelective(role);
        }
    }

    @Override
    public void updateRole(TRole role) {
        roleMapper.updateByPrimaryKey(role);
    }

    @Autowired
    TAdminRoleMapper adminRoleMapper;
    @Override
    public List<Integer> getAssignedRoles(Integer id) {
        TAdminRoleExample exa = new TAdminRoleExample();
        exa.createCriteria().andAdminidEqualTo(id);
        List<TAdminRole> adminRoles = adminRoleMapper.selectByExample(exa);
        List<Integer> ids = new ArrayList<>();
        if (!CollectionUtils.isEmpty(adminRoles)){
            for (TAdminRole adminRole : adminRoles) {
                ids.add(adminRole.getRoleid());
            }
        }
        return ids;
    }

    @Override
    public void batchDeleteRoles(List<Integer> ids) {

        TRoleExample exam = new TRoleExample();
        exam.createCriteria().andIdIn(ids);
        roleMapper.deleteByExample(exam);

    }

    @Override
    public void deleteRole(Integer id) {
        roleMapper.deleteByPrimaryKey(id);
    }
}
