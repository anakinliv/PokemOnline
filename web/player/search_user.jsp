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
        <script type="text/javascript">
            Ext.require([
                'Ext.grid.*',
                'Ext.data.*',
                'Ext.util.*',
                'Ext.Action'
            ]);

            var store;
            var pages=[];
            var displayPanel;
            var grid;

            Ext.onReady(function() {
                Ext.QuickTips.init();

            var myData = [];

            // create the data store
            store = Ext.create('Ext.data.ArrayStore', {
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

            grid = Ext.create('Ext.grid.Panel', {
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
                dockedItems: [{
                    xtype: 'toolbar',
                    items: [sendRequestAction, acceptRequestAction]
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
            displayPanel = Ext.create('Ext.Panel', {
                width        : 650,
                height       : 450,
                layout       : {
                    type: 'hbox',
                    align: 'stretch',
                    padding: 5
                },
                renderTo     : 'panel',
                defaults     : { flex : 1 }, //auto stretch
                items        : [grid],
                dockedItems  : {
                    xtype: 'toolbar',
                    dock: 'bottom',
                    items: pages
                }
            });
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

            function do_search() {
                currentPage = 1;
                currentSearchString = document.getElementById("username_input").value;
                sendSearchRequest(currentPage);
            }

            function clearResult() {
                store.loadData([]);
                displayPanel.removeDocked(Ext.getCmp('docked'), true);
                displayPanel.doComponentLayout();
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
            displayPanel.addDocked({
                    id: "docked",
                    xtype: 'toolbar',
                    dock: 'bottom',
                    items: pages
                });
            displayPanel.doComponentLayout();
//                var pageDiv = document.getElementById("page_div");
//                for (i = 1;i <= searchResult.totalPages;++i) {
//                    var label = document.createElement("label");
//                    label.innerHTML = "" + i;
//                    if (i != currentPage) {
//                        label.onclick = "moveToPage(" + i + ");";
//                        label.className = "notCurPage";
//                    } else {
//                        label.className = "curPage";
//                    }
//                    pageDiv.appendChild(label);
//                }
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

            <div id="panel">
            </div>
        </div>
    </body>
</html>