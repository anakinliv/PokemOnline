<%-- 
    Document   : nav
    Created on : 2011-12-10, 20:45:47
    Author     : Sidney
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
        <script type="text/javascript">
            function createNavMenu() {
                var handleAction = function(url){
                    window.location.href=url;
                };
                var panel=new Ext.Panel({
                        tbar:[{
                            xtype:'button',
                            text: '管理宠物',
                            handler: Ext.Function.pass(handleAction, 'arrange_pet.do')
                        },{
                            xtype:'button',
                            text: '处理好友请求',
                            handler: Ext.Function.pass(handleAction, 'friend_request.do')
                        },{
                            xtype:'button',
                            text: '好友列表',
                            handler: Ext.Function.pass(handleAction, 'friend_list.do')
                        },{
                            xtype:'button',
                            text: '查找用户',
                            handler: Ext.Function.pass(handleAction, 'search_user.do')
                        },{
                            xtype:'button',
                            text: '管理背包',
                            handler: Ext.Function.pass(handleAction, 'bag_list.do')
                        },{
                            xtype:'button',
                            text: '登出',
                            handler: Ext.Function.pass(handleAction, '../logout.do')
                        },]});
                return panel;
            }
        </script>