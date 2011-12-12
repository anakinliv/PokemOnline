<%@page import="com.pokemon.structure.*"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>

﻿<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%
    Object obj = request.getSession().getAttribute("user");
    if (obj != null) {
        response.sendRedirect(((User)obj).getTypeName()+"/index.jsp");
    }
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/index.css"/>
        <title>Pokemon</title>
    </head>

    <body>
        <div id="main">
            <html:form action="/login.do" method="POST">
                <label for="username">用户名</label>
                <input type="text" id="username" name="username" />
                <label for="password">密码</label>
                <input type="text" id="password" name="password" />
                <button type="submit">登陆</button>
            </html:form>
                <a href="regist.html">注册</a>
        </div>
    </body>
</html>