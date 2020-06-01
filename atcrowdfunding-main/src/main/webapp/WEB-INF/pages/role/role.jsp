<%--
  Created by IntelliJ IDEA.
  User: 45847
  Date: 2020/5/19
  Time: 21:00
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
    <meta name="author" content="">
    <%@include file="/WEB-INF/common/base_css.jsp"%>

    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
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
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="conditionInp" class="form-control has-success" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="button" id="conditionBtn" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" id="batchDelBtn" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" id="addBtn" class="btn btn-primary" style="float:right;" ><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                            <tr >
                                <th width="30">#</th>
                                <th width="30"><input type="checkbox"></th>
                                <th>名称</th>
                                <th width="100">操作</th>
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">

                                    </ul>
                                </td>
                            </tr>

                            </tfoot>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%--添加角色信息模态框--%>
<div class="modal fade" id="addModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header" id="addMsg">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">请输入角色信息</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="recipient-name"  class="control-label">name</label>
                        <input type="text" class="form-control"  id="recipient-name">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="addRoleSubmit" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
<%--更新角色信息模态框--%>
<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header" id="updateMsg">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="ModalLabel">请输入角色信息</h4>
            </div>
            <div class="modal-body">
                <form id="updateForm">
                    <div class="form-group">
                        <label for="recipient-name"  class="control-label">name</label>
                        <input type="hidden" id="roleIdInp" name="id" >
                        <input type="text" name="name" class="form-control"  id="roleNameInp">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="updateRoleSubmit" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/base_js.jsp"%>
