<%-- 
    Document   : arrange_rights
    Created on : 2011-12-19, 10:10:15
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
                   {name: 'rights', type: 'int'},
                   {name: 'userid', type: 'int'},
                   {name: 'username'},
                   {name: 'chat_rights'},
                   {name: 'adventure_rights'},
                   {name: 'login_rights'}
                ],
                data: myData
            });

            function setRights(uid, rights) {
                Ext.Ajax.request({
                    url: '../set_rights',
                    params: {
                        uid:uid,
                        rights:rights
                    },
                    success: function(response, options) {}
                });
                resetActions(grid.getSelectionModel().getSelection());
            }

            function enable(data, mask) {
                data.rights  = data.rights | mask;
                setRights(data.userid, data.rights);
            }

            function disable(data, mask) {
                data.rights  = data.rights & ~mask;
                setRights(data.userid, data.rights);
            }

            var enableChatAction = Ext.create('Ext.Action', {
                text: '允许聊天',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        enable(rec.data, <%= User.CHAT_RIGHTS %>);
                        rec.data.chat_rights = "是";
                        rec.commit();
                    }
                }
            });

            var disableChatAction = Ext.create('Ext.Action', {
                text: '禁止聊天',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        disable(rec.data, <%= User.CHAT_RIGHTS %>);
                        rec.data.chat_rights = "否";
                        rec.commit();
                    }
                }
            });

            var enableAdventureAction = Ext.create('Ext.Action', {
                text: '允许冒险',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        enable(rec.data, <%= User.ADVENTURE_RIGHTS %>);
                        rec.data.adventure_rights = "是";
                        rec.commit();
                    }
                }
            });

            var disableAdventureAction = Ext.create('Ext.Action', {
                text: '禁止冒险',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        disable(rec.data, <%= User.ADVENTURE_RIGHTS %>);
                        rec.data.adventure_rights = "否";
                        rec.commit();
                    }
                }
            });

            var enableLoginAction = Ext.create('Ext.Action', {
                text: '允许登陆',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        enable(rec.data, <%= User.LOGIN_RIGHTS %>);
                        rec.data.login_rights = "是";
                        rec.commit();
                    }
                }
            });

            var disableLoginAction = Ext.create('Ext.Action', {
                text: '禁止登陆',
                disabled: true,
                handler: function(widget, event) {
                    var rec = grid.getSelectionModel().getSelection()[0];
                    if (rec) {
                        disable(rec.data, <%= User.LOGIN_RIGHTS %>);
                        rec.data.login_rights = "否";
                        rec.commit();
                    }
                }
            });

            var contextMenu = Ext.create('Ext.menu.Menu', {
                items: [enableChatAction, disableChatAction, enableAdventureAction, disableAdventureAction, enableLoginAction, disableLoginAction]
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
                        text     : '聊天权限',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'chat_rights'
                    },
                    {
                        text     : '冒险权限',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'adventure_rights'
                    },
                    {
                        text     : '登陆权限',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'login_rights'
                    }
                ],
                tbar:[searchTextField, searchbutton],
                dockedItems: [{
                    xtype: 'toolbar',
                    items: [enableChatAction, disableChatAction, enableAdventureAction, disableAdventureAction, enableLoginAction, disableLoginAction]
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
                    if ((rec.data.rights & <%= User.CHAT_RIGHTS %>) == <%= User.CHAT_RIGHTS %>) {
                        enableChatAction.disable();
                        disableChatAction.enable();
                    } else {
                        enableChatAction.enable();
                        disableChatAction.disable();
                    }
                    if ((rec.data.rights & <%= User.ADVENTURE_RIGHTS %>) == <%= User.ADVENTURE_RIGHTS %>) {
                        enableAdventureAction.disable();
                        disableAdventureAction.enable();
                    } else {
                        enableAdventureAction.enable();
                        disableAdventureAction.disable();
                    }
                    if ((rec.data.rights & <%= User.LOGIN_RIGHTS %>) == <%= User.LOGIN_RIGHTS %>) {
                        enableLoginAction.disable();
                        disableLoginAction.enable();
                    } else {
                        enableLoginAction.enable();
                        disableLoginAction.disable();
                    }
                }
                else {
                    enableChatAction.disable();
                    disableChatAction.disable();
                    enableAdventureAction.disable();
                    disableAdventureAction.disable();
                    enableLoginAction.disable();
                    disableLoginAction.disable();
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
                            type:"gm"
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