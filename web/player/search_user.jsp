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
        <script type="text/javascript" src="../js/ext/ext-all.js"></script>
        <script type="text/javascript" src="../js/ext/src/data/Connection.js"></script>
        <script type="text/javascript">
            var needRefresh = false;
            var currentPage = 1;
            var currentSearchString = "player1";
            var searchResult;
            function sendSearchRequest(from) {
                    Ext.Ajax.request({
                        url: '../search_user',
                        params: {
                            username:currentSearchString,
                            page:from
                        },
                        success: function(response, options) {
                            searchResult = eval("(" + response.responseText + ')');
                            needRefresh = false;
                            if (searchResult.totalPages > 0)
                                moveToPage(currentPage);
                            else
                                clearResult();
                          needRefresh = false;
                        }
                    });
            }

            function moveToPage(pageNumber) {
                currentPage = pageNumber;
                if ((!needRefresh) && currentPage >= searchResult.pageFrom && currentPage <= searchResult.pageFrom + (searchResult.users.length + searchResult.itemsPerPage - 1) / searchResult.itemsPerPage - 1)
                {
                    showResult();
                }
                else
                {
                    var from;
                    if (currentPage < searchResult.pageFrom)
                        from = currentPage - 2;
                    else
                        from = currentPage;
                    if (from <= 0)
                        from = 1;
                    if (from > searchResult.totalPages)
                        from = searchResult.totalPages;
                    sendSearchRequest(from);
                }
            }

            function do_search() {
                currentPage = 1;
                currentSearchString = document.getElementById("username_input").value;
                sendSearchRequest(currentPage);
            }

            function decorateButton(button, id, type) {
                switch (type)
                {
                    case 3:
                        button.innerHTML = "已为好友";
                        button.uid = id;
                        button.setAttribute("onclick", "");
                        break;
                    case 2:
                        button.innerHTML = "接受请求";
                        button.uid = id;
                        button.setAttribute("onclick", "addFriend(this, "+ id + ");");
                        break;
                    case 1:
                        button.innerHTML = "请求已发送";
                        button.uid = id;
                        button.setAttribute("onclick", "");
                        break;
                    case 0:
                        button.innerHTML = "加为好友";
                        button.uid = id;
                        button.setAttribute("onclick", "addFriend(this, "+ id + ");");
                        break;
                    }
            }

            function addFriend(button, id) {
                decorateButton(button, id, 1);

                Ext.Ajax.request({
                    url: '../send_friend_request',
                    params: {
                        uid:id
                    },
                    success: function(response, options) {
                        var v = eval(response.responseText);
                        decorateButton(button, id, v);
                    }
                });

                needRefresh = true;
            }

            function clearResult() {
                var userListTable = document.getElementById("user_list");
                while (userListTable.hasChildNodes())
                    userListTable.removeChild(userListTable.firstChild);
                var pageDiv = document.getElementById("page_div");
                while (pageDiv.hasChildNodes())
                    pageDiv.removeChild(pageDiv.firstChild);
            }

            function showResult() {
                clearResult();
                var userListTable = document.getElementById("user_list");
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
                    var button = document.createElement("button");
                    decorateButton(button, searchResult.users[i].userid, searchResult.users[i].friendState);
                    tdButton.appendChild(button);
                    tr.appendChild(tdName);
                    tr.appendChild(tdButton);
                    userListTable.appendChild(tr);
                }

                var pageDiv = document.getElementById("page_div");
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