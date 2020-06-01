<%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2020/5/28
  Time: 15:18
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
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 给角色分配许可权限<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <button id="assignRolePermission" class="btn btn-success">分配许可</button>
                    <br><br>
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

        //当打开角色维护的相关页面时，设置角色维护所在的父菜单的子菜单列表显示
        $("a:contains('角色维护')").parents("li").find("ul").show();
        //设置当前模块超链接高亮显示
        $(".tree a:contains('角色维护')").css("color" , "red");

        var setting = {
            check : {
                enable : true,
                nocheckInherit: true
            },
            view: {
                selectedMulti: false,
                addDiyDom: function(treeId, treeNode){
                    console.log(treeNode);
                    //删除默认图标
                    $("#"+treeNode.tId +"_ico").remove();
                    //在显示节点标题的span标签左边创建标签并设置上class属性值为当前节点的字体图标值
                    $("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>");
                    //获取当前节点的a标签，设置target属性值为空，避免跳转
                    $("#"+treeNode.tId+"_a").prop("target","");
                },
            },
            data: {
                key:{
                    name:"title"
                },
                simpleData:{
                    enable: true,
                    pIdKey: "pid"
                }
            },
            async: {
                enable: true,
                url:"tree.txt",
                autoParam:["id", "name=n", "level=lv"]
            },
            callback: {
                onClick : function(event, treeId, json) {

                }
            }
        };
        //$.fn.zTree.init($("#treeDemo"), setting); //异步访问数据
        var zTreeObj =  null;

        //刷新权限树方法抽取出来
        function initPermissionTree(){
            $.ajax({
                type:"POST",
                url:"${PATH}/permission/getPermissions",
                success:function (data) {
                    zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, data);
                    //自动展开所有选项
                    zTreeObj.expandAll(true);
                    //获取已分配的权限并标记
                    getRolePermission();
                }
            });
        }

       initPermissionTree();

        function getRolePermission() {
            $.ajax({
                type:"POST",
                url:"${PATH}/permission/getPermissionIdsByRoleId",
                data: "roleId=${param.id}",
                success:function (data) {
                    $.each(data,function () {
                        var node = zTreeObj.getNodeByParam("id",this);
                        node.checked=true;
                        zTreeObj.updateNode(node);
                    })
                }
            });
        }

        //给分配许可按钮绑定单击事件
        $("#assignRolePermission").click(function () {

            var ids = new Array();
            //获取所有选中的权限id
            $("#treeDemo .checkbox_true_full").each(function () {
                ids.push(this.id.split("_")[1]);
            });
            $("#treeDemo .checkbox_true_part").each(function () {
                ids.push(this.id.split("_")[1]);
            });
            $.ajax({
                type:"POST",
                url:"${PATH}/permission/assignPermission",
                data:"roleId=${param.id}&ids="+ids.join(),
                success:function (data) {
                    if (data == "ok"){
                        layer.msg("权限分配成功！",{time:1000})
                        //刷新权限树
                        initPermissionTree();
                    }
                }
            });


        });


    })

</script>
</body>
</html>

