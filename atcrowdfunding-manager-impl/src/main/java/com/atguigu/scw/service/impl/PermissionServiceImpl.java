package com.atguigu.scw.service.impl;

import com.atguigu.scw.bean.TPermission;
import com.atguigu.scw.bean.TPermissionExample;
import com.atguigu.scw.bean.TRolePermission;
import com.atguigu.scw.bean.TRolePermissionExample;
import com.atguigu.scw.mapper.TPermissionMapper;
import com.atguigu.scw.mapper.TRolePermissionMapper;
import com.atguigu.scw.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;

import java.util.List;

/**
 * @author Lee_engineer
 * @create 2020-05-22 23:02
 */
@Controller
public class PermissionServiceImpl implements PermissionService {

    @Autowired
    TPermissionMapper permissionMapper;
    @Autowired
    TRolePermissionMapper rolePermissionMapper;

    @Override
    public List<TPermission> getPermissions() {
        return permissionMapper.selectByExample(null);
    }

    @Override
    public void addPermission(TPermission permission) {
        permissionMapper.insertSelective(permission);
    }

    @Override
    public void deletePermission(Integer id) {
        permissionMapper.deleteByPrimaryKey(id);
    }

    @Override
    public TPermission getPermissionById(Integer id) {
        return permissionMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updatePermission(TPermission permission) {
        permissionMapper.updateByPrimaryKeySelective(permission);
    }

    @Override
    public List<Integer> getPermissionIdsByRoleId(Integer roleId) {

        return rolePermissionMapper.getPermissionIdsByRoleId(roleId);

    }

    @Override
    public void assignPermission(Integer roleId, List<Integer> ids) {

        //清空roleId原权限
        TRolePermissionExample exa = new TRolePermissionExample();
        exa.createCriteria().andRoleidEqualTo(roleId);
        rolePermissionMapper.deleteByExample(exa);
        if (CollectionUtils.isEmpty(ids)){
            return;
        }
        //增加权限
        rolePermissionMapper.batchAssignPermissions(roleId,ids);

    }
}
