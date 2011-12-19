<%-- 
    Document   : nav
    Created on : 2011-12-19, 14:49:15
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
                            text: '设定管理员',
                            handler: Ext.Function.pass(handleAction, 'set_gm.do')
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