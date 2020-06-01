package com.atguigu.scw.service;

import com.atguigu.scw.bean.TRole;

import java.util.List;

/**
 * @author Lee_engineer
 * @create 2020-05-19 21:28
 */
public interface RoleService {

    public List<TRole> queryRoles(String condition);

    void addRole(TRole role);

    void deleteRole(Integer id);

    void batchDeleteRoles(List<Integer> ids);

    void updateRole(TRole role);

    List<Integer> getAssignedRoles(Integer id);
}
