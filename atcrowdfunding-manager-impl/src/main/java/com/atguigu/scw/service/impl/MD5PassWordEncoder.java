package com.atguigu.scw.service.impl;

import com.atguigu.scw.utils.MD5Util;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

/**
 * @author Lee_engineer
 * @create 2020-05-24 16:30
 */
@Component
public class MD5PassWordEncoder implements PasswordEncoder {
    @Override
    public String encode(CharSequence charSequence) {
        return MD5Util.digest(charSequence.toString());
    }

    @Override
    public boolean matches(CharSequence rawPassword, String encodedPassword) {
        //将浏览器提交的密码进行加密
        String pwd = encode(rawPassword);
        //使用数据库密码和 提交的加密后的密码进行比较
        return pwd.equals(encodedPassword);
    }
}
