<%--
  Created by IntelliJ IDEA.
  User: 45847
  Date: 2020/5/22
  Time: 18:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <%@include file="/WEB-INF/common/base_css.jsp"%>
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="user.html">众筹平台 - 用户维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
            <%@include file="/WEB-INF/common/admin_loginbar.jsp"%>
            <form class="navbar-form navbar-right">
                <input type="text" class="form-control" placeholder="Search...">
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
            <%@include file="/WEB-INF/common/admin_menubar.jsp"%>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">分配角色</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-body">
                    <form role="form" class="form-inline">
                        <div class="form-group">
                            <label>未分配角色列表</label><br>
                            <select id="unAssignedRoles" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                                <c:forEach items="${unAssignedRoles}" var="role">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                        <div class="form-group">
                            <ul>
                                <li id="addRole" class="btn btn-default glyphicon glyphicon-chevron-right"></li>
                                <br>
                                <li id="deleteRole" class="btn btn-default glyphicon glyphicon-chevron-left" style="margin-top:20px;"></li>
                            </ul>
                        </div>
                        <div class="form-group" style="margin-left:40px;">
                            <label >已分配角色列表</label><br>
                            <select id="assignedRoles" class="form-control" multiple size="10" style="width:200px;overflow-y:auto;">
                                <c:forEach items="${assignedRoles}" var="role">
                                    <option value="${role.id}">${role.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/base_js.jsp"%>
<script type="text/javascript">

    $("#addRole").click(function () {
        if ($("#unAssignedRoles :selected").length == 0) return;
        var unAssignIds = new Array();
        $("#unAssignedRoles :selected").each(function () {
            unAssignIds.push(this.value);
        });

        $.ajax({
            type:"POST",
            url:"${PATH}/admin/assignRole",
            data:{ids:unAssignIds.join(),adminId:${param.id}},
            success:function (data) {
                if (data == "ok") {
                    layer.msg("角色分配成功",{time:1000});
                    $("#unAssignedRoles :selected").appendTo("#assignedRoles");
                }
            }
        });

    });

    //给删除角色绑定单击事件
    $("#deleteRole").click(function () {
        if ($("#assignedRoles :selected").length == 0)return;
        var selRoleIds = new Array();
        $("#assignedRoles :selected").each(function () {
            selRoleIds.push(this.value);
        });
        $.ajax({
            type:"POST",
            url:"${PATH}/admin/unAssignRole",
            data:{roleIds:selRoleIds.join(),adminId:${param.id}},
            success:function (data) {
                if (data == "ok"){
                    layer.msg("移除权限成功",{time:1000});
                    $("#assignedRoles :selected").appendTo("#unAssignedRoles");
                }
            }
        });


    });

    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
    });
</script>
</body>
</html>

