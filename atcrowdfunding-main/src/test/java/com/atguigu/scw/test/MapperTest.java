package com.atguigu.scw.test;

import com.atguigu.scw.mapper.TAdminMapper;
import com.atguigu.scw.utils.MD5Util;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * @author Lee_engineer
 * @create 2020-05-17 13:09
 */
@ContextConfiguration(locations = {"classpath:spring/spring-beans.xml","classpath:spring/spring-tx.xml","classpath:spring/spring-mybatis.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class MapperTest {
    @Autowired
    TAdminMapper tAdminMapper;
    @Test
    public void MapperTest(){

        System.out.println(tAdminMapper.countByExample(null));
    }

    @Test
    public void Md5Test(){

        //encodedPwd = e99a18c428cb38d5f260853678922e03
        String str = "admin";
        String encodedPwd = MD5Util.digest(str);
        System.out.println("encodedPwd = " + encodedPwd);

    }

}
