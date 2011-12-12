<%-- 
    Document   : adventure
    Created on : 2011-12-10, 20:51:22
    Author     : Sidney
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.pokemon.structure.*" %>
﻿<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%
    Object obj = request.getSession().getAttribute("user");
    if (obj == null) {
        response.sendRedirect("../index.jsp");
    }
    User user = (User)obj;
%>

<!--TODO:检查战斗状态-->

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/common.css"/>
        <title>Pokémon——冒险</title>
    </head>

    <body>
        <div id="top">
                <jsp:include flush="true" page="nav.jsp"></jsp:include>
        </div>
        <div id="main">
            冒险
        </div>
    </body>
</html>