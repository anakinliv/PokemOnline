<%-- 
    Document   : change_user_property
    Created on : 2011-12-20, 15:07:40
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
                   {name: 'userid', type: 'int'},
                   {name: 'username'},
                   {name: 'money', type: 'int'}
                ],
                data: myData
            });

            function setUserProperty(data) {
                Ext.Ajax.request({
                    url: '../change_user_property',
                    params: {
                        uid:data.userid,
                        money:data.money
                    },
                    success: function(response, options) {}
                });
            }

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

            var cellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
                clicksToEdit: 1
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
                        text     : '金钱',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'money',
                        editor: {
                            xtype: 'numberfield',
                            allowBlank: false,
                            minValue: 0,
                            maxValue: 100000
                        }
                    }
                ],
                tbar:[searchTextField, searchbutton],
                dockedItems: [{
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
                stateful: false,
                plugins: [cellEditing]
            });

            grid.on('edit', function(editor, e) {
                // commit the changes right after editing finished
                setUserProperty(e.record.data);
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