<%-- 
    Document   : SearchUserResultServlet
    Created on : 2011-12-12, 14:38:35
    Author     : Sidney
--%>
<%@page import="com.pokemon.structure.*"%>
<%@page import="com.pokemon.database.Database"%>
<%@page contentType="json" pageEncoding="UTF-8"%>
<%
    Object obj = request.getSession().getAttribute("user");
    if (obj == null) {
        response.sendRedirect("../index.jsp");
    }
    User user = (User)obj;
    String username = request.getParameter("username");
    String pageStr = request.getParameter("page");
    Integer pageNumber;
    if (username == null)
        username = "player1";
    if (pageStr == null || pageStr == "")
        pageNumber = 1;
    else
        pageNumber = Integer.parseInt(pageStr);
    Database db = Database.getNewDatabase();
    SearchResult result = db.searchUser(username, pageNumber.intValue());
%>
{
"totalPages" : <%= result.totalPages %>,
"page"       : <%= result.pageFrom %>,
"users"      :
 [<%
     int count = 0;
     for (int i = 0;i < result.result.size();++i) {
         ++count;
         User currentUser = (User)result.result.elementAt(i);
         int state = db.getUserFriendState(user.getUid(), currentUser.getUid());
         String stateStr = "";
         switch(state) {
             case 3:
                 stateStr = "已为好友";
                 break;
             case 2:
                 stateStr = "收到来自对方的好友申请";
                 break;
             case 1:
                 stateStr = "已发送好友申请";
                 break;
             case 0:
                 stateStr = "无";
                 break;
         }
%><%= count == 1 ? "" : "," %>
  {
    "friendState"    : <%= state %>,
    "friendStateStr" : '<%= stateStr %>',
    "userid"         : <%= currentUser.getUid() %>,
    "username"       : "<%= currentUser.getUserName() %>"
  }
<%
    }
    Database.databaseAfterUse(db);
%> ]
}