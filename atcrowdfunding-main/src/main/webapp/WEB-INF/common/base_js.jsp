<%--
  Created by IntelliJ IDEA.
  User: 45847
  Date: 2020/5/18
  Time: 12:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="jquery/jquery-2.1.1.min.js"></script>
<script src="bootstrap/js/bootstrap.min.js"></script>
<script src="script/docs.min.js"></script>
<script src="script/back-to-top.js"></script>
<script src="layer/layer.js"></script>
<script type="text/javascript">
    <%--  绑定注销按钮单击事件  --%>
    $("#logoutA").click(function () {
        layer.confirm("您确定退出登陆吗？",{title:"登出提示",icon:7},function () {
            <%--window.location="${PATH}/admin/logout";--%>
            $("#logoutForm").submit();
        })
    });
</script>