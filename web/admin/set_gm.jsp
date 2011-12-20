<%-- 
    Document   : set_gm
    Created on : 2011-12-19, 14:54:15
    Author     : Sidney
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.pokemon.structure.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
    Object obj = request.getSession().getAttribute("user");
    if (obj == null) {
        response.sendRedirect("../index.jsp");
    }
    User user = (User)obj;
    if (user.getType() != User.GM && user.getType() != User.ADMIN)
        response.sendRedirect("../index.jsp");
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
                   {name: 'type', type: 'int'},
                   {name: 'userid', type: 'int'},
                   {name: 'username'},
                   {name: 'type_str'}
                ],
                data: myData
            });

            function setType(uid, type) {
                Ext.Ajax.request({
                    url: '../set_type',
                    params: {
                        uid:uid,
                        type:type
                    },
                    success: function(response, options) {}
                });
                resetActions(grid.getSelectionModel().getSelection());
            }

            var setToGMAction = Ext.create('Ext.Action', {
                text: '设为管理员',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        rec.data.type = <%= User.GM %>;
                        rec.data.type_str = "管理员";
                        rec.commit();
                        setType(rec.data.userid, <%= User.GM %>);
                    }
                }
            });

            var setToPlayerAction = Ext.create('Ext.Action', {
                text: '设为普通玩家',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        rec.data.type = <%= User.PLAYER %>;
                        rec.data.type_str = "普通玩家";
                        rec.commit();
                        setType(rec.data.userid, <%= User.PLAYER %>);
                    }
                }
            });

            var contextMenu = Ext.create('Ext.menu.Menu', {
                items: [setToGMAction, setToPlayerAction]
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
                        text     : '类型',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'type_str'
                    }
                ],
                tbar:[searchTextField, searchbutton],
                dockedItems: [{
                    xtype: 'toolbar',
                    items: [setToGMAction, setToPlayerAction]
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

            function resetActions(selections) {
                if (selections.length) {
                    var rec = selections[0];
                    switch (rec.data.type) {
                        case <%= User.GM %>:
                            setToGMAction.disable();
                            setToPlayerAction.enable();
                            break;
                        case <%= User.PLAYER %>:
                            setToGMAction.enable();
                            setToPlayerAction.disable();
                            break;
                        default:
                            setToGMAction.disable();
                            setToPlayerAction.disable();
                            break;
                    }
                }
                else {
                    setToGMAction.disable();
                    setToPlayerAction.disable();
                }
            }

            grid.getSelectionModel().on({
                selectionchange: function(sm, selections) {
                    resetActions(selections);
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
                            page:from,
                            type:"admin"
                        },
                        success: function(response, options) {
                            searchResult = eval("(" + response.responseText + ')');
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
                if (searchTextField.getValue() == "")
                    return;
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
                for (i = 0;i < searchResult.users.length;++i) {
                    switch (searchResult.users[i].type) {
                        case <%= User.ADMIN %>:
                            searchResult.users[i].type_str = "超级管理员";
                            break;
                        case <%= User.GM %>:
                            searchResult.users[i].type_str = "管理员";
                            break;
                        case <%= User.PLAYER %>:
                            searchResult.users[i].type_str = "普通玩家";
                            break;
                    }
                }
                store.loadData(searchResult.users);

                pages=[];
                for (i = 1;i <= searchResult.totalPages;++i) {
                    var pageStr = "" + i;
                    pages.push(
                        {text: pageStr,
                         index: i,
                            handler: function(){
                        moveToPage(this.index);
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
                                layout:'fit',
                                items: grid
                            },createChatWidget()
                        ]
                    }]});
        });
        </script>
        <title>Pokémon——管理玩家权限</title>
    </head>
</html>
