<%--
  Created by IntelliJ IDEA.
  User: 45847
  Date: 2020/5/22
  Time: 22:32
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
    <link rel="stylesheet" href="ztree/zTreeStyle.css">
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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 许可维护</a></div>
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
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 许可权限管理 <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree"></ul>
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
                    <h4>没有默认类</h4>
                    <p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>没有默认类</h4>
                    <p>警告框没有默认类，只有基类和修饰类。默认的灰色警告框并没有多少意义。所以您要使用一种有意义的警告类。目前提供了成功、消息、警告或危险。</p>
                </div>
            </div>
        </div>
    </div>
</div>
<%--增加权限模态框--%>
<div class="modal fade" id="addPermissionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="addModalLabel">新增权限</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="pid" id="pid">
                    <div class="form-group">
                        <label for="addName" class="control-label">name</label>
                        <input type="text" class="form-control" name="name" id="addName">
                    </div>
                    <div class="form-group">
                        <label for="addTitle" class="control-label">title</label>
                        <textarea class="form-control" name="title" id="addTitle"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="addIcon" class="control-label">icon</label>
                        <textarea class="form-control" name="icon" id="addIcon"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="addPermissionBtn" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
<%--修改权限模态框--%>
<div class="modal fade" id="updatePermissionModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="updateModalLabel">修改权限</h4>
            </div>
            <div class="modal-body">
                <form>
                    <input type="hidden" name="id" id="id">
                    <div class="form-group">
                        <label for="addName" class="control-label">name</label>
                        <input type="text" class="form-control" name="name" id="updateName">
                    </div>
                    <div class="form-group">
                        <label for="addTitle" class="control-label">title</label>
                        <textarea class="form-control" name="title" id="updateTitle"></textarea>
                    </div>
                    <div class="form-group">
                        <label for="addIcon" class="control-label">icon</label>
                        <textarea class="form-control" name="icon" id="updateIcon"></textarea>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="updatePermissionBtn" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/base_js.jsp"%>
<script src="ztree/jquery.ztree.all-3.5.min.js"></script>
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

    var setting = {
        view: {
            selectedMulti: false,
            addDiyDom: function(treeId, treeNode){
                console.log(treeNode);
                $("#"+treeNode.tId +"_ico").remove();
                $("#"+treeNode.tId+"_span").before("<span class='"+ treeNode.icon +"'></span>")
                $("#" + treeNode.tId + "_a").prop("target","");
            },
            addHoverDom: function(treeId, treeNode){
                var aObj = $("#" + treeNode.tId + "_a"); // tId = permissionTree_1, ==> $("#permissionTree_1_a")
                aObj.attr("href", "javascript:;");
                if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                var s = '<span id="btnGroup'+treeNode.tId+'">';
                if ( treeNode.level == 0 ) {
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="addPermission('+ treeNode.id + ')" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 1 ) {
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="updatePermission(' + treeNode.id + ')" style="margin-left:10px;padding-top:0px;"  href="javascript:void(0);" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    if (treeNode.children == null || treeNode.children.length == 0) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="deletePermission('+ treeNode.id +')" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="addPermission('+ treeNode.id +')" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 2 ) {
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="updatePermission(' + treeNode.id + ')" style="margin-left:10px;padding-top:0px;"  href="javascript:void(0);" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="deletePermission('+ treeNode.id +')" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                }

                s += '</span>';
                aObj.after(s);
            },
            removeHoverDom: function(treeId, treeNode){
                $("#btnGroup"+treeNode.tId).remove();
            }
        },
        data:{
            key: {
                url: "xUrl",
                name:"title"
            },
            simpleData: {
                enable: true,
                pIdKey: "pid"
            }
        }
    };

    //初始化权限树
    initPermissionTree();

    //抽取初始化权限树方法
    function initPermissionTree(){
        //发起ajax请求获取所有权限
        $.ajax({
            type:"POST",
            url:"${PATH}/permission/getPermissions",
            success:function (permissions) {
                console.log(permissions);
                permissions.push({id:0,title:"权限管理",icon:"glyphicon glyphicon-wrench"});
                var treeObj = $.fn.zTree.init($("#treeDemo"), setting, permissions);
                treeObj.expandAll(true);
            }
        });
    }

    //添加权限方法
    function addPermission(pid){
        //清空输入框内容
        $("#addPermissionModal form :input").val("");
        //显示添加权限模态框
        $("#addPermissionModal").modal("toggle");
        //填充隐藏域中pid的值
        $("#pid").val(pid);
    }

    //提交按钮绑定单击事件
    $("#addPermissionBtn").click(function () {
        $.ajax({
            type:"POST",
            url:"${PATH}/permission/addPermission",
            data:$("#addPermissionModal form").serialize(),
            success:function (data) {
                if (data == "ok"){
                    layer.msg("权限添加成功",{time:1000});
                    //关闭模态框
                    $("#addPermissionModal").modal("toggle");
                    //刷新权限树
                    initPermissionTree();
                }
            }
        });
    });


    //修改权限方法
    function updatePermission(id){
        //发送ajax请求获取权限信息
        $.post("${PATH}/permission/getPermission",{"id":id},function(data){
            $("#id").val(id);
            $("#updateName").val(data.name);
            $("#updateTitle").val(data.title);
            $("#updateIcon").val(data.icon);
        });
        //显示模态框
        $("#updatePermissionModal").modal("toggle");
    }

    //修改提交按钮绑定单击事件
    $("#updatePermissionBtn").click(function () {
        $.ajax({
            type:"POST",
            url:"${PATH}/permission/updatePermission",
            data:$("#updatePermissionModal form").serialize(),
            success:function (data) {
                if (data == "ok"){
                    $("#updatePermissionModal").modal("toggle");
                    layer.msg("更新成功",{time:1000});
                    initPermissionTree();
                }
            }
        });
    });


    //删除权限方法
    function deletePermission(id){
        layer.confirm("您确定要删除此权限吗？",{title:"删除提示",icon: 3},function () {
            $.post("${PATH}/permission/deletePermission",{"id":id},function (data) {
                if(data == "ok"){
                    layer.msg("删除成功",{time:1000});
                    //刷新权限树
                    initPermissionTree();
                }
            });
        });
    }



    //当打开权限维护的相关页面时，设置权限维护所在的父菜单的子菜单列表显示
    $("a:contains('权限维护')").parents("li").find("ul").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('权限维护')").css("color" , "red");
</script>
</body>
</html>

