<%-- 
    Document   : friend_request
    Created on : 2011-12-12, 10:22:01
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
    User user = (User)obj;
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/common.css"/>
        <title>Pokémon——处理好友请求</title>
    </head>

    <body>
        <div id="top">
                <jsp:include flush="true" page="nav.jsp"></jsp:include>
        </div>
        <div id="main">
            <table id="friend_request">
<%
    obj = request.getSession().getAttribute("friend_request");
    if (obj == null)
        response.sendRedirect("index.jsp");
    Vector<User> friend_requests = (Vector<User>) obj;
    for (int i = 0;i < friend_requests.size();++i) {
        if (friend_requests.elementAt(i) == null)
            continue;
        // Currently, we have the uid, username and type of the user, if more infomation is needed, change getUserOverall in Database
%>
                <tr>
                    <td><%= friend_requests.elementAt(i).getUserName() %></td>
                    <td><button>接受请求</button></td>
                </tr>
<%
    }
    request.getSession().removeAttribute("friend_request");
%>
            </table>
        </div>
    </body>
</html>