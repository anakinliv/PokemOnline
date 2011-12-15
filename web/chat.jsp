<%-- 
    Document   : chat
    Created on : 2011-12-14, 22:39:45
    Author     : Sidney
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
    Object obj = request.getSession().getAttribute("user");
    if (obj == null) {
        return;
    }
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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

                // create the data store
                var chatstore = Ext.create('Ext.data.ArrayStore', {
                    fields: [
                       {name: 'username'},
                       {name: 'chatcontent'},
                       {name: 'time'}
                    ]
                });

                var chatgrid = Ext.create('Ext.grid.Panel', {
                    store: chatstore,
                    columnLines: true,
                    columns: [
                        {
                            text     : '用户名',
                            flex     : 1,
                            sortable : true,
                            dataIndex: 'username'
                        },
                        {
                            text     : '内容',
                            flex     : 1,
                            sortable : true,
                            dataIndex: 'chatcontent'
                        },
                        {
                            text     : '时间',
                            flex     : 1,
                            sortable : true,
                            dataIndex: 'time'
                        }
                    ],
                    height: 300,
                    stateful: false
                });

                var chattextfield = Ext.create('Ext.form.field.Base', {
                });

Ext.define('ChatUnit', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'username'},
        {name: 'chatcontent'},
        {name: 'time'}
    ]
});

                var sendbutton = Ext.create('Ext.Button', {
                    text: '发送',
                    handler: function() {
                        Ext.Ajax.request({
                            url: '../chat_info',
                            params: {
                                    chat:chattextfield.getValue()
                            },
                            success: function(response, options) {
                                var v = eval(response.responseText);
                                for (i = 0;i < v.length;++i) {
                                    var chatUnit = Ext.create('ChatUnit', {
                                        username : v[i].username,
                                        chatcontent  : v[i].chatcontent,
                                        time     : v[i].time
                                    });
                                    chatstore.insert(chatstore.count(), chatUnit);
                                }
                            }
                        });
                    }
                });

                
                var typePanel = Ext.create('Ext.Panel', {
                    defaults     : { flex : 1 }, //auto stretch
                    items: [chattextfield,sendbutton]
                });
                Ext.create('Ext.Panel', {
                    title   : '聊天',
                    renderTo: "chat",
                    defaults     : { flex : 1 }, //auto stretch
                    items: [chatgrid, typePanel]
                });

                setTimeout(getChat, 1000);

                function getChat() {
                    setTimeout(getChat, 1000);
                    Ext.Ajax.request({
                        url: '../chat_info',
                        success: function(response, options) {
                            v = eval(response.responseText);
                            for (i = 0;i < v.length;++i) {
                                var chatUnit = Ext.create('ChatUnit', {
                                    username : v[i].username,
                                    chatcontent  : v[i].chatcontent,
                                    time     : v[i].time
                                });
                                chatstore.insert(chatstore.count(), chatUnit);
                            }
                        }
                    });
                }

            });
        </script>
        <title>聊天</title>
    </head>
    <body>
        <div id="chat">
        </div>
    </body>
</html>
