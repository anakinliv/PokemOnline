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
    obj = request.getSession().getAttribute("friend_request");
    if (obj == null)
        response.sendRedirect("index.jsp");
    Vector<User> friend_requests = (Vector<User>) obj;
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/common.css"/>
        <link rel="stylesheet" type="text/css" href="../js/ext/resources/css/ext-all.css" />
        <script type="text/javascript" src="../js/ext/ext-all.js"></script>
        <script type="text/javascript" src="../js/ext/src/data/Connection.js"></script>
        <script type="text/javascript">
            Ext.require([
                'Ext.grid.*',
                'Ext.data.*',
                'Ext.util.*',
                'Ext.Action'
            ]);

            Ext.onReady(function() {
                Ext.QuickTips.init();

            var myData = [
<%
    boolean first = true;
    for (int i = 0;i < friend_requests.size();++i) {
        if (friend_requests.elementAt(i) == null)
            continue;
        // Currently, we have the uid, username and type of the user, if more infomation is needed, change getUserOverall in Database
 %>
            <%= first ? "" : "," %>[<%= "'" + friend_requests.elementAt(i).getUid() + "'" %>, <%= "'" + friend_requests.elementAt(i).getUserName() + "'" %>]
<%
        first = false;
    }
    request.getSession().removeAttribute("friend_request");
%>
            ];

            // create the data store
            var store = Ext.create('Ext.data.ArrayStore', {
                fields: [
                   {name: 'id', type: 'int'},
                   {name: 'name'}
                ],
                data: myData
            });

            var action = Ext.create('Ext.Action', {
                text: '接受请求',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        Ext.Ajax.request({
                            url: '../accept_friend_request',
                            params: {uid:rec.get('id')}
                        });
                    }
                    store.remove(rec);
                }
            });

            var contextMenu = Ext.create('Ext.menu.Menu', {
                items: [action]
            });

            var grid = Ext.create('Ext.grid.Panel', {
                store: store,
                columnLines: true,
                columns: [
                    {
                        text     : '用户名',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'name'
                    }
                ],
                dockedItems: [{
                    xtype: 'toolbar',
                    items: [action]
                }],
                viewConfig: {
                    stripeRows: true,
                    listeners: {
                        itemcontextmenu: function(view, rec, node, index, e) {
                            e.stopEvent();
                            contextMenu.showAt(e.getXY());
                            return false;
                        }
                    }
                },
                height: 350,
                width: 600,
                title: '处理好友请求',
                renderTo: 'friend_request',
                stateful: false
            });
            grid.getSelectionModel().on({
                selectionchange: function(sm, selections) {
                    if (selections.length)
                        action.enable();
                    else
                        action.disable();
                }
            });
        });
        </script>
        <title>Pokémon——处理好友请求</title>
    </head>

    <body>
        <div id="top">
                <jsp:include flush="true" page="nav.jsp"></jsp:include>
        </div>
        <div id="main">
            <div id="friend_request">
            </div>
        </div>
    </body>
</html>