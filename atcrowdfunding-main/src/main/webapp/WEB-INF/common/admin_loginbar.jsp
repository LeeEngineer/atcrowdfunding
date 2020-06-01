<%--
  Created by IntelliJ IDEA.
  User: 45847
  Date: 2020/5/18
  Time: 16:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="rec" uri="http://www.springframework.org/security/tags" %>
<ul class="nav navbar-nav navbar-right">
    <li style="padding-top:8px;">
        <div class="btn-group">
            <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
                <i class="glyphicon glyphicon-user"></i><sec:authentication property="name"></sec:authentication>
            </button>
            <ul class="dropdown-menu" role="menu">
                <li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
                <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
                <li class="divider"></li>
                <form id="logoutForm" action="${PATH}/admin/logout" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                </form>
                <li><a id="logoutA" href="javascript:void(0)"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
            </ul>
        </div>
    </li>
    <li style="margin-left:10px;padding-top:8px;">
        <sec:authorize access="hasAnyRole('PM - 项目经理')">
            <button type="button" class="btn btn-default btn-danger">
                <span class="glyphicon glyphicon-question-sign"></span> 帮助1
            </button>
        </sec:authorize>
    </li>
</ul>
