<%-- 
    Document   : chat
    Created on : 2011-12-14, 22:39:45
    Author     : Sidney
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Object obj = request.getSession().getAttribute("user");
    if (obj == null) {
        return;
    }
%>
        <script type="text/javascript">
            Ext.require([
                'Ext.grid.*',
                'Ext.data.*',
                'Ext.util.*',
                'Ext.Action'
            ]);

            function createChatWidget() {
                Ext.QuickTips.init();

                // create the data store
                var chatstore = Ext.create('Ext.data.ArrayStore', {
                    fields: [
                       {name: 'username'},
                       {name: 'chatcontent'},
                       {name: 'time'}
                    ]
                });

                var chattextfield = Ext.create('Ext.form.field.Base', {
                    listeners :{
                        specialKey :function(field,e){
                            if (e.getKey() == Ext.EventObject.ENTER) sendMessage();
                        }
                    }
                });

                var sendbutton = Ext.create('Ext.Button', {
                    text: '发送',
                    handler: sendMessage
                });

                var chatgrid = Ext.create('Ext.grid.Panel', {
                    store: chatstore,
                    columnLines: true,
                    columns: [
                        {
                            text     : '用户名',
                            sortable : true,
                            flex: 1,
                            dataIndex: 'username'
                        },
                        {
                            text     : '内容',
                            sortable : true,
                            flex: 1,
                            dataIndex: 'chatcontent'
                        },
                        {
                            text     : '时间',
                            sortable : true,
                            flex: 1,
                            dataIndex: 'time'
                        }
                    ],
                    dockedItems: [{
                        xtype: 'toolbar',
                        dock: 'bottom',
                        items: [chattextfield, sendbutton]
                    }]
                });

Ext.define('ChatUnit', {
    extend: 'Ext.data.Model',
    fields: [
        {name: 'username'},
        {name: 'chatcontent'},
        {name: 'time'}
    ]
});
                function sendMessage() {
                        if (chattextfield.getValue() == "")
                            return;
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
                        chattextfield.setValue("");
                }

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
                
                return {region: 'east',
                        minWidth : 200,
                        width : 200,
                        title: '聊天',
                        layout:'fit',
                        split: true,
                        animCollapse: true,
                        collapsible: true,
                        items : chatgrid};
            }
        </script>
