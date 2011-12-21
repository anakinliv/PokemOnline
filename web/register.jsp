<%@page import="com.pokemon.structure.*"%>
<%
    Object obj = request.getSession().getAttribute("user");
    if (obj != null) {
        response.sendRedirect(((User)obj).getTypeName()+"/index.jsp");
    }
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PokemOnline - register</title>
    </head>
    <body>
            <html:form action="/register.do" method="POST">
                <div><label for="username">用户名</label><input type="text" id="username" name="username" /></div>
                <div><label for="password">密　码</label><input type="password" id="password" name="password" /></div>
                <div><label for="password2">重　复</label><input type="password" id="password2" name="password2" /></div>
                <div><button type="submit">注册</button><button type="reset">重置</button></div>
            </html:form>
    </body>
</html>
