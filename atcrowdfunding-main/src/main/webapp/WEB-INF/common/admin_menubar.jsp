<%--
  Created by IntelliJ IDEA.
  User: 45847
  Date: 2020/5/18
  Time: 16:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="tree">
    <ul style="padding-left:0px;" class="list-group">
        <c:choose>
            <c:when test="${empty sessionScope.pmenus}">
                <h3>当前无菜单项</h3>
            </c:when>
            <c:otherwise>
                <c:forEach items="${sessionScope.pmenus}" var="pMenu">
                    <c:choose>
                        <%--没有子菜单时--%>
                        <c:when test="${empty pMenu.children}">
                            <li class="list-group-item tree-closed" >
                                <a href="main.html"><i class="glyphicon glyphicon-dashboard"></i> ${pMenu.name}</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <%--有子菜单时--%>
                            <li class="list-group-item tree-closed">
                                <span><i class="glyphicon glyphicon glyphicon-tasks"></i> ${pMenu.name} <span class="badge" style="float:right">${pMenu.children.size()}</span></span>
                                    <%--遍历子菜单--%>
                                <c:forEach var="cMenu" items="${pMenu.children}">
                                    <ul style="margin-top:10px;display:none;">
                                        <li style="height:30px;">
                                            <a href="${PATH}/${cMenu.url}"><i class="glyphicon glyphicon-user"></i> ${cMenu.name}</a>
                                        </li>
                                    </ul>
                                </c:forEach>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </ul>
</div>