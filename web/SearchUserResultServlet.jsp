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
"totalPages"   : <%= result.totalPages %>,
"pageFrom"     : <%= result.pageFrom %>,
"itemsPerPage" : <%= SearchResult.COUNT_PER_PAGE %>,
"users"        :
 [<%
     int count = 0;
     for (int i = 0;i < result.result.size();++i) {
         ++count;
         User currentUser = (User)result.result.elementAt(i);
%><%= count == 1 ? "" : "," %>
  {
    "friendState"  : <%= db.getUserFriendState(user.getUid(), currentUser.getUid()) %>,
    "userid"       : <%= currentUser.getUid() %>,
    "username"     : "<%= currentUser.getUserName() %>",
    "itemsPerPage" : <%= SearchResult.COUNT_PER_PAGE %>
  }
<%
    }
    Database.databaseAfterUse(db);
%> ]
}