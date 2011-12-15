<%-- 
    Document   : ChatServlet
    Created on : 2011-12-14, 22:17:31
    Author     : Sidney
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.pokemon.structure.ChatUnit"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.pokemon.others.ChatController"%>
<%@page import="com.pokemon.structure.User"%>
<%@page contentType="json" pageEncoding="UTF-8"%>
[<%
    Object obj = request.getSession().getAttribute("user");
    if (obj == null)
        return;
    User user = (User)obj;
    obj = application.getAttribute("chatcontroller");
    if (obj == null) {
        obj = new ChatController();
        application.setAttribute("chatcontroller", obj);
    }
    ChatController chatController = (ChatController)obj;
    Calendar datetime = (Calendar)request.getSession().getAttribute("chattime");

    String sendStr = request.getParameter("chat");
    if (sendStr != null) {
        chatController.addChatUnit(user.getUid(), user.getUserName(), sendStr);
    }
    Calendar datetime2 = Calendar.getInstance();
    LinkedList<ChatUnit> chats = chatController.getChatsFromTime(datetime);
    boolean first = true;
    SimpleDateFormat df=new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
    for (ChatUnit chat : chats) {
        Calendar tmp =  chat.getDatetime();
 %><%= first ? "" : "," %>
 {
   "username" : '<%= chat.getName() %>',
   "chatcontent" : '<%= chat.getWords() %>',
   "time"    : 'time'
 }
 <%
        first = false;
    }
    datetime = datetime2;
    request.getSession().setAttribute("chattime", datetime);
%>]
