<%-- 
    Document   : search_user
    Created on : 2011-12-12, 14:16:44
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
            var currentPage = 1;
            var currentSearchString = "player1";
            var searchResult = {
"totalPages"    : 10,
"pageFrom"      : 1,
"itemsPerPage"  : 12,
"users"         :
 [
  {
    "isFriend" : true,
    "userid"   : 2,
    "username" : "player1"
  },
  {
    "isFriend" : false,
    "userid"   : 3,
    "username" : "player2"
  }
 ]
}
            function moveToPage(pageNumber) {
                currentPage = pageNumber;
                if (currentPage >= searchResult.pageFrom &&
                    currentPage <= searchResult.pageFrom + searchResult.users.length / searchResult.itemsPerPage - 1)
                    showResult();
                else if (currentPage < searchResult.pageFrom)
                {
                    var from = currentPage - 2;
                    if (from <= 0)
                        from = 1;
                    // TODO: 发异步请求
                }
            }

            function do_search() {
                currentPage = 1;
                currentSearchString = document.getElementById("username_input").value;
                // TODO: 发异步请求
                // 下面这句只是暂时测试的
                showResult(searchResult);
            }

            function addFriend(button, id) {
                button.innerHTML = "请求已发送";
            }

            function showResult() {
                var userListTable = document.getElementById("user_list");
                while (userListTable.hasChildNodes())
                    userListTable.removeChild(userListTable.firstChild);
                var indexFrom = (currentPage - searchResult.pageFrom) * searchResult.itemsPerPage;
                if (indexFrom < 0)
                    indexFrom = 0;
                var indexTo = indexFrom + searchResult.itemsPerPage - 1;
                if (indexTo >= searchResult.users.length)
                    indexTo = searchResult.users.length - 1;
                for (i = indexFrom;i <= indexTo;++i) {
                    var tr = document.createElement("tr");
                    var tdName = document.createElement("td");
                    tdName.innerHTML = searchResult.users[i].username;
                    var tdButton = document.createElement("td");
                    if (searchResult.users[i].isFriend)
                        tdButton.innerHTML = "<button>已为好友</button>";
                    else
                        tdButton.innerHTML = "<button onclick='addFriend(this, "+ searchResult.users[i].userid + ");'>加为好友</button>";
                    tr.appendChild(tdName);
                    tr.appendChild(tdButton);
                    userListTable.appendChild(tr);
                }

                var pageDiv = document.getElementById("page_div");
                while (pageDiv.hasChildNodes())
                    pageDiv.removeChild(pageDiv.firstChild);
                for (i = 1;i <= searchResult.totalPages;++i) {
                    var label = document.createElement("label");
                    label.innerHTML = "" + i;
                    if (i != currentPage) {
                        label.onclick = "moveToPage(" + i + ");";
                        label.className = "notCurPage";
                    } else {
                        label.className = "curPage";
                    }
                    pageDiv.appendChild(label);
                }
                //userListTable.
            }
        </script>
        <title>Pokémon——查找用户</title>
    </head>

    <body>
        <div id="top">
                <jsp:include flush="true" page="nav.jsp"></jsp:include>
        </div>
        <div id="main">
            <table id="search_table">
                <tr>
                    <td>用户名</td><td><input type="text" id="username_input"/></td><td><button onclick="do_search();">查找</button></td>
                </tr>
            </table>

            <table id="user_list">
            </table>
            <div id="page_div">
            </div>
        </div>
    </body>
</html>