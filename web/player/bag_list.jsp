<%-- 
    Document   : bag_list
    Created on : 2011-12-12, 13:16:12
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
    obj = request.getSession().getAttribute("bag_list");
    if (obj == null)
        response.sendRedirect("index.jsp");
    Bag bag_list = (Bag) obj;
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
    Vector<Item> items = bag_list.getItems();
    Vector<Integer> counts = bag_list.getCounts();
    boolean first = true;
    for (int i = 0;i < items.size();++i) {
        if (items.elementAt(i) == null)
            continue;
 %>
            <%= first ? "" : "," %>[<%= "'" + items.elementAt(i).getIid() + "'" %>, <%= "'" + items.elementAt(i).getName() + "'" %>, <%= "'" + counts.elementAt(i).intValue() + "'" %>, <%= "'" + items.elementAt(i).getDescription() + "'" %>]
<%
        first = false;
    }
    request.getSession().removeAttribute("bag_list");
%>
            ];

            // create the data store
            var store = Ext.create('Ext.data.ArrayStore', {
                fields: [
                   {name: 'id', type: 'int'},
                   {name: 'name'},
                   {name: 'amount', type: 'int'},
                   {name: 'description'}
                ],
                data: myData
            });

            var useAction = Ext.create('Ext.Action', {
                text: '使用',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        Ext.Ajax.request({
                            url: '../item_use_at_peace',
                            params: {iid:rec.get('id')},
                            success: function(response, options) {
                                document.getElementById("resultDiv").innerHTML = response.responseText;
                            }
                        });
                        --rec.data.amount;
                        if (rec.data.amount == 0)
                            store.remove(rec);
                        rec.commit();
                    }
                }
            });
            var abandonAction = Ext.create('Ext.Action', {
                text: '丢弃',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        Ext.Ajax.request({
                           url: '../drop_item',
                           params: {iid:rec.get('id')},
                           success: function(response, options) {
                               document.getElementById("resultDiv").innerHTML = response.responseText;
                           }
                        });
                        store.remove(rec);
                    }
                }
            });

            var contextMenu = Ext.create('Ext.menu.Menu', {
                items: [
                    useAction,
                    abandonAction
                ]
            });

            var grid = Ext.create('Ext.grid.Panel', {
                store: store,
                columnLines: true,
                columns: [
                    {
                        text     : '物品ID',
                        width    : 75,
                        sortable : true,
                        dataIndex: 'id'
                    },
                    {
                        text     : '物品名',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'name'
                    },
                    {
                        text     : '剩余数量',
                        width    : 75,
                        sortable : true,
                        dataIndex: 'amount'
                    },
                    {
                        text     : '描述',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'description'
                    }
                ],
                dockedItems: [{
                    xtype: 'toolbar',
                    items: [
                        useAction, abandonAction
                    ]
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
                title: '管理物品',
                renderTo: 'bag_list',
                stateful: false
            });
            grid.getSelectionModel().on({
                selectionchange: function(sm, selections) {
                    if (selections.length) {
                        useAction.enable();
                        abandonAction.enable();
                    } else {
                        useAction.disable();
                        abandonAction.disable();
                    }
                }
            });
        });
        </script>
        <title>Pokémon——管理背包</title>
    </head>

    <body>
        <div id="top">
                <jsp:include flush="true" page="nav.jsp"></jsp:include>
        </div>
        <div id="main">
            <div id="bag_list">
            </div>
            <div id="resultDiv">
            </div>
        </div>
    </body>
</html>