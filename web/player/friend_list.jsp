<%-- 
    Document   : friend_list
    Created on : 2011-12-12, 11:18:47
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
    obj = request.getSession().getAttribute("friend_list");
    if (obj == null)
        response.sendRedirect("index.jsp");
    Vector<User> friend_list = (Vector<User>) obj;
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../css/common.css"/>
        <link rel="stylesheet" type="text/css" href="../js/ext/resources/css/ext-all.css" />
        <script type="text/javascript" src="../js/ext/ext-all.js"></script>
        <script type="text/javascript" src="../js/ext/src/data/Connection.js"></script>
        <jsp:include flush="true" page="../chat.jsp"></jsp:include>
        <jsp:include flush="true" page="nav.jsp"></jsp:include>
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
    for (int i = 0;i < friend_list.size();++i) {
        if (friend_list.elementAt(i) == null)
            continue;
        // Currently, we have the uid, username and type of the user, if more infomation is needed, change getUserOverall in Database
 %>
            <%= first ? "" : "," %>[<%= "'" + friend_list.elementAt(i).getUid() + "'" %>, <%= "'" + friend_list.elementAt(i).getUserName() + "'" %>]
<%
        first = false;
    }
    request.getSession().removeAttribute("friend_list");
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
                text: '解除好友',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        Ext.Ajax.request({
                            url: '../terminate_friendship',
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
                title: '好友列表',
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
                                layout:'fit',
                                items: grid
                            },createChatWidget()
                        ]
                    }]
                });
        });
        </script>
        <title>Pokémon——好友列表</title>
    </head>
</html>