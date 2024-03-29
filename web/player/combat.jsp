<%-- 
    Document   : combat
    Created on : 2011-12-10, 21:31:36
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
%>
<!--TODO:检查战斗状态-->

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="../js/ext/resources/css/ext-all.css" />
        <script type="text/javascript" src="../js/ext/ext-all.js"></script>
        <script type="text/javascript" src="../js/ext/src/data/Connection.js"></script>
        <jsp:include flush="true" page="../chat.jsp"></jsp:include>
        <jsp:include flush="true" page="nav.jsp"></jsp:include>
        <script type="text/javascript">
            Ext.require([
                'Ext.Component',
                'Ext.grid.*',
                'Ext.data.*',
                'Ext.util.*',
                'Ext.Action'
            ]);

            var testData = ["a","b","c"];

            Ext.onReady(function() {
                var contextMenu = Ext.create('Ext.menu.Menu', {
                    items: []
                });
                
                function showSkill() {
                    contextMenu.removeAll();
                    Ext.Ajax.request({
                        url: '../combat',
                        params: {
                            skill:1
                        },
                        success: function(response, options) {
                            contextMenu.removeAll();
                            var jsondata = eval("(" + response.responseText + ')');
                            for (i = 0;i < jsondata.skillinfo.length;++i) {
                                contextMenu.add(Ext.create('Ext.Action', {
                                    text: jsondata.skillinfo[i].name,
                                    sid: jsondata.skillinfo[i].id,
                                    handler: function () {
                                        alert("" +this.sid);
                                    }
                                }));
                            }
                            dealWithMainInfo(jsondata);
                            pos = skillAction.getPosition();
                            contextMenu.showAt(skillAction.getPosition());
                            pos[1] = pos[1] - contextMenu.getHeight();
                            contextMenu.showAt(pos);
                        }
                    });
                }

                var skillAction = Ext.create('Ext.Button', {
                    text: '使用技能',
                    handler: showSkill
                });

                function showItem() {
                    contextMenu.removeAll();
                    Ext.Ajax.request({
                        url: '../combat',
                        params: {
                            item:1
                        },
                        success: function(response, options) {
                            contextMenu.removeAll();
                            var jsondata = eval("(" + response.responseText + ')');
                            for (i = 0;i < jsondata.iteminfo.length;++i) {
                                contextMenu.add(Ext.create('Ext.Action', {
                                    text: jsondata.iteminfo[i].name,
                                    iid: jsondata.iteminfo[i].id,
                                    handler: function () {
                                        alert("" +this.iid);
                                    }
                                }));
                            }
                            dealWithMainInfo(jsondata);
                            pos = itemAction.getPosition();
                            contextMenu.showAt(itemAction.getPosition());
                            pos[1] = pos[1] - contextMenu.getHeight();
                            contextMenu.showAt(pos);
                        }
                    });
                }

                var itemAction = Ext.create('Ext.Button', {
                    text: '使用物品',
                    handler: showItem
                });

                function showPet() {
                    contextMenu.removeAll();
                    Ext.Ajax.request({
                        url: '../combat',
                        params: {
                            pet:1
                        },
                        success: function(response, options) {
                            contextMenu.removeAll();
                            var jsondata = eval("(" + response.responseText + ')');
                            for (i = 0;i < jsondata.petinfo.length;++i) {
                                contextMenu.add(Ext.create('Ext.Action', {
                                    text: jsondata.petinfo[i].name,
                                    pid: jsondata.petinfo[i].id,
                                    handler: function () {
                                        alert("" +this.pid);
                                    }
                                }));
                            }
                            dealWithMainInfo(jsondata);
                            pos = petAction.getPosition();
                            contextMenu.showAt(petAction.getPosition());
                            pos[1] = pos[1] - contextMenu.getHeight();
                            contextMenu.showAt(pos);
                        }
                    });
                }

                var petAction = Ext.create('Ext.Button', {
                    text: '切换宠物',
                    handler: showPet
                });

                function escape() {
                    alert(1);
                }

                var escapeAction = Ext.create('Ext.Button', {
                    text: '逃跑',
                    handler: escape
                });

                var myHead = Ext.create('Ext.Component', {
                    flex: 1,
                    preserveRatio:true,
                    autoEl: {
                        id: 'myHeadImg',
                        tag: 'img',
                        src: "../image/test.jpg"
                     }
                });

                var myName = Ext.create('Ext.form.field.Text', {
                    flex: 1,
                    readOnly : true
                });

                var myHp = Ext.create('Ext.form.field.Text', {
                    flex: 1,
                    readOnly : true
                });

                var myState = Ext.create('Ext.form.field.Text', {
                    flex: 1,
                    readOnly : true
                });

                var enemyHead = Ext.create('Ext.Component', {
                    flex: 1,
                    preserveRatio:true,
                    autoEl: {
                        tag: 'img',
                        src: "../image/test.jpg"
                     }
                });

                var enemyName = Ext.create('Ext.form.field.Text', {
                    flex: 1,
                    readOnly : true
                });

                var enemyHp = Ext.create('Ext.form.field.Text', {
                    flex: 1,
                    readOnly : true
                });

                var enemyState = Ext.create('Ext.form.field.Text', {
                    flex: 1,
                    readOnly : true
                });

                var myPanelWithoutHead = Ext.create('Ext.Panel', {
                    flex: 1,
                    layout: {
                        type: 'vbox',
                        align: 'stretch'
                    },
                    items: [myHead, myName, myHp, myState]
                });

                var myPanelWithHead = Ext.create('Ext.Panel', {
                    width: 200,
                    layout: {
                        type: 'vbox',
                        align: 'stretch'
                    },
                    items: [myHead, myPanelWithoutHead]
                });

                var enemyPanelWithoutHead = Ext.create('Ext.Panel', {
                    flex: 1,
                    layout: {
                        type: 'vbox',
                        align: 'stretch'
                    },
                    items: [enemyName, enemyHp, enemyState]
                });

                var enemyPanelWithHead = Ext.create('Ext.Panel', {
                    width: 200,
                    layout: {
                        type: 'vbox',
                        align: 'stretch'
                    },
                    items: [enemyHead, enemyPanelWithoutHead]
                });

                var combatStatePanel = Ext.create('Ext.form.field.TextArea', {});

                var mainPanel =  Ext.create('Ext.Panel', {
                    layout: {
                        type: 'border',
                        padding: 5,
                        align: 'stretch'
                    },
                    defaults: {
                        split: true
                    },
                    items: [
                        {
                            region: 'west',
                            layout:'fit',
                            items:myPanelWithHead
                        },
                        {
                            region: 'center',
                            layout:'fit',
                            items:combatStatePanel
                        },
                        {
                            region: 'east',
                            layout:'fit',
                            items:enemyPanelWithHead
                        }
                    ],
                    dockedItems: [{
                        xtype: 'toolbar',
                        dock: 'bottom',
                        items: [skillAction, '-', itemAction, '-', petAction, '-', escapeAction]
                    }]
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
                                items: mainPanel
                            },createChatWidget()
                        ]
                    }]
                });

                function dealWithMainInfo(jsondata) {
                    myName.setValue(jsondata.mainInfo[0].name);
                    myHp.setValue("" + jsondata.mainInfo[0].currenthp + "/" + jsondata.mainInfo[0].maxhp);
                    myState.setValue(jsondata.mainInfo[0].state);
                    enemyName.setValue(jsondata.mainInfo[1].name);
                    enemyHp.setValue("" + jsondata.mainInfo[1].currenthp + "/" + jsondata.mainInfo[1].maxhp);
                    enemyState.setValue(jsondata.mainInfo[1].state);
                }
                
                Ext.Ajax.request({
                    url: '../combat',
                    params: {
                        skill:1
                    },
                    success: function(response, options) {
                        var jsondata = eval("(" + response.responseText + ')');
                        dealWithMainInfo(jsondata);
                    }
                });
            });
        </script>
        <title>Pokémon——战斗</title>
    </head>
</html>