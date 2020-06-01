<%--
  Created by IntelliJ IDEA.
  User: 45847
  Date: 2020/5/18
  Time: 16:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh_cn">
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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
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
                    <form class="form-inline" role="form" style="float:left;" action="${PATH}/admin/user">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input class="form-control has-success" name="condition" value="${param.condition}" type="text" placeholder="请输入查询条件">
                            </div>
                        </div>
                        <button type="submit" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button type="button" id="batchDelete" class="btn btn-danger" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${PATH}/admin/add.html'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <table class="table  table-bordered">
                            <thead>
                                <tr >
                                    <th width="30">#</th>
                                    <th width="30"><input id="checkbox" type="checkbox"></th>
                                    <th>账号</th>
                                    <th>名称</th>
                                    <th>邮箱地址</th>
                                    <th width="100">操作</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:choose>
                                    <%--无管理员对象时--%>
                                    <c:when test="${empty pageInfo.list}">
                                        <tr>
                                            <td colspan="6">未查询到管理员账号</td>
                                        </tr>
                                    </c:when>
                                    <%-- 查询到管理员对象时 --%>
                                    <c:otherwise>
                                        <c:forEach items="${pageInfo.list}" var="admin" varStatus="vs">
                                            <tr>
                                                <td>${vs.count}</td>
                                                <td><input id="${admin.id}" type="checkbox"></td>
                                                <td>${admin.loginacct}</td>
                                                <td>${admin.username}</td>
                                                <td>${admin.email}</td>
                                                <td>
                                                    <button type="button" onclick='window.location="${PATH}/admin/assignRole?id=${admin.id}"' class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>
                                                    <button type="button" onclick="window.location='${PATH}/admin/edit.html?id=${admin.id}'" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>
                                                    <button type="button" userId = "${admin.id}" class="btn btn-danger btn-xs delete-button"><i class=" glyphicon glyphicon-remove"></i></button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </c:otherwise>
                                </c:choose>
                            </tbody>
                            <tfoot>
                            <tr >
                                <td colspan="6" align="center">
                                    <ul class="pagination">
                                        <c:choose>
                                            <c:when test="${pageInfo.isFirstPage}">
                                                <li class="disabled"><a href="javascript:void(0)">上一页</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li><a href="${PATH}/admin/index?pageNum=${pageInfo.pageNum-1}&condition=${param.condition}">上一页</a></li>
                                            </c:otherwise>
                                        </c:choose>
                                        <c:forEach items="${pageInfo.navigatepageNums}" var="index">
                                            <c:choose>
                                                <c:when test="${pageInfo.pageNum == index}">
                                                    <%--页码等于当前页，高亮显示并不可以点击--%>
                                                    <li class="active"><a href="javascript:void(0)">${index}<span class="sr-only">(current)</span></a></li>
                                                </c:when>
                                                <c:otherwise>
                                                    <li><a href="${PATH}/admin/index?pageNum=${index}&condition=${param.condition}">${index}</a></li>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:forEach>
                                        <c:choose>
                                            <c:when test="${pageInfo.isLastPage}">
                                                <li class="disabled"><a href="javascript:void(0)">下一页</a></li>
                                            </c:when>
                                            <c:otherwise>
                                                <li><a href="${PATH}/admin/index?pageNum=${pageInfo.pageNum+1}&condition=${param.condition}">下一页</a></li>
                                            </c:otherwise>
                                        </c:choose>
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

    //给删除按钮绑定单机事件
    $(".delete-button").click(function () {
        var loginacct = $(this).parents("tr").find("td").eq(2).text();
        var userId = $(this).attr("userId");
        layer.confirm("您确定要删除"+ loginacct +"吗？",{title:"删除提示",icon:3},function () {
            window.location="${PATH}/admin/deleteAdmin?id="+userId+"&pageNum=${pageInfo.pageNum}";
        });
    });
    //当打开用户维护的相关页面时，设置用户维护所在的父菜单的子菜单列表显示
    $("a:contains('用户维护')").parents("li").find("ul").show();
    //设置当前模块超链接高亮显示
    $(".tree a:contains('用户维护')").css("color" , "red");

    //给全选框绑定单机事件
    $("#checkbox").click(function () {
        $("tbody :checkbox").prop("checked",this.checked);
    });
    //给复选框绑定单机事件
    $("tbody :checkbox").click(function () {
        var checkedCount = $("tbody :checkbox:checked").length;
        var totalCount = $("tbody :checkbox").length;
        $("#checkbox").prop("checked",checkedCount == totalCount);
    });

    //给删除按钮绑定单机事件
    $("#batchDelete").click(function () {
        var selectNum = $("tbody :checkbox:checked").length;
        if (selectNum > 0){
            layer.confirm("您确定要删除选定管理员吗？",{title: "删除提示",icon: 3},function () {
                var idsArr = new Array();
                $("tbody :checkbox:checked").each(function () {
                    idsArr.push(this.id);
                });
                var idsStr = idsArr.join();
                window.location = "${PATH}/admin/batchDelete?ids=" + idsStr;
            });
        }else {
            layer.msg("请勾选要删除的管理员")
        }
    });

</script>
</body>
</html>