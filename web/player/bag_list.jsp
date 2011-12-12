<%-- 
    Document   : bag_list
    Created on : 2011-12-12, 13:16:12
    Author     : Sidney
--%>

<%@page import="java.util.Vector"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.pokemon.structure.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
    Object obj = request.getSession().getAttribute("user");
    if (obj == null) {
        response.sendRedirect("../index.jsp");
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/common.css"/>
        <script type="text/javascript">
            function userItem(button, iid) {
                //TODO
            }

            function dropItem(button, iid) {
                //TODO
            }
        </script>
        <title>Pokémon——管理背包</title>
    </head>

    <body>
        <div id="top">
                <jsp:include flush="true" page="nav.jsp"></jsp:include>
        </div>
        <div id="main">
            <table id="bag_list">
<%
    obj = request.getSession().getAttribute("bag_list");
    if (obj == null)
        response.sendRedirect("index.jsp");
    Bag bag_list = (Bag) obj;

    Vector<Item> items = bag_list.getItems();
    Vector<Integer> counts = bag_list.getCounts();
    for (int i = 0;i < items.size();++i) {
        if (items.elementAt(i) == null)
            continue;
%>
                <tr>
                    <td><%= items.elementAt(i).getName() %></td>
                    <td><%= items.elementAt(i).getDescription() %></td>
                    <td><%= counts.elementAt(i).intValue() %></td>
                    <td><button>使用</button></td>
                    <td><button>丢弃</button></td>
                </tr>
<%
    }
    request.getSession().removeAttribute("bag_list");
%>
            </table>
        </div>
    </body>
</html>