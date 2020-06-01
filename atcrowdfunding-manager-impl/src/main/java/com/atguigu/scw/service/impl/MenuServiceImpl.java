package com.atguigu.scw.service.impl;

import com.atguigu.scw.bean.TMenu;
import com.atguigu.scw.mapper.TMenuMapper;
import com.atguigu.scw.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Lee_engineer
 * @create 2020-05-21 14:38
 */
@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    TMenuMapper menuMapper;
    @Override
    public List<TMenu> getMenus() {
        return menuMapper.selectByExample(null);
    }

    @Override
    public void addMenu(TMenu menu) {
        menuMapper.insertSelective(menu);
    }

    @Override
    public void deleteMenu(Integer id) {
        menuMapper.deleteByPrimaryKey(id);
    }

    @Override
    public TMenu getMenu(Integer id) {
        return menuMapper.selectByPrimaryKey(id);
    }

    @Override
    public void updateMenu(TMenu menu) {
        menuMapper.updateByPrimaryKeySelective(menu);
    }
}
