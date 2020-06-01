package com.atguigu.scw.service;

import com.atguigu.scw.bean.TPermission;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Lee_engineer
 * @create 2020-05-22 23:01
 */
public interface PermissionService {
    List<TPermission> getPermissions();

    void addPermission(TPermission permission);

    void deletePermission(Integer id);

    TPermission getPermissionById(Integer id);

    void updatePermission(TPermission permission);

    List<Integer> getPermissionIdsByRoleId(Integer roleId);

    void assignPermission(Integer roleId, List<Integer> ids);
}