<script type="text/javascript">

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

    $("tbody .btn-success").click(function(){
        window.location.href = "assignPermission.html";
    });
    //当打开角色维护的相关页面时，设置角色维护所在的父菜单的子菜单列表显示
    $("a:contains('角色维护')").parents("li").find("ul").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('角色维护')").css("color" , "red");




    //给删除按钮动态绑定单击事件
    $("tbody").delegate(".deleteBtn","click",function () {
        var roleName = this.getAttribute("roleName");
        var roleId = this.id;
        layer.confirm("您确定删除" + roleName +"吗？",{title:"删除提示",icon:3},function () {
            $.post("${PATH}/role/deleteRole",{"id":roleId},function (data) {
                if (data == "ok"){
                    layer.msg("角色删除成功");
                    initRoleTable(page);
                }
            });
        });
    });

    //给新增按钮绑定单击事件
    $("#addBtn").click(function () {
        //显示模态框
        $("#addModal").modal("toggle");
        //置空提示栏
        $("#addMsg span").text("");
        //置空模态框内容
        $("#recipient-name").val("");
    });

    //给角色新增提交按钮绑定单击事件
    $("#addRoleSubmit").click(function () {
        $("#addMsg span").text("");
        var name = $("#recipient-name").val();
        $.post(
            "${PATH}/role/addRole",
            {"name":name},
            function (data) {
                if (data == "ok"){
                    layer.msg("用户添加成功!");
                    $("#addModal").modal("toggle");//关闭添加用户信息栏
                    initRoleTable(maxpage+1);
                }else {
                    $("#addMsg").append("<span style='color: red'>您输入的用户名已存在</span>")
                }
            }
        );
    });

    //给条件查询按钮绑定单击事件
    $("#conditionBtn").click(function () {
        condition = $("#conditionInp").val();
        initRoleTable(1,condition);
    });

    //将查询到的用户信息填充到页面
    function initRoleList(pageInfo) {
        $("tbody").empty();//清空之前数据
        $.each(pageInfo.list,function () {
            $("tbody").append("<tr>\n" +
                "                <td>"+ this.id +"</td>\n" +
                "                <td><input roleId='" + this.id +"' type=\"checkbox\"></td>\n" +
                "                <td>"+ this.name +"</td>\n" +
                "                <td>\n" +
                "                    <button type=\"button\" roleId = '" + this.id + "' class=\"btn btn-success btn-xs assignPermissionBtn\"><i class=\" glyphicon glyphicon-check\"></i></button>\n" +
                "                    <button type=\"button\" roleId = '"+ this.id +"'roleName='"+ this.name +"'class=\"btn btn-primary btn-xs updateRoleBtn\"><i class=\" glyphicon glyphicon-pencil\"></i></button>\n" +
                "                    <button type=\"button\" id='"+ this.id +"' roleName='" + this.name +"' class=\"btn btn-danger btn-xs deleteBtn\"><i class=\" glyphicon glyphicon-remove\"></i></button>\n" +
                "                </td>\n" +
                "            </tr>")
        });
    }

    //显示分页导航栏
    function initRoleListNav(pageInfo){
        $("ul.pagination").empty();//清空之前数据
        if (pageInfo.isFirstPage){
            $("ul.pagination").append("<li class=\"disabled\"><a href=\"javascript:void(0)\">上一页</a></li>")
        }else {
            $("ul.pagination").append("<li><a class='navA' pageNum = '" + (pageInfo.pageNum - 1) + "'href=\"javascript:void(0)\">上一页</a></li>")
        }

        $.each(pageInfo.navigatepageNums,function () {
            if (this == pageInfo.pageNum){
                $("ul.pagination").append("<li class=\"active\"><a href=\"javascript:void(0)\">"+ this +"<span class=\"sr-only\">(current)</span></a></li>");
            }else {
                $("ul.pagination").append("<li><a class='navA' pageNum = '" + this + "'href=\"javascript:void(0)\">"+this+"</a></li>");
            }
        });
        if (pageInfo.isLastPage){
            $("ul.pagination").append("<li class=\"disabled\"><a href=\"javascript:void(0)\">下一页</a></li>")
        }else {
            $("ul.pagination").append("<li><a class='navA' pageNum='"+ (pageInfo.pageNum + 1) +"' href=\"javascript:void(0)\">下一页</a></li>")
        }

        $("tfoot .navA").click(function () {
            page = this.getAttribute("pageNum");
            var condition = $("#conditionInp").val();
            $.get(
                "${PATH}/role/getRoles",
                 {"pageNum":page,"condition":condition},
                function (pageInfo) {
                    pages = pageInfo.pages;
                    initRoleList(pageInfo);
                    initRoleListNav(pageInfo);
                }
            );
        });
    }
    var condition;//当前查询条件
    var page;//当前页码
    var maxpage;//总页码
    //向服务器发送ajax请求获取数据
    initRoleTable(1);
    //将异步请求分页角色集合并解析的代码块提取成函数
    function initRoleTable(pageNum,condition) {
        $.ajax({
            type:"GET",
            url:"${PATH}/role/getRoles",
            data:{"pageNum":pageNum,"condition":condition},
            success:function(pageInfo){
                initRoleList(pageInfo);
                initRoleListNav(pageInfo);
                maxpage = pageInfo.pages;
            }
        });
    }

    //全选全不选
    $("thead :checkbox").click(function () {
        $("tbody :checkbox").prop("checked",this.checked);
    });
    $("tbody").delegate(":checkbox","click",function () {
        var checkedCount = $("tbody :checkbox:checked").length;
        var totalCount = $("tbody :checkbox").length;
        $("thead :checkbox").prop("checked",checkedCount==totalCount);
    });

    //给批量删除按钮添加单击事件
    $("#batchDelBtn").click(function () {
        var count = $("tbody :checkbox:checked").length;
        if (count == 0 ){
            layer.alert("请选择要删除的角色",{title: "提示",icon: 7});
        }else {
            layer.confirm("您确定要删除选中的角色吗？",{title:"删除提示",icon:3},function () {
                var ids = new Array();
                $("tbody :checkbox:checked").each(function () {
                    ids.push(this.getAttribute("roleId"));
                });
                //发送ajax请求
                $.post("${PATH}/role/deleteRoles",{"ids":ids.join()},function (data) {
                    if (data == "ok"){
                        layer.msg("删除角色成功");
                        initRoleTable(page);//返回当前页
                    }
                });
            });
        }
    });

    //动态绑定编辑按钮单击事件
    $("tbody").delegate(".updateRoleBtn","click",function () {
        $("#updateModal").modal("toggle");
        var roleName = this.getAttribute("roleName");
        $("#roleNameInp").val(roleName);//角色信息回显
        $("#roleIdInp").val(this.getAttribute("roleId"));
    });
    //更新角色提交按钮单击事件
    $("#updateModal").delegate("#updateRoleSubmit","click",function () {
        $.post("${PATH}/role/updateRole",$("#updateForm").serialize(),function (data) {
            if (data == "ok"){
                layer.msg("角色信息更新成功!");
                $("#updateModal").modal("toggle");//关闭模态框
                initRoleTable(page);//跳转至当前页
            }
        });
    });

    //给分配权限按钮动态绑定单机事件
    $("tbody").delegate(".assignPermissionBtn","click",function () {
        window.location="${PATH}/role/assignPermission?id=" + $(this).attr("roleId");
    });

</script>x
</body>
</html>

