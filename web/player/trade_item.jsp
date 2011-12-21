<%-- 
    Document   : trade_item
    Created on : 2011-12-20, 22:52:49
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
    obj = request.getSession().getAttribute("store_item_list");
    if (obj == null)
        response.sendRedirect("index.jsp");
    Vector<Item> items = (Vector<Item>) obj;
    request.getSession().removeAttribute("store_item_list");
    obj = request.getSession().getAttribute("user_current_money");
    if (obj == null)
        response.sendRedirect("index.jsp");
    Integer user_current_money = (Integer) obj;
    request.getSession().removeAttribute("user_current_money");
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

            var storeData = [
<%
    boolean first = true;
    for (int i = 0;i < items.size();++i) {
        if (items.elementAt(i) == null)
            continue;
 %>
            <%= first ? "" : "," %>[<%= "'" + items.elementAt(i).getIid() + "'" %>, <%= "'" + items.elementAt(i).getName() + "'" %>, <%= "'" + items.elementAt(i).getPrice() + "'" %>, <%= "'" + items.elementAt(i).getDescription() + "'" %>, '1']
<%
        first = false;
    }
%>
            ];

            var userCurrentMoney = <%= user_current_money.intValue() %>;
            var userCurrentMoneyTextField = Ext.create('Ext.form.field.Text', {
                flex: 1,
                readOnly : true,
                value : "" + userCurrentMoney,
                fieldLabel: '总余额'
            });
            var totalPrice = 0;
            var totalPriceTextField = Ext.create('Ext.form.field.Text', {
                flex: 1,
                readOnly : true,
                value : "" + totalPrice,
                fieldLabel: '总价格'
            });

            // create the data store
            var storeStore = Ext.create('Ext.data.ArrayStore', {
                fields: [
                   {name: 'id', type: 'int'},
                   {name: 'name'},
                   {name: 'price', type: 'int'},
                   {name: 'description'},
                   {name: 'amount', type: 'int'}
                ],
                data: storeData
            });
            
            var cartData = [];

            var cartStore = Ext.create('Ext.data.ArrayStore', {
                fields: [
                   {name: 'id', type: 'int'},
                   {name: 'name'},
                   {name: 'price', type: 'int'},
                   {name: 'description'},
                   {name: 'amount', type: 'int'}
                ],
                data: cartData
            });

            var storeitemgrid = Ext.create('Ext.grid.Panel', {
                viewConfig: {
                    plugins:
                        {ptype: 'gridviewdragdrop',
                        dragGroup: 'GridDDGroup',
                        dropGroup: 'GridDDGroup'}
                },
                store: storeStore,
                columnLines: true,
                columns: [{
                        text     : '物品名',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'name'
                    },
                    {
                        text     : '价格',
                        sortable : true,
                        dataIndex: 'price'
                    },
                    {
                        text     : '描述',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'description'
                    }
                ],
                title: '商店',
                stateful: false
            });

            var cellEditing = Ext.create('Ext.grid.plugin.CellEditing', {
                clicksToEdit: 1
            });
            
            var cartitemgrid = Ext.create('Ext.grid.Panel', {
                viewConfig: {
                    plugins:
                        {ptype: 'gridviewdragdrop',
                        dragGroup: 'GridDDGroup',
                        dropGroup: 'GridDDGroup'},
                    listeners: {
                        drop: function(node, data, dropRec, dropPosition) {
                            recalculateTotalPrice();
                        },
                        drag: function(node, data, dropRec, dropPosition) {
                            recalculateTotalPrice();
                        }
                    }
                },
                store: cartStore,
                columnLines: true,
                columns: [{
                        text     : '物品名',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'name'
                    },
                    {
                        text     : '价格',
                        sortable : true,
                        dataIndex: 'price'
                    },
                    {
                        text     : '描述',
                        flex     : 1,
                        sortable : true,
                        dataIndex: 'description'
                    },
                    {
                        text     : '数量',
                        sortable : true,
                        dataIndex: 'amount',
                        editor: {
                            xtype: 'numberfield',
                            allowBlank: false,
                            minValue: 1,
                            maxValue: 100000
                        }
                    }
                ],
                title: '购物车',
                stateful: false,
                plugins: [cellEditing]
            });
            
            cartitemgrid.on('edit', function(editor, e) {
                recalculateTotalPrice();
            });
            
            var displayPanel = Ext.create('Ext.Panel', {
                height       : 300,
                layout       : {
                    type: 'hbox',
                    align: 'stretch',
                    padding: 5
                },
                defaults     : { flex : 1 }, //auto stretch
                items        : [storeitemgrid,cartitemgrid],
                dockedItems: [{
                    xtype: 'toolbar',
                    dock: 'bottom',
                    items: [userCurrentMoneyTextField, '-', totalPriceTextField, '-', {text: "确定", handler: confirm}]
               }]
            });
            
            function recalculateTotalPrice() {
                totalPrice = 0;
                for (i = 0;i < cartStore.data.items.length;++i)
                    totalPrice += cartStore.data.items[i].data.price * cartStore.data.items[i].data.amount;
                totalPriceTextField.setValue("" + totalPrice);
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
                                items: displayPanel
                            },createChatWidget()
                        ]
                    }]
                });

                function confirm() {
                    var formStr = "<form id='DoTradeItemForm' name='DoTradeItemForm' action='../do_trade_item.do' method='post'>";
                    if (userCurrentMoney < totalPrice) {
                         Ext.Msg.alert("出错啦", "余额不足");
                         return;
                    }
                    for (i = 0; i < cartStore.data.items.length;++i) {
                        formStr = formStr + "<input type='text' name='itemid' value='" + cartStore.data.items[i].data.id + "'/>";
                        formStr = formStr + "<input type='text' name='amount' value='" + cartStore.data.items[i].data.amount + "'/>";
                    }
                    formStr = formStr + "</form>";
                    document.getElementById("hiddenDiv").innerHTML = formStr;
                    document.forms["DoTradeItemForm"].submit();
                }
            });
        </script>
        <title>Pokémon——购买物品</title>
    </head>
    
    <body>
        <div id="hiddenDiv" style="display:none">
        </div>
    </body>
</html>
