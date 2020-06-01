<%--
  Created by IntelliJ IDEA.
  User: 45847
  Date: 2020/5/17
  Time: 13:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <%--  静态引入css样式  --%>
    <%@include file="/WEB-INF/common/base_css.jsp"%>
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div class="container">

    <form class="form-signin" role="form" method="post" action="${PATH}/admin/login">
        <span>${SPRING_SECURITY_LAST_EXCEPTION.message}</span>
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户登录</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="inputSuccess4" name="loginacct" placeholder="请输入登录账号" value="${requestScope.loginacct}" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="inputSuccess4" name="userpswd" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <span style="color: red">${requestScope.errorMsg}</span>
        <div class="form-group has-success has-feedback">
            <select class="form-control" >
                <option value="member">会员</option>
                <option value="user" selected>管理</option>
            </select>
        </div>
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> 记住我
            </label>
            <br>
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="reg.html">我要注册</a>
            </label>
        </div>
        <button class="btn btn-lg btn-success btn-block" type="submit" > 登录</button>
    </form>
</div>
<%--静态引入js--%>
<%@include file="/WEB-INF/common/base_js.jsp"%>
<script>
    function dologin() {

    }
</script>
</body>
</html>
