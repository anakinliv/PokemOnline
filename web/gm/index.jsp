<%--
    Document   : index
    Created on : 2011-12-19, 10:03:32
    Author     : Sidney
--%>
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
    if (user.getType() != User.GM && user.getType() != User.ADMIN)
        response.sendRedirect("../index.jsp");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../js/ext/resources/css/ext-all.css" />
        <script type="text/javascript" src="../js/ext/ext-all.js"></script>
        <script type="text/javascript" src="../js/ext/src/data/Connection.js"></script>
        <jsp:include flush="true" page="../chat.jsp"></jsp:include>
        <jsp:include flush="true" page="nav.jsp"></jsp:include>
        <script type="text/javascript">
            Ext.onReady(function() {
                Ext.create('Ext.Viewport', {
                    layout: {
                        type: 'border',
                        padding: 5
                    },
                    defaults: {
                        split: true
                    },
                    items: [createNavMenu(),{
                        region: 'center',
                        layout: {
                            type: 'border',
                            padding: 5
                        },
                        border: false,
                        items: [
                            {
                                region: 'center',
                                html: <%= "\"" + user.getUserName() + "（管理员）：欢迎回来<br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>\""%>
                            },createChatWidget()
                        ]
                    }]
                });
            });
        </script>
        <title>Pokémon</title>
    </head>
</html>