<%-- 
    Document   : friend_list
    Created on : 2011-12-12, 11:18:47
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
        <title>Pokémon——好友列表</title>
    </head>

    <body>
        <div id="top">
                <jsp:include flush="true" page="nav.jsp"></jsp:include>
        </div>
        <div id="main">
            <table id="friend_list">
<%
    obj = request.getSession().getAttribute("friend_list");
    if (obj == null)
        response.sendRedirect("index.jsp");
    Vector<User> friend_list = (Vector<User>) obj;
    for (int i = 0;i < friend_list.size();++i) {
        if (friend_list.elementAt(i) == null)
            continue;
        // Currently, we have the uid, username and type of the user, if more infomation is needed, change getUserOverall in Database
%>
                <tr>
                    <td><%= friend_list.elementAt(i).getUserName() %></td>
                    <td><button>解除好友关系</button></td>
                </tr>
<%
    }
    request.getSession().removeAttribute("friend_request");
%>
            </table>
        </div>
    </body>
</html>