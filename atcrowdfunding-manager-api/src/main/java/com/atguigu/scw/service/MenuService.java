package com.atguigu.scw.service;

import com.atguigu.scw.bean.TMenu;

import java.util.List;

/**
 * @author Lee_engineer
 * @create 2020-05-21 14:37
 */
public interface MenuService {

    public List<TMenu> getMenus();

    void addMenu(TMenu menu);

    void deleteMenu(Integer id);

    TMenu getMenu(Integer id);

    void updateMenu(TMenu menu);
}
