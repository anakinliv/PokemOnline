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

            var myData = [];

            // create the data store
            var store = Ext.create('Ext.data.ArrayStore', {
                fields: [
                   {name: 'friendState', type: 'int'},
                   {name: 'friendStateStr'},
                   {name: 'userid', type: 'int'},
                   {name: 'username'}
                ],
                data: myData
            });

            var sendRequestAction = Ext.create('Ext.Action', {
                text: '发送好友申请',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        Ext.Ajax.request({
                            url: '../send_friend_request',
                            params: {
                                uid:rec.data.userid
                            },
                            success: function(response, options) {
                                var v = eval(response.responseText);
                                decorateButton(button, id, v);
                            }
                        });
                        rec.data.friendState = 1;
                        rec.data.friendStateStr = "已发送好友申请";
                        rec.commit();
                    }
                }
            });

            var acceptRequestAction = Ext.create('Ext.Action', {
                text: '接受好友申请',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        Ext.Ajax.request({
                            url: '../accept_friend_request',
                            params: {
                                uid:rec.data.userid
                            },
                            success: function(response, options) {
                                var v = eval(response.responseText);
                                decorateButton(button, id, v);
                            }
                        });
                        rec.data.friendState = 3;
                        rec.data.friendStateStr = "已为好友";
                        rec.commit();
                    }
                }
            });

            var contextMenu = Ext.create('Ext.menu.Menu', {
                items: [sendRequestAction, acceptRequestAction]
            });

            var searchTextField = Ext.create('Ext.form.field.Base', {
                listeners :{
                    specialKey :function(field,e){
                        if (e.getKey() == Ext.EventObject.ENTER) doSearch();
                    }
                }
            });
            var searchbutton = Ext.create('Ext.Button', {
                text: '搜索',
                handler: doSearch
            });

            var grid = Ext.create('Ext.grid.Panel', {
                store: store,
                columnLines: true,
                columns: [
                    {
                        text     : '用户名',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'username'
                    },
                    {
                        text     : '好友状态',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'friendStateStr'
                    }
                ],
                tbar:[searchTextField, searchbutton],
                dockedItems: [{
                    xtype: 'toolbar',
                    items: [sendRequestAction, acceptRequestAction]
                },{
                    xtype: 'toolbar',
                    dock: 'bottom',
                    items: []
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
                title: '搜索结果',
                stateful: false
            });
            grid.getSelectionModel().on({
                selectionchange: function(sm, selections) {
                    if (selections.length) {
                        var rec = selections[0];
                        switch (rec.data.friendState){
                            case 3:
                            case 1:
                                sendRequestAction.disable();
                                acceptRequestAction.disable();
                                break;
                            case 2:
                                sendRequestAction.disable();
                                acceptRequestAction.enable();
                                break;
                            case 0:
                                sendRequestAction.enable();
                                acceptRequestAction.disable();
                                break;
                        }
                    }
                    else {
                        sendRequestAction.disable();
                        acceptRequestAction.disable();
                    }
                }
            });

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
                                showResult();
                            else
                                clearResult();
                        }
                    });
            }

            function moveToPage(pageNumber) {
                if (currentPage != pageNumber) {
                    currentPage = pageNumber;
                    sendSearchRequest(pageNumber);
                }
            }

            function doSearch() {
                currentPage = 1;
                currentSearchString = searchTextField.getValue();
                sendSearchRequest(currentPage);
            }

            function clearResult() {
                store.loadData([]);
                grid.removeDocked(Ext.getCmp('docked'), true);
                grid.doComponentLayout();
            }

            function showResult() {
                clearResult();
                store.loadData(searchResult.users);

                pages=[];
                for (i = 1;i <= searchResult.totalPages;++i) {
                    var pageStr = "" + i;
                    pages.push(
                        {text: pageStr,
                            handler: function(){
                        moveToPage(eval(this.text));
                        }});
                }
                grid.addDocked({
                    id: "docked",
                    border: "false",
                    xtype: 'toolbar',
                    dock: 'bottom',
                    items: pages
                });
                grid.doComponentLayout();
            }

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
                                items: grid
                            },createChatWidget()
                        ]
                    }]});
        });
        </script>
        <title>Pokémon——查找用户</title>
    </head>
</html>