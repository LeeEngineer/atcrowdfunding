<%--
  Created by IntelliJ IDEA.
  User: 45847
  Date: 2020/5/21
  Time: 14:01
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
                <div class="panel-heading"><i class="glyphicon glyphicon-th-list"></i> 权限菜单列表 <div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <ul id="treeDemo" class="ztree">

                    </ul>
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

<%--添加菜单模态框--%>
<div class="modal fade" id="addMenuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="ModalLabel">请输入菜单信息</h4>
            </div>
            <div class="modal-body">
                <form id="updateForm">
                    <input type="hidden" id="menuIdInp" name="pid" >
                    <div class="form-group">
                        <label class="control-label">name</label>
                        <input type="text" name="name" class="form-control"  id="menuNameInp">
                    </div>
                    <div class="form-group">
                        <label class="control-label">icon</label>
                        <input type="text" name="icon" class="form-control"  id="menuIconInp">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="addMenuSubmit" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>


<%--更新菜单模态框--%>
<div class="modal fade" id="updateMenuModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >请输入菜单信息</h4>
            </div>
            <div class="modal-body">
                <form id="updateMenuForm">
                    <input type="hidden" id="updateMenuIdInp" name="id" >
                    <div class="form-group">
                        <label class="control-label">name</label>
                        <input type="text" name="name" class="form-control"  id="updateMenuNameInp">
                    </div>
                    <div class="form-group">
                        <label class="control-label">icon</label>
                        <input type="text" name="icon" class="form-control"  id="updateMenuIconInp">
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" id="updateMenuSubmit" class="btn btn-primary">提交</button>
            </div>
        </div>
    </div>
</div>
<%@include file="/WEB-INF/common/base_js.jsp"%>
<script src="ztree/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript">

    //添加菜单方法
    function addMenu(pid){
        //删除旧数据
        $("#addMenuModal :input").val("");
        //显示添加模态框
        $("#addMenuModal :input[name='pid']").val(pid);//回显pid属性
        $("#addMenuModal").modal("toggle");
    }

    //添加菜单
    $("#addMenuSubmit").click(function () {
        $.ajax({
            type:"POST",
            url:"${PATH}/menu/addMenu",
            data:$("#addMenuModal form").serialize(),
            success:function (data) {
               if (data=="ok"){
                   //提示添加成功
                   layer.msg("添加菜单成功！",{time:1000});
                   //关闭模态框
                   $("#addMenuModal").modal("toggle");
                   //刷新菜单树
                   initMenuTree();
               }
            }
        });
    });

    var setting = {
        view: {
            addHoverDom:function(treeId,treeNode){
                var aObj = $("#" + treeNode.tId + "_a");
                aObj.attr("href", "javascript:;");
                if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
                var s = '<span id="btnGroup'+treeNode.tId+'">';
                if ( treeNode.level == 0 ) {
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="addMenu('+ treeNode.id +')" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 1 ) {
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="updateMenu('+ treeNode.id + ')" href="javascript:void(0);" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    if (treeNode.children == null||treeNode.children.length == 0) {
                        s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="deleteMenu('+ treeNode.id +')" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                    }
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" onclick="addMenu('+ treeNode.id +')" style="margin-left:10px;padding-top:0px;" href="javascript:void(0);" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
                } else if ( treeNode.level == 2 ) {
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="updateMenu('+ treeNode.id +')" href="javascript:void(0);" title="修改权限信息">&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
                    s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteMenu('+ treeNode.id +')" href="javascript:void(0);">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
                }
                s += '</span>';
                aObj.after(s);
            },
            removeHoverDom:function(treeId,treeNode){
                $("#btnGroup"+treeNode.tId).remove();
            },
            addDiyDom: function (treeId,treeNode) {
                console.log(treeNode);
                //删除默认图标
                $("#"+treeNode.tId +"_ico").remove();
                //在显示节点标题的span标签左边创建标签并设置上class属性值为当前节点的字体图标值
                $("#"+treeNode.tId+"_span").before("<span class='"+treeNode.icon+"'></span>");
                //获取当前节点的a标签，设置target属性值为空，避免跳转
                $("#"+treeNode.tId+"_a").prop("target","");
            }
        },
        data: {
            key: {
                url: "xUrl"
            },
            simpleData: {
                enable: true,
                pIdKey: "pid"
            }
        }
    };
    var zNodes;

    //初始化菜单树
    initMenuTree();
    //提取显示菜单方法
    function initMenuTree() {
        $.get("${PATH}/menu/getMenus",function (data) {
            console.log(data);
            //读取完所有菜单后给其增加根菜单
            data.push({id:0,name:"系统菜单",icon:"glyphicon glyphicon-list-alt"});
            zNodes = data;
            var zTreeObj = $.fn.zTree.init($("#treeDemo"), setting, zNodes);
            //自动展开所有选项
            zTreeObj.expandAll(true);
        });
    }

    //删除菜单方法
    function deleteMenu(id){

        layer.confirm("您确定删除此菜单吗？",{title:"删除提示",icon: 3},function () {
            //发送ajax请求删除菜单
            $.post(
                "${PATH}/menu/deleteMenu",
                {id:id},
                function (data) {
                    if (data == "ok"){
                        //提示删除成功
                        layer.msg("删除成功",{time:1000});
                        //刷新菜单树
                        initMenuTree();
                    }
                }
            );
        });

    }

    //更改菜单方法
    function updateMenu(id){
        //显示更新菜单模态框
        $("#updateMenuModal").modal("toggle");

        //根据id查询菜单信息
        $.ajax({
            type:"POST",
            url:"${PATH}/menu/getMenu",
            data:{id:id},
            success:function (data) {
                //信息回传给模态框
                $("#updateMenuIdInp").val(id);
                $("#updateMenuNameInp").val(data.name);
                $("#updateMenuIconInp").val(data.icon);
            }
        });
    }
    //更新提交按钮绑定单击事件
    $("#updateMenuSubmit").click(function () {
        //发送ajax请求
        $.ajax({
            type:"POST",
            url:"${PATH}/menu/updateMenu",
            data:$("#updateMenuModal form").serialize(),
            success:function (data) {
                if (data=="ok"){
                    //关闭模态框
                    $("#updateMenuModal").modal("toggle");
                    layer.msg("更新成功",{time:1000});
                    //刷新页面
                    initMenuTree();
                }
            }
        });
    });


    //当打开菜单维护的相关页面时，设置菜单维护所在的父菜单的子菜单列表显示
    $("a:contains('菜单维护')").parents("li").find("ul").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('菜单维护')").css("color" , "red");

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
