package com.atguigu.scw.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * @author Lee_engineer
 * @create 2020-05-17 13:49
 */
public class AppStartupListener implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {

        System.out.println("项目启动成功");
        //将全局上下文路径存在application对象中 方便页面中使用
        servletContextEvent.getServletContext().setAttribute("PATH" ,
                servletContextEvent.getServletContext().getContextPath());

    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
