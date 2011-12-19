<%-- 
    Document   : nav
    Created on : 2011-12-19, 10:02:14
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
                            text: '管理玩家权限',
                            handler: Ext.Function.pass(handleAction, 'arrange_rights.do')
                        },{
                            xtype:'button',
                            text: '修改玩家数据',
                            handler: Ext.Function.pass(handleAction, 'change_user_property.do')
                        },{
                            xtype:'button',
                            text: '登出',
                            handler: Ext.Function.pass(handleAction, '../logout.do')
                        }]});
                return {region: 'north',
                        split: false,
                        animCollapse: true,
                        collapsible: true,
                        items: panel};
            }
        </script>
