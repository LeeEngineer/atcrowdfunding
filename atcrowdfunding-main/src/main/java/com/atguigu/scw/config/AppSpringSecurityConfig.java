package com.atguigu.scw.config;

import com.atguigu.scw.service.impl.MD5PassWordEncoder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * @author Lee_engineer
 * @create 2020-05-22 21:30
 */
@EnableWebSecurity//启用security的web功能
@EnableGlobalMethodSecurity(prePostEnabled = true)//启用注解进行权限控制功能
@Configuration
public class AppSpringSecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    UserDetailsService userDetailsService;
    @Autowired
    MD5PassWordEncoder passWordEncoder;

    //授权:处理登录、注销、其他的访问路径资源的  权限要求
    @Override
    protected void configure(HttpSecurity http) throws Exception {

        //1、授权首页+静态资源+登录页面 任何人都可以访问
        http.authorizeRequests().antMatchers("/","/index","/static/**","/login.html")
                .permitAll() //配置浏览器访问首页的地址
//                .antMatchers("/admin/user").hasAnyRole("admin")//配置部分请求需要的权限、角色
                .anyRequest().authenticated();//配置其他的任意请求都需要授权认证
        //2、SpringSecurity管理登陆,以下配置需要和登录页面的配置一致，取代AdminController的login方法
        http.formLogin().loginPage("/login.html")//指定登录页面
                .loginProcessingUrl("/admin/login")//指定处理登录请求的url,表单提交方式为post
                .usernameParameter("loginacct")//指定浏览器提交登录请求的账号参数
                .passwordParameter("userpswd")//指定浏览器提交登录请求的密码参数
                .successForwardUrl("/admin/main.html");//指定登录成功后要跳转的地址

        http.logout().logoutUrl("/admin/logout")//注销的url地址  , 页面必须以post方式提交注销请求
                .logoutSuccessUrl("/");//注销成功之后的跳转地址
                //取消csrf：防止跨站点攻击
                http.csrf().disable();//SpringSecurity认为提交表单请求可能会被攻击，默认加上csrf验证

        //当访问未授权页面时的异常处理
        http.exceptionHandling().accessDeniedHandler(new AccessDeniedHandler() {
            @Override
            public void handle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AccessDeniedException e) throws IOException, ServletException {
                //处理403的方法
                //判断请求时异步还是同步
                //异步请求报文请求头中携带参数：X-Requested-With: XMLHttpRequest
                if ("XMLHttpRequest".equals(httpServletRequest.getHeader("X-Requested-With"))){
                    //异步请求，不需要相应整个页面，只需要相应状态即可
                    httpServletResponse.getWriter().write("fail");
                }else {
                    String msg = e.getMessage();//获取异常信息
                    httpServletRequest.setAttribute("errorMsg",msg);//放入域中在页面显示
                    httpServletRequest.getRequestDispatcher("/WEB-INF/pages/error/403.jsp")
                            .forward(httpServletRequest,httpServletResponse);
                }


            }
        });

    }

    //认证
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {

        //authorities() 给内存账号添加权限列表
        //roles() 给内存行号添加角色列表   底层也是调用authorities()来实现，但是会在roles方法中传入的每一个参数前拼接前缀"ROLE_"
//        auth.inMemoryAuthentication()
//                .withUser("zhangsan").password("123456").authorities("user:add","menu:del")
//                .and()
//                .withUser("anni").password("123456").roles("admin");
        auth.userDetailsService(userDetailsService).passwordEncoder(passWordEncoder);
    }

}
